package com.share.common.excelUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import org.apache.log4j.Logger;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.share.themis.common.map.DataMap;

public class ExcelUtil {

	private Logger log = Logger.getLogger(this.getClass());
	
    public String targetSheetFilePath = "";
    public String templeteSheetFilePath = "";
	
	private File _targetdir = null;
    private File _tempdir = null;
    private XSSFSheet sheet = null; 
   
    private String targetFileNm = "TMP1000.xlsx";
    private String zipFileNm = "folderfile.zip";
    private FileOutputStream _tempFileOutputStream = null;
    private Map<String, XSSFCellStyle> wbStyle = null;
	private ZipOutputStream zos = null;

	public XSSFWorkbook wb = null;
	public File _targetFile = null;
	public File _xml = null;
	public File _tempFile = null;
	public FileOutputStream out = null;
    public String sheetRef = "";
    public Map sheetMap = null;
    public ExcelInterface excelInterface = null;
    public Writer fw = null;
    public SpreadSheetWriter sw = null;
    public int sheetTempCount = 0;
    public String deleteUseYn = "Y";
    public String outputZipFile = "";
    public String zipOrXlsxFlag = "";
    private ExcelUtil excelUtil;
    
    /**
     * origenal path
     */
    public ExcelUtil(){
    	this.outputZipFile         = "/webstore/web_chg/pub/Tmonet_Admin/webapps/excelfile/" + this.zipFileNm;
        this.targetSheetFilePath   = "/webstore/web_chg/pub/Tmonet_Admin/webapps/excelfile/";
        this.templeteSheetFilePath = "/webstore/web_chg/pub/Tmonet_Admin/webapps/excelfile/";
        this._targetdir            = new File(targetSheetFilePath);
        this._tempdir              = new File(templeteSheetFilePath);
        
        ExcelUtil.removeDIR(this.targetSheetFilePath);
    }
    
    public ExcelUtil(int loopCnt , int loopLastCnt , String setFileNm , String zipOrXlsx){
    	if(loopCnt != 0 ) this.keepFile();
    	if(!setFileNm.equals("")) this.setFileNm(setFileNm);
    	this.zipOrXlsxFlag = zipOrXlsx;
    }
    
    public void executeBigDataHeader(ExcelUtil excelUtil , String sheetNm , ExcelInterface excelInterface , DataMap headMap , String excelfileName) throws IOException{
    	this.excelUtil = excelUtil;
    	if(!excelfileName.equals(""))this.targetFileNm = excelfileName + ".xlsx";
    	excelUtil.init(sheetNm,  excelInterface);
    	
        excelUtil.sw.beginSheet();
		excelUtil.setHeader();
		excelUtil.excelInterface.setHeaderRowSet(headMap);
    }
    
    public void executeBigDataFooter() throws IOException{
    	excelUtil.sw.endSheet();
        excelUtil.fw.close();
        excelUtil.setSheetPut();
    }
    
    public void executeOne(ExcelUtil excelUtil ,String sheetNm , ExcelInterface excelInterface , DataMap headMap,List<DataMap> list) throws IOException{
    	this.excelUtil = excelUtil;
        excelUtil.init(sheetNm,  excelInterface);
        excelUtil.sw.beginSheet();
		excelUtil.setHeader();
		excelUtil.excelInterface.setHeaderRowSet(headMap);
		excelUtil.excelInterface.handleRow(list); //소량 데이터 엑셀 처리
        excelUtil.sw.endSheet();
        excelUtil.fw.close();
        excelUtil.setSheetPut();
    }
    
    public void executeOne(ExcelUtil excelUtil ,String sheetNm , ExcelInterface excelInterface , DataMap headMap,List<DataMap> list, String excelName) throws IOException{
    	this.excelUtil = excelUtil;
    	excelUtil.targetFileNm = excelName + ".xlsx";
        excelUtil.init(sheetNm,  excelInterface);
        excelUtil.sw.beginSheet();
		excelUtil.setHeader();
		excelUtil.excelInterface.setHeaderRowSet(headMap);
		excelUtil.excelInterface.handleRow(list); //소량 데이터 엑셀 처리
        excelUtil.sw.endSheet();
        excelUtil.fw.close();
        excelUtil.setSheetPut();
    }
    
    public void executeEnd() throws IOException{
    	excelUtil.substitute();
        excelUtil.initEnd();
    }
    
    public void executeZip(){
    	this.zipFileMake();
    	this._targetFile = new File(this._targetdir + "/" + this.zipFileNm);
    }
    
	/**
     * init........
	 * @throws IOException 
     */
	public void init(String sheetName , ExcelInterface excelInterface) throws IOException{
		if(this.wb == null)	this.wb = new XSSFWorkbook();
        this.sheet = wb.createSheet(sheetName);
        
        //excel instance injection
        this.excelInterface = excelInterface;
        this.wbStyle = this.excelInterface.createStyles(this.wb);
        this.sheetRef = this.sheet.getPackagePart().getPartName().getName();
        
        if(!_targetdir.isDirectory()) _targetdir.mkdir();
        if(!_tempdir.isDirectory()) _tempdir.mkdir();
        
    	this._xml = File.createTempFile("excelDownLoadTest", ".xml", this._tempdir);
        this.fw = new OutputStreamWriter(new FileOutputStream(_xml), "UTF-8");
        this.sw = new SpreadSheetWriter(fw , this.excelInterface.setWidthSize() );
        
        if(this.sheetMap==null)  this.sheetMap = new HashMap();
        
        this.sheetTempCount++;
	}
	
	public void setHeader(){
		this.excelInterface.setExcelInstance(this.wb, this.sw, this.wbStyle);
	}
	
	public void setSheetPut(){
		this.sheetMap.put(this.sheetRef.substring(1), this._xml);
	}
	
	public void initEnd() throws IOException{
		if(this.fw != null)this.fw.close();
		if(this.out != null)this.out.close();
		if(this.zos != null)this.zos.close();
		if(this._tempFileOutputStream != null) this._tempFileOutputStream.close();
		if(this.zipOrXlsxFlag.equals("zip") || !this.zipOrXlsxFlag.equals("")) this.zipFileMake();
		if(this.wb != null)this.wb = null;
	}
	
	public void setFileNm(String targetString){
		this.targetFileNm = targetString;
	}
	
	public void keepFile(){
		this.deleteUseYn = "N";
	}
	
	public void deleteDirFile(){
		this.deleteUseYn = "Y";
	}
	
	/**
    * @param zipfile the template file
    * @param tmpfile the XML file with the sheet data
    * @param entry the name of the sheet entry to substitute, e.g. xl/worksheets/sheet1.xml
    * @param out the stream to write the result to
    */
	@SuppressWarnings("rawtypes")
	public void substitute() throws IOException {
        //this._targetFile =  File.createTempFile("excelDownLoad", ".xlsx", this._targetdir);
        this._targetFile = new File(this._targetdir + "/" + this.targetFileNm);  
        this._tempFile = File.createTempFile("TMP", ".xlsx", _tempdir);
        this._tempFileOutputStream = new FileOutputStream(this._tempFile);
        this.wb.write(_tempFileOutputStream);
		this.out = new FileOutputStream(this._targetFile);
		
		ZipFile zip = new ZipFile(this._tempFile);
		ZipOutputStream zos = new ZipOutputStream(this.out);
		
		@SuppressWarnings("unchecked")
		Enumeration<ZipEntry> en = (Enumeration<ZipEntry>) zip.entries();
		while (en.hasMoreElements()) {
			ZipEntry ze = en.nextElement();
			if (!this.sheetMap.containsKey(ze.getName())) {
				zos.putNextEntry(new ZipEntry(ze.getName()));
				InputStream is = zip.getInputStream(ze);
				copyStream(is, zos);
				is.close();
			}
		}

		Iterator it = this.sheetMap.keySet().iterator();
		while (it.hasNext()) {
			String entry = (String) it.next();
			System.out.println(entry + "<< entry");
			zos.putNextEntry(new ZipEntry(entry));
			InputStream is = new FileInputStream((File) this.sheetMap.get(entry));
			copyStream(is, zos);
			is.close();
		}
		zos.close();
	}
	
   /**
    * @param in
    * @param out
    * @throws IOException
    */
   private void copyStream(InputStream in, OutputStream out) throws IOException {
       byte[] chunk = new byte[1024];
       int count;
       while ((count = in.read(chunk)) >=0 ) {
         out.write(chunk,0,count);
       }
   }

   /**
    * folder delete
    * @param source
    */
	public static void removeDIR(String source){
		File[] listFile = new File(source).listFiles(); 
		try{
			if(listFile.length > 0){
				for(int i = 0 ; i < listFile.length ; i++){
					if(listFile[i].isFile()){
						listFile[i].delete(); 
					}else{
						removeDIR(listFile[i].getPath());
					}
					listFile[i].delete();
				}
			}
		}catch(Exception e){
			System.err.println(System.err);
			System.exit(-1); 
		}
	}
	
	public void zipFileMake(){
		new ZipUtil(this.targetSheetFilePath , this.outputZipFile , new File(this.targetSheetFilePath));
	}
}
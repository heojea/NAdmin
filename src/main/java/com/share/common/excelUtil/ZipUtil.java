package com.share.common.excelUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
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

public class ZipUtil {
	//private String OUTPUT_ZIP_FILE = "C:\\excelfile\\folderfile.zip";
	//private String SOURCE_FOLDER = "C:\\excelfile";
	List<String> fileList;
	private String OUTPUT_ZIP_FILE = "";
	private String SOURCE_FOLDER = "";
	private File GENERATE_TARGETFILE = null; 

	public ZipUtil(){
		this.fileList = new ArrayList<String>();
	}
	
	public ZipUtil(String sourceFolder , String outputZipFile , File file){
		this.fileList = new ArrayList<String>();
		this.SOURCE_FOLDER       = sourceFolder ;
		this.OUTPUT_ZIP_FILE     = outputZipFile ;
		this.GENERATE_TARGETFILE = file;
		this.generateFileList();
        this.zipIt();
	}

	
	public static void main( String[] args )  {
		//ZipUtil ZipFolder = new ZipUtil();
		//ZipFolder.generateFileList(new File(SOURCE_FOLDER));
		//ZipFolder.zipIt(OUTPUT_ZIP_FILE);
	}

	
	public void zipIt(){
		byte[] buffer = new byte[1024];
		try{
			FileOutputStream fos = new FileOutputStream(this.OUTPUT_ZIP_FILE);
			ZipOutputStream zos = new ZipOutputStream(fos);
			System.out.println("this.OUTPUT_ZIP_FILE : " + this.OUTPUT_ZIP_FILE);
			for(String file : this.fileList){
				System.out.println("File 추가 : " + file);
				ZipEntry ze= new ZipEntry(file);
				zos.putNextEntry(ze);
				FileInputStream in = new FileInputStream(SOURCE_FOLDER + File.separator + file);
				int len;
				while ((len = in.read(buffer)) > 0) {
				zos.write(buffer, 0, len);
			}
		in.close();
		}
			zos.closeEntry();
			zos.close();
			System.out.println("압축이 완료되었습니다.");
			
		}catch(IOException ex){
			ex.printStackTrace();   
		}
	}
	
	public void zipIt(String zipFile){
		byte[] buffer = new byte[1024];
		try{
			FileOutputStream fos = new FileOutputStream(zipFile);
			ZipOutputStream zos = new ZipOutputStream(fos);
			System.out.println("ZipFile : " + zipFile);
			for(String file : this.fileList){
				System.out.println("File 추가 : " + file);
				ZipEntry ze= new ZipEntry(file);
				zos.putNextEntry(ze);
				FileInputStream in = new FileInputStream(SOURCE_FOLDER + File.separator + file);
				int len;
				while ((len = in.read(buffer)) > 0) {
				zos.write(buffer, 0, len);
			}
		in.close();
		}
			zos.closeEntry();
			zos.close();
			System.out.println("압축이 완료되었습니다.");
			
		}catch(IOException ex){
			ex.printStackTrace();   
		}
	}
	
	public void generateFileList(){
		if(this.GENERATE_TARGETFILE.isFile()){
		fileList.add(generateZipEntry(this.GENERATE_TARGETFILE.getAbsoluteFile().toString()));
		}
	
		if(this.GENERATE_TARGETFILE.isDirectory()){
			String[] subNote = this.GENERATE_TARGETFILE.list();
			for(String filename : subNote){
				String endTemp = filename.substring(filename.length()-4);
				String firstTemp = filename.substring(0,3).toLowerCase();
				if(endTemp.equals("xlsx") && !firstTemp.equals("tmp") )generateFileList(new File(this.GENERATE_TARGETFILE, filename));
			}
		}
	}
	
	public void generateFileList(File node){
		if(node.isFile()){
		fileList.add(generateZipEntry(node.getAbsoluteFile().toString()));
		}
	
		if(node.isDirectory()){
			String[] subNote = node.list();
			for(String filename : subNote){
				String endTemp = filename.substring(filename.length()-4);
				String firstTemp = filename.substring(0,3).toLowerCase();
				if(endTemp.equals("xlsx") && !firstTemp.equals("tmp") )generateFileList(new File(node, filename));
			}
		}
	}

	private String generateZipEntry(String file){
		return file.substring(SOURCE_FOLDER.length()+1, file.length());
	}
}


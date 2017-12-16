package com.share.closeAccount.excelTemplete;
import java.awt.Color;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.share.common.vo.ExcelMergeParamVO;
import com.share.common.excelUtil.ExcelInterface;
import com.share.common.excelUtil.SpreadSheetWriter;
import com.share.themis.common.map.DataMap;

public class CashCardExcelTemple implements ExcelInterface {

	private int iTotRowCount = 0;
	private int rowNum = 0;
	
	/**
	 * @uml.property  name="sw"
	 * @uml.associationEnd  
	 */
	private SpreadSheetWriter sw;
	private Map<String, XSSFCellStyle> styles;
	private XSSFWorkbook wb;
	
	public CashCardExcelTemple(){}
	
	@Override
	public void setExcelInstance(XSSFWorkbook wb, SpreadSheetWriter sw, Map<String, XSSFCellStyle> styles){
		this.sw = sw;
		this.wb = wb;
		this.styles = styles;
	}
	
	@Override
	public void handleRow(Object rows) {
		DataMap dMap = (DataMap) rows;
		if(iTotRowCount % 10000 == 0) System.out.println(iTotRowCount);
		addRow(dMap);
	}
    
	@Override
	public void setHeaderRowSet(DataMap dMap) {
		XSSFCellStyle cellStyle =(XSSFCellStyle)this.styles.get("header");
		
		int i = 0;		
		//셀을 Merge 하는 부분
        ArrayList<ExcelMergeParamVO> arrCellMerg = new ArrayList();
        
        //엑셀의 좌표를 주어 셀을 Merge함
        arrCellMerg.add(0, new ExcelMergeParamVO("A1","B1"));
	        try {
	            //타이틀 A1~B1을 Merge함 
	            this.sw.mergeCell(arrCellMerg);
	        	
	        	this.sw.insertRow(this.rowNum++);
	            this.sw.createCell(i++, "신용카드 선불 정산", cellStyle.getIndex());
	            this.sw.createCell(i++, "", cellStyle.getIndex());
	            this.sw.endRow();
	          
	            i=0;
	            this.sw.insertRow(this.rowNum++);
	            this.sw.createCell(i++, "총갯수", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getInt("TOT_CNT") , cellStyle.getIndex());
	            this.sw.createCell(i++, "성공갯수", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getDouble("SUCC_TOT_CNT") , cellStyle.getIndex());
	            
	            this.sw.createCell(i++, "성공갯수", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getDouble("FAIL_TOT_CNT") , cellStyle.getIndex());
	            this.sw.endRow();
	            
	            this.sw.insertRow(this.rowNum++);
	            this.sw.endRow();
	       
	        	i=0;
	        	this.sw.insertRow(this.rowNum++);
				this.sw.createCell(i++, "거래번호"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "거래수단코드"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "PG사거래금액"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "PG사승인번호"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "카드번호"       ,   cellStyle.getIndex());
				
				this.sw.createCell(i++, "핸드폰번호"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "충전 전 금액"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "수수료"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "충전금액"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "충전 후 금액"       ,   cellStyle.getIndex());
				
				this.sw.createCell(i++, "HSM인증여부"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "승인상태"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "충전상태"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "카드구분"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "거래일시"       ,   cellStyle.getIndex());
				
				this.sw.createCell(i++, "취소일시"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "CHG_CARD"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "STATUS"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "PG_RES_CD"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "PG_RES_MSG"       ,   cellStyle.getIndex());
				
				this.sw.createCell(i++, "KSCC_GUBUN"       ,   cellStyle.getIndex());				
				this.sw.createCell(i++, "DATA_GUBUN"       ,   cellStyle.getIndex());				
				
				
        
	            
	            this.sw.endRow();
     } catch (Exception ex) {
         throw new RuntimeException (ex);
     }
     this.iTotRowCount++;
     //this.rowNum ++;
		
	}
	
	@Override
    public void addRow(DataMap dMap) throws RuntimeException {
        int i = 0;
        XSSFCellStyle cellStyle =(XSSFCellStyle)this.styles.get("data");
        XSSFCellStyle cellStyleHeader =(XSSFCellStyle)this.styles.get("header");

        try {
            this.sw.insertRow(this.rowNum);
            
			this.sw.createCell(i++, dMap.getString("CHG_SER") , cellStyle.getIndex());
			this.sw.createCell(i++, dMap.getString("P_METHOD") , cellStyle.getIndex());
			this.sw.createCell(i++, dMap.getString("PG_AMT") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("PG_TR_NO") , cellStyle.getIndex());
			
			this.sw.createCell(i++, dMap.getString("CARD_ID") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("MOBILE_NO") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("BFR_AMT") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("FEE_AMT") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("CHG_AMT") , cellStyle.getIndex());
			
			this.sw.createCell(i++, dMap.getString("AFT_AMT") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("SIGN2") , cellStyle.getIndex());
			this.sw.createCell(i++, dMap.getString("STATUS_TR") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("STATUS_CHG") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("CHG_CARD_GUBUN") , cellStyle.getIndex());
			
			this.sw.createCell(i++, dMap.getString("REQ_DH") , cellStyle.getIndex());
			this.sw.createCell(i++, dMap.getString("STATUS_DATE") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("CHG_CARD") , cellStyle.getIndex());
			this.sw.createCell(i++, dMap.getString("STATUS") , cellStyle.getIndex());
			this.sw.createCell(i++, dMap.getString("PG_RES_CD") , cellStyle.getIndex());
			
			this.sw.createCell(i++, dMap.getString("PG_RES_MSG") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("KSCC_GUBUN") , cellStyle.getIndex());                                                          
			this.sw.createCell(i++, dMap.getString("DATAGUBUN") , cellStyle.getIndex());
            
            //this.sw.createCell(i++, String.valueOf(this.rowNum), cellStyle.getIndex());		
            this.sw.endRow();
        } catch (Exception ex) {
            throw new RuntimeException (ex);
        }
        this.iTotRowCount++;
        this.rowNum ++;
    }
    
    /**
     * @param wb
     * @return
     */
	@Override
 	public Map<String, XSSFCellStyle> createStyles(XSSFWorkbook wb){
        Map<String, XSSFCellStyle> styles = new HashMap<String, XSSFCellStyle>();
        
        XSSFCellStyle style5 = wb.createCellStyle();
        XSSFFont font5 = wb.createFont();
        font5.setBold(true);
        font5.setFontHeight(10);
        font5.setFontName("Tahoma");
        style5.setFillForegroundColor(new XSSFColor(new Color(219, 219, 219)));
        style5.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
        style5.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style5.setBorderRight(XSSFCellStyle.BORDER_THIN);           
        style5.setBorderLeft(XSSFCellStyle.BORDER_THIN);   
        style5.setBorderTop(XSSFCellStyle.BORDER_THIN);
        style5.setBorderBottom(XSSFCellStyle.BORDER_THIN);   
        style5.setFont(font5);
        styles.put("header", style5);
        
        XSSFCellStyle style1 = wb.createCellStyle();
        XSSFFont font1 = wb.createFont();
        font1.setFontName("Tahoma");
        font1.setFontHeight(10);
        style1.setBorderRight(XSSFCellStyle.BORDER_THIN);           
        style1.setBorderLeft(XSSFCellStyle.BORDER_THIN);   
        style1.setBorderTop(XSSFCellStyle.BORDER_THIN);
        style1.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        style1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style1.setFont(font1);
        styles.put("data", style1);

        return styles;
    }

	@Override
	public List<Integer> setWidthSize() {
		List<Integer> columnSizeList = new ArrayList<Integer>();
		columnSizeList.add(10);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(10);
		columnSizeList.add(10);
		columnSizeList.add(10);
		columnSizeList.add(10);
		columnSizeList.add(10);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(10);
		columnSizeList.add(10);
		columnSizeList.add(10);
		columnSizeList.add(10);
		return columnSizeList;
	}
}

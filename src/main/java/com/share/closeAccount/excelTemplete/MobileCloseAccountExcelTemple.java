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

public class MobileCloseAccountExcelTemple implements ExcelInterface {

	private int iTotRowCount = 0;
	private int rowNum = 0;
	
	/**
	 * @uml.property  name="sw"
	 * @uml.associationEnd  
	 */
	private SpreadSheetWriter sw;
	private Map<String, XSSFCellStyle> styles;
	private XSSFWorkbook wb;
	
	public MobileCloseAccountExcelTemple(){}
	
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
	            this.sw.createCell(i++, "모바일 마감충전내역", cellStyle.getIndex());
	            this.sw.createCell(i++, "", cellStyle.getIndex());
	            this.sw.endRow();
	          
	            i=0;
	            this.sw.insertRow(this.rowNum++);
	            this.sw.createCell(i++, "총갯수", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getInt("TOT_CNT") , cellStyle.getIndex());
	            this.sw.createCell(i++, "총합계", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getDouble("TOT_AMT") , cellStyle.getIndex());
	            this.sw.endRow();
	            
	            this.sw.insertRow(this.rowNum++);
	            this.sw.endRow();
	       
	        	i=0;
	        	this.sw.insertRow(this.rowNum++);
	        	this.sw.createCell(i++, "마감일"       ,   cellStyle.getIndex());				
	            this.sw.createCell(i++, "거래번호"     ,   cellStyle.getIndex());			
	            this.sw.createCell(i++, "카드번호"     ,   cellStyle.getIndex());
	            this.sw.createCell(i++, "전화번호"     ,  cellStyle.getIndex());			
	            this.sw.createCell(i++, "충전 전 금액"      ,   cellStyle.getIndex());
	            this.sw.createCell(i++, "충전 금액"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "충전 후 금액"  , cellStyle.getIndex());
	            this.sw.createCell(i++, "수수료"   , cellStyle.getIndex());
	            this.sw.createCell(i++, "마감결과"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "업체코드"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "결제수단"       , cellStyle.getIndex());
	            this.sw.createCell(i++, "이벤트"       , cellStyle.getIndex());
	            this.sw.createCell(i++, "거래일자"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "결제수단 세부구분"     , cellStyle.getIndex());
	            
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
             
            this.sw.createCell(i++, dMap.getString("DAY_CLOSE_DATE") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_TRANS_ID") , cellStyle.getIndex());
            
            this.sw.createCell(i++, dMap.getString("CARD_ID") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("MOBILE_NO") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_BEF_AMT") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_REQ_AMT") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_AFT_AMT") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_FEE_AMT") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_RESULT_CD") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_ENTPRI_CD") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("PAYMETHOD_NM") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("EVENT_CD") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("TR_REQ_DTIME") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("ENTPRI_NAME") , cellStyle.getIndex());
            
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

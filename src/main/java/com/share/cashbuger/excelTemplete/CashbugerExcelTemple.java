package com.share.cashbuger.excelTemplete;
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

public class CashbugerExcelTemple implements ExcelInterface {

	private int iTotRowCount = 0;
	private int rowNum = 0;
	
	/**
	 * @uml.property  name="sw"
	 * @uml.associationEnd  
	 */
	private SpreadSheetWriter sw;
	private Map<String, XSSFCellStyle> styles;
	private XSSFWorkbook wb;
	
	public CashbugerExcelTemple(){}
	
	@Override
	public void setExcelInstance(XSSFWorkbook wb, SpreadSheetWriter sw, Map<String, XSSFCellStyle> styles){
		this.sw = sw;
		this.wb = wb;
		this.styles = styles;
	}
	
	@Override
	public void handleRow(Object rows) {
		List<DataMap> list = (List<DataMap>) rows;
		for(int i = 0 ; i < list.size() ; i++){
			addRow(list.get(i));
		}
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
	            this.sw.createCell(i++, "account payment", cellStyle.getIndex());
	            this.sw.createCell(i++, "", cellStyle.getIndex());
	            this.sw.endRow();
	            
	            this.sw.insertRow(this.rowNum++);
	            this.sw.endRow();
	            
	            this.sw.insertRow(this.rowNum++);
	            
	            i=0;
	            this.sw.createCell(i++, "결제건수", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getInt("paySuccCnt"), cellStyle.getIndex());
	            this.sw.createCell(i++, "결제금액", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getInt("paySuccSum"), cellStyle.getIndex());
	            this.sw.createCell(i++, "취소건수", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getInt("payCanCnt") +  dMap.getInt("payPartCanCnt"), cellStyle.getIndex());
	            this.sw.createCell(i++, "취소금액", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getInt("payCanSum") +  dMap.getInt("payPartCanSum") , cellStyle.getIndex());
	            this.sw.createCell(i++, "정산금액", cellStyle.getIndex());
	            this.sw.createCell(i++, dMap.getInt("paySuccSum") - (dMap.getInt("payCanSum") + dMap.getInt("payPartCanSum")), cellStyle.getIndex());
	            this.sw.endRow();
	            
	            this.sw.insertRow(this.rowNum++);
	            this.sw.endRow();
	            
	        	this.sw.insertRow(this.rowNum++);
	        	
	        	i=0;
	        	this.sw.createCell(i++, "거래일"       ,   cellStyle.getIndex());				
	            this.sw.createCell(i++, "거래구분"     ,   cellStyle.getIndex());			
	            this.sw.createCell(i++, "거래번호"     ,   cellStyle.getIndex());
	            this.sw.createCell(i++, "주문번호"     ,  cellStyle.getIndex());			
	            this.sw.createCell(i++, "통신사"      ,   cellStyle.getIndex());
	            this.sw.createCell(i++, "가맹점명"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "지급대상업체"  , cellStyle.getIndex());
	            this.sw.createCell(i++, "수수료유형"   , cellStyle.getIndex());
	            this.sw.createCell(i++, "수수료율"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "거래금액"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "수수료"       , cellStyle.getIndex());
	            this.sw.createCell(i++, "공급가"       , cellStyle.getIndex());
	            this.sw.createCell(i++, "부가세"       , cellStyle.getIndex());
	            this.sw.createCell(i++, "지급금액"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "지급일자"     , cellStyle.getIndex());
	            this.sw.createCell(i++, "데이터생성일" , cellStyle.getIndex());
	            
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

        try {
            this.sw.insertRow(this.rowNum);
            
            this.sw.createCell(i++, dMap.getString("day_close_date"   ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("tr_class_nm"      ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("tr_trans_id"      ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("tr_order_no"      ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("tr_sub_channel_nm") , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("mstor_nm"         ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("pay_nm"           ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("comm_set_nm"      ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("pay_commset"      ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getInt("tr_req_amt"       ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getInt("pay_comm"         ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getInt("sup_tmonet"       ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getInt("vat_tmonet"       ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getInt("PAY_AMT"          ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("pay_day"          ) , cellStyle.getIndex());
            this.sw.createCell(i++, dMap.getString("batch_day"        ) , cellStyle.getIndex());
            
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
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(30);
		columnSizeList.add(15);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		columnSizeList.add(20);
		
		return columnSizeList;
	}
}

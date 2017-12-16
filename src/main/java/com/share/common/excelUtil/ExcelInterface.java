package com.share.common.excelUtil;

import java.util.List;
import java.util.Map;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.ibatis.sqlmap.client.event.RowHandler;
import com.share.themis.common.map.DataMap;

public interface ExcelInterface extends RowHandler  {
    public void addRow(DataMap dMap) throws RuntimeException ;
  
 	public Map<String, XSSFCellStyle> createStyles(XSSFWorkbook wb);

 	public void setExcelInstance(XSSFWorkbook wb, SpreadSheetWriter sw, Map<String, XSSFCellStyle> styles);
 	
 	public void setHeaderRowSet(DataMap dMap);
 	
 	public List<Integer> setWidthSize(); 
}

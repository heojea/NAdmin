package com.share.common.excelUtil;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.ss.usermodel.DateUtil;



import com.share.common.vo.ExcelMergeParamVO;

public class SpreadSheetWriter {

	private final Writer _out;
	private int _rownum;
	private int _startCount = 0 ;
	private List<Integer> _sizeList = null; 
	
	private String _merge = null;

	public SpreadSheetWriter(Writer out , List<Integer> list ) {
		_out = out;
		_sizeList = list;
	}

	public void beginSheet() throws IOException {
		int a = 0;
		_out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
				+ "<worksheet xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\">");

		if(_sizeList != null){
			_out.write("<cols>");
			for(int i = 0 ; i < _sizeList.size() ; i++){
				int tempInt = 1 + i;
				_out.write("<col min=\"" + tempInt + "\" max=\"" + tempInt + "\" width=\"" + _sizeList.get(i) + "\" />");
			}
			_out.write("</cols>");
		}
		 
		 
		_out.write("<sheetData>\n");
		this._startCount ++ ;
	}

	public void endSheet() throws IOException {
		_out.write("</sheetData>");
		if(_merge != null)
			_out.write(_merge);
		_out.write("</worksheet>");
	}

	/**
	 * Insert a new row
	 * 
	 * @param rownum
	 *            0-based row number
	 */
	public void insertRow(int rownum) throws IOException {
		_out.write("<row r=\"" + (rownum + 1) + "\">\n");
		this._rownum = rownum;
	}

	/**
	 * Insert row end marker
	 */
	public void endRow() throws IOException {
		_out.write("</row>\n");
	}

	public void createCell(int columnIndex, String value, int styleIndex)
			throws IOException {
		String ref = new CellReference(_rownum, columnIndex).formatAsString();
		ref = ref.replaceAll("\\$", "");
		if(value == null)
			value = "";
		_out.write("<c r=\"" + ref + "\" t=\"inlineStr\"");
		if (styleIndex != -1)
			_out.write(" s=\"" + styleIndex + "\"");
		_out.write(">");
		_out.write("<is><t><![CDATA[" + value + "]]></t></is>");
		
		_out.write("</c>");

	}

	public void createCell(int columnIndex, String value) throws IOException {
		createCell(columnIndex, value, -1);
	}

	public void createCell(int columnIndex, double value, int styleIndex)
			throws IOException {
		String ref = new CellReference(_rownum, columnIndex).formatAsString();
		ref = ref.replaceAll("\\$", "");
		_out.write("<c r=\"" + ref + "\" t=\"n\"");
		if (styleIndex != -1)
			_out.write(" s=\"" + styleIndex + "\"");
		_out.write(">");
		_out.write("<v><![CDATA[" + value + "]]></v>");
		_out.write("</c>");

	}

	public void createCell(int columnIndex, double value) throws IOException {
		createCell(columnIndex, value, -1);
	}

	public void createCell(int columnIndex, Calendar value, int styleIndex)
			throws IOException {
		createCell(columnIndex, DateUtil.getExcelDate(value, false), styleIndex);
	}
	
	/**
	 * ex)
	 * <mergeCells count="5">
  	 *  <mergeCell ref="A1:A2"/>
  	 *  <mergeCell ref="C1:D1"/>
  	 *  <mergeCell ref="B1:B2"/>
  	 *  <mergeCell ref="F1:H1"/>
  	 *  <mergeCell ref="E1:E2"/>
  	 * </mergeCells>
	 * 1. A1, A2�÷��� MERGE�Ѵ�. -> ROWSPAN
	 * 2. C1, D1�÷��� MERGE�Ѵ�. -> COLSPAN
	 * 3. B1, B2�÷��� MERGE�Ѵ�. -> ROWSPAN
	 * @param arry
	 * @throws IOException
	 */
	public void mergeCell(ArrayList<ExcelMergeParamVO> arry) throws IOException{
		if(arry == null) return;
		
		int mergeCnt = arry.size();
		StringBuilder sb = new StringBuilder();
		sb.append("<mergeCells>");
		for(int i=0; i < mergeCnt; i++){
			sb.append("<mergeCell ref=\""+arry.get(i).getFROM()+ ":" + arry.get(i).getTO() + "\"/>");
		}
		sb.append("</mergeCells>");
		
		_merge = sb.toString();
	}
}
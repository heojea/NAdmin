<%@ page language="java" contentType="text/html; charset=EUC-KR"     pageEncoding="EUC-KR"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="com.share.common.excelUtil.ExcelUtil" %>


<%
	out.clear();
	out = pageContext.pushBody();
	String _fileName = (String) request.getAttribute("FILE_NAME");
	FileInputStream _fis = null;
	File _targetFile = null;
	
	try{
		_targetFile = new File(_fileName);
		String _dncName = _targetFile.getName();
		_dncName = java.net.URLEncoder.encode(_dncName, "UTF-8");
		if (_targetFile == null || _targetFile.exists() == false )
		{
           	out.println("<script>alert('파일이 없거나 읽을수 없습니다.');</script>");
		}else{
			response.reset();
			response.setContentType("application/zip");
			response.setHeader("Content-Disposition", "attachment; filename=" + _dncName);
			_fis = new FileInputStream(_targetFile);
			
			byte b[] = new byte[(int) _targetFile.length()];
			int leng = 0;
			while ((leng = _fis.read(b)) > 0)
            {
				response.getOutputStream().write(b, 0, leng);
			}
		}
	}catch(IOException iex){
		out.println("<script>alert('파일이 없거나 읽을수 없습니다.');</script>");
	}finally{
		if (_fis != null) 
			_fis.close();
	}
%>
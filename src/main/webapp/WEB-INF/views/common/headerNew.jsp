<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="TANINE_BOS_LOGIN_SESSION_KEY" value="<%=com.share.themis.common.Constants.TANINE_BOS_LOGIN_SESSION_KEY%>"/>
<c:set var="ADMIN_TP_CD" value="${sessionScope[TANINE_BOS_LOGIN_SESSION_KEY].admin_tp_cd}" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>어드민</title> 
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/base.css" />
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/styleNew.css" />
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/jquery/jquery-ui-1.8.21.custom.css" />
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/jquery/plugins/uploadify/uploadify.css" />
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/jquery/plugins/jqplot/jquery.jqplot.css" />
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/editor/editor.css" charset="utf-8"/>
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/editor/popup.css" charset="utf-8"/>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-ui-1.8.21.custom.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery.custom.extend.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jquery.alphanumeric-0.1.1.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jquery.validate.1.8.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jquery.uploadify-3.1.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/commons.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/table.js"></script>
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/excanvas.js"></script><![endif]-->
<script language="javascript" type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jquery.jqplot.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.cursor.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.highlighter.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.dragable.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.trendline.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.canvasAxisTickRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.donutRenderer.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jqplot/jqplot.pointLabels.min.js"></script>
<script type="text/javascript" src="<c:url value='/view.do?viewName=common&layout=js'/>"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/editor/editor_loader.js?environment=development" charset="utf-8"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/editor/popup.js" charset="utf-8"></script>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>어드민</title>
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/base.css" />
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/style.css" />
<link rel="stylesheet" type="text/css" href="${cfn:getString('system.static.path')}/css/jquery/jquery-ui.1.8.css" />
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-ui-1.8.21.custom.min.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-tab-close.js"></script>
<script type="text/javascript">

var mainTabs;

var thisFrame;
jQuery(document).ready(function(){
	mainTabs = $('#myTabs').tabs({
		closable:true
	});
	fn_addTab("00000","최초화면","<c:url value='/test/test.do' />");
	//$(".ui-icon-circle-close").hide();
	
});

$(document).keypress(function (event) {
	if ($.browser.mozilla || $.browser.opera) {
		if (event.keyCode == '116') {
			fn_frameReload();
			event.preventDefault();
			return false;
		}
	}
});
$(document).keydown(function (event) {
	if ($.browser.webkit || $.browser.msie) {
		if (event.keyCode == '116') {
			fn_frameReload();
			event.preventDefault();
			return false;
		}
	}
});

function fn_frameReload()
{
	thisFrame = fn_getCurrFrameId();
   	window[thisFrame].location.reload(true);
}

function fn_addTab(mid, name, url)
{
	mid = 'menu-'+mid;
	// var maintab =$('#myTabs').tabs();
	var st = '#t'+mid;
	if($(st).html()!=null) {
		mainTabs.tabs('select', st);
		thisFrame = 'f'+mid;
		if(url!=$('#'+thisFrame).attr('src')) $('#'+thisFrame).attr('src',url);
	}
	else
	{
		mainTabs.tabs('add', st, name);
		$(st, '#myTabs').append("<iframe id='f"+mid+"' name='f"+mid+"' src='"+url+"' frameborder='0' width='100%' height='560' onload='fn_resizeFrame(this);'></iframe>");

		thisFrame = 'f'+mid;
		mainTabs.tabs('select', st);
		//var iframeContents = "<p><iframe src='"+url+"' frameborder='0' width='100%' height='100%'></iframe></p>";
		//$('#myTabs').append(iframeContents);
	}

}

function fn_resizeFrame()
{
	thisFrame = fn_getCurrFrameId();
   	var frameDefHeight = ($('#'+thisFrame).contents().find('body')[0].scrollHeight+30);
	if(frameDefHeight < 500) frameDefHeight = 500;
	$('#'+thisFrame).css("height", frameDefHeight + "px");
}

function fn_getCurrFrameId()
{
	var curTab = $('#myTabs .ui-tabs-panel:not(.ui-tabs-hide)');
	var currId = curTab.prop("id");
	return "f"+currId.substr(1);
}
</script>
</head>
<body>
<div id="myTabs" style="font-size:12px">
	<ul>
	</ul>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript">
function onLoading(){
	var div = document.createElement('div');
	$(div).css('background','url(<c:url value="/images/common/waiting.gif"/>)no-repeat');
	$(div).attr('id','onaction');
	$($('div')[0]).before(div);
	$(div).dialog({
		position:['center',200],
	 	overlay: { 
	 		background: '#ffffff', 
	 		opacity: 0.4 
	 	} 
	});
	
	$('.ui-widget-header').remove();
	$(div).css('background-position','center');
	$('.ui-resizable-handle').remove();
	$(div).parent().removeClass('ui-widget-content');
	$(div).css('min-height','140px');
}

function offLoading(){
	$('#onaction').remove();
}
</script>
    <div id="location">
        <a href="<c:url value='/home.do'/>" target="_top">홈</a> &gt; <a href="<c:url value='/layout/left.do'/>?menu_id=${DEPTH1_MENU_ID}" target="leftFrame"/>${DEPTH1_MENU_NM}</a> &gt; ${DEPTH2_MENU_NM}
    </div>
    <h1>${MENU_NM}</h1>
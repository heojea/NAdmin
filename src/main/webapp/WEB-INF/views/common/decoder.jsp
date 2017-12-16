<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<script type="text/javascript">
$(document).ready(function() {
    $('#btn_sel').click(function() {doSearch();});
});

// 검색
function doSearch(page) {
	$("#dStr").html("번역 : ");
	$.ajax({
        type: 'POST',
        url: "<c:url value='/common/decoderStr.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            $("#dStr").html("번역 : "+item.dStr);
            
        } ,
		error : function(){
        	alert("판독할수 없는 문자입니다. 다시 시도해주세요.");
		}
    });
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <c:import url="/view.do?viewName=location&layout=common" />

    <div class="h2">
        <h2>decoder</h2>
    </div>

    <div id="tab1_page">
    <form name="f_cond" id="f_cond" onsubmit="return false">
        <div class="bbs_search">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond">
	                <th width="50">입력</th>
	                <td width="500"><input type="text" id="enStr" name="enStr" class="text" style="width:500px;"></input></td>
	                <td class="right">
	                	<a href="#" class="btn" id="btn_sel"><span>조회</span></a>
	                </td>
	            </tr>
            </table>
        </div>
        <div class="bbs_search">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond">
	                <th width="*" id="dStr">번역 : </th>
	            </tr>
            </table>
        </div>
    </form>
    </div>
</div>    
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />

<script type="text/javascript">
function buttonEventAdd(){
	$('#btn_sel').click(function() {doSearch();});
}

$(document).ready(function() {
	//init search action
	doSearch(null);
	buttonEventAdd();
});

//검색
function doSearch(page) {
	//page init
    if(page == null) page = 1;
	
	//ajax call
    $.ajax({
        type: 'POST',        
        url: "<c:url value='/account/agent.json'/>",
        data: formSerialize("#f_cond") +"&page="+page,
        dataType: 'json',
        
        /* success logic  */
        success: function(data) {
            var list = eval(data);
            if (list.list) {
                $("#g_order tbody").html("");
                for (var i = 0; i < list.list.length; i++) {
                    var item = list.list[i];
                    var tr = $("<tr></tr>");
                    if(i == 0) {
                    	//empty
                    }else{
                    	var targetMethod = "javascript:selectAgent('" + item.agent_id + "','" + item.agent_nm +"')"; 
                    	var htmlAgentNm = "<a href=\"" + targetMethod + "\">" + item.agent_nm + "</a>";
                    	var htmlCP = "<a href=\"" + targetMethod + "\">" + item.cp_id + "</a>";
	                    $("<td></td>").html(htmlAgentNm).appendTo(tr);
	                    $("<td></td>").html(htmlCP).appendTo(tr);
	                    $("<td></td>").html("").appendTo(tr);
	                    tr.appendTo($("#g_order tbody"));
                    }
                }
                if(list.list.length==1) {
	            	var tr = $("<tr></tr>");
					$("#g_order tbody").append(tr.append($("<td colspan=17 align='center' height='100'></td>").html("조회된 데이터가 없습니다.")));
                }
                
                paintGrid("g_order");
                //paging setting
                $('div.paging').html(
                        paintPager(list.page, list.cpp, list.totalCnt, 'doSearch')
                );
            }
        } 
    });
}

function selectAgent(agent_id, agent_nm) {
	dialogArguments.search_agent_id.value = agent_id;
	dialogArguments.search_agent_nm.value = agent_nm;
	popupClose();
}

function popupClose() {
	window.close();
}

</script>
</head>
<body>
<div style="min-width:0px; width:900px;">
   <div class="h3">
       <span>가맹점 조회</span>
   </div>
   <div class="bbs_search"  style="height:200px; ">
    <form name="f_cond" id="f_cond" onsubmit="return false">
    
        <div class="bbs_search">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond">
	                <th width="30">가맹점명</th>
	                <td><input type="text" value=""  id="search_agent_nm" name="search_agent_nm" /></td>
	                <td class="right" width="100">
	                	<a href="#" class="btn" id="btn_sel"><span>조회</span></a>
	                	<a href="javascript:popupClose();" class="btn_s right" id="btn_excel"><span>닫기</span></a>
	                </td>
	            </tr>
	            
	            <tr id="d_cond">
	                <th width="100">가맹점아이디(CP)</th>
	                <td><input type="text" value=""  id="search_cp_id" name="search_cp_id" /></td>
	            </tr>
            </table>
        </div>
        <div class="bbs_grid" style="height:570px">
            <table id="g_order" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="50">가맹점명</th>
                        <th width="70">가맹점아읻(CP)</th>
                        <th width="250">비고</th>
                    </tr> 
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        
        <!-- paging -->
        <div class="paging" style="margin-top:10px;"></div>
        <!-- paging // -->
    </form>
   </div>
</div>    
</body>
</html>


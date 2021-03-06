<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />

<script type="text/javascript">
/**
 * button event listenr
 */
function buttonEventAdd(){
	$('#btn_sel').click(function() {doSearch();});
}

/**
 * date init settting
 */
function dateSetting(){
	var start_dt = $("#start_dt").val();
	if(start_dt == null || start_dt == "") {
		
	    $('#f_cond').find('#start_dt').val(getToday().substring(0,8)+"01");
	    $('#f_cond').find('#end_dt').val(getToday());
	} 
}

/**
 * data - "" convert
 */
function dateSet(){
	var start_dt =  $("#start_dt").val();
	var end_dt =  $("#end_dt").val();
	start_dt.replace("-","").replace("-","");
	end_dt.replace("-","").replace("-","");
	start_dt = start_dt.replaceAll("-", ""); 
	end_dt   = end_dt.replaceAll("-", "");
	
	$("#start_dt").val(start_dt);
	$("#end_dt").val(end_dt);
}

/**
 * first init setting ready
 */
$(document).ready(function() {
	
	
	buttonEventAdd();
	dateSetting();
});

// 검색
function doSearch(page) {
	//data - "" convert
	dateSet();
	$("#excelType").val("");
	
	//page init
    if(page == null) page = 1;
	
	//ajax call
    $.ajax({
        type: 'POST',
        url: "<c:url value='/custom/gsRetail.json'/>",
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
                    }else{
                    	alert(item.account_name);
                    	$("<td></td>").html("").appendTo(tr); 
                		$("<td></td>").html(item.account_name).appendTo(tr); 
                		$("<td></td>").html("").appendTo(tr); 
                		tr.appendTo($("#g_order tbody"));	
                    }
	                if(list.list.length==1) {
		            	var tr = $("<tr></tr>");
						$("#g_order tbody").append(tr.append($("<td colspan=17 align='center' height='100'></td>").html("조회된 데이터가 없습니다.")));
	                }
                }
                paintGrid("g_order");
                //paging setting
                $('div.paging').html(
                        //paintPager(list.page, list.cpp, list.totalCnt, 'doSearch')
                );
            }
    
        } 
    });
}



//검색
function doSearch(page) {
	//data - "" convert
	dateSet();
	$("#excelType").val("");
	$("#accountSeqArray").val("");
	//page init
 if(page == null) page = 1;
	
	//ajax call
 $.ajax({
     type: 'POST',
     url: "<c:url value='/custom/gsRetail.json'/>",
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
                 }else{
                	var paramS = item.account_seq 
                	var html = "<input type=\"checkbox\" value=\"" + paramS + "\" name=\"checkNames\" id=\"\" />";
                	$("<td></td>").html(html).appendTo(tr);
             		$("<td></td>").html(item.account_name).appendTo(tr);
             		
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

function excelFileDownload() {
	 var arraySeq = new Array();
	$("[name='checkNames']:checked").each(function(){
	    arraySeq.push($(this).val());
	});
	$("#accountSeqArray").val(arraySeq);
	
	
	$("#excelType").val("excelType");
	document.f_cond.action = "/custom/gsRetailExcel.do";
	document.f_cond.submit();
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
 <c:import url="/view.do?viewName=location&layout=common" />
    <div class="h2">
        <h2>정산 상세 조회 조건</h2>
    </div>

    <div id="tab1_page">
    <form name="f_cond" id="f_cond" onsubmit="return false">
        <input type="hidden" value="excelType" name="excelType" id="excelType" />
        <input type="hidden" value="" name="accountSeqArray" id="accountSeqArray" />
        <div class="bbs_search">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond">
	                <th width="50">일자</th>
	                <td width="250">
	                    <input type="text" name="start_dt" id="start_dt" class="text" style="width:70px;text-align:center;"/>
	                    <img src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" onclick="openCal('start_dt','start_dt','end_dt');" />
	                    ~
	                    <input type="text" name="end_dt" id="end_dt" class="text" style="width:70px;text-align:center;"/>
	                    <img src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" onclick="openCal('end_dt','start_dt','end_dt');" />
	                </td>
	                <td width="10"></td>
	                <th width="70">계정명</th>
	                	<td width="80">
	                    	<input type="text" value="" id="search_accountNm" name="search_accountNm" />
						</td>
	                <td class="right">
	                	<a href="#" class="btn" id="btn_sel"><span>조회</span></a>
	                	<a href="javascript:excelFileDownload()" class="btn_s right" id="btn_excel"><span>EXCEL</span></a>
	                </td>
	            </tr>
            </table>
        </div>
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	           
            </table>
        
        
        <!-- culture column 정보   -->
        <div class="bbs_grid" id="" style="height:500px">
            <table id="g_order" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="80">선택</th>
                        <th width="80">계정명</th>
                         <th width="450">비고</th>
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


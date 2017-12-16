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
 * 10보다작으면 0을 붙여준다.
 */
function addZero(n){
	return n < 10 ? "0"+n : n;
	
}


/**
 * date init settting
 */
function dateSetting(){
	var start_dt = $("#start_dt").val();
	if(start_dt == null || start_dt == "") {
		var settingDate = new Date();
		settingDate.setMonth(settingDate.getMonth()-6); //6개월전 
		var dateVal = addZero(settingDate.getFullYear()) + "-" + addZero(settingDate.getMonth()+1) + "-" + addZero(settingDate.getDate());
		
	    $('#f_cond').find('#start_dt').val(dateVal);
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

/* 법인 tmoney 상세 */
function loadCarMst(){
    centerPopupWindow('<c:url value='/etc/popupNegativeUser.do'/>', 'popup', {width:600,height:270,scrollbars:'no'});
}

//검색
function doSearch(page) {
	//data - "" convert
	dateSet();
	$("#excelType").val("");
	$("#accountSeq").val("");
	//page init
 if(page == null) page = 1;
	
	//ajax call
 $.ajax({
     type: 'POST',
     url: "<c:url value='/etc/negativeUser.json'/>",
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
                	$("<td></td>").html(formatDate(item.REGIST_DT)).appendTo(tr);
             		$("<td></td>").html(item.CARD_ID).appendTo(tr);
             		
             		var html = "<input type=\"button\" value=\"BL해지\" onclick=\"doDelete('" + item.CARD_ID + "');\" id=\"" + item.CARD_ID + "\"  />";
             		$("<td></td>").html(html).appendTo(tr);
             		
             		$("<td></td>").html(item.BL_COMMENT).appendTo(tr);
             		
             		
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

//삭제
function doDelete(card_id) {
	if (confirm("삭제하시겠습니까?") == false)return;

	 $.ajax({
	     type: 'POST',
	     url: "<c:url value='/etc/deleteNegativeUser.json'/>",
	     data: "&cardId="+card_id,
	     dataType: 'json',
	     
	     /* success logic  */
	     success: function(data) {
	    	 $("#" + card_id).parents("tr").remove();
			 alert(data.deleteResult + "개 삭제 성공~");
	     },
	     error : function(){
		   alert("삭제 실패~ Exception ~");
		}
	 	
	 });
}

</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <div class="h2">
        <h2>부정의심 사용자 관리</h2>
    </div>

    <div id="tab1_page">
    <form name="f_cond" id="f_cond" onsubmit="return false">
        <input type="hidden" value="excelType" name="excelType" id="excelType" />
        <input type="hidden" value="" name="card_id" id="card_id" />
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
	                <th width="70">카드번호</th>
	                	<td width="80">
	                    	<input type="text" value="" id="search_cardId" name="search_cardId" />
						</td>
	                <td class="right">
	                	<a href="#" class="btn" id="btn_sel"><span>조회</span></a>
	                	<a href="javascript:loadCarMst()" class="btn_s right" id="btn_excel"><span>등록 팝업</span></a>
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
                        <th width="80">등록일시</th>
                        <th width="80">카드번호</th>
                        <th width="80">처리구분</th>
                        <th width="700">BL등록사유</th>
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


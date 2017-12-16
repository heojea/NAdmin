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
	$('#tr_paymethod_cd').bind("change",function(){
		var txt = $("#tr_paymethod_cd option:selected").text();
		var val = $("#tr_paymethod_cd option:selected").val();
		addPayMethod(txt , val);
	})
}

/**
	target paymethod add
*/
var methodArray = [];
var tr = $("<tr></tr>");
 function addPayMethod(txt , val){
	 if(val==""){
	    	$("#g_order_payMethod tbody").html("");
	    	methodArray = [];
	    	$("#payMethod_arr").val(methodArray);
	    	return;
	 }
	 
	  for ( var i = 0; i < methodArray.length; i++) {
      		if(methodArray[i]==val)return;
	  }
	  
	  if(methodArray.length%5==0)tr = $("<tr></tr>");
	  methodArray.push(val);
	  
	  var tdHtml = txt;
	      tdHtml +="<img src=\"${cfn:getString('system.static.path')}/images/common/clear_icon.gif\" align=\"top\" onclick=\"removePayMethod(this);\" style=\"cursor:pointer;\" />";
	      tdHtml +="<input type=\"hidden\" value=\"" + val + "\" name=\"payMethod_arr\" id=\"payMethod_arr\" />";

	      
	  $("<td></td>").html(tdHtml).appendTo(tr);
	  tr.appendTo($("#g_order_payMethod tbody"));
	  $("#payMethod_arr").val(methodArray);
}

/**
  target paymethod remove
 */
function removePayMethod(thisV){
	$(thisV).closest("td").remove();
	var inputVal = $(thisV).next().val();
	for ( var i = 0; i < methodArray.length; i++) {
  		if(methodArray[i]==inputVal) methodArray.splice(i,1);
    }
	
	$("#payMethod_arr").val(methodArray);
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
	
	goAction("search_tr_result_cd" , "search_group_cd=DC_RLT_I"  , "<c:url value='/common/commonCode.json'/>");
	goAction("tr_paymethod_cd"     , "search_group_cd=PAYMETHOD" , "<c:url value='/common/commonCode.json'/>");
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
        url: "<c:url value='/close/mobileClose.json'/>",
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
                    	$("#sumamt1").html("총건수 : "+formatNumber(item.TOT_CNT));
                    	$("#sumamt2").html("총합계(충전금액) : "+formatNumber(item.TOT_AMT));
                    }else{
                    	
	                   	$("<td></td>").html(formatDate(item.DAY_CLOSE_DATE)).appendTo(tr);
	                   	$("<td></td>").html(item.TR_TRANS_ID).appendTo(tr);
	                    $("<td></td>").html(item.CARD_ID).appendTo(tr);
	                    $("<td></td>").html(item.MOBILE_NO).appendTo(tr);
	                    $("<td style=\"text-align:right\"></td>").html(formatNumber(item.TR_BEF_AMT)).appendTo(tr);
	                    $("<td style=\"text-align:right\"></td>").html(formatNumber(item.TR_REQ_AMT)).appendTo(tr);
	                    $("<td style=\"text-align:right\"></td>").html(formatNumber(item.TR_AFT_AMT)).appendTo(tr);
	                    $("<td style=\"text-align:right\"></td>").html(formatNumber(item.TR_FEE_AMT)).appendTo(tr);
	                    $("<td></td>").html(item.TR_RESULT_CD).appendTo(tr);
	                    $("<td></td>").html(item.TR_ENTPRI_CD).appendTo(tr);
	                    $("<td></td>").html(item.PAYMETHOD_NM).appendTo(tr);
	                    $("<td></td>").html(item.EVENT_CD).appendTo(tr);
	                    $("<td></td>").html(item.TR_REQ_DTIME).appendTo(tr);
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
        ,error : function() {
        	alert("data Exception ~");
        }
    });
}

function excelFileDownload() {
	$("#excelType").val("excelType");
	document.f_cond.action = "/close/mobileCloseExcel.do";
	document.f_cond.submit();
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
 <c:import url="/view.do?viewName=location&layout=common" />
    <div class="h2">
        <h2>모바일 충전 마감 내역 조회</h2>
    </div>

    <div id="tab1_page">
    <form name="f_cond" id="f_cond" onsubmit="return false">
        <input type="hidden" value="excelType" name="excelType" id="excelType" />
        <div class="bbs_search">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond">
	                <th width="50">마감일자</th>
	                <td width="250">
	                    <input type="text" name="start_dt" id="start_dt" class="text" style="width:70px;text-align:center;"/>
	                    <img src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" onclick="openCal('start_dt','start_dt','end_dt');" />
	                    ~
	                    <input type="text" name="end_dt" id="end_dt" class="text" style="width:70px;text-align:center;"/>
	                    <img src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" onclick="openCal('end_dt','start_dt','end_dt');" />
	                </td>
	                <td width="10"></td>
	                <th width="70">거래번호</th>
	                	<td width="80">
	                    	<input type="text" value="" id="search_trans_id" name="search_trans_id" />
						</td>
					<td width="10"></td>	
	                <th width="70">카드번호</th>
	                	<td width="80">
	                    	<input type="text" value="" id="search_card_id" name="search_card_id" />
						</td>
	                
	                <td class="right">
	                	<a href="#" class="btn" id="btn_sel"><span>조회</span></a>
	                	<a href="javascript:excelFileDownload()" class="btn_s right" id="btn_excel"><span>EXCEL</span></a>
	                </td>
	            </tr>
	            <tr id="d_cond">
	                <th>이통사</th>
	                <td>
	                    <select name="search_mtelcm_cd">
							<option value="">전체</option>
							<option value="MK100301">SKT</option>
							<option value="MK100302">KT</option>
							<option value="MK100303">LGU</option>
						</select>
	                </td>
	                <td width="10"></td>
					<th>전화번호</th>
	                	<td >
	                    	<input type="text" value=""  id="search_cust_tel" name="search_cust_tel" />
 	                	</td>	
 	                <td width="10"></td>
	            </tr>
	            <tr id="d_cond">
	                <th>마감결과</th>
	                <td>
	                    <select name="search_tr_result_cd" id="search_tr_result_cd" style="width:150px;">
							<option value="">전체</option>
						</select>
	                </td>
	                <td width="10"></td>
	                
	                <th width="40">결제수단</th>
	            	<td width="100" colspan="2">
	            	 	<select name="tr_paymethod_cd" id="tr_paymethod_cd">
	            	 		<option value="">전체</option>
	            	 	</select>
	            	</td>
	            </tr>
	            </tr>
            </table>
        </div>
        
        <div class="bbs_grid" style="height:150px">
            <table id="g_order_payMethod" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="80" colspan="20">결제수단 조회 리스트</th>
                        <input type="hidden" value=""  name="payMethod_arr" id="payMethod_arr" />
                    </tr> 
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond2">
	            	<td width="*">&nbsp;</td>
	                <th width="150" id="sumamt1">총건수 : 0</th>
	                <th width="300" id="sumamt2">총합계(충전금액) : 0</th>
	            </tr>
            </table>
        
        <!--  column 정보   -->
        <div class="bbs_grid" style="height:570px">
            <table id="g_order" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="50">마감일</th>
						<th width="100">거래번호</th>
						<th width="80">카드번호</th>
						<th width="50">전화번호</th>
						<th width="50">충전 전 금액</th>
						<th width="50">충전 금액</th>
						<th width="50">충전 후 금액</th>
						<th width="30">수수료</th>
						<th width="100">마감결과</th>
						<th width="50">업체코드</th>
						<th width="150">결제수단</th>
						<th width="50">이벤트</th>
						<th width="80">거래일자</th>
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


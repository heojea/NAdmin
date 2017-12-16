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
	
	$("#search_bank_selected").bind("change",function(){
		if(this.value == '1'){
			$("#search_bankCd").val("");
			$("#search_bankCd").attr("readonly",false);
		}else{
			$("#search_bankCd").val(this.value);	
			$("#search_bankCd").attr("readonly",true);
		}
	});		
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
        url: "<c:url value='/account/payment.json'/>",
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
                    	$("#sumamt1").html("결제건수 : "+formatNumber(item.paySuccCnt));
                    	$("#sumamt2").html("결제금액 : "+formatNumber(item.paySuccSum));
                    	$("#sumamt3").html("취소건수 : "+formatNumber(item.payCanCnt + item.payPartCanCnt));
                    	$("#sumamt4").html("취소금액 : "+formatNumber(item.payCanSum + item.payPartCanSum));
                    	$("#sumamt5").html("정산금액 : "+formatNumber(item.paySuccSum - (item.payCanSum + item.payPartCanSum)));
                    }else{
	                   	$("<td></td>").html(formatDate(item.day_close_date)).appendTo(tr);
	                   	$("<td></td>").html(item.tr_class_nm).appendTo(tr);
	                    $("<td></td>").html(item.tr_trans_id).appendTo(tr);
	                    $("<td></td>").html(item.tr_order_no).appendTo(tr);
	                    $("<td></td>").html(item.tr_sub_channel_nm).appendTo(tr);
	                    $("<td></td>").html(item.mstor_nm).appendTo(tr);
	                    $("<td></td>").html(item.pay_nm).appendTo(tr);
	                    $("<td></td>").html(item.comm_set_nm).appendTo(tr);
	                    $("<td></td>").html(item.pay_commset).appendTo(tr);
	                    $("<td></td>").html(formatNumber(item.tr_req_amt)).appendTo(tr);
	                    $("<td></td>").html(formatNumber(item.pay_comm)).appendTo(tr);
	                    $("<td></td>").html(formatNumber(item.sup_tmonet)).appendTo(tr);
	                    $("<td></td>").html(item.vat_tmonet).appendTo(tr);
	                    $("<td></td>").html(formatNumber(item.PAY_AMT)).appendTo(tr);
	                    $("<td></td>").html(formatDate(item.pay_day)).appendTo(tr);
	                    $("<td></td>").html(formatDate(item.batch_day)).appendTo(tr);
	                 
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
	$("#excelType").val("excelType");
	document.f_cond.action = "/account/paymentExcel.do";
	document.f_cond.submit();
}


function agentPopup() {
	window.showModalDialog('/account/agent.do', document.f_cond, 'dialogWidth:910px;dialogHeight:420px;status:no;help:no;scroll:auto;fullscreen=no;menubar=no;toolbar=no;titlebar=no;location=no;scrollbars=no;');
}

function agentClear() {
	//document.f_cond.search_agent_id.value = document.f_cond.agent_id.value;
	document.f_cond.search_agent_id.value = "";
	document.f_cond.search_agent_nm.value = "";
}
</script>

</head>
<body>
<!-- wrap -->
<div id="wrap">
 <c:import url="/view.do?viewName=location&layout=common" />
    <div class="h2">
        <h2>지불정산내역 조회 조건</h2>
    </div>

    <div id="tab1_page">
    <form name="f_cond" id="f_cond" onsubmit="return false">
        <input type="hidden" value="excelType" name="excelType" id="excelType" />
        <div class="bbs_search">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond">
	            	<!--  일자 거래조건  -->
	            	<th width="50">일자구분</th>
	            	<td width="10">
	                    <input type="radio" value="true"  id="search_closeDate" name="search_closeDate" checked />거래일자
	                    <input type="radio" value=""  id="search_closeDate" name="search_closeDate" />지급일자
 	                </td>
	                <td width="200">
	                    <input type="text" name="start_dt" id="start_dt" class="text" style="width:70px;text-align:center;"/>
	                    <img src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" onclick="openCal('start_dt','start_dt','end_dt');" />
	                    ~
	                    <input type="text" name="end_dt" id="end_dt" class="text" style="width:70px;text-align:center;"/>
	                    <img src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" onclick="openCal('end_dt','start_dt','end_dt');" />
	                </td>
 	                	
 	                 <td class="right" width="600">
	                	<a href="#" class="btn" id="btn_sel"><span>조회</span></a>
	                	<a href="javascript:excelFileDownload()" class="btn_s right" id="btn_excel"><span>EXCEL</span></a>
	                </td>
	            </tr>
	            
	         
	            
	            <tr>
	                <th width="50">거래구분</th>
	            	<td width="100" colspan="2">
	            		<input type="radio" value=""  id="search_trClassNm" name="search_trClassNm" checked />전체거래
	            		<input type="radio" value="지불"  id="search_trClassNm" name="search_trClassNm" />지불거래
	            		<input type="radio" value="지불취소"  id="search_trClassNm" name="search_trClassNm" />취소거래
	            		<input type="radio" value="지불부분취소"  id="search_trClassNm" name="search_trClassNm" />부분취소거래	 
	            	</td>
	            </tr>
	            
	            <tr id="d_cond">
	                <th width="50">결제수단</th>
	            	<td width="20">
	            		<input type="radio" value=""  id="search_inApp" name="search_inApp" checked />전체거래
	            		<input type="radio" value="false"  id="notInApp" name="search_inApp" />온라인
	            		<input type="radio" value="true"  id="InApp" name="search_inApp" />인앱
	            	</td>
	            </tr>
	            
	            <tr id="d_cond">
	                <th width="30">거래번호</th>
	                <td><input type="text" value=""  id="serach_trTransId" name="serach_trTransId" /></td>
	            </tr>
	            
	            <tr id="d_cond">
	                <th width="10">주문번호</th>
	                <td><input type="text" value=""  id="search_trOrderNo" name="search_trOrderNo" /></td>
	            </tr>
	          
	            <tr id="d_cond">
	                <th width="20">가맹점</th>
	            	<td width="20" colspan="2">
	            	    <input type="hidden" name="search_agent_id" value="" />
	            		<input type="text" name="search_agent_nm" value="" readonly="readonly" />
	            		<img src="${cfn:getString('system.static.path')}/images/common/select_icon.gif" align="top" onclick="agentPopup();">
						<img src="${cfn:getString('system.static.path')}/images/common/clear_icon.gif" align="top" onclick="agentClear();">
	            	</td>
	            </tr>
	             <tr id="d_cond">
	                <th width="30">지급대상업체</th>
	                <td><input type="text" value=""  id="search_pay_nm" name="search_pay_nm" /></td>
	            </tr>	
            </table>
        </div>
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond2">
	            	<td width="*">&nbsp;</td>
	                <th width="150" id="sumamt1">결제건수 : 0</th>
	                <th width="200" id="sumamt2">결제금액 : 0</th>
	                <th width="150" id="sumamt3">취소건수 : 0</th>
	                <th width="200" id="sumamt4">취소금액 : 0</th>
	                <th width="200" id="sumamt5">정산금액 : 0</th>
	                
	            </tr>
            </table>
        
        <div class="bbs_grid" style="height:570px">
            <table id="g_order" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="50">거래일</th>
                        <th width="50">거래구분</th>
                        <th width="100">거래번호</th>
                        <th width="100">주문번호</th>
                        <th width="50">통신사</th>
                        <th width="100">가맹점명</th>
                        <th width="100">지급대상업체</th>
                        <th width="50">수수료유형</th>
                        <th width="50">수수료율</th>
                        <th width="50">거래금액</th>
                        <th width="50">수수료</th>
                        <th width="50">공급가</th>
                        <th width="50">부가세</th>
                        <th width="50">지급금액</th>
                        <th width="50">지급일자</th>
                        <th width="70">데이터생성일</th>
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

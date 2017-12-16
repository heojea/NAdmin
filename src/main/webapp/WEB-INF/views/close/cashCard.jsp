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
        url: "<c:url value='/cash/cashCard.json'/>",
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
                    	$("#sumamt2").html("성공건수 : "+formatNumber(item.SUCC_TOT_CNT));
                    	$("#sumamt3").html("실패건수 : "+formatNumber(item.FAIL_TOT_CNT));
                    }else{
                    	$("<td></td>").html(item.CHG_SER       ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.P_METHOD      ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.PG_AMT    		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.PG_TR_NO  		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.CARD_ID   		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.MOBILE_NO 		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.BFR_AMT   		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.FEE_AMT   		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.CHG_AMT   		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.AFT_AMT   		 ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.SIGN2         ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.STATUS_TR     ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.STATUS_CHG    ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.CHG_CARD_GUBUN).appendTo(tr);                                                           
                    	$("<td></td>").html(item.REQ_DH        ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.STATUS_DATE   ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.CHG_CARD      ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.STATUS        ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.PG_RES_CD     ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.PG_RES_MSG    ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.KSCC_GUBUN    ).appendTo(tr);                                                           
                    	$("<td></td>").html(item.DATAGUBUN     ).appendTo(tr);                                                           
                    	                                                   
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
	document.f_cond.action = "/cash/cashCardExcel.do";
	document.f_cond.submit();
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
 <c:import url="/view.do?viewName=location&layout=common" />
    <div class="h2">
        <h2>신용카드 선불 정산 조회조건</h2>
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
	                
	                <td class="right">
	                	<a href="#" class="btn" id="btn_sel"><span>조회</span></a>
	                	<a href="javascript:excelFileDownload()" class="btn_s right" id="btn_excel"><span>EXCEL</span></a>
	                </td>
	            </tr>
            </table>
        </div>
        
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond2">
	            	<td width="*">&nbsp;</td>
	                <th width="150" id="sumamt1">총건수 : 0</th>
	                <th width="300" id="sumamt2">총합계(충전금액) : 0</th>
	                <th width="300" id="sumamt3">총합계(충전금액) : 0</th>
	            </tr>
            </table>
        
        <!--  column 정보   -->
        <div class="bbs_grid" style="height:570px;">
            <table id="g_order" class="bbs_grid" cellpadding="0" cellspacing="0" border="0" style="width:2000px;">
                <thead>
                    <tr>
                        <th width="50">거래번호</th>
						<th width="100">거래수단코드</th>
						<th width="80">PG사거래금액</th>
						<th width="50">PG사승인번호</th>
						<th width="50">카드번호</th>
						<th width="50">핸드폰번호</th>
						<th width="50">충전 전 금액</th>
						
						<th width="30">수수료</th>
						<th width="100">충전금액</th>
						<th width="50">충전 후 금액</th>
						<th width="150">HSM인증여부</th>
						<th width="50">승인상태</th>
						<th width="80">충전상태</th>
						<th width="80">카드구분</th>
						<th width="80">거래일시</th>
						<th width="80">취소일시</th>
						<th width="80">CHG_CARD</th>
						<th width="80">STATUS</th>
						<th width="80">PG_RES_CD</th>
						<th width="80">PG_RES_MSG</th>
						<th width="80">KSCC_GUBUN</th>
						<th width="80">DATA_GUBUN</th>
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


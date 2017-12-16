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
	
	//payment onchage event
	$('#search_pay_com_cd').change(function() {
		payComCdAjaxCall();
	});
	
	//payment onchage event
	$('#search_prod_nm').change(function() {
		prodNmAjaxCall();
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
	
	//init change action ~
	$('#search_pay_com_cd').change();
});

function prodNmAjaxCall(){
	var existVal = $("select[name='search_prod_nm']").val();
	 $.ajax({
	        type: 'POST',        
	        url: "<c:url value='/account/prodNmAjaxCall.json'/>",
	        data: formSerialize("#f_cond"),
	        dataType: 'json',
	        
	        /* success logic  */
	        success: function(data) {
	        	for(var i=0 ; i < data.length ; i++){
	        		$("select[name='search_prod_nm']").find('option').each(function() {
		        	    if(this.value != "")$(this).remove();
		            });
	        		
		        	for(var i=0 ; i < data.length ; i++){
		        		var selectedV = existVal == data[i].PROD_CD ? "selected" : "";
		        		var html = "<option value=\"" + data[i].PROD_CD + "\"  " + selectedV + ">" + data[i].PROD_NM + "</option>";
		        		$('#search_prod_nm').append(html);
		        	}
	        	}
	        },
	        error :function(data){
	        	alert("fail~")
	        }
	        
	      
	    });
}

function payComCdAjaxCall(){
	var existVal = $("select[name='search_pay_com_cd']").val();
	 $.ajax({
	        type: 'POST',        
	        url: "<c:url value='/account/payComCdAjaxCall.json'/>",
	        data: formSerialize("#f_cond"),
	        dataType: 'json',
	        
	        /* success logic  */
	        success: function(data) {
	        	$("select[name='search_pay_com_cd']").find('option').each(function() {
	        	    if(this.value != "")$(this).remove();
	            });
	        	
	        	for(var i=0 ; i < data.length ; i++){
	        		var selectedV = existVal == data[i].TM_CP_NM ? "selected" : "";
	        		/* var hanPayComCd = hangulPayComCd(data[i].PAY_COM_CD)=="" ? data[i].PAY_COM_CD : hangulPayComCd(data[i].PAY_COM_CD) ; */
	        		
	        		var html = "<option value=\"" + data[i].TM_CP_NM + "\"  " + selectedV + ">" + data[i].TM_CP_NM + "</option>";
	        		$('#search_pay_com_cd').append(html);
	        	}
	        	//second select ajax call
	        	$('#search_prod_nm').change();
	        },
	        error :function(data){
	        	alert("fail~")
	        }
	    });
}

/* function hangulPayComCd(targetV){
	var returnValue = "";
	switch(targetV){
	    case 'TEENCASH'       : returnValue = '틴캐시'                      
		break;
		case 'ITEM_MANIA'     : returnValue = '아이템매니아'
		break;
		case 'ITEM_BAY'       : returnValue = '아이템베이'  
		break;
		case 'HAPPY_ONLINE'   : returnValue = '해피머니'    
		break;
		case 'GXIA_SEVEN'     : returnValue = 'SEVEN편의점' 
		break;
		case 'GXIA_GS25'      : returnValue = 'GS편의점'    
		break;
		case 'GXIA_CU'        : returnValue = 'CU편의점'    
		break;
		case 'EGGMONEY'       : returnValue = '에그머니'    
		break;
		case 'CULTURE_SMART'  : returnValue = '문화상품권'  
		break;
		case 'CULTURE_ONLINE' : returnValue = '스마트문상'  
		break;
		case 'BOOKNLIFE'      : returnValue = '도서문화'     
		break;
	}
	return returnValue;
} */

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
        url: "<c:url value='/account/giftCard.json'/>",
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
                    	//총계 표현
                    	if(item.REG_DH==null && item.PROD_NM==null && item.PAY_COM_CD==null){
                    		$("<td colspan=\"3\"></td>").html("총계").appendTo(tr);
                    	}else if(item.REG_DH==null && item.PROD_NM==null){
                    		$("<td colspan=\"2\"></td>").html("소계").appendTo(tr);
                    		$("<td></td>").html(item.PAY_COM_CD).appendTo(tr);
                    	}else{
                    		$("<td></td>").html(formatDate(item.REG_DH)).appendTo(tr);
                        	$("<td></td>").html(item.PROD_NM).appendTo(tr);
                        	$("<td></td>").html(item.PAY_COM_CD).appendTo(tr);
                    	}
                    	
                    	$("<td></td>").html(item.PROD_NM_CNT).appendTo(tr);
                    	$("<td></td>").html(formatNumber(item.AMT)).appendTo(tr);
                    	$("<td></td>").html(item.CANCEL_PROD_NM_CNT).appendTo(tr);
                    	$("<td></td>").html(formatNumber(item.CANCELAMT)).appendTo(tr);	
                    	$("<td></td>").html(item.TM_FEE).appendTo(tr);
                    	$("<td></td>").html(formatNumber(item.STORE_MEMBER_FEE)).appendTo(tr);
                    	$("<td></td>").html(formatNumber(item.PROVIDER_PRICE)).appendTo(tr);
                    	$("<td></td>").html(formatNumber(item.SURTAX)).appendTo(tr);
                    	$("<td></td>").html(formatNumber(item.COST_PRESS)).appendTo(tr);
                    	$("<td></td>").html(formatNumber(item.REQ_AMT)).appendTo(tr);
                    	$("<td></td>").html(item.DISCOUNT_RATE).appendTo(tr);
                		$("<td></td>").html(formatNumber(item.DISCOUNT_PAY)).appendTo(tr);
	                    //$("<td></td>").html(formatNumber(item.PAY_AMT)).appendTo(tr);
	                    //$("<td></td>").html(formatDate(item.pay_day)).appendTo(tr);
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
                        //paintPager(list.page, list.cpp, list.totalCnt, 'doSearch')
                );
            }
        } 
    });
}


function excelFileDownload() {
	$("#excelType").val("excelType");
	document.f_cond.action = "/account/giftCardExcel.do";
	document.f_cond.submit();
}
</script>

</head>
<body>
<!-- wrap -->
<div id="wrap">
 <c:import url="/view.do?viewName=location&layout=common" />
    <div class="h2">
        <h2>내역 조회-</h2>
    </div>

    <div id="tab1_page">
    <form name="f_cond" id="f_cond" onsubmit="return false">
        <input type="hidden" value="excelType" name="excelType" id="excelType" />
        <div class="bbs_search">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	            <tr id="d_cond">
	            	<!--  일자 거래조건  -->
	            	<th width="50">거래일자</th>
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
	                <th width="40">지급대상</th>
	            	<td width="100" colspan="2">
	            	 	<select name="search_pay_com_cd" id="search_pay_com_cd">
	            	 		<option value="">전체</option>
	            	 	</select>
	            	</td>
	            </tr>
	            
	            <tr id="d_cond">
	                <th width="40">상품권 유형</th>
	            	<td width="20">
	            		<select name="search_prod_nm" id="search_prod_nm">
	            	 		<option value="">전체</option>
	            	 	</select>
	            	</td>
	            </tr>
	            
	            <!-- 
	            <tr id="d_cond">
	                <th width="20">결제수단</th>
	            	<td width="20" colspan="2">
	            		<input type="radio" name="search_agent_nm" value=""  />온라인 
	            		<input type="radio" name="search_agent_nm" value=""  />인앱
	            	</td>
	            </tr>
	            -->
            </table>
        </div>
        <div class="bbs_grid" style="height:570px">
            <table id="g_order" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="50">거래일자</th>
                        <th width="100">상품명</th>
                        <th width="100">지급 가맹점</th>
                        <th width="50">거래건수</th>
                        <th width="100">액면금액</th>
                        <th width="50">취소건수</th>
                        <th width="50">취소금액</th>
                        <th width="50">판매수수료율</th>
                        <th width="50">가맹점수수료</th>
                        <th width="50">공급가</th>
                        <th width="50">부가세</th>
                        <th width="50">대금지급금액</th>
                        <th width="50">판매금액</th>
                        <th width="30">할인율</th>
                        <th width="50">할인금액</th>
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

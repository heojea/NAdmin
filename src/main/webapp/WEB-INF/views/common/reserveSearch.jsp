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
    
    $("#btn_com").click(function() {reserveSearch();});
    $("#btn_sel").click(function() {doSearch();}); 
    
});

function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pmon/pmonm501/carReserveSearch.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_car_schedule tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = eval(list[i]);
                    var tr = $("<tr></tr>");
                    
                    $("<td></td>").addClass("left").html(item.REG_DAYS).appendTo(tr);
                    //$("<td></td>").html(i+1).appendTo(tr);
                    //if (gvsa) $("<td></td>").addClass("left").html((item.SITE_ACTIVE_YN == 'N'?"<span class='inactive'>":"")+val(item.SITE_NM)).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID0).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID1).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID2).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID3).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID4).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID5).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID6).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID7).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID8).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RESERVATION_ID9).appendTo(tr);
                    tr.appendTo($("#g_car_schedule tbody"));
                }
                paintGrid("g_car_schedule");
            }
        } 
    });
}

function reserveSearch(){

    $.ajax({
        type: 'POST',
        url: "<c:url value='/controllCar.json'/>",
        data: formSerialize("#f_cond")+'&service_cd=1033',
        dataType: 'json',
        async: false,
        success: function(data) {
            var item = eval(data);
            if (item.result == '200') {
                alert('정상적으로 요청 되었습니다');
            }
            else {
                alert('처리시 오류가 발생하였습니다');
                if (item.RESULT_MSG != '') {
                    alert(item.RESULT_MSG);
                }
            }
        }
    });
}
</script>
</head>
<body>
<!-- wrap -->
<div style="width:900px;">

    <div class="h2" style="width:900px">
        <h2>예약조회</h2>
    </div>
    <div id="reserveList" class="bbs_search_c" style="padding-top:9px;width:910px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}"></input>
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}"></input>
        <input type="hidden" id="h_site_order_id" name="h_car_mgr_no" value="${param.car_mgr_no}"></input>
        
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	        <tr>
	            <th width="80" class="point">조회일자</th>
	            <td width="220" style="padding-left:2px"><a href="#" class="btn_s" id="btn_com"><span>조회발송</span></a></td>
	            <td class="right"><a href="#" class="btn_s" id="btn_sel"><span>조회</span></a></td>
	        </tr>
        </table>
        </form>            
    
        <div class="bbs_list" style="height:170px">
            <table id="g_car_schedule"cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="160px">날짜</th>
                    <th width="80px">예약1</th>
                    <th width="80px">예약2</th>
                    <th width="80px">예약3</th>
                    <th width="80px">예약4</th>
                    <th width="80px">예약5</th>
                    <th width="80px">예약6</th>
                    <th width="80px">예약7</th>
                    <th width="80px">예약8</th>
                    <th width="80px">예약9</th>
                    <th width="80px">예약10</th>
                </tr>              
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>       
    </div>   
</div>
</body>
</html>


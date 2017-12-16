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
    $("#btn_sel").click(function() {doSearch();});
    
    $("#s_cal_start_dy").click(function() {openCal("s_cal_start_dy","s_cal_start_dy","s_cal_end_dy");});
    $("#m_cal_start_dy").click(function() {openCal("s_cal_start_dy","s_cal_start_dy","s_cal_end_dy");});
    $("#s_cal_end_dy").click(function() {openCal("s_cal_end_dy","s_cal_start_dy","s_cal_end_dy");});
    $("#m_cal_end_dy").click(function() {openCal("s_cal_end_dy","s_cal_start_dy","s_cal_end_dy");});  
    
    var date = getDate();
    $("#s_cal_start_dy").val(date.LAST_5_DAY);
    $("#s_cal_end_dy").val(date.YYYYMMDD);  
    
});

function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pdrv/pdrvm101/carScheduleReserveList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_car_schedule tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = eval(list[i]);
                    var tr = $("<tr></tr>");
                    
                    $("<td></td>").html("<input type='radio' name='i_site_order_id' value='"+val(item.SITE_ORDER_ID+"A"+item.RETURN_YN+"A"+item.CAR_AUTH_DT)+"'/>").appendTo(tr);
                    //$("<td></td>").html(i+1).appendTo(tr);
                    //if (gvsa) $("<td></td>").addClass("left").html((item.SITE_ACTIVE_YN == 'N'?"<span class='inactive'>":"")+val(item.SITE_NM)).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.SITE_MEMBER_NM).appendTo(tr);
                    $("<td></td>").html(formatDate(item.RESERVE_DT)).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.RETURN_YN == 'Y'? "반납됨":"미반납").appendTo(tr);
                    //$("<td></td>").addClass("left").html(item.CAR_MODEL_NM).appendTo(tr);
                    //$("<td></td>").addClass("left").html("<a href='javascript:loadCarSchedule(\""+item.SITE_ID+"\", \""+item.CAR_ID+"\")'>"+(item.USE_YN == 'N'?"<span class='inactive'>":"")+val(item.CAR_NM)).appendTo(tr);
                    $("<td></td>").html(formatDate(item.RENT_DY+item.RENT_TM)+" ~ "+formatDate(item.RETURN_SCH_DY+item.RETURN_SCH_TM)).appendTo(tr);
                    tr.appendTo($("#g_car_schedule tbody"));
                }
                paintGrid("g_car_schedule");
            }
        } 
    });
}

</script>
</head>
<body>
<!-- wrap -->
<div style="width:510px;">

    <div class="h2" style="width:500px">
        <h2>예약 수신 확인</h2>
    </div>
     
    <div class="tab_s" style="margin-top:10px">
        <ul>
            <li id="tab1_top_s" class="on"><span><a href="#" id="tab1_top_title_s">예약조회</a></span></li>
        </ul>
    </div>
    <div id="tab1_page_s" class="bbs_search_c" style="padding-top:9px;width:508px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}"></input>
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}"></input>
        <input type="hidden" id="h_car_id" name="h_car_mgr_no" value="${param.car_mgr_no}"></input>
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">                
        <tr>
            <th width="80" class="point">조회일자</th>
            <td width="220" style="padding-left:2px"><input type="text" class="inputRead center" readonly="true" name="s_cal_start_dy" id="s_cal_start_dy" style="width:70px;" /> <img id="m_cal_start_dy" src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" /> ~
                            <input type="text" class="inputRead center" readonly="true" name="s_cal_end_dy" id="s_cal_end_dy" style="width:70px;" /> <img id="m_cal_end_dy" src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" /></td>
            <td class="right"><a href="#" class="btn_s" id="btn_sel"><span>조회</span></a></td>
        </tr>
        </table>
        </form>            
    
        <div class="bbs_list" style="height:450px">
            <table id="g_car_schedule" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="30">선택</th>
                    <th width="80">고객명</th>
                    <th width="110">예약일자</th>
                    <th width="60">반납여부</th>
                    <th>대여시간</th>
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














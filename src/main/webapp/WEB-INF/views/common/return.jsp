<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<script type="text/javascript">
var s_rent_dy = "${carDist.RENT_DY}";
var s_rent_tm = "${carDist.RENT_TM}";
var s_rent_t = s_rent_tm.substring(0,2);
var s_rent_m = s_rent_tm.substring(2,4);
var s_return_sch_dy = "${carDist.RETURN_SCH_DY}";
var s_return_sch_tm = "${carDist.RETURN_SCH_TM}";
var s_return_sch_t = s_return_sch_tm.substring(0,2);
var s_return_sch_m = s_return_sch_tm.substring(2,4);
var s_max_return_sch_dtm = "${carDist.MAX_RETURN_SCH_DTM}";
$(document).ready(function() {
	var s_max_return_sch_dy = s_max_return_sch_dtm.substring(0,4)+"-"+s_max_return_sch_dtm.substring(4,6)+"-"+s_max_return_sch_dtm.substring(6,8);
    $("#btn_return").click(function() {carConReturn();}); //강제반납 버튼 클릭시
    //달력셋팅 step2
    $("#i_return_sch_dy_step2" ).datepicker($.extend({}, calendarDefaultOption, {
         onSelect: function( selectedDate, inst ) {
             instance = $( this ).data( "datepicker" );
             var option = this.id == instance.settings.minObjId ? "minDate" : "maxDate",
                     date = $.datepicker.parseDate(
                             instance.settings.dateFormat || $.datepicker._defaults.dateFormat,
                             selectedDate, 
                             instance.settings );
             var obj = (option == 'minDate') ? instance.settings.maxObjId : instance.settings.minObjId;
             $('#' + obj ).datepicker( "option", option, date );
         },
         minDate: "${carDist.RENT_DY}",
         maxDate: s_max_return_sch_dy
    }));
    $("#s_return_sch_hh_step2").val(s_return_sch_t);
    $("#s_return_sch_mm_step2").val(s_return_sch_m);
});

function carConReturn(){
	var i_return_sch_dy_step2 = $("#i_return_sch_dy_step2").val();
	var s_return_sch_tm_step2 = $("#s_return_sch_hh_step2").val()+$("#s_return_sch_mm_step2").val();
	if($('#h_car_id').val() == null || $('#h_car_id').val() == "") {
		alert("차량코드가 존재하지 않습니다. 재접속후 다시 시도해주세요");
		return;
	}
	if(s_rent_dy == i_return_sch_dy_step2) {
		if(new Number(s_rent_tm) >= new Number(s_return_sch_tm_step2)) {
			alert("에약시작시간 이전으로의 반납은 불가합니다.");
			return
		};
	}
	if(new Number(i_return_sch_dy_step2.replaceAll("-","")+s_return_sch_tm_step2) > new Number(s_max_return_sch_dtm)) {
		alert("예약종료 3일 이내에서만 강제반납 가능합니다.");
		return
	}
	
	$("#s_year").val(i_return_sch_dy_step2.substring(0,4));
	$("#s_month").val(i_return_sch_dy_step2.substring(5,7));
	$("#s_day").val(i_return_sch_dy_step2.substring(8,10));
	$("#s_hour").val($("#s_return_sch_hh_step2").val());
	$("#s_minute").val($("#s_return_sch_mm_step2").val());
	
	s_max_return_sch_dtm
	
    /*
    if($("#s_car_use_dist").val().length < 1){
        alert("이용거리를 입력하세요");
        $("#s_car_use_dist").focus();
        return; 
    }
    */
    if (!confirm('반납 하시겠습니까?')) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/carConplusionReturn.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        async: false,
        success: function(data) {
            var item = eval(data);
            if (item.RESULT_CD == 'Y') {
                alert('이미 반납이 된 예약입니다');
            }
            else {
                alert('반납이 정상적으로 처리되었습니다');
                window.close();
            }
        }
    });
    
    
}

</script>
</head>
<body>
<!-- wrap -->
<div style="width:350px;">

    <div class="h2" style="width:340px">
        <h2>강제 반납</h2>
    </div>
    <div class="bbs_search" style="width:348px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}"></input>
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}"></input>
        <input type="hidden" id="h_site_order_id" name="h_site_order_id" value="${param.site_order_id}"></input>
        <input type="hidden" id="s_car_use_dist" name="s_car_use_dist" value="${carDist.CAR_USE_DIST}"></input>
        <input type="hidden" id="s_year" name="s_year" value=""></input>
        <input type="hidden" id="s_month" name="s_month" value=""></input>
        <input type="hidden" id="s_day" name="s_day" value=""></input>
        <input type="hidden" id="s_hour" name="s_hour" value=""></input>
        <input type="hidden" id="s_minute" name="s_minute" value=""></input>
        
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr height="100">
		        <td class="center">
		            반납일시 : <input type="text" name="i_return_sch_dy_step2" id="i_return_sch_dy_step2" style="width:70px;text-align:center;" class="text" value="${carDist.RETURN_SCH_DY}" readonly/> 
		            &nbsp;&nbsp;
		            <select name="s_return_sch_hh_step2" id="s_return_sch_hh_step2" style="width:40px">
		                <c:forEach begin="0" end="23" var="tm" step="1"> 
		                	<option value="${cfn:lpad(tm,2,'0')}">${cfn:lpad(tm,2,'0')}</option>
		                </c:forEach>
		            </select> 시
		            &nbsp;&nbsp;
		            <select name="s_return_sch_mm_step2" id="s_return_sch_mm_step2" style="width:40px">
		                <c:forEach begin="0" end="59" var="mm" step="1"> 
		                	<option value="${cfn:lpad(mm,2,'0')}">${cfn:lpad(mm,2,'0')}</option>
		                </c:forEach>
		            </select> 분
		        </td>
            </tr>
            <!-- 
            <tr>
                <th width="80" class="point">총주행거리</th>
                <td colspan="3"><input type="text" class="inputRead right" id="s_car_use_dist" name="s_car_use_dist" style="width:50px;"></input>Km</td>
            </tr>
             -->
<!--             <tr>
                <th width="80" class="point">이용시간</th>
                <td colspan="3"><input type="text" class="inputRead right" id="s_car_use_min" name="s_car_use_min" style="width:50px;"></input>분</td>
            </tr>
            <tr> -->
                <td style="text-align: center;"><a href="#" class="btn_s" id="btn_return"><span>강제 반납</span></a></td>
            </tr>
        </table>
        </form> 
    </div>
</div>
</body>
</html>


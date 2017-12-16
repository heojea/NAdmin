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
    
    $("#btn_nfc").click(function() {reserveComplete();}); 
    
});

function reserveComplete(){

    $.ajax({
        type: 'POST',
        url: "<c:url value='/controllCar.json'/>",
        data: formSerialize("#f_cond")+'&service_cd=1034',
        dataType: 'json',
        async: false,
        success: function(data) {
            var item = eval(data);
            if (item.result == '200') {
                alert('정상적으로 요청 되었습니다');
                window.close();
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
<div style="width:350px;">

    <div class="h2" style="width:340px">
        <h2>강제예약</h2>
    </div>
    <div class="bbs_search" style="width:348px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}"></input>
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}"></input>
        <input type="hidden" id="h_site_order_id" name="h_car_mgr_no" value="${param.car_mgr_no}"></input>
        <input type="hidden" id="site_order_id" name="site_order_id" value="${reserve.ORDER_ID}"></input>
        
        
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr style="height: 30px">
                <th width="100" class="point">카드ID</th>
                <td colspan="3"><input type="text" class="inputRead left" id="site_nfc_no" name="site_nfc_no" style="width:100px;" value="${reserve.NFC_NO }"></input></td>
            </tr>
            <tr style="height: 30px">
                <th width="100" class="point">예약시작시간</th>
                <td colspan="3"><input type="text" class="inputRead left" id="site_start_date" name="site_start_date" style="width:100px;" value="${reserve.DAY1 }"></input></td>
            </tr>
            <tr style="height: 30px">
                <th width="100" class="point">예약종료시간</th>
                <td colspan="3"><input type="text" class="inputRead left" id="site_end_date" name="site_end_date" style="width:100px;" value="${reserve.DAY2 }"></input></td>
            </tr>
            <tr></tr>
            <tr>
                <td style="text-align: center;" colspan="4"><a href="#" class="btn_s" id="btn_nfc"><span>예약완료</span></a></td>
            </tr>
        </table>
        </form> 
    </div>
</div>
</body>
</html>


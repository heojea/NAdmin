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
    
    $("#btn_nfc").click(function() {adminNfcId();}); 
    
});

function adminNfcId(){

    $.ajax({
        type: 'POST',
        url: "<c:url value='/controllCar.json'/>",
        data: formSerialize("#f_cond")+'&service_cd=1014',
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
        <h2>관리자  RFID</h2>
    </div>
  
    <div class="bbs_search" style="width:348px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}"></input>
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}"></input>
        <input type="hidden" id="h_site_order_id" name="h_car_mgr_no" value="${param.car_mgr_no}"></input>
        
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr style="height: 38px">
                <th width="100" class="point">관리자 NFC INDEX</th>
                <td colspan="3"><input type="text" class="inputRead left" id="s_nfc_id" name="s_nfc_index" style="width:100px;"></input></td>
            </tr>
            <tr style="height: 38px">
                <th width="100" class="point">관리자 NFC ID</th>
                <td colspan="3"><input type="text" class="inputRead left" id="s_nfc_id" name="s_nfc_id" style="width:100px;"></input></td>
            </tr>
            <tr></tr>
            <tr>
                <td style="text-align: center;" colspan="4"><a href="#" class="btn_s" id="btn_nfc"><span>등록</span></a></td>
            </tr>
        </table>
        </form> 
    </div>
</div>
</body>
</html>


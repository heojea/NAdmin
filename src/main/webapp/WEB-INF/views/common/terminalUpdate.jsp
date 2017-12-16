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
	var terminal_ip = $("#s_terminal_ip").val();
	var terminal_port = $("#s_terminal_port").val();
	if(terminal_ip==null||terminal_ip=="") {
		alert("ip를 입력하지않아 기본 ip로 세팅됩니다.");
		$("#s_terminal_ip").val($("#h_tIp").val());
		var terminal_ip = $("#h_tIp").val();
	}
	if(terminal_port==null||terminal_port=="") {
		alert("port를 입력하지않아 기본 port로 세팅됩니다.");
		$("#s_terminal_port").val($("#h_tPort").val());
		terminal_port = $("#h_tPort").val();
	}
	if (confirm(" 차량의 접속 서버를\nip : "+terminal_ip+"\nport : "+terminal_port+"\n로 변경하시겠습니까?")) {
	    $.ajax({
	        type: 'POST',
	        url: "<c:url value='/controllCar.json'/>",
	        data: formSerialize("#f_cond")+'&service_cd=1012',
	        dataType: 'json',
	        async: false,
	        success: function(data) {
	            var item = eval(data);
	            if(item.result == '200'){
	                alert('정상적으로 요청 되었습니다');
	                self.close();
	            }else{
	                alert('처리시 오류가 발생하였습니다');
	            }
	        }
	    });
	}
}

</script>
</head>
<body>
<!-- wrap -->
<div style="width:350px;">

    <div class="h2" style="width:340px">
        <h2>단말기 설정 업데이트</h2>
    </div>
  
    <div class="bbs_search" style="width:348px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}" />
        <input type="hidden" id="h_site_order_id" name="h_site_order_id" value="${param.site_id}" />
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}" />
        <input type="hidden" id="h_car_mgr_no" name="h_car_mgr_no" value="${param.car_mgr_no}" />
        <input type="hidden" id="h_tIp" name="h_tIp" value="${terminal_ip}" />
        <input type="hidden" id="h_tPort" name="h_tPort" value="${terminal_port}" />
        
        
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr style="height: 38px">
                <th width="100" class="point">server ip</th>
                <td colspan="3"><input type="text" class="inputRead left" maxlength="20" id="s_terminal_ip" name="s_terminal_ip" style="width:100px;" value="${terminal_ip}" />
                </td>
            </tr>
            <tr style="height: 38px">
                <th width="100" class="point">server port</th>
                <td colspan="3"><input type="text" class="inputRead left" maxlength="4" id="s_terminal_port" name="s_terminal_port" style="width:100px;" value="${terminal_port}" />
                </td>
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


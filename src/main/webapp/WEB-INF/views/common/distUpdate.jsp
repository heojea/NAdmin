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
	var car_no = $("#h_car_no").val();
	var mileage_dist = $("#mileage_dist").val();
	if(mileage_dist==null||mileage_dist=="") {
		alert("신규 설정 주행거리를 입력해주세요.");
		$("#mileage_dist").focus();
		return;
	}
	if (confirm(car_no+" 차량의 총 주행거리를 "+mileage_dist+"km로 설정하시겠습니까?")) {
		onLoading();
	    $.ajax({
	        type: 'POST',
	        url: "<c:url value='/controllCar.json'/>",
	        data: formSerialize("#f_cond")+'&service_cd=1042',
	        dataType: 'json',
	        async: false,
	        success: function(data) {
	            var item = eval(data);
	            offLoading();
	            if(item.result == '200'){
	                alert('정상적으로 요청 되었습니다');
	                self.close();
	            }else{
	                alert('처리시 오류가 발생하였습니다');
	            }
			} ,
			error : function(){
				offLoading();
			}
		});
	}
    
}
function checkNum(objNumBox){
    var numBoxValue = objNumBox.value;
    for(var i=0;i<numBoxValue.length;i++){
        if(isNaN(numBoxValue.charAt(i))){
             window.alert("숫자만 입력해주세요.");
             objNumBox.value = '';
             for(var j=0;j<i;j++){
                 objNumBox.value += numBoxValue.charAt(j);
             }
             return;
        } else {
    			numBoxValue = numBoxValue.replace(/[^0-9]/g,'');
    			objNumBox.value = numBoxValue;
    			
        }
    }
}
function onLoading(){
	var div = document.createElement('div');
	$(div).css('background','url(<c:url value="/imagesNew/common/loading.gif"/>)no-repeat');
	$(div).attr('id','onaction');
	$($('div')[0]).before(div);
	$(div).dialog({
		position:['center',200],
	 	overlay: { 
	 		background: '#ffffff', 
	 		opacity: 0.4 
	 	} 
	});
	
	$('.ui-widget-header').remove();
	$(div).css('background-position','center');
	$('.ui-resizable-handle').remove();
	$(div).parent().removeClass('ui-widget-content');
	$(div).css('min-height','140px');
}

function offLoading(){
	$('#onaction').remove();
}
</script>
</head>
<body>
<!-- wrap -->
<div style="width:350px;">
    <div class="h2" style="width:340px">
        <h2>총주행거리설정</h2>
    </div>
  
    <div class="bbs_search" style="width:348px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}" />
        <input type="hidden" id="h_site_order_id" name="h_site_order_id" value="${param.site_id}" />
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}" />
        <input type="hidden" id="h_car_mgr_no" name="h_car_mgr_no" value="${param.car_mgr_no}" />
        <input type="hidden" id="h_car_no" name="h_car_no" value="${car_no}" />
        
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr style="height: 33px">
                <td style="text-align: center;">차량번호&nbsp;:&nbsp;${car_no}</td>
            </tr>
            <tr style="height: 33px">
                <td style="text-align: center;">현재 총 주행거리&nbsp;:&nbsp;${mileage_dist}km</td>
            </tr>
            <tr style="height: 33px">
                <td style="text-align: center;">신규 설정 주행거리&nbsp;:&nbsp; 
                	<input type="text" class="inputRead right" id="mileage_dist" name="mileage_dist" style="width:70px;" value="" maxlength="7" onkeyup="checkNum(this)" />km
                </td>
            </tr>
            <tr></tr>
            <tr>
                <td style="text-align: center;">
                	<a href="#" class="btn_s" id="btn_nfc"><span>설정</span></a>&nbsp;
                	<a href="javascript:self.close();" class="btn_s"><span>취소</span></a>
                </td>
            </tr>
        </table>
        </form> 
    </div>
</div>
</body>
</html>


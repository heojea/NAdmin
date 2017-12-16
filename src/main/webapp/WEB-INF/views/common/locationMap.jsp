<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
  <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
  <title>차량찾기</title>
		<script type="text/javascript" src="http://apis.daum.net/maps/maps3.js?apikey=${cfn:getString('daum.map.key')}"></script>

<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<script type="text/javascript">

$(document).ready(function() {
    var map;
    
	$(document).ready(function(e) {
	    loadMap();
	    $('html, body').stop().animate({scrollTop:0},0);
	});

	$("#btn_com").click(function() {locationSearch();});
	$("#btn_sel").click(function() {locationSearchList();}); 
    
});

function loadMap() {
	map = new daum.maps.Map(document.getElementById('store_map'), {
        center: new daum.maps.LatLng("37.5272088", "126.97786853880915"),
        level: 8, 
        mapTypeId: daum.maps.MapTypeId.ROADMAP 
    });
	
	var marker = new daum.maps.Marker({
		position: new daum.maps.LatLng("37.5272088", "126.97786853880915")
	});
	marker.setMap(map);
	
    var zoomControl = new daum.maps.ZoomControl();
    map.addControl(zoomControl, daum.maps.ControlPosition.BOTTOMRIGHT);
    var mapTypeControl = new daum.maps.MapTypeControl();
    map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
}

function locationSearch(){

    $.ajax({
        type: 'POST',
        url: "<c:url value='/controllCar.json'/>",
        data: formSerialize("#f_cond")+'&service_cd=1036',
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

function selectLoadMap(x,y) {
	map = new daum.maps.Map(document.getElementById('store_map'), {
        center: new daum.maps.LatLng(x, y),
        level: 4, 
        mapTypeId: daum.maps.MapTypeId.ROADMAP 
    });
	
	var marker = new daum.maps.Marker({
		position: new daum.maps.LatLng(x, y)
	});
	marker.setMap(map);
	
    var zoomControl = new daum.maps.ZoomControl();
    map.addControl(zoomControl, daum.maps.ControlPosition.BOTTOMRIGHT);
    var mapTypeControl = new daum.maps.MapTypeControl();
    map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
}

function locationSearchList(){

    $.ajax({
        type: 'POST',
        url: "<c:url value='/pmon/pmonm501/carLocationSearch.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        async: false,
        success: function(data) {
       		var list = eval(data); 
            var item = eval(list[0]);
    		selectLoadMap(item.LATITUDE_NO, item.LONGITUDE_NO);
        }
    });
}

</script>
</head>
<body>
<!-- wrap -->
<div style="width:350px;">
    <div class="h2" style="width:450px">
        <h2>강제예약</h2>
    </div>
    <div class="bbs_search" style="width:450px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}"></input>
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}"></input>
        <input type="hidden" id="h_site_order_id" name="h_car_mgr_no" value="${param.car_mgr_no}"></input>
        <input type="hidden" id="site_order_id" name="site_order_id" value="${reserve.ORDER_ID}"></input>
	        
	        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
		        <tr>
		            <th width="80" class="point">조회일자</th>
		            <td width="220" style="padding-left:2px"><a href="#" class="btn_s" id="btn_com"><span>조회발송</span></a></td>
		            <td class="right"><a href="#" class="btn_s" id="btn_sel"><span>조회</span></a></td>
		        </tr>
	        </table>
        </form>   
    </div>
</div>
<div id="store_map" style="position: relative; width: 450px; height: 300px; z-index: 0;"></div>

</body>
</html>


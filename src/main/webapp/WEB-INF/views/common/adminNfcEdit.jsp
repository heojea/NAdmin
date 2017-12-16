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
    
    $("#btn_nfc").click(function() {adminNfcSearch();}); 
    
    $('#btn_nfc_card').click(function() {doSearch(); });
    
    $('#btn_nfc_del').click(function(){
    	var id = null;
    	
    	 if ($('input[name="i_site_check_id"]:checked').val() == undefined) {
             alert('삭제할 RFID를 선택해주세요.');
             return;
         }
    	 check =  $('input[name="i_site_check_id"]:checked').val();
    	 var index = $('input[name="i_site_check_id"]');
    	 for(var i = 0; i < index.length; i++){
    		 if(index[i].checked == true){
				id = i+1;
    		 }
    	 }
    	 adminNfcDelete(id, check);
    	 
    });
    
    $('#btn_nfc_edit').click(function(){
    	adminNfcEdit();
    });
    
});

function adminNfcEdit(){
	openadminNfcEdit("${param.site_id}","${param.car_id}", "${param.car_mgr_no}");
	return;
}

function adminNfcSearch(){

    $.ajax({
        type: 'POST',
        url: "<c:url value='/controllCar.json'/>",
        data: formSerialize("#f_cond")+'&service_cd=1039',
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

function adminNfcDelete(id, check){

    $.ajax({
        type: 'POST',
        url: "<c:url value='/controllCar.json'/>",
        data: formSerialize("#f_cond")+'&index_no='+id+'&nfc_id='+check+'&service_cd=1038',
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

function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pmon/pmonm501/carRFIDSearch.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_car_schedule tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = eval(list[i]);
                    var tr = $("<tr></tr>");
                    var tr1 = $("<tr></tr>");
                    //$("<td></td>").html(i+1).appendTo(tr);
                    //if (gvsa) $("<td></td>").addClass("left").html((item.SITE_ACTIVE_YN == 'N'?"<span class='inactive'>":"")+val(item.SITE_NM)).appendTo(tr);
                    $("<th height='30px'></th>").html("<input type='radio' id='i_site_check_id' name='i_site_check_id' value='" + val(item.RF_ID1) + "' />").appendTo(tr);
                    $("<th height='30px'></th>").html("<input type='radio' id='i_site_check_id' name='i_site_check_id' value='" + val(item.RF_ID2) + "' />").appendTo(tr);
                    $("<th height='30px'></th>").html("<input type='radio' id='i_site_check_id' name='i_site_check_id' value='" + val(item.RF_ID3) + "' />").appendTo(tr);
                    $("<th height='30px'></th>").html("<input type='radio' id='i_site_check_id' name='i_site_check_id' value='" + val(item.RF_ID4) + "' />").appendTo(tr);
                    $("<th height='30px'></th>").html("<input type='radio' id='i_site_check_id' name='i_site_check_id' value='" + val(item.RF_ID5) + "' />").appendTo(tr);
                    
                    $("<th></th>").html(item.RF_ID1).appendTo(tr1);
                    $("<th></th>").html(item.RF_ID2).appendTo(tr1);
                    $("<th></th>").html(item.RF_ID3).appendTo(tr1);
                    $("<th></th>").html(item.RF_ID4).appendTo(tr1);
                    $("<th></th>").html(item.RF_ID5).appendTo(tr1);
                    
                    tr.appendTo($("#g_car_schedule tbody"));
                    tr1.appendTo($("#g_car_schedule tbody"));
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
                <th width="100" class="point">관리자 NFC 조회</th>
                <td colspan="3"><a href="#" class="btn_s" id="btn_nfc"><span>조회</span></a></td>
            </tr>
            <tr style="height: 38px">
                <th width="100" class="point">관리자 NFC 수정</th>
                <td colspan="3"><a href="#" class="btn_s" id="btn_nfc_edit"><span>수정</span></a></td>
            </tr>
            <tr style="height: 38px">
                <th width="100" class="point">관리자 NFC 삭제</th>
                <td colspan="3"><a href="#" class="btn_s" id="btn_nfc_del"><span>삭제</span></a></td>
            </tr>
        </table>
        </form> 
        
		<table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
		        <tr style="height: 38px">
		        <th width="200" class="point">관리자 NFC 카드 내역</th>
		        <td colspan="3"><a href="#" class="btn_s" id="btn_nfc_card"><span>조회</span></a></td>
		    </tr>
		</table>
        
        <div class="bbs_list" style="height:100px">
            <table id="g_car_schedule"cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="80px">RFID1</th>
                    <th width="80px">RFID2</th>
                    <th width="80px">RFID3</th>
                    <th width="80px">RFID4</th>
                    <th width="80px">RFID5</th>
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


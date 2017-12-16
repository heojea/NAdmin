<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<style type="text/css">

a.btn_s2_1:link, a.btn_s2_1:active, a.btn_s2_1:visited, a.btn_s2_1:hover {
    color:#676767;
    font-size:11px;
    line-height:28px;
    padding:0 0 0 5px; 
    display:inline-block;
    background:url('${cfn:getString('system.static.path')}/images/common/btn_bg_s-3.jpg') no-repeat left top;
    cursor:pointer;
    text-decoration: none;
}
a.btn_s2_1:link span, a.btn_s2_1:active span, a.btn_s2_1:visited span, a.btn_s2_1:hover span {
    color:#676767;
    padding:0 5px 0 0; 
    display:inline-block;
    background:url('${cfn:getString('system.static.path')}/images/common/btn_bg_s-3.jpg') no-repeat right top; 
    cursor:pointer;
}
</style>

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
    /*
    if($('#site_login_check').val() == 'Y'){
    	$('#beris').css("display", "");
    }else{
    	$('#beris').css("display", "none");	
    }
    */
    
    
    loadCar();
    
   // setTimeout("carPopReload()", 1000*60);
    setTimeout("loadCar()", 1000*60);
    
});

function carPopReload(){
    location.reload();
}

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
var car_mgr_no = null;
var carNm;
var carNo;
function loadCar() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pcar/pcarm202/carMst.json'/>",
        data: 'site_id=${param.site_id}&car_id=${param.car_id}',
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            carNm = item.CAR_NM;
           	carNo = item.CAR_NO;
           	$("#h_car_sts_cd").val(item.CAR_STS_CD);
            $("#t_car_info").html(item.CAR_GRP_NM +" "+item.CAR_MODEL_NM + " "+item.CAR_NM +" "+item.CAR_NO +"["+item.CAR_STS_NM+"]");
            $("#t_site_nm").html(item.SITE_NM);
            $("#t_door_sts_cd").html(item.DOOR_STS_CD == "10"? "잠금":"잠금해제");
            $("#t_escort_sts_cd").html(item.ESCORT_STS_CD == "10"? "에스코트중":"에스코트종료");
            $("#t_engine_kill_sts_cd").html(item.ENGINE_KILL_STS_CD == "10"? "시동차단중":"시동차단종료");
            $("#t_engine_run_sts_cd").html(item.ENGINE_RUN_STS_CD == "10"? "시동중":"시동꺼짐");
            $("#t_nfc_touch_sts_cd").html(item.NFC_TOUCH_STS_CD == "10"? "기능정지중":"기능가능");
            $("#t_impact_detect_sts_cd").html(item.IMPACT_DETECT_STS_CD == "10"? "충격감지":"충격없음");
            $("#t_door_detect_sts_cd").html(item.DOOR_DETECT_STS_CD == "10"? "강제열림":"정상상태");
            $("#t_low_bat_detect_cd").html(item.LOW_BAT_DETECT_STS_CD == "10"? "정상":"경고");
            $("#t_ctrl_conn_sts_cd").html(item.CTRL_CONN_STS_CD == "10"? "연결중":"연결끊김");
            $("#t_mil_sts_cd").html(item.MIL_STS_CD == "10"? "고장발생":"고장없음");
            $("#t_dtc_cd").html(item.DTC_CD);
            car_mgr_no = item.CAR_MGR_NO;
        }
    });
}
/* 
function controll(cd, need) {
    
    var oid = "";
    if (need) {
        if ($('input[name="i_site_order_id"]:checked').val() == undefined) {
            alert('예약을 조회하여 선택하세요');
            return;
        }
        oid =  $('input[name="i_site_order_id"]:checked').val();
    }
    
    var oidSplit = oid.split("A");
    oid = oidSplit[0];
    
    if(cd == "adminNfc"){
        openadminNfc("${param.site_id}","${param.car_id}", car_mgr_no);
        return;
    }
    
    if(cd == "touch"){
        opentouch("${param.site_id}","${param.car_id}", car_mgr_no);
        return;
    }
    
    if(cd == "return" || cd == "1010"){
        if(oidSplit[1] == "Y"){
            alert("반납 된 예약입니다");
            return;
        }else if(oidSplit[2] == "NULL"){
            alert("고객이 인증번호를 입력하지 않은 차량입니다.");
            return;
        }
    }
    
    if(cd == "1009" || cd == "1006"){
        if(oidSplit[1] == "Y"){
            alert("반납 된 예약입니다");
            return;
        }
    }
    
    if(cd == "return"){
        openReturn("${param.site_id}","${param.car_id}", oid);
        return;
    }
    
    if (cd == 'default') {
        // 도어록, NFC unset, 시동차단
        controll('1000', false);
        controll('1005', false);
        controll('1007', false);
    }
    else {
        $.ajax({
            type: 'POST',
            url: "<c:url value='/controllCar.json'/>",
            data: 'site_id=${param.site_id}&car_id=${param.car_id}&car_mgr_no='+car_mgr_no+'&service_cd='+cd+'&site_order_id='+oid,
            dataType: 'json',
            async: false,
            success: function(data) {
                var item = eval(data);
                alert(item.result);
                if(item.result == '200'){
                    alert('정상적으로 요청 되었습니다');
                }else{
                    alert('처리시 오류가 발생하였습니다');
                }
                loadCar();
                  if (item.RESULT_CD == '10') {
                    if(cd == "1009"){
                        updateCarScheduleReserveSend(oid);
                    }
                    alert('정상적으로 요청 되었습니다');
                }
                else {
                    alert('처리시 오류가 발생하였습니다');
                    if (item.RESULT_MSG != '') {
                        alert(item.RESULT_MSG);
                    }
                }
                loadCar(); 
            }
        });
    }
}
 */
 
 function controll(cd, need) {
     
     var oid = "";
     if (need) {
         if ($('input[name="i_site_order_id"]:checked').val() == undefined) {
             alert('예약을 조회하여 선택하세요');
             return;
         }
         oid =  $('input[name="i_site_order_id"]:checked').val();
     }
     
     var oidSplit = oid.split("A");
     oid = oidSplit[0];
     
     if(cd == "adminNfc"){
         openadminNfc("${param.site_id}","${param.car_id}", car_mgr_no);
         return;
     }
     
     if(cd == "terminalUpdate"){
         openaterminalUpdate("${param.site_id}","${param.car_id}", car_mgr_no);
         return;
     }
     
     if(cd == "1042"){
    	 if($("#h_car_sts_cd").val()=="20") { // 이용중
			alert("차량상태가 이용중인 경우 거리요금계산에 오류가 발생할 수 있음으로 변경불가합니다.");
    	 	return;
    	 } else {
	        openDistUpdate("${param.site_id}","${param.car_id}", car_mgr_no);
	        return;
     	}
     }

     if(cd == "1043"){
        openFirmWareUpdate("${param.site_id}","${param.car_id}", car_mgr_no);
        return;
     }
     
     if(cd == "insertHpno"){
         openinsertHpno("${param.site_id}","${param.car_id}", car_mgr_no);
         return;
     }
     
     if(cd == "reserveForce"){
    	 openReserveForce("${param.site_id}","${param.car_id}", car_mgr_no);
         return;
     }
     
     if(cd == "1032"){
    	 openReserveEdit("${param.site_id}","${param.car_id}", car_mgr_no, oid );
         return;
     }
     
     if(cd == "1033"){
    	 openReserveSearch("${param.site_id}","${param.car_id}", car_mgr_no );
         return;
     }
     
     if(cd == "1034"){
    	 openReserveComplete("${param.site_id}","${param.car_id}", car_mgr_no, oid );
         return;
     }
     
     if(cd == "1036"){
    	 openLocationMap("${param.site_id}","${param.car_id}", car_mgr_no);
         return;
     }
     
     if(cd == "1039"){
    	 openRfid("${param.site_id}","${param.car_id}", car_mgr_no);
         return;
     }
     
/*      //예약조회확인 팝업창
     if(cd == "1000"){
         open("${param.site_id}","${param.car_id}", car_mgr_no);
         return;
     } */
     
     if(cd == "return" || cd == "1010"){
         if(oidSplit[1] == "Y"){
             alert("반납 된 예약입니다");
             return;
         }
     }
     
     if(cd == "1009" || cd == "1006"){
         if(oidSplit[1] == "Y"){
             alert("반납 된 예약입니다");
             return;
         }
     }
     
     if(cd == "return"){
         openReturn("${param.site_id}","${param.car_id}", oid);
         return;
     }
     if(cd == "1031"){
    	 if(oidSplit[1] == "Y"){
             alert("반납 된 예약입니다");
             return;
         }else{
        	 if(!confirm("예약을 취소 하시겠습니까?")) return;
         }
         
     }
     if(cd == "1020"&&!confirm("["+carNm+" "+carNo+"] 차량의 관리자 RFID를 삭제 하시겠습니까?")) return;
     if(cd == "1002"&&!confirm("["+carNm+" "+carNo+"] 차량의 도어를 잠그시겠습니까?")) return;
     if(cd == "1003"&&!confirm("["+carNm+" "+carNo+"] 차량의 도어를 잠금해제 하시겠습니까?")) return;
     if(cd == "1000"&&!confirm("["+carNm+" "+carNo+"] 차량의 비상등 켜기(3초)를 하시겠습니까?")) return;
     if(cd == "1001"&&!confirm("["+carNm+" "+carNo+"] 차량의 끄기를 하시겠습니까?")) return;
     if(cd == "1004"&&!confirm("["+carNm+" "+carNo+"] 차량의 경적켜기(3초)를 하시겠습니까?")) return;
     if(cd == "1005"&&!confirm("["+carNm+" "+carNo+"] 차량의 경적끄기를 하시겠습니까?")) return;
     if(cd == "1006"&&!confirm("["+carNm+" "+carNo+"] 차량의 트렁크열기를 하시겠습니까?")) return;
     
     if(cd == "1031"&&!confirm("["+carNm+" "+carNo+"] 차량의 예약취소를 하시겠습니까?")) return;
     if(cd == "1032"&&!confirm("["+carNm+" "+carNo+"] 차량의 예약수정을 하시겠습니까?")) return;
     if(cd == "1034"&&!confirm("["+carNm+" "+carNo+"] 차량의 예약완료를 하시겠습니까?")) return;
     if(cd == "1035"&&!confirm("["+carNm+" "+carNo+"] 차량의 예약 전체 삭제를 하시겠습니까?")) return;
     if(cd == "1040"&&!confirm("["+carNm+" "+carNo+"] 차량의 단말기 초기화를 하시겠습니까?")) return;
     if(cd == "1041"&&!confirm("["+carNm+" "+carNo+"] 차량의 단말기 리셋 하시겠습니까?")) return;
     
/*      if (cd == 'default') {
         // 도어록, NFC unset, 시동차단
         controll('1000', false);
         controll('1005', false);
         controll('1007', false);
     } */
     
         $.ajax({
             type: 'POST',
             url: "<c:url value='/controllCar.json'/>",
             data: 'site_id=${param.site_id}&car_id=${param.car_id}&car_mgr_no='+car_mgr_no+'&service_cd='+cd+'&site_order_id='+oid,
             dataType: 'json',
             async: false,
             success: function(data) {
                 var item = eval(data);
                 //alert(item.result);
                 if(item.result == '200'){
                     alert('정상적으로 요청 되었습니다');
                 }else{
                     alert('처리시 오류가 발생하였습니다');
                 }
                 loadCar();
 /*                 if (item.RESULT_CD == '10') {
                     if(cd == "1009"){
                         updateCarScheduleReserveSend(oid);
                     }
                     alert('정상적으로 요청 되었습니다');
                 }
                 else {
                     alert('처리시 오류가 발생하였습니다');
                     if (item.RESULT_MSG != '') {
                         alert(item.RESULT_MSG);
                     }
                 }
                 loadCar(); */
             }
         });
 }
 
 
function updateCarScheduleReserveSend(oid){
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pcar/pcarm202/updateCarScheduleReserveSend.json'/>",
        data: 'site_id=${param.site_id}&car_id=${param.car_id}&site_order_id='+oid,
        dataType: 'json',
        async: false,
        success: function(data) {
        }
    });
}


</script>
</head>
<body>
<!-- wrap -->
<div style="width:510px;">

    <div class="h2" style="width:500px">
        <h2>차량 제어</h2>
    </div>
  
    <div class="bbs_search" style="width:508px">
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <th class="point" width="100">사이트명</th>
            <td colspan="3"><span id="t_site_nm"></span></td>
        </tr>        
            <th class="point" width="100">차량정보</th>
            <td colspan="3"><span id="t_car_info"></span></td>
        </tr>
        <tr>
            <th width="100">도어상태</th>
            <td><span id="t_door_sts_cd"></span></td>
            <th width="100">엔진시동상태</th>
            <td><span id="t_engine_run_sts_cd"></span></td>
<!--             <th width="100">에스코트상태</th>
            <td><span id="t_escort_sts_cd"></span></td> -->
        </tr>
<!--         <tr>
            <th width="100">시동차단상태</th>
            <td><span id="t_engine_kill_sts_cd"></span></td>
            <th width="100">엔진시동상태</th>
            <td><span id="t_engine_run_sts_cd"></span></td>
        </tr>
        <tr>
            <th width="100">NFC 터치키상태</th>
            <td><span id="t_nfc_touch_sts_cd"></span></td>
            <th width="100">충격감지상태</th>
            <td><span id="t_impact_detect_sts_cd"></span></td>
        </tr> -->
        <tr>
<!--             <th width="100">강제문열림상태</th>
            <td><span id="t_door_detect_sts_cd"></span></td> -->
            <th width="100">보조배터리상태</th>
            <td><span id="t_low_bat_detect_cd"></span></td>
            <th width="100">고장램프상태</th>
            <td><span id="t_mil_sts_cd"></span></td>
        </tr>
<!--         <tr>
            <th width="100">제어장치연결</th>
            <td><span id="t_ctrl_conn_sts_cd"></span></td>
            <th width="100">고장램프상태</th>
            <td><span id="t_mil_sts_cd"></span></td>
        </tr>
        <tr>
            <th width="100">차량고장코드</th>
            <td colspan="2"><span id="t_dtc_cd"></span></td>
        </tr> -->
        </table>
    </div>
    
    <div class="bbs_grid" style="width:508px">
        <table class="bbs_grid" cellpadding="0" cellspacing="0" border="0">   
<!--             <tr>
                <td style="width: 20%; background-color: #BF9EE8" >차량관리</td>
                <td style="width: 80%">
                    <table class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                       <tr>
                           <td style="width: 50%"><a href="javascript:controll('adminNfc', false)" class="btn_s2"><span>관리자 NFC ID</span></a></td>            
                           <td style="width: 50%"><a href="javascript:controll('1020', false)" class="btn_s2"><span>관리자 전체 클리어</span></a></td>   
                       </tr>
                       <tr>
                           <td style="width: 50%"><a href="javascript:controll('terminalUpdate', false)" class="btn_s2"><span>단말기 설정 업데이트</span></a></td>            
                           <td style="width: 50%"><a href="javascript:controll('insertHpno', false)" class="btn_s2"><span>SMS 제어명령이 오는 단말기 전화번호 등록</span></a></td>   
                       </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 20%; background-color: #C6EFCE" >서비스제어</td>
                <td style="width: 80%">
                    <table class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                       <tr>
                           <td style="width: 50%"><a href="javascript:controll('return', true)" class="btn_s2"><span>수동 반납처리</span></a></td>             
                           <td style="width: 50%"><a href="javascript:controll('1009', true)" class="btn_s2"><span>예약정보 전송</span></a></td>   
                       </tr>
                       <tr style="height: 30px">
                           <td style="width: 50%"><a href="javascript:controll('1011', false)" class="btn_s2"><span>블랙박스 영상요청</span></a></td>             
                           <td style="width: 50%"><a href="javascript:controll('1010', true)" class="btn_s2"><span>반납지연메시지전송</span></a></td>   
                       </tr>
                    </table>
                </td>
            </tr> -->
            <tr>
                <td style="width: 20%; background-color: #FFC7CE" >차량제어 명령</td>
                <td style="width: 80%">
                    <table class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
<!--                        <tr>
                           <td style="width: 50%"><a href="javascript:controll('default', false)" class="btn_s2"><span>차량제어 디폴트설정</span></a></td>             
                           <td style="width: 50%"><a href="javascript:controll('1008', false)" class="btn_s2"><span>차량제어확인</span></a></td>   
                       </tr> -->
                       <tr style="height: 30px">
                           <td style="width: 33%"><a href="javascript:controll('adminNfc', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">관리자 RFID ID</span></a></td>            
                           <td style="width: 33%"><a href="javascript:controll('1020', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">관리자 RFID 삭제</span></a></td>
                           <td><a href="javascript:controll('1002', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">도어잠금</span></a></td>   
                       </tr>
                       <tr style="height: 30px">             
                           <td><a href="javascript:controll('1003', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">도어잠금해제</span></a></td>   
                           <td><a href="javascript:controll('1000', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">비상등 켜기(3초)</span></a></td>             
                           <td><a href="javascript:controll('1001', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">비상등 끄기</span></a></td>
                       </tr>
                       <tr style="height: 30px">
                           <td><a href="javascript:controll('1004', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">경적 켜기(3초)</span></a></td>             
                           <td><a href="javascript:controll('1005', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">경적 끄기</span></a></td>
                           <td></td>
                       </tr>
                       <!-- 
                       <tr style="height: 30px">
                           <td style="width: 50%"><a href="javascript:controll('1006', false)" class="btn_s2"><span>트렁크열기</span></a></td>             
                       </tr>
                        -->
<!--                        <tr style="height: 30px">
                           <td style="width: 50%"><a href="javascript:controll('1006', true)" class="btn_s2"><span>NFC ID SET</span></a></td>
                           <td style="width: 50%"><a href="javascript:controll('1007', false)" class="btn_s2"><span>NFC ID UNSET</span></a></td> 
                       </tr> -->
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <c:if test="${login_check eq 'Y'}">
    <br/><br/>
    <div class="bbs_grid" id="beris" style="width:508px;">
    	<table class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
			<tr>
                <td style="width: 20%; background-color: #FFC7CE" >차량제어 명령</td>
                <td>
                    <table class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                       <tr style="height: 30px">
                           <td style="width: 33%"><a href="javascript:controll('reserveForce', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">강제예약</span></a></td>            
                           <td style="width: 33%"><a href="javascript:controll('1031', true)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">예약취소</span></a></td>
                           <td><a href="javascript:controll('1032', true)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">예약 수정</span></a></td>
                       </tr>
                       <tr style="height: 30px">            
                           <td><a href="javascript:controll('1033',  false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">예약 정보 조회</span></a></td>
                           <td><a href="javascript:controll('1034', true)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">예약 완료</span></a></td>            
                           <td><a href="javascript:controll('1035',  false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">예약 전체 삭제</span></a></td>
                       </tr>
                       <tr style="height: 30px">
                           <td><a href="javascript:controll('1036', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">현재위치조회</span></a></td>            
                           <td><a href="javascript:controll('1039',  false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">관리자RFID조회</span></a></td>
                           <td><a href="javascript:controll('terminalUpdate', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">단말기설정업데이트</span></a></td>
                       </tr>
                       <tr style="height: 30px">            
                           <td><a href="javascript:controll('insertHpno', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">제어 전화번호 등록</span></a></td>
                           <td><a href="javascript:controll('1040', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">단말기 초기화</span></a></td>            
                           <td><a href="javascript:controll('1041', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">단말기 리셋</span></a></td>   
                       </tr>
                       <tr style="height: 30px">            
                           <td><a href="javascript:controll('1042', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">총주행거리설정</span></a></td>
                           <td><a href="javascript:controll('1043', false)" class="btn_s2_1"><span style="width:110px;font-weight:bold;">펌웨어업데이트</span></a></td>            
                           <td></td>   
                       </tr>
                    </table>
                </td>
            </tr>
    	</table>
    </div>
	</c:if>
<!--     <div class="bbs_grid" style="width:508px">
        <table class="bbs_grid" cellpadding="0" cellspacing="0" border="0">   
            <tr>
                <td width="50%"><a href="javascript:controll('default', false)" class="btn_s2"><span>차량제어 디폴트설정</span></a></td>            
                <td width="50%"><a href="javascript:controll('return', true)" class="btn_s2"><span>수동 반납처리</span></a></td>            
            </tr>  
            <tr>
                <td width="50%"><a href="javascript:controll('1000', false)" class="btn_s2"><span>도어록</span></a></td>
                <td width="50%"><a href="javascript:controll('1001', false)" class="btn_s2"><span>도어언록</span></a></td>
            </tr>   
            <tr>
                <td><a href="javascript:controll('1002', false)" class="btn_s2"><span>에스코트ON</span></a></td>
                <td><a href="javascript:controll('1003', false)" class="btn_s2"><span>에스코트OFF</span></a></td>
            </tr>
            <tr>
                <td><a href="javascript:controll('1004', false)" class="btn_s2"><span>시동차단해제</span></a></td>
                <td><a href="javascript:controll('1005', false)" class="btn_s2"><span>시동차단</span></a></td>
            </tr>
            <tr>
                <td><a href="javascript:controll('1008', false)" class="btn_s2"><span>차량제어확인</span></a></td>
                <td><a href="javascript:controll('1011', false)" class="btn_s2"><span>블랙박스 영상 요청</span></a></td>
            </tr>
            <tr>
                <td><a href="javascript:controll('1006', true)" class="btn_s2"><span>NFC ID SET</span></a></td>
                <td><a href="javascript:controll('1007', false)" class="btn_s2"><span>NFC ID UNSET</span></a></td>
            </tr>
            <tr>
                <td><a href="javascript:controll('1009', true)" class="btn_s2"><span>예약정보 전송</span></a></td>
                <td><a href="javascript:controll('1010', true)" class="btn_s2"><span>반납지연메시지전송</span></a></td>
            </tr>
        </table>
    </div> -->
    
    <div class="tab_s" style="margin-top:10px">
        <ul>
            <li id="tab1_top_s" class="on"><span><a href="#" id="tab1_top_title_s">예약조회</a></span></li>
        </ul>
    </div>
    <div id="tab1_page_s" class="bbs_search_c" style="padding-top:9px;width:508px">
        <form name="f_cond" id="f_cond">
        <input type="hidden" id="h_site_id" name="h_site_id" value="${param.site_id}" />
        <input type="hidden" id="h_car_id" name="h_car_id" value="${param.car_id}" />
        <input type="hidden" id="site_login_check" name="site_login_check" value="${login_check}" />
        <input type="hidden" id="h_car_sts_cd" name="h_car_sts_cd" value="" />
        
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <th width="80" class="point">조회일자</th>
            <td width="220" style="padding-left:2px"><input type="text" class="inputRead center" readonly="true" name="s_cal_start_dy" id="s_cal_start_dy" style="width:70px;" /> <img id="m_cal_start_dy" src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" /> ~
                            <input type="text" class="inputRead center" readonly="true" name="s_cal_end_dy" id="s_cal_end_dy" style="width:70px;" /> <img id="m_cal_end_dy" src="${cfn:getString('system.static.path')}/images/common/calendar.gif" alt="달력선택" class="middle pointer" /></td>
            <td class="right"><a href="#" class="btn_s" id="btn_sel"><span>조회</span></a></td>
        </tr>
        <tr>
            <th width="80" class="point">고객명</th>
            <td><input type="text" class="text" id="s_site_member_nm" name="s_site_member_nm"></input></td>
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
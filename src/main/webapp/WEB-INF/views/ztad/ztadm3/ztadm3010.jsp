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
    $('#btn_sel').click(function() {doSearch();});
    $('#btn_mod').click(function() {modifyMajorCode();});
    $('#btn_del').click(function() {removeMajorCode();});
    $('#btn_ins1').click(function() {appendMajorCode();});
    $('#btn_ins2').click(function() {appendMinorCode();});
    
    $("#t_new_major").hide();
    $("#t_new_minor").hide();
    $('#s_cd_grp_nm').focus();
    $('#s_cd_grp_nm').keypress(function(e) {
        if (e.which == 13) {
            doSearch();
        }
    });
});

function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/majorCodeList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data);            
            if (list != "") {
                $("#g_major tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").html(item.MAJOR_CD).appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:loadMajorCode(\""+item.MAJOR_CD+"\")'>"+item.CD_GRP_NM+"</a>").appendTo(tr);
                    tr.appendTo($("#g_major tbody"));
                }
                paintGrid("g_major");
                $("#f_admin")[0].reset();
                $("#g_minor tbody").html("");
                $("#t_new_major").hide();
                $("#t_new_minor").hide();
            } else {
            	$("#g_major tbody").html("");
            	alert("검색결과가 없습니다.");            	
            }
        } 
    });
}

function loadMajorCode(mid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/majorCode.json'/>",
        data: 'major_cd='+mid,
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            $("#i_major_cd").val(item.MAJOR_CD);
            $("#i_cd_grp_nm").val(item.CD_GRP_NM);
            $("#i_cd_grp_desc").val(item.CD_GRP_DESC);
        } 
    });
    loadMinorCode( mid);   
}

function loadMinorCode(mid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/minorCodeList.json'/>",
        data: 'major_cd='+mid,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);  
            if (list) {
                $("#g_minor tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").html(item.MINOR_CD).appendTo(tr);
                    $("<td></td>").addClass("left").html("<input type='text' class='text' id='i_cd_nm_"+item.MAJOR_CD+"_"+item.MINOR_CD+"' value='"+val(item.CD_NM)+"' style='width:145px'/>").appendTo(tr);
                    $("<td></td>").addClass("left").html("<input type='text' class='text right' id='i_order_seq_"+item.MAJOR_CD+"_"+item.MINOR_CD+"' style='width:40px' value='"+item.ORDER_SEQ+"'/>").appendTo(tr);
                    $("<td></td>").addClass("left").html("<select id='i_use_yn_"+item.MAJOR_CD+"_"+item.MINOR_CD+"' style='width:80px'><option value='Y' "+(item.USE_YN == 'Y'? "selected":"")+">활성화</option><option value='N' "+(item.USE_YN == 'N'? "selected":"")+">비활성화</option></select>").appendTo(tr);
                    $("<td></td>").addClass("left").html("<input type='text' class='text' id='i_ref1_"+item.MAJOR_CD+"_"+item.MINOR_CD+"' style='width:80px' value='"+val(item.REF1)+"'/>").appendTo(tr);
                    $("<td></td>").addClass("left").html("<input type='text' class='text' id='i_ref2_"+item.MAJOR_CD+"_"+item.MINOR_CD+"' style='width:80px' value='"+val(item.REF2)+"'/>").appendTo(tr);
                    $("<td></td>").addClass("left").html("<input type='text' class='text' id='i_ref3_"+item.MAJOR_CD+"_"+item.MINOR_CD+"' style='width:80px' value='"+val(item.REF3)+"'/>").appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:modifyMinorCode(\""+item.MAJOR_CD+"\", \""+item.MINOR_CD+"\")' class='btn_s'><span>수정</span></a> <a href='javascript:removeMinorCode(\""+item.MAJOR_CD+"\", \""+item.MINOR_CD+"\")' class='btn_s'><span>삭제</span></a>").appendTo(tr);
                    tr.appendTo($("#g_minor tbody"));                    
                    $('#order_seq_'+item.MENU_ID).numeric();
                }
                paintGrid("g_minor");
            }
        } 
    });
}

function modifyMajorCode() {
    if ($("#h_major_cd").val() == "") {
        alert("마스터 코드를 선택 하세요");
        return;
    }
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/updateMajorCode.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정되었습니다');
                doSearch();
                loadMajorCode($("#i_major_cd").val());
            }
        } 
    });
}

function modifyMinorCode(mid, nid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/updateMinorCode.json'/>",
        data: 'major_cd='+mid+'&minor_cd='+nid+'&cd_nm='+val($("#i_cd_nm_"+mid+"_"+nid).val())+'&order_seq='+val($("#i_order_seq_"+mid+"_"+nid).val())+'&use_yn='+val($("#i_use_yn_"+mid+"_"+nid).val())+'&ref1='+val($("#i_ref1_"+mid+"_"+nid).val())+'&ref2='+val($("#i_ref2_"+mid+"_"+nid).val())+'&ref3='+val($("#i_ref3_"+mid+"_"+nid).val()),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정되었습니다');
                loadMinorCode(mid);
            }
        } 
    });
}

function removeMajorCode() {
    if ($("#h_major_cd").val() == "") {
        alert("마스터 코드를 선택 하세요");
        return;
    }
    if (!confirm("정말 삭제 하시겠습니까?")) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/deleteMajorCode.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제 되었습니다');
                doSearch();
            }
        } 
    });
}

function removeMinorCode(mid, nid) {
    if (!confirm("정말 삭제 하시겠습니까?")) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/deleteMinorCode.json'/>",
        data: 'major_cd='+mid+'&minor_cd='+nid,
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제 되었습니다');
                loadMinorCode(mid);
            }
        } 
    });
}

function appendMajorCode() {
    if ($("#t_new_major").css('display') == 'none') {
        $("#t_new_major").fadeIn();
        $("#i_new_major_cd").focus();
        return;
    }
    if ($('#i_new_major_cd').val() == '') {
        alert('마스터 코드를 입력하세요');
        $('#i_new_major_cd').focus();
        return;
    }
    if ($('#i_new_cd_grp_nm').val() == '') {
        alert('마스터 코드명을 입력하세요');
        $('#i_new_cd_grp_nm').focus();
        return;
    }
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/insertMajorCode.json'/>",
        data: 'major_cd='+$('#i_new_major_cd').val()+'&cd_grp_nm='+$('#i_new_cd_grp_nm').val(),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 추가되었습니다');
                //loadMajorCode($('#i_new_major_cd').val());
                $("#i_new_major_cd").val("");
                $("#i_new_cd_grp_nm").val("");
                $("#t_new_major").hide();                
                doSearch();
            }
        } 
    });
}

function appendMinorCode() {
    if ($("#t_new_minor").css('display') == 'none') {
        $("#t_new_minor").fadeIn();
        $("#i_new_minor_cd").focus();
        return;
    }
    if ($("#i_major_cd").val() == "") {
        alert("마스터 코드를 선택하세요");
        return;
    }    
    if ($('#i_new_minor_cd').val() == '') {
        alert('상세 코드를 입력하세요');
        $('#i_new_minor_cd').focus();
        return;
    }
    if ($('#i_new_cd_nm').val() == '') {
        alert('상세 코드명을 입력하세요');
        $('#i_new_cd_nm').focus();
        return;
    }
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm301/insertMinorCode.json'/>",
        data: 'major_cd='+$("#i_major_cd").val()+'&minor_cd='+$('#i_new_minor_cd').val()+'&cd_nm='+$('#i_new_cd_nm').val(),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 추가되었습니다');
                loadMinorCode($("#i_major_cd").val());
                $("#i_new_minor_cd").val("");
                $("#i_new_cd_nm").val("");
                $("#t_new_minor").hide();
            }
        } 
    });
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <c:import url="/view.do?viewName=location&layout=common" />

    <div class="h2">
        <h2>코드 조회 / 생성</h2>
    </div>
  
    <div class="bbs_search">
        <form name="f_cond" id="f_cond" onsubmit="return false">
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <th width="80">코드명</th>
            <td width="180"><input type="text" class="text" name="s_cd_grp_nm" id="s_cd_grp_nm" style="width:150px;" /></td>
            <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
        </tr>
        </table>
        </form>
    </div>

    <div id="left_content" style="width:30%">
        <div class="bbs_grid" style="height:652px">
            <table id="g_major" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th width="50">코드</th>
                    <th>마스터 코드명</th>
                </tr>                
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>      
    </div>  
    
    <div id="right_content" style="width:69%">
        <div class="h3">
            <a href="#" class="btn_s right" id="btn_del"><span>삭제</span></a>
            <a href="#" class="btn_s right" id="btn_mod"><span>저장</span></a>
            <a href="#" class="btn_s right" id="btn_ins1"><span>신규</span></a>
            <span id="t_new_major" class="bar right"> 마스터 코드/ 코드명&nbsp;&nbsp;<input type="text" class="text" id="i_new_major_cd" style="width:50px"/> / <input type="text" class="text" id="i_new_cd_grp_nm"/>&nbsp;</span>
            <span>마스터 코드 수정</span>
        </div>

        <div class="bbs_search">
            <form name="f_admin" id="f_admin">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <colgroup>
                <col width="100"/>
                <col/>
                <col width="100"/>
                <col/>
            </colgroup>
            <tr>
                <th class="point">마스터 코드</th>
                <td>
                    <input type="text" name="i_major_cd" id="i_major_cd" class="inputRead" readonly="true" style="width:150px"/>
                </td>
                <th class="point">마스터 코드명</th>
                <td>
                    <input type="text" name="i_cd_grp_nm" id="i_cd_grp_nm" class="text" style="width:150px"/>
                </td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="3"><textarea name="i_cd_grp_desc" id="i_cd_grp_desc" rows="3" style="width:100%"></textarea></td>
            </tr>
            </table>
            </form>
        </div>
        
        <div class="h3">
            <span>코드 상세 리스트</span>
            <span id="new_code">
                <a href="#" class="btn_s right" id="btn_ins2"><span>신규</span></a>
                <span id="t_new_minor" class="bar right"> 상세 코드 / 코드명&nbsp;&nbsp;<input type="text" class="text" id="i_new_minor_cd" style="width:50px"/> / <input type="text" class="text" id="i_new_cd_nm"/>&nbsp;</span>
            </span>
        </div>
        <div class="bbs_grid" style="height:480px">
            <table id="g_minor" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th width="50">코드</th>
                    <th width="150">상세코드명</th>
                    <th width="60">코드순서</th>
                    <th width="90">사용여부</th>
                    <th>참조1</th>
                    <th>참조2</th>
                    <th>참조3</th>
                    <th width="90">작업</th>
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

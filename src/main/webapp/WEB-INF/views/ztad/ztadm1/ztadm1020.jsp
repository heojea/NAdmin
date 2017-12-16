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
    $('#btn_mod').live("click", function() {modifyRole();});
    $('#btn_del').live("click", function() {removeRole();});
    $('#btn_ins').live("click", function() {appendRole();});
    $('#tab1_top_title').click(function() {showTabs('1');});
    $('#tab2_top_title').click(function() {showTabs('2',true);});
    $('#tab2_page').hide();
    //initTableHeader('g_role', 2, 200);
    //initSiteSelector("g_selector", 3);
    
    getRoleOptionList($('#s_role_id'), true);
    
    $('#f_admin').validate({
        rules: {
            i_role_nm: {required:true},
            i_active_yn: {required:true},
            i_site_nm: {required:true}
        },
        messages: {},
        errorPlacement: function(error, element) {   
            if (!element.is(":radio") && !element.is(":checkbox"))
                error.insertAfter(element);
        }
    });
});

function showTabs(no, isNew) {
    initTabs(2, no);
    if (no == '1') {
        $('#tab2_top_title').html('권한그룹 생성');
    }        
    else {
        // 신규
        if (isNew) {
            formReset('f_admin'); //$('#f_admin')[0].reset();
            $('#btn_del').hide();
            $('#btn_mod').hide();
            $('#btn_ins').show();
            $('#tab2_top_title').html('권한그룹 생성');
        }
        // 수정
        else {
            $('#btn_del').show();
            $('#btn_mod').show();
            $('#btn_ins').hide();
            $('#tab2_top_title').html('권한그룹 수정');
        }
    }
}
// 검색
function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm202/roleList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_role tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:loadRole(\""+item.ROLE_ID+"\")'>"+(item.ACTIVE_YN == 'N'?"<span class='inactive'>":"")+val(item.ROLE_NM)+"</a>").appendTo(tr);
                    $("<td></td>").html(item.ACTIVE_YN == 'Y'? "활성화":"비활성화").appendTo(tr);
                    $("<td></td>").addClass("left").html(item.ROLE_DESC).appendTo(tr);
                    tr.appendTo($("#g_role tbody"));
                }
                paintGrid("g_role");
            }
        } 
    });
}

// 신규생성
function appendRole() {
    if (!$('#f_admin').validate().form()) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm102/insertRole.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 신규 생성 되었습니다');
                showTabs('1');
                // 추가된것 보이게
                getRoleOptionList($('#s_role_id'), true);
                doSearch();
            }
        }
    });
}

function modifyRole() {
    if (!$('#f_admin').validate().form()) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm102/updateRole.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정 되었습니다');
                showTabs('1');
                // 수정된것 보이게
                getRoleOptionList($('#s_role_id'), true);
                doSearch();
            }
        }
    });
}

function removeRole() {
    if (!confirm('정말 삭제 하시겠습니까?')) return;    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm102/deleteRole.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제 되었습니다');
                showTabs('1');
                getRoleOptionList($('#s_role_id'), true);
                doSearch();
            }
        }
    });
}

function loadRole(rid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm102/role.json'/>",
        data: 'role_id='+rid,
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            showTabs('2', false);
            $('#i_role_nm').val(item.ROLE_NM);
            $('#i_role_id').val(item.ROLE_ID);
            $('#i_role_desc').val(item.ROLE_DESC);
            $("input:radio[name=i_active_yn][value="+item.ACTIVE_YN+"]").attr("checked","checked");
        }
    });
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <c:import url="/view.do?viewName=location&layout=common" />

    <div class="tab">
        <ul>
            <li id="tab1_top" class="on"><span><a href="#" id="tab1_top_title">권한그룹 목록</a></span></li>
            <li id="tab2_top" class="off"><span><a href="#" id="tab2_top_title">권한그룹 생성</a></span></li>
        </ul>
    </div>

    <div id="tab1_page">
        <div class="bbs_search">
            <form name="f_cond" id="f_cond" onsubmit="return false">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr id="d_cond">
                <th width="80">권한그룹</th>
                <td width="180">
                    <select name="s_role_id" id="s_role_id">
                        <option value="">전체</option>
                    </select>
                </td>
                <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
            </tr>
            </table>
            </form>
        </div>
        
        <div class="bbs_grid" style="height:640px">
            <table id="g_role" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="40">번호</th>
                        <th width="200">권한명</th>
                        <th width="80">활성화여부</th>
                        <th>비고</th>
                    </tr> 
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="tab2_page">
        <div class="bbs_search">
            <form name="f_admin" id="f_admin">
            <table id="g_selector" class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <colgroup>
                <col width="150"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th class="point">권한명</th>
                <td><input type="text" name="i_role_nm" id="i_role_nm" class="text" style="width:150px"/><input type="hidden" name="i_role_id" id="i_role_id"/></td>
            </tr>
            <tr>    
                <th class="point">활성화여부</th>
                <td><input type="radio" name="i_active_yn" value="Y"/> 활성화 <input type="radio" name="i_active_yn" value="N"/> 비활성화</td>
            </tr>
            <tr>
                <th>비고</th>
                <td><textarea name="i_role_desc" id="i_role_desc" style="width:100%" rows="10"></textarea></td>
            </tr>
            <tr>
                <td colspan="2" class="center">
                    <a href="#" class="btn_s" id="btn_mod"><span>저장</span></a>
                    <a href="#" class="btn_s" id="btn_del"><span>삭제</span></a>
                    <a href="#" class="btn_s" id="btn_ins"><span>저장</span></a>
                </td>
            </tr>
            </tbody>
            </table>
            </form>
        </div>
    </div>
</div>    
</body>
</html>














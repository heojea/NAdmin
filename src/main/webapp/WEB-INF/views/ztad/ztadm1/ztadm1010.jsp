<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />

<script type="text/javascript">
var flag = false;
$(document).ready(function() {
    $('#btn_sel').click(function() {doSearch();});
    $('#btn_mod').live("click", function() {modifyAdmin();});
    $('#btn_del').live("click", function() {removeAdmin();});
    $('#btn_ins').live("click", function() {appendAdmin();});
    $('#btn_search_corp').click(function() {popCorpSearch('selectCorp');});
    $('#btn_ini').live("click", function() {
        $('#i_pwd_error_cnt').val('0');
    });
    $('#btn_mod_pwd').live("click", function() {popModPass($('#h_admin_id').val());});
    $('#tab1_top_title').click(function() {showTabs('1');});
    $('#tab2_top_title').click(function() {showTabs('2',true);});
    $('#tab2_page').hide();
    //initTableHeader('g_admin', 2, 150);   
    //initSiteSelector("g_selector", 3);
    
    $('#i_admin_tp_cd').change(function(){
        if($("#i_admin_tp_cd option:selected").val() == 30) {
            $('#f_corp_1').show();
            $('#f_corp_2').show();
        } else {
            $('#f_corp_1').hide();
            $('#f_corp_2').hide();
        }
    });
    
    getRoleOptionList($('#s_role_id'), true);
    getRoleCheckboxList($('#h_admin_id').val(), $('#t_role_nms'));
    
    $('input[name^=i_tel]').numeric();
    $('input[name^=i_cell]').numeric();

    $('#f_admin').validate({
        rules: {
            i_admin_nm: {required:true},
            i_admin_tp_cd: {required:true},
            i_login_id: {required:true, minlength:4, maxlength: 20},
            i_pwd: {required:true, minlength:4, maxlength: 100},
            i_pwd_confirm: {required:true, equalTo: '#i_pwd', minlength:4, maxlength: 100},
            i_email: {required:true, email:true},
            i_tel1_no: {maxlength:4},
            i_tel2_no: {maxlength:4},
            i_tel3_no: {maxlength:4},
            i_cell1_no: {required:true, maxlength:4},
            i_cell2_no: {required:true, maxlength:4},
            i_cell3_no: {required:true, maxlength:4},
            i_active_yn: {required:true}
        },
        messages: {},
        errorPlacement: function(error, element) {   
            if (!element.is(":radio") && !element.is(":checkbox"))
                error.insertAfter(element);
        }
     });
});

function showTabs(no, isNew) {
    flag = false;
    initTabs(2, no);
    if (no == '1') {
        $('#tab2_top_title').html('관리자 생성');
        $('#trPwd').show();
    }        
    else {
        // 신규
        if (isNew) {
            formReset('f_admin'); //$('#f_admin')[0].reset();
            $('#tab2_top_title').html('관리자 생성');
            $('#btn_del').hide();
            $('#btn_mod').hide();
            $('#btn_mod_pwd').hide();
            $('#trPwd').show();
            $('#btn_ins').show();
            $('#f_corp_1').hide();
            $('#f_corp_2').hide();
            $("input:radio[name=i_active_yn][value=Y]").attr("checked","checked");
        }
        // 수정
        else {
            $('#tab2_top_title').html('관리자 수정');
            $('#btn_del').show();
            $('#btn_mod').show();
            $('#btn_mod_pwd').show();
            $('#btn_ins').hide();
        }
    }   
}
// 검색
function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm101/adminList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_admin tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = eval(list[i]);
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.ADMIN_TP_NM).appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:loadAdmin(\""+item.ADMIN_ID+"\")'>"+(item.ACTIVE_YN == 'N'?"<span class='inactive'>":"")+val(item.ADMIN_NM)).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.LOGIN_ID).appendTo(tr);
                    $("<td></td>").html(item.ACTIVE_YN == 'Y'? "활성화":"비활성화").appendTo(tr);
                    $("<td></td>").addClass("left").html(item.EMAIL).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.CELL_NO).appendTo(tr);
                    $("<td></td>").html(item.REG_DATE).appendTo(tr);
                    $("<td></td>").html(item.MOD_DATE).appendTo(tr);
                    tr.appendTo($("#g_admin tbody"));
                }
                paintGrid("g_admin");
            }
        } 
    });
}

// 신규생성
function appendAdmin() {
    if (!$('#f_admin').validate().form()) return;    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm101/insertAdmin.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 신규 생성 되었습니다');
                showTabs('1');
                doSearch();
            }
        }
    });
}

function modifyAdmin() {
    if (!$('#f_admin').validate().form()) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm101/updateAdmin.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정 되었습니다');
                showTabs('1');
                doSearch();
            }
        }
    });
}

function removeAdmin() {
    if (!confirm('정말 삭제 하시겠습니까?')) return;
    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm101/deleteAdmin.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제 되었습니다');
                showTabs('1');
                doSearch();
            }
        }
    });
}

function loadAdmin(aid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm101/admin.json'/>",
        data: 'admin_id='+aid,
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            showTabs('2', false);
            $('#i_admin_nm').val(item.ADMIN_NM);
            $('#h_admin_id').val(item.ADMIN_ID);
            $('#i_login_id').val(item.LOGIN_ID);
            $('#i_emp_no').val(item.EMP_NO);
            $('#i_email').val(item.EMAIL);
            $('#trPwd').hide();
            $('#i_pwd').val(item.PWD);
            $('#i_pwd_confirm').val(item.PWD);
            $('#i_tel1_no').val(item.TEL1_NO);
            $('#i_tel2_no').val(item.TEL2_NO);
            $('#i_tel3_no').val(item.TEL3_NO);
            $('#i_cell1_no').val(item.CELL1_NO);
            $('#i_cell2_no').val(item.CELL2_NO);
            $('#i_cell3_no').val(item.CELL3_NO);
            $('#i_pwd_error_cnt').val(item.PWD_ERROR_CNT);
            $('#i_pwd_error_dy').val(item.PWD_ERROR_DY);
            $('#i_admin_tp_cd').val(item.ADMIN_TP_CD);
            if(item.ADMIN_TP_CD == '30') {
                $('#f_corp_1').show();
                $('#f_corp_2').show();
                $('#i_corp_no').val(item.CORP_NO);
            } else {
                $('#f_corp_1').hide();
                $('#f_corp_2').hide();
            }
            $("input:radio[name=i_active_yn][value="+item.ACTIVE_YN+"]").attr("checked","checked");
            getRoleCheckboxList(item.ADMIN_ID, $('#t_role_nms'));
        }
    });
}

function selectCorp(corp_no) {
    $('#i_corp_no').val(corp_no);
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <c:import url="/view.do?viewName=location&layout=common" />

    <div class="tab">
        <ul>
            <li id="tab1_top" class="on"><span><a href="#" id="tab1_top_title">권한자 목록</a></span></li>
            <li id="tab2_top" class="off"><span><a href="#" id="tab2_top_title">관리자 생성</a></span></li>
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
                <th width="80">관리자유형</th>
                <td width="180">
                    <select name="s_admin_tp_cd" id="s_admin_tp_cd">
                        <option value="">전체</option>
                    <c:forEach var="adminTp" items="${adminTpList}" >
                        <option value="${adminTp.MINOR_CD}">${adminTp.CD_NM}</option>
                    </c:forEach> 
                    </select>
                </td>
                <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
            </tr>
            </table>
            </form>
        </div>
        
        <div class="bbs_grid" style="height:580px">
            <table id="g_admin" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th width="150">관리자유형</th>
                    <th width="80">관리자명</th>
                    <th width="80">로그인ID</th>
                    <th width="80">활성화여부</th>
                    <th width="150">이메일</th>
                    <th width="100">휴대폰번호</th>
                    <th width="100">등록일</th>
                    <th width="100">수정일</th>
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
                <col width="350"/>
                <col width="150"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th class="point">관리자명</th>
                <td><input type="text" name="i_admin_nm" id="i_admin_nm" class="text" style="width:150px"/><input type="hidden" name="h_admin_id" id="h_admin_id"/></td>
                <th class="point">관리자유형</th>
                <td>
                    <select name="i_admin_tp_cd" id="i_admin_tp_cd" onchange="">
                        <option value="">선택</option>
                    <c:forEach var="adminTp" items="${adminTpList}" >
                        <option value="${adminTp.MINOR_CD}">${adminTp.CD_NM}</option>
                    </c:forEach> 
                    </select>
                </td>
            </tr>
            <tr>
                <th class="point">로그인 ID</th>
                <td><input type="text" name="i_login_id" id="i_login_id" class="text" style="width:150px"/></td>
                <th class="point" id="f_corp_1">
                    법인코드
                    <span ></span>
                        <a href="#" class="btn_s2" id="btn_search_corp"><span>법인검색</span></a>
                </th>
                <td id="f_corp_2"><input type="text" name="i_corp_no" id="i_corp_no" class="inputRead right" readOnly="true" style="width:150px"/></td>
            </tr>
            <tr id="trPwd">           
                <th class="point">비밀번호</th>
                <td><input type="password" name="i_pwd" id="i_pwd" class="text" style="width:150px"/></td>
                <th class="point">비밀번호확인</th>
                <td><input type="password" name="i_pwd_confirm" id="i_pwd_confirm" class="text" style="width:150px"/></td>
            </tr>
            <tr>
                <th>사번</th>
                <td><input type="text" name="i_emp_no" id="i_emp_no" class="text" style="width:150px" maxlength="10"/></td>
                <th class="point">이메일</th>
                <td><input type="text" name="i_email" id="i_email" class="text" style="width:150px"/></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="i_tel1_no" id="i_tel1_no" class="text center" style="width:42px;" maxlength="4" /> <input type="text" name="i_tel2_no" id="i_tel2_no" class="text center" style="width:42px" maxlength="4"/> <input type="text" name="i_tel3_no" id="i_tel3_no" class="text center" style="width:42px" maxlength="4"/></td>
                <th class="point">핸드폰번호</th>
                <td><input type="text" name="i_cell1_no" id="i_cell1_no" class="text center" style="width:42px" maxlength="4"/> <input type="text" name="i_cell2_no" id="i_cell2_no" class="text center" style="width:42px" maxlength="4"/> <input type="text" name="i_cell3_no" id="i_cell3_no" class="text center" style="width:42px" maxlength="4"/></td>
            </tr>
            <tr>
                <th>비밀번호 오류횟수</th>
                <td><input type="text" name="i_pwd_error_cnt" id="i_pwd_error_cnt" class="inputRead right" readOnly="true" onFocus="blur();" style="width:50px"/> <a href="#" class="btn_s2" id="btn_ini"><span>초기화</span></a></td>
                <th>최근 비밀번호 오류일</th>
                <td><input type="text" name="i_pwd_error_dy" id="i_pwd_error_dy" class="inputRead right" readOnly="true" onFocus="blur();" style="width:150px"/></td>
            </tr>
            <tr>    
                <th class="point">활성화여부</th>
                <td colspan="3"><input type="radio" name="i_active_yn" value="Y"/> 활성화 <input type="radio" name="i_active_yn" value="N"/> 비활성화</td>
            </tr>
            <tr>
                <th class="point">관리자 권한그룹</th>
                <td colspan="3" id="t_role_nms"></td>
            </tr>
            <tr>
                <td colspan="4" class="center">
                    <a href="#" class="btn_s" id="btn_mod_pwd"><span>비밀번호 변경</span></a>
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














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
    $('#btn_mod').click(function() {modifyRole();});
    $('#btn_all').click(function() {toggleCheckBox();});
    //initTableHeader('g_role', 2, 150);
    
    getRoleOptionList($('#s_role_id'), true);
    
    doSearch();
});

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
                    $("<td></td>").addClass("left").html("<a href='javascript:loadMenu(\""+item.ROLE_ID+"\", \""+val(item.ROLE_NM)+"\")'>"+(item.ACTIVE_YN == 'N'?"<span class='inactive'>":"")+val(item.ROLE_NM)+"</a>").appendTo(tr);
                    tr.appendTo($("#g_role tbody"));
                }
                paintGrid("g_role");
            }
        } 
    });
}


function loadMenu(rid, rnm) {
    if (rnm) $('#t_role_nm').html(rnm);
    $('#h_role_id').val(rid);
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm202/menuList.json'/>",
        data: 'role_id='+rid,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);
            if (list) {
                $("#g_menu tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").html("<input type='checkbox' name='i_auth_yn_"+(item.MENU_ID)+"' "+(item.AUTH_YN == 'Y'? "checked":"")+" value='Y'/>").appendTo(tr);
                    $("<td></td>").addClass("left").css("padding-left", (eval(item.MENU_DEPTH)*30)+"px").html((item.MENU_DEPTH == '1'?"<b>":"")+(item.MENU_DEPTH == '4'?"<font style='font-style:oblique'>":"")+(item.ACTIVE_YN == 'N'?"<span class='inactive'>":"")+val(item.MENU_NM)+"</a>").appendTo(tr);
                    $("<td></td>").addClass("left").html((item.LEAF_MENU_YN == 'Y' ?
                            "<input type='radio' name='i_reg_view_divn_cd_"+item.MENU_ID+"' value='10' "+(item.ASSIGNED_REG_VIEW_DIVN_CD == '10'? "checked":"")+" "+(item.REG_VIEW_DIVN_CD == '20'? "disabled":"")+" />등록권한 <input type='radio' name='i_reg_view_divn_cd_"+item.MENU_ID+"' value='20' "+(item.ASSIGNED_REG_VIEW_DIVN_CD == '20'? "checked":"")+"/>조회권한" : "")).appendTo(tr);
                    tr.appendTo($("#g_menu tbody"));
                }
                paintGrid("g_menu");
            }
        }
    });     
}

function modifyRole() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm202/modifyRole.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 저장 되었습니다');
                loadMenu($('#h_role_id').val());
            }
        }
    });
}

// 전체선택 토글
var isChecked = true;
function toggleCheckBox() {
    if (isChecked) {
        $('input[name=auth_yn*]:checkbox').attr('checked', true);
        isChecked = false;
    }
    else {
        $('input[name=auth_yn*]:checkbox').attr('checked', false);
        isChecked = true;
    }
}



</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <c:import url="/view.do?viewName=location&layout=common" />

    <div class="h2">
        <h2>관리자 그룹 조회 조건</h2>
    </div>
  
    <div class="bbs_search">
        <form name="f_cond" id="f_cond" onsubmit="return false">
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <tr id="d_cond">
            <th width="80">권한그룹</th>
            <td width="150">
                <select name="s_role_id" id="s_role_id" style="width:150px">
                    <option value="">전체</option>
                </select>
            </td>
            <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
        </tr>
        </table>
        </form>
    </div>

    <div id="left_content" style="width:40%">
        <div class="bbs_grid" style="height:646px">
            <table id="g_role" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th>권한그룹</th>
                </tr>                
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>     
    </div>  
    <div id="right_content" style="width:59%">
        <form name="f_admin" id="f_admin">
        <div class="h3">
            <a href="#" class="btn_s right" id="btn_mod"><span>저장</span></a>
            <a href="#" class="btn_s2 right" id="btn_all"><span>전체선택</span></a>
            <span>메뉴 권한 할당</span>
            <span class="bar" id="t_role_nm"></span>
            <input type="hidden" name="h_role_id" id="h_role_id"/>
        </div>
        
        <div class="bbs_grid" style="height:610px">
            <table id="g_menu" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th width="40">선택</th>
                    <th>메뉴명</th>
                    <th width="180">조회등록권한</th>
                </tr>                
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>    
        </form>
    </div>  
    
</div>    
</body>
</html>














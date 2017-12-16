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
    $('#btn_mod').click(function() {modifyMenu();});
    $('#btn_del').click(function() {removeMenu();});
    $('#btn_ins').click(function() {appendMenu();});
    
    $('#s_menu_nm').focus();
    $('#s_menu_nm').keypress(function(e){
        if (e.which == 13) {
            doSearch();            
        }
        return false;
    });
    $('#t_new_menu').hide();
    $("#t_sub_new_menu").hide();
    $('#i_order_seq').numeric();
    
    doSearch();
});

function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/menuList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data);            
            if (list) {
                $("#g_menu tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").addClass("left").css("padding-left", (eval(item.MENU_DEPTH)*30)+"px").html("<a href='javascript:loadMenu(\""+item.MENU_ID+"\")'>"+(item.MENU_DEPTH == '1' || item.MENU_DEPTH == '2' ?"<b>":"")+(item.MENU_DEPTH == '4'?"<font style='font-style:oblique'>":"")+(item.ACTIVE_YN == 'N'?"<span class='inactive'>":"")+item.MENU_NM+"</a>").appendTo(tr);
                    tr.appendTo($("#g_menu tbody"));
                }
                paintGrid("g_menu");
            }
        } 
    });
}

function loadMenu(id) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/menu.json'/>",
        data: 'menu_id='+id,
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            var menu_nms = '';
            if (item.MENU_DEPTH == '1')
                menu_nms = item.MENU_NM;
            else if (item.MENU_DEPTH == '2')
                menu_nms = item.DEPTH3_MENU_NM+'<span class="bar">'+val(item.MENU_NM)+'</span>';
            else if (item.MENU_DEPTH == '3')
                menu_nms = item.DEPTH2_MENU_NM+'<span class="bar">'+val(item.DEPTH3_MENU_NM)+'</span><span class="bar">'+val(item.MENU_NM)+'</span>';
            else if (item.MENU_DEPTH == '4')
                menu_nms = item.DEPTH1_MENU_NM+'<span class="bar">'+val(item.DEPTH2_MENU_NM)+'</span><span class="bar">'+val(item.DEPTH1_MENU_NM)+'</span><span class="bar">'+val(item.MENU_NM)+'</span>';

            $('#t_menu_nms').html(menu_nms);
            $('#i_menu_nm').val(item.MENU_NM);
            $('#h_menu_id').val(item.MENU_ID);
            $('#i_url').val(item.URL);
            $('#i_order_seq').val(item.ORDER_SEQ);
 
            $("input:radio[name=i_menu_depth][value="+item.MENU_DEPTH+"]").attr("checked","checked");
            $("input:radio[name=i_menu_depth]").attr("disabled", true);
            $("input:radio[name=i_menu_yn][value="+item.MENU_YN+"]").attr("checked","checked");
            $("input:radio[name=i_active_yn][value="+item.ACTIVE_YN+"]").attr("checked","checked");
            $("input:radio[name=i_leaf_menu_yn][value="+item.LEAF_MENU_YN+"]").attr("checked","checked");
            $("input:radio[name=i_reg_view_divn_cd][value="+item.REG_VIEW_DIVN_CD+"]").attr("checked","checked");

            if (item.MENU_DEPTH == '4') 
                $('#t_new_menu').hide();
            else
                $('#t_new_menu').show();
        } 
    });
    
    loadSubMenu(id);   
}

function loadSubMenu(id) {
    if (!id && id.lengthh == 0)
        return;
    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/menuSubList.json'/>",
        data: 'up_menu_id='+id,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);  
            if (list) {
                $("#g_menu_sub tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").addClass("left").html((item.ACTIVE_YN == 'N'? "<i>":"")+val(item.MENU_NM)).appendTo(tr);
                    $("<td></td>").html("<input type='text' class='text right' name='i_order_seq_"+item.MENU_ID+"' id='i_order_seq_"+item.MENU_ID+"' style='width:40px' value='"+item.ORDER_SEQ+"'/>").appendTo(tr);
                    $("<td></td>").html("<a href='javascript:modifySubMenu(\""+item.MENU_ID+"\", \""+item.UP_MENU_ID+"\")' class='btn_s'><span>수정</span></a> <a href='javascript:removeSubMenu(\""+item.MENU_ID+"\", \""+item.UP_MENU_ID+"\")' class='btn_s'><span>삭제</span></a>").appendTo(tr);
                    tr.appendTo($("#g_menu_sub tbody"));
                    
                    $('#i_order_seq_'+item.MENU_ID).numeric();
                }
                paintGrid("g_menu_sub");
            }
        } 
    });
}

function modifyMenu() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/updateMenu.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정되었습니다');
                doSearch();
            }
        } 
    });
}

function modifySubMenu(id) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/updateMenu.json'/>",
        data: 'menu_id='+id+'&order_seq='+$('#i_order_seq_'+id).val(),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정되었습니다');
                doSearch();
                loadSubMenu($('#h_menu_id').val());
            }
        } 
    });
}

function removeMenu() {
    if (!confirm('정말 삭제 하시겠습니까?')) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/deleteMenu.json'/>",
        data: 'menu_id='+$('#h_menu_id').val(),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제되었습니다');
                doSearch();
                formReset('f_admin'); //$('#f_admin')[0].reset();
            }
        } 
    });
}

function removeSubMenu(id) {
    if (!confirm('정말 삭제 하시겠습니까?')) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/deleteMenu.json'/>",
        data: 'menu_id='+id,
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제되었습니다');
                doSearch();
                loadSubMenu($('#h_menu_id').val());
            }
        } 
    });
}

function appendMenu() {
    if ($("#t_new_menu").css('display') != 'none' && $("#t_sub_new_menu").css('display') == 'none') {
        $("#t_sub_new_menu").fadeIn();
        $("#i_new_menu_nm").focus();
        return;
    }
    if ($('#menu_nm').val() == '') {
        alert('메뉴명을 입력하세요');
        $('#menu_nm').focus();
        return;
    }
    if ($('#url').val() == '') {
        alert('URL을 입력하세요');
        $('#url').focus();
        return;
    }
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm201/insertMenu.json'/>",
        data: 'menu_nm='+$('#i_new_menu_nm').val()+'&up_menu_id='+$('#h_menu_id').val(),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 추가되었습니다');
                doSearch();
                loadSubMenu($('#h_menu_id').val());
                $("#i_new_menu_nm").val("");
                $("#t_sub_new_menu").hide();
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

    <!-- <div class="h2">
        <h2>메뉴 조회 조건</h2>
    </div>
  
    <div class="bbs_search">
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <form name="f_cond" id="f_cond" onsubmit="return false">
        <tr>
            <th width="80">메뉴명</th>
            <td width="180"><input type="text" class="text" name="s_menu_nm" id="s_menu_nm" style="width:150px;" /></td>
            <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
        </tr>
        </table>
        </form>
    </div> -->

    <div id="left_content" style="width:35%">
        <div class="bbs_grid" style="height:646px">
            <table id="g_menu" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th>메뉴명</th>
                </tr>                
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>      
    </div>  
    <div id="right_content" style="width:64%">
        <div class="h3">
            <a href="#" class="btn_s right" id="btn_del"><span>삭제</span></a>
            <a href="#" class="btn_s right" id="btn_mod"><span>저장</span></a>
            <span id="t_menu_nms">메뉴명</span>
        </div>

        <!-- content -->
        <div class="bbs_search">
            <form name="f_admin" id="f_admin">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <colgroup>
                <col width="120"/>
                <col/>
                <col width="120"/>
                <col/>
            </colgroup>
            <tr>
                <th class="point">메뉴명</th>
                <td colspan="3"><input type="text" name="i_menu_nm" id="i_menu_nm" class="text" style="width:150px"/><input type="hidden" name="h_menu_id" id="h_menu_id"/></td>
            </tr>
            <tr>                
                <th class="point">URL</th>
                <td colspan="3"><input type="text" name="i_url" id="i_url" class="text" style="width:400px" /></td>
            </tr>
            <tr>
                <th class="point">메뉴 뎁스</th>
                <td>
                    <input type="radio" name="i_menu_depth" value="1" id="i_menu_depth1"/><label for="i_menu_depth1">1뎁스</label>
                    <input type="radio" name="i_menu_depth" value="2" id="i_menu_depth2"/><label for="i_menu_depth2">2뎁스</label>
                    <input type="radio" name="i_menu_depth" value="3" id="i_menu_depth3"/><label for="i_menu_depth3">3뎁스</label>
                    <input type="radio" name="i_menu_depth" value="4" id="i_menu_depth4"/><label for="i_menu_depth4">내부URL</label>
                </td>
                <th class="point">메뉴여부</th>
                <td>
                    <input type="radio" name="i_menu_yn" value="Y" id="i_menu_yn_y"/><label for="i_menu_yn_y">Y</label>
                    <input type="radio" name="i_menu_yn" value="N" id="i_menu_yn_n"/><label for="i_menu_yn_n">N</label>
                </td>
            </tr>
            <tr>
                <th class="point">메뉴 활성화 여부</th>
                <td>
                    <input type="radio" name="i_active_yn" value="Y" id="i_active_yn_y"/><label for="i_active_yn_y">활성화</label>
                    <input type="radio" name="i_active_yn" value="N" id="i_active_yn_n"/><label for="i_active_yn_n">비활성화</label>
                </td>
                <th class="point">최하위메뉴 여부</th>
                <td>
                    <input type="radio" name="i_leaf_menu_yn" value="Y" id="i_leaf_menu_yn_y"/><label for="i_leaf_menu_yn_y">Y</label>
                    <input type="radio" name="i_leaf_menu_yn" value="N" id="i_leaf_menu_yn_n"/><label for="i_leaf_menu_yn_n">N</label>
                </td>
            </tr>
            <tr>
                <th class="point">등록조회구분</th>
                <td>
                    <input type="radio" name="i_reg_view_divn_cd" value="10" id="i_reg_view_divn_cd_10"/><label for="i_reg_view_divn_cd_10">등록화면</label>
                    <input type="radio" name="i_reg_view_divn_cd" value="20" id="i_reg_view_divn_cd_20"/><label for="i_reg_view_divn_cd_20">조회화면</label>
                </td>
                <th class="point">정렬순서</th>
                <td>
                    <input type="text" class="text right" name="i_order_seq" id="i_order_seq" style="width:50px"/>
                </td>
            </tr>
            </table>
            </form>
        </div>
        <div class="h3">
            <span>하위 메뉴 리스트</span>
            <span id="t_new_menu">
                <a href="#" class="btn_s right" id="btn_ins"><span>신규</span></a>
                <span id="t_sub_new_menu" class="bar right"> 메뉴명&nbsp;&nbsp;<input type="text" class="text" name="i_new_menu_nm" id="i_new_menu_nm"/>&nbsp;</span>
            </span>
        </div>
        <div class="bbs_grid" style="height:421px;overflow-y:auto;margin-bottom:0">
            <table id="g_menu_sub" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th>메뉴명</th>
                    <th width="60">메뉴순서</th>
                    <th width="100">작업</th>
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














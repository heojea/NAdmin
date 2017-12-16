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
    doSearch();
});
function checkKey(){
	if(event.keyCode==13){
		doSearch();
	}
}
function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm103/adminList.json'/>",
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
                    $("<td></td>").addClass("left").html(item.ADMIN_TP_NM).appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:loadMapping(\""+item.ADMIN_ID+"\",\""+item.ADMIN_NM+"\")'>"+val(item.LOGIN_ID)+"</a>").appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:loadMapping(\""+item.ADMIN_ID+"\",\""+item.ADMIN_NM+"\")'>"+val(item.ADMIN_NM)+"</a>").appendTo(tr);
                    tr.appendTo($("#g_role tbody"));
                }
                paintGrid("g_role");
            }
        } 
    });
}


function loadMapping(admin_id, admin_nm) {
    if (admin_nm) $('#t_admin_nm').html(admin_nm);
    $('#h_admin_id').val(admin_id);
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm103/adminComplexAssignList.json'/>",
        data: 'admin_id='+admin_id,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);
            if (list) {
                $("#g_admin tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").html("<input type='checkbox' name='i_auth_yn_"+(item.SIDO_CD)+(item.COMPLEX_CD)+"' "+(item.AUTH_YN == 'Y'? "checked":"")+" />").appendTo(tr);
                    $("<td></td>").addClass("left").html(item.SIDO_NM).appendTo(tr);
                    $("<td></td>").addClass("left").html(item.COMPLEX_NM).appendTo(tr);
                    tr.appendTo($("#g_admin tbody"));
                }
                paintGrid("g_admin");
            }
        }
    });     
}

function modifyRole() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm103/modifyAdminComplexAssign.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 저장 되었습니다');
                loadMapping($('#h_admin_id').val());
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
        <h2>관리자 담지 매핑 조회 조건</h2>
    </div>
  
    <div class="bbs_search">
        <form name="f_cond" id="f_cond" onsubmit="return false">
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <tr id="d_cond">
            <th width="80">관리자 유형</th>
			<td width="180">
				<select name="s_admin_tp_cd" id="s_admin_tp_cd">
					<option value="">전체</option>
                    <c:forEach var="adminTp" items="${adminTpList}" >
                        <option value="${adminTp.MINOR_CD}">${adminTp.CD_NM}</option>
                    </c:forEach>
				</select>
			</td>
			<th width="60">관리자ID</th>
            <td width="180"><input type="text" class="text" name="s_login_id" id="s_login_id" style="width:150px;" onkeypress="checkKey()" /></td>
			<th width="60">관리자명</th>
            <td width="180"><input type="text" class="text" name="s_admin_nm" id="s_admin_nm" style="width:150px; IME-MODE: active;" onkeypress="checkKey()" /></td>
            <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
        </tr>
        </table>
        </form>
    </div>

    <div id="left_content" style="width:45%">
        <div class="bbs_grid" style="height:646px">
            <table id="g_role" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th width="150">관리자유형</th>
                    <th width="70">관리자ID</th>
                    <th>관리자명</th>
                </tr>                
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>     
    </div>  
    <div id="right_content" style="width:54%">
        <form name="f_admin" id="f_admin">
        <div class="h3">
            <a href="#" class="btn_s right" id="btn_mod"><span>저장</span></a>
            <a href="#" class="btn_s2 right" id="btn_all"><span>전체선택</span></a>
            <span>관리자 단지 할당</span>
            <span class="bar" id="t_admin_nm"></span>
            <input type="hidden" name="h_admin_id" id="h_admin_id"/>
        </div>
        
        <div class="bbs_grid" style="height:610px">
            <table id="g_admin" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                <tr>
                    <th width="40">번호</th>
                    <th width="40">선택</th>
                    <th width="80">시도</th>
                    <th>단지명</th>
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














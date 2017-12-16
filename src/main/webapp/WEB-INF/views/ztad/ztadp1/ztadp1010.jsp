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
	$('#i_admin_id').val('${param.admin_id}');
	$('#btn_mod_pwd').live("click", function() {
		modPwd();
	});
	
	$('#f_pwd').validate({
        rules: {
        	i_admin_id: {required:true},
        	i_org_pwd: {required:true, minlength:4, maxlength: 100},
            i_new_pwd: {required:true, equalTo: '#i_new_pwd_confirm', minlength:4, maxlength: 100},
        	i_new_pwd_confirm: {required:true, minlength:4, maxlength: 100}
        },
        messages: {},
        errorPlacement: function(error, element) {   
            if (!element.is(":radio") && !element.is(":checkbox"))
                error.insertAfter(element);
        }
     });
});

// 비밀번호 변경
function modPwd() {
	if (!$('#f_pwd').validate().form()) return;
	$.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadp101/updateSadUserPwd.json'/>",
        data: formSerialize("#f_pwd"),
        dataType: 'json',
        success: function(data) {
            if(data.isSuccess) {// 성공
            	if(data.code == 'success') {
            		alert(data.msg);
            		window.close();
            	}
            }else {// 실패
            	alert(data.msg);
            	if(data.code == 'errCurPwd') {
            		$('#i_org_pwd').val('');
            		$('#i_org_pwd').focus();
            	}else if(data.code == 'errCurPwdDupl') {
            		$('#i_new_pwd').val('');
            		$('#i_new_pwd_confirm').val('');
            		$('#i_new_pwd').focus();
            	}else {
            		$('#i_org_pwd').val('');
            		$('#i_new_pwd').val('');
            		$('#i_new_pwd_confirm').val('');
            		$('#i_org_pwd').focus();
            	}
            	return;
            }
        }
    });
}
</script>
</head>
<body>
<!-- wrap -->
<div style="min-width:0px; width:400px;">
    <div class="h2"><h2>비밀번호 변경</h2></div>

    <form id="f_pwd" name="f_pwd" method="post">
        <input type="hidden" id="i_admin_id" name="i_admin_id" />
        <div class="bbs_search">
	        <table id="g_selector" class="bbs_search" cellpadding="0" cellspacing="0" border="0">
	        <colgroup>
	            <col width="150"/>
	            <col/>
	        </colgroup>
	        <tbody>
	        <tr>
	            <th class="point">현재 비밀번호</th>
                <td><input type="password" name="i_org_pwd" id="i_org_pwd" class="text" style="width:250px"/></td>
	        </tr>
	        <tr>
	            <th class="point">새 비밀번호</th>
                <td><input type="password" name="i_new_pwd" id="i_new_pwd" class="text" style="width:250px"/></td>
	        </tr>
	        <tr>
	            <th class="point">새 비밀번호 확인</th>
                <td><input type="password" name="i_new_pwd_confirm" id="i_new_pwd_confirm" class="text" style="width:250px"/></td>
	        </tr>
	        <tr>
	            <td colspan="2" class="center">
	                <a href="#" class="btn_s" id="btn_mod_pwd"><span>저장</span></a>
	            </td>
	        </tr>
	        </tbody>
	        </table>
	    </div>
    </form>
</div>    
</body>
</html>

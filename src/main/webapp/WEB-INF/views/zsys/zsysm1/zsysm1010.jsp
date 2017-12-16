<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>어드민</title>
<%--
<link rel="stylesheet" href="<c:url value='/css.do?viewName=base'/>" />
<link rel="stylesheet" href="<c:url value='/css.do?viewName=login'/>" />
--%>
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/base.css" />
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/login.css" />
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/commons.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/plugins/jquery.validate.1.8.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    
    if ($('#login_id').val() == '')
        $('#login_id').focus();
    else {
        $('#login_pw').focus();
        $('#save_yn').attr('checked', true);
    }
    
    $('#corp_form').hide();
    
    $('#corp_ok').click(function() {
        if($('#corp_ok').is(':checked') == true) {
            $('#corp_form').show();
            $('#corp_form').reset();
        } else {
            $('#corp_form').hide();
        }
    });
    
    //$('#login_id').alphanumeric();
    //$('#login_pw').alphanumeric();
    
//     ajaxSetup();
    $('#login_img').click(function() {
        if($('#corp_ok').is(':checked') == true) {
            corpLogin();
        } else {
            login();
        }
    });
    
    $("input").keypress(function(e){
        if (e.which == 13) {
            if($('#corp_ok').is(':checked') == true) {
                corpLogin();
            } else {
                login();
            }
        }
    }); 
    
});
</script>
<script type="text/javascript">
function login() {
    if ($('#login_id').val() == '') {
        alert('로그인 아이디를 입력하세요');
        $('#login_id').focus();
        return;
    }
    
    if ($('#login_pw').val() == '') {
        alert('로그인 비밀번호를 입력하세요');
        $('#login_pw').focus();
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/zsys/zsysm101/login.do'/>",
        data: 'save_yn='+($('#save_yn').attr('checked')?'Y':'N')+'&site_login_id='+$('#site_login_id').val()+'&login_id='+$('#login_id').val()+'&login_pw='+$('#login_pw').val(),
        dataType: 'json',
        success: function(data) {
            if (data.result) {
                window.open("<c:url value='/home.do'/>","_top");
            }
            else {
                if(data.pwdErr){
                    alert("비밀번호를 5회 이상 틀린 아이디입니다");                
                }else if(data.adminTpCdErr) {
                    alert("법인 관리자로 로그인 하세요.");
                }else{
                    alert('로그인 정보가 올바르지 않습니다.');
                }
            } 
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
    });
}

function corpLogin() {
    if($('#login_id').val() == '') {
        alert('로그인 아이디를 입력하세요');
        $('#login_id').focus();
        return;
    }
    
    if($('#login_pw').val() == '') {
        alert('로그인 비밀번호를 입력하세요');
        $('#login_pw').focus();
        return;
    }
    
    if($('#biz_no').val() == '') {
        alert('사업자 번호를 입력하세요');
        $('#biz_no').focus();
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/zsys/zsysm101/corpLogin.do'/>",
        data: 'corp_ok='+($('#corp_ok').attr('checked')?'Y':'N')+'&save_yn='+($('#save_yn').attr('checked')?'Y':'N')+'&site_login_id='+$('#site_login_id').val()+'&login_id='+$('#login_id').val()+'&login_pw='+$('#login_pw').val()+'&biz_no='+$('#biz_no').val(),
        dataType: 'json',
        success: function(data) {
            if(data.result) {
                window.open("<c:url value='/home.do'/>","_top");
            }
            else if(data.pwdErr){
                alert("비밀번호를 5회 이상 틀린 아이디 입니다.");
            }else if(data.biz_no_err){
                alert("사업자번호가 올바르지 않습니다.");
            }else {
                alert('로그인 정보가 올바르지 않습니다.');
            }
        }
    });
    
    
    
    
}




var testInstance = {
		abcMethod : function(){
			var abcMethodInner = 'abcMethod innsert text';
			alert(abcMethodInner);
		},
		
		abcPlus : function(){
			this.abc += 1;
		},
		
		makeAbc : function(){
			
		}
};


varBeanModule = (function(){
	 abc = {
		"a" : "aaaa",
		"b" : "bbbb",
		"c" : "cccc"
	 }
})();
//testInstanceModule = {};

testInstanceModule = (function(){
	var abc = 1;
	var varBeanModule;
	return {
		init : function(){
			console.log("init");
			console.log(arguments[0])
			varBeanModule = arguments[0];
		},
		
		alertMethod : function(){
			var abcMethodIn = 'ccc';
			alert(abcMethodIn);
			
			
			for (var i = 0; i< 4; i++) {
				console.log("for::"+i);
			}
			
			alert(varBeanModule);
		},
		
		getAbc : function(){
			return abc;
		},
		
		getAbcPlus : function(){
			return ++abc;
		},
		
		getVarBeanModule : function(){
			return varBeanModule;	
		}
	};
	
	
})();





function abcFunction(){
	var ccc = 1;
	return {
		abc : function(){
			return ccc;
		},
		
		abcPlus : function(){
			return ++ccc; 
		},
		
		getAbc : function(){
			return ccc;
		}
	}
}
alert(111);
var ccc = new abcFunction();






$(document).ready(function(testInstance , testInstanceModule , abcIns){
	console.log("======testInstanceModule");
	console.log(testInstanceModule.abc);
	testInstanceModule.alertMethod();
	console.log(testInstanceModule.getAbc());
	console.log(testInstanceModule.getAbcPlus());
	console.log(testInstanceModule.getAbcPlus());
	console.log(testInstanceModule.getAbcPlus());
	console.log(testInstanceModule.getAbcPlus());
	console.log(testInstanceModule.getAbcPlus());
	
	
	console.log(testInstanceModule.getAbc());
	
	console.log("private 객채 가져오기 시다 :" + testInstanceModule);
	
	console.log("======abcIns");
	console.log(abcIns.ccc);
	console.log(abcIns.getAbc());
	console.log(abcIns.abcPlus());
	
	
}(testInstance , testInstanceModule , new abcFunction()))



</script>
</head>


<body style="overflow:hidden">
	<div class="logo">
		<%-- <img src="${cfn:getString('system.static.path')}/images/login/admin_login_04.gif" alt="" /> --%>
	</div>
    <!--  login box -->
    <div class="loginBox">
        
        <!-- form -->
        <div class="form" id="form">
            <dl>
                <dt class="r5">아이디</dt> 
                <dd><input type="text" class="text" id="login_id" value="${login_id}" style="font-weight:bold;font-family:verdna;width:150px;" tabindex="1"/></dd>
            </dl>
            <dl>
                <dt class="r1">비밀번호</dt>
                <dd><input type="password" class="text" id="login_pw" value="#admin!@admin" style="font-weight:bold;font-family:verdna;width:150px;" tabindex="2" /></dd>
            </dl>
            <dl>
            	<dt></dt>
                <dd>
                    <div class="corp_form" id="corp_form">
                        <div style="float:left;width: 80px;">사업자 번호 </div>
                        <input type="text" class="text" id="biz_no" value="${biz_no}" style="font-weigt:bold;font-family:verdna;width:120px; " maxlength="10" tabindex="3"/>
                    </div>
                </dd>
            </dl>
            <dl>
            	<dt></dt>
                <dd style="width:420px; padding-left: 95px; padding-top: 10px;">
<!--                     <input type="checkbox" id="corp_ok" value=""/>법인관리자 -->
                    <input type="checkbox" id="save_yn" value=""/><span>아이디 저장</span>
                </dd>
            </dl>
        </div>
        <div class="btn">
        	<img src="${cfn:getString('system.static.path')}/images/login/btn_login.png" alt="" id="login_img" style="cursor:pointer"/>
        </div>
        <!-- form // -->
    </div>
    <!--  login box // -->
    <!--  copy box -->
    <div class="copy">
    </div>
    <!--  copy box // -->
    
    <div>
    	
    </div>
</body>
</html>

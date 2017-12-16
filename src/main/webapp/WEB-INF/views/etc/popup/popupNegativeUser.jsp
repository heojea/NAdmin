<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />

<script type="text/javascript">
/**
 * button event listenr
 */
function buttonEventAdd(){
	$("#btn_mod").bind("click",function(){
		insertModify();	
	});
	
	$("#dupId").bind("click",function(){
		dupAjax();	
	});
	
	$("#cardId").bind("change",function(){
		$("#dupActionYn").val("N");
	});
}

/* error check */
function validation(){
	var flag = true;
	if ($('#cardId').val() == '') {
	   alert('카드아이디를 입력하세요');
	   $('#cardId').focus();
	   flag = false;
	   return;
    }
	
	if ($('#negativeDesc').val() == '') {
		   alert('사유를 입력하세요');
		   $('#negativeDesc').focus();
		   flag = false;
		   return;
	}
	
	
	
	if($("#dupActionYn").val()== 'N'){
		alert("중복검사가 필요합니다.");
		flag = false;
		return 
	}
	if($("#dupFlag").val()== 'N'){
		alert("사용불가 카드아이디 입니다.");
		flag = false;
		return
	}
	
	return flag;
}


/**
 * first init setting ready
 */
$(document).ready(function() {
	buttonEventAdd();
});

/* 승인 event  */
function insertModify(){
	if(!validation())return;
	if (confirm("등록하시겠습니까?") == false)return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/etc/negativeUserCardIdInsert.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        
        /* success logic  */
        success: function(data) {
			alert("등록 성공~");
			window.close();
        },
	    error : function(){
	    	alert("등록 실패~");
		}
    });
}

function dupAjax(){
	if ($('#cardId').val() == '') {
		   alert('카드번호를 입력하세요');
		   $('#cardId').focus();
		   return;
	}
    $.ajax({
        type: 'POST',
        url: "<c:url value='/etc/negativeUserDup.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        
        /* success logic  */
        success: function(data) {
        	if(data.DUPCNT == 0){
        		$("#dupActionYn").val("Y");
				$("#dupFlag").val("Y");
				alert("사용가능 카드 아이디 입니다.");
        	}else{
        		$("#dupActionYn").val("Y");
        		$("#dupFlag").val("N");
        		alert("사용불가 카드 아이디 입니다.");
        	}
        } 
    });
}

</script>
</head>
<body>
<div style="min-width:0px; width:600px;">
   <div class="h3">
       <span>부정의심 사용자 관리</span>
   </div>
   <div class="bbs_search"  style="height:230px; ">
            <form name="f_admin" id="f_admin">
            <table id="g_selector" class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <colgroup>
                <col width="100"/>
                <col width="100"/>
                <col width="100"/>
                
            </colgroup>
           
            <tbody>
            <tr>
                <th class="point">카드아이디</th>
                <td><input type="text" value="" id="cardId" name="cardId"  /></td>
                <td><input type="button" value="아이디 중복검사" id="dupId" /></td>
            </tr>
            <tr>
                <th class="point">사유</th>
                <td>
                	<textarea rows="10" cols="50" name="negativeDesc" id="negativeDesc"></textarea>
                </td>
                
            </tr>
		
            <tr>
                <td colspan="3" class="center">
                    <a href="#" class="btn_s" id="btn_mod"><span>등록</span></a>
                    <a href="javascript:window.close();" class="btn_s" id="btn_close"><span>닫기</span></a>
                </td>
            </tr>
            </tbody>
            </table>
            <input type="hidden" value="N" id="dupFlag" name="dupFlag" />
            <input type="hidden" value="N" id="dupActionYn" name="dupActionYn" />
            </form>
   </div>
</div>    
</body>
</html>


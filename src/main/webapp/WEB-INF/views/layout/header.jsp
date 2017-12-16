<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.share.themis.common.Constants" %>
<%@ page import="com.share.themis.common.model.LoginSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>어드민</title>
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/base.css" />
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/header.css" />

<script>
var menuId;
var changeMenuId;
$(document).ready(function() {
    <c:forEach items="${menuList}" var="menu" begin="0">
        //메뉴명 클릭시
        $("#${menu.MENU_ID}").click(function(){
            $("#${menu.MENU_ID}").css("color", 'aqua');
            menuId = "${menu.MENU_ID}";
            <c:forEach items="${menuList}" var="changeMenu" begin="0">
                 changeMenuId = "${changeMenu.MENU_ID}";
                 if(menuId != changeMenuId){
                     $("#${changeMenu.MENU_ID}").css("color", '');
                 }   
            </c:forEach>
            
            parent.document.getElementById('totalWin').cols = '200, *';
            document.bgColor = '#efece0';
            //document.getElementById('leftClose').style.display= 'block';
            document.getElementById('leftOpen').style.display= 'none';
        });
    </c:forEach>
});

</script>
</head>
<body>
<!--    header  -->
<div id="header">
    <%-- <div class="hlogo">
    	<a href="<c:url value='/home.do'/>" target="_top"><img src="${cfn:getString('system.static.path')}/images/common/img_logo.png" alt="" /></a>
    </div> 
 --%>        
    <!-- member info -->
    <div class="hinfo">   
                사용자 ID : <strong><%=((LoginSession)session.getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY)).getLogin_id() %></strong>
        <span class="bar">사용자명 :</span> <%=((LoginSession)session.getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY)).getAdmin_nm() %> 
    </div>

    <div class="htime">접속시간 : ${serverTime} </div>
    <div class="logout"><a href="<c:url value='/zsys/zsysm101/logout.do'/>" target="_top"><img src="${cfn:getString('system.static.path')}/images/common/btn_logout.gif" alt="로그아웃" class="middle" /></a></div>
    <!-- member info // -->

    <!-- top menu -->
    <div class="hquick">
        <c:forEach items="${menuList}" var="menu" begin="0">
            <span class="bar"><a href="left.do?menu_id=${menu.MENU_ID}" id="${menu.MENU_ID}" target="leftFrame">${menu.MENU_NM}</a></span>
         </c:forEach>
         <span class="bar"></span>
    </div>
    <!-- top menu // -->
    
</div>
<!--    header  //-->
</body>
</html>
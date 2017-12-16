<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>어드민</title>
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/base.css" />
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/left.css" />
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/menu.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    resizeLeft();
    $('#close_img').click(function(){
        resizeMenu();
    });
    $('#open_img').click(function(){
        resizeMenu();
    });
});

function goActFrame(mid, name, url)
{
	parent.rightFrame.fn_addTab(mid, name, url);
}
</script>
</head>
<body>
<!--    left Close  -->
<div id="leftClose">
    <div class="topT"><img id="close_img" src="${cfn:getString('system.static.path')}/images/common/left_close.gif" alt="닫기" class="hand" /></div>
    <!-- menu -->
    <div id="LeftList" class="left_menu">
    
    <c:forEach items="${menuList}" var="menu" varStatus="stat" begin="0">
        <c:if test="${menu.MENU_DEPTH == '1'}">
            <ul class="depth1">
                <li id="depth1_${stat.count}" class="on">
                    <span class="hand" onclick="viewMenu('depth1_${stat.count}');">${menu.MENU_NM}</span>
        </c:if>
        
        <c:if test="${stat.count gt 2 && menu.MENU_DEPTH  == '2'}">
                            </ul>
                        </li>
                    </ul>        
        </c:if>
        
        <c:if test="${menu.MENU_DEPTH == '2'}">
                    <ul class="depth2">
                        <li id="depth2_${stat.count}" class="on">
                            <span class="hand" onclick="viewMenu('depth2_${stat.count}');">${menu.MENU_NM}</span>
                            <ul class="depth3">
        </c:if>
        
        <c:if test="${menu.MENU_DEPTH == '3'}">                                    
                                <!--<li class="off"><a href="<c:url value='/'/>${menu.URL}" target="rightFrame" onMouseover="this.style.color='#0D80F2'" onMouseout="this.style.color=''">${menu.MENU_NM}</a></li>-->
                                <li class="off"><a href="javascript:goActFrame('${menu.MENU_ID}','${menu.MENU_NM}','<c:url value='/'/>${menu.URL}');" onMouseover="this.style.color='#0D80F2'" onMouseout="this.style.color=''">${menu.MENU_NM}</a></li>
        </c:if>
    </c:forEach>
                            </ul>
                        </li>
                    </ul>        
                </li>
             </ul>       
    </div>
    <!-- menu // -->
</div>
<!--    left Close  //-->


<!--    left Open   -->
<div id="leftOpen">
    <div class="topT"><img id="open_img" src="${cfn:getString('system.static.path')}/images/common/left_open.gif" alt="닫기" class="hand"/></div>
</div>
<!--    left Open   //-->
</body>
</html>
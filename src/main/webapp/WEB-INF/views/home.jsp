<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>어드민</title>
<script type="text/javascript" src="<c:url value='/js/menu.js'/>"></script>
    <frameset rows="90, *" id="totalParent" name="totalParent" frameborder="no" border="0" framespacing="0">
        <frame src="<c:url value='/layout/header.do'/>" id="topFrame" name="topFrame" scrolling="no" noresize="noresize">
        <frameset cols="200, *" id="totalWin" name="totalWin" frameborder="no" border="0" framespacing="0">
            <frame src="<c:url value='/layout/left.do'/>" id="leftFrame" name="leftFrame" scrolling="no" noresize="noresize">
            <frame src="<c:url value='mDiv.jsp'/>" id="rightFrame" name="rightFrame" scrolling="yes" noresize="noresize">
        </frameset>
    </frameset>

</head>
<body>
</body>
</html>
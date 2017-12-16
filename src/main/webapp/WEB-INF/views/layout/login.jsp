<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>어드민</title>
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/base.css" />
<link rel="stylesheet" href="${cfn:getString('system.static.path')}/css/login.css" />
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/jquery/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/commons.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    window.open("<c:url value='/zsys/zsysm101/main.do'/>", "_top");
});
</script>
</head>
<body>
</body>
</html>
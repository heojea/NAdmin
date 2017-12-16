<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>어드민</title>
<script type="text/javascript" src="/js/jquery/jquery-1.7.2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	ajaxHttpRestCall();
   
	
   //window.open("<c:url value='/zsys/zsysm101/main.do'/>", "_self");
});

function ajaxHttpRestCall(){
	 $.ajax({
	       // url: "http://rest-service.guides.spring.io/greeting"
	       
	       
	       
	       
	       
	       
	       
	       
	       
	       
		 url: "http://localhost:9090/say/hello"  
	    }).then(function(data) {
	    	console.log(data);
	    	console.log(data.id);
	    	console.log(data.content);
	    });
}
</script>
</head>
<body>
</body>
</html>

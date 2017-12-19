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
	
	//ajaxHttpRestCallGet();
   
	console.log("===================");
	ajaxHttpRestCallPost();
   //window.open("<c:url value='/zsys/zsysm101/main.do'/>", "_self");
});

function ajaxHttpRestCallPost(){
	  var data = {};
	  data["aaa"] = 1;
	  data["bbbb"] = 1;
	  console.log(JSON.stringify(data));
	
	  $.ajax({
          type: "post",
          url: "http://localhost:9090/say/bye",
          data: JSON.stringify(data),
          contentType: "application/json; charset=utf-8",
          crossDomain: true,
          dataType: "json",
          success: function (data, status, jqXHR) {

              alert(data);
          },

          error: function (jqXHR, status) {
              // error handler
              console.log(jqXHR);
              alert('fail' + status.code);
          }
       });
}

function ajaxHttpRestCallGet(){
	   $.ajax({
		   url: "http://localhost:9090/say/hello",
           type: "GET",
           dataType: 'json',
           success: function(data){
               console.log(data);
               console.log(data.id);
               console.log(data.content);
           },
           error:function(){
               $("#result").html('there is error while submit');
           }  
       });
	   
	 
}
</script>
</head>
<body>
<div id="result"></div>
</body>
</html>

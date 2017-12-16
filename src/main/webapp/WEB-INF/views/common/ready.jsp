<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
var gvsa = false;
$(document).ready(function() {
    $("<input type='hidden' name='i_site_id' id='i_site_id' value='${site_id}'/>").appendTo($("body"));
    
    // ajax 기본 세팅
    ajaxSetup();    

    // table header 고정
    $("table.bbs_grid").fixedtableheader();
});
</script>
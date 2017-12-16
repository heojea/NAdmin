<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<c:import url="/view.do?viewName=header&layout=common" />
<script type="text/javascript">
var _parameters = {};

function getParameter() {
    var str = '';
    var urlHalves = String(document.location).split('?');
    if(urlHalves[1]){
        var urlVars = urlHalves[1].split('&');
        for(var i=0; i<=(urlVars.length); i++){
            if(urlVars[i]){
                var urlVarPair = urlVars[i].split('=');
                if(i > 0) str += ',';
                str += urlVarPair[0] + ":" + "'"+urlVarPair[1]+"'";
            }
        }
    }
    _parameters = eval("({"+str+"})");
}

//jQeury 초기화
$(document).ready(function(){
    
    //파라메터 로드
    getParameter();

//  Common.installDatePicker();
    // datepicker regional['ko'] 속성 정의.
    $.datepicker.regional['ko'] = {
        closeText: '닫기',
        prevText: '이전달',
        nextText: '다음달',
        currentText: '오늘',
        monthNames: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        dateFormat: 'yy-mm-dd',
        firstDay: 0,
        minDate:_parameters.minDate,
        maxDate:_parameters.maxDate,
        isRTL: false
    };

    // datepicker 설정.
    $.datepicker.setDefaults(
            $.extend(
                {
                    showMonthAfterYear: true, 
                    //showButtonPanel: true
                    changeMonth: true,
                    changeYear: true
                },
                $.datepicker.regional['ko']
            )
    );
    
    $('#datepicker').datepicker({
        onSelect: function(dateText, inst){
            //var inputName = getInputName();
            var inputName = '${inputName}'; //_parameters.inputName;
            var callbackFunc = '${callbackFunc}'; //_parameters.callbackFunc;
            var inputField = eval('opener.document.'+inputName);
            if (inputField) {
                $(inputField).val(dateText);
                if(callbackFunc) eval('opener.'+callbackFunc+'()');
                window.close();
            }
            else {
                alert('inputName이 올바르지 않습니다: ' + inputName);
            }
        }
    });

});

</script>
</head>
<body>
<div id="datepicker" style="margin-left:9px;margin-top:8px;" />
</body>
</html>

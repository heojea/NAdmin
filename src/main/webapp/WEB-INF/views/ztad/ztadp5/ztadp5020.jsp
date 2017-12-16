<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<script type="text/javascript">
$(document).ready(function() {
    $('#btn_target').click(function() {popMemberSearchMulti('selectMemberOk');});
    $('#btn_send').live("click", function() {sendTemplete();});
    $('#tab1_top_title').click(function() {showTabs('1');});
    $('#tab2_page').hide();
    //initTableHeader('g_admin', 2, 150);   
    //initSiteSelector("g_selector", 3);
    
    $('input[name=i_use_start_hour]').numeric();
    $('input[name=i_use_start_min]').numeric();
    $('input[name=i_use_end_hour]').numeric();
    $('input[name=i_use_end_min]').numeric();
    
    loadTemplete('${param.temp_no}');
});

// 쿠폰발급
function sendTemplete() {
    if($('#i_temp_no').val() == ''){
        alert('템플릿이 선택되지 않았습니다.');
        return;
    }
    if($('#i_member_json').val() == ''){
        alert('발송대상이 선택되지 않았습니다.');
        return;
    }
    
    if (!confirm('발송 하시겠습니까?')) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadp502/sendTemplete.json'/>",
        data: formSerialize("#f_admin"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 발송 되었습니다');
                self.close();
            }
        }
    });
}

function loadTemplete(rid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadp502/templete.json'/>",
        data: 'temp_no='+rid,
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            $('#i_temp_no').val(item.TEMP_NO);
            $('#d_temp_subject_nm').html(item.TEMP_SUBJECT_NM);
            $('#d_temp_nm').html(item.TEMP_NM);
            $('#d_temp_content').html(item.TEMP_CONTENT.replaceAll('\r\n','<br/>'));
        }
    });
}

function selectMemberOk(jsonStr, tot){
    $('#i_member_json').val(jsonStr);
    $('#d_tot').html(tot+'명이 선택되었습니다.');
 }
</script>
</head>
<body>
<!-- wrap -->
<div style="min-width:0px; width:775px;">
    <div class="h2"><h2>이메일발송</h2></div>

    <form id="f_admin" name="f_admin" method="post">
        <input type="hidden" id="i_temp_no" name="i_temp_no" />
        <input type="hidden" id="i_member_json" name="i_member_json" />
    <div class="bbs_search">
        <table id="g_selector" class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <colgroup>
            <col width="100"/>
            <col/>
        </colgroup>
        <tbody>
        <tr>
            <th class="point">템플릿명</th>
            <td id="d_temp_nm"></td>
        </tr>
        <tr>
            <th class="point">제목</th>
            <td id="d_temp_subject_nm"></td>
        </tr>
        <tr>
            <th class="point">내용</th>
            <td>
                <div id="d_temp_content" style="width:100%;height:240px;overflow:auto;"></div>
            </td>
        </tr>
        <tr>
            <th>발송대상</th>
            <td colspan="3">
                <a href="#" class="btn_s2" id="btn_target"><span>발송대상검색</span></a>
                <span id="d_tot"></span>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="center">
                <a href="#" class="btn_s" id="btn_send"><span>이메일발송</span></a>
            </td>
        </tr>
        </tbody>
        </table>
    </div>
    </form>
</div>    
</body>
</html>

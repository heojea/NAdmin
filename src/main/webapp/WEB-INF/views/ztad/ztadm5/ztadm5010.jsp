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
    $('#btn_sel').click(function() {doSearch();});
    $('#btn_mod').live("click", function() {modifyTemplete();});
    $('#btn_del').live("click", function() {removeTemplete();});
    $('#btn_ins').live("click", function() {appendTemplete();});
    $('#tab1_top_title').click(function() {showTabs('1');});
    $('#tab2_top_title').click(function() {showTabs('2',true);});
    $('#tab2_page').hide();
    //initTableHeader('g_admin', 2, 150);   
    //initSiteSelector("g_selector", 3);
    
    $('#f_templete').validate({
        rules: {
            i_temp_nm: {required:true, maxlength:25},
            i_temp_tp_cd: {required:true}
        },
        messages: {},
        errorPlacement: function(error, element) {   
            if (!element.is(":radio") && !element.is(":checkbox"))
                error.insertAfter(element);
        }
     });
});

function showTabs(no, isNew) {
    initTabs(2, no);
    if (no == '1') {
        $('#tab2_top_title').html('템플릿 생성');
    }        
    else {
        // 신규
        if (isNew) {
            $('#f_templete')[0].reset();
            $('#btn_del').hide();
            $('#btn_mod').hide();
            $('#btn_ins').show();
            $('#tab2_top_title').html('템플릿 생성');
        }
        // 수정
        else {
            $('#btn_del').show();
            $('#btn_mod').show();
            $('#btn_ins').hide();
            $('#tab2_top_title').html('템플릿 수정');
        }
    }
}
// 검색
function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm501/templeteList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_templete tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:loadTemplete(\""+item.TEMP_NO+"\")'>"+val(item.TEMP_NM)+"</a>").appendTo(tr);
                    //$("<td></td>").html('<a href="javascript:popSms(\''+item.TEMP_NO+'\');" class="btn" id="btn_send_mail"><span>SMS보내기</span></a>').appendTo(tr);
                    $("<td></td>").html(item.REG_DATE).appendTo(tr);
                    tr.appendTo($("#g_templete tbody"));
                }
                paintGrid("g_templete");
            }
        } 
    });
}

// 신규생성
function appendTemplete() {
    if (!$('#f_templete').validate().form()) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm501/insertTemplete.json'/>",
        data: formSerialize("#f_templete"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 신규 생성 되었습니다');
                showTabs('1');
                doSearch();
            }
        }
    });
}

function modifyTemplete() {
    if (!$('#f_templete').validate().form()) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm501/updateTemplete.json'/>",
        data: formSerialize("#f_templete"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정 되었습니다');
                showTabs('1');
                doSearch();
            }
        }
    });
}

function removeTemplete() {
    if (!confirm('정말 삭제 하시겠습니까?')) return;    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm501/deleteTemplete.json'/>",
        data: formSerialize("#f_templete"),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제 되었습니다');
                showTabs('1');
                doSearch();
            }
        }
    });
}

function loadTemplete(rid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm501/templete.json'/>",
        data: 'temp_no='+rid,
        dataType: 'json',
        success: function(data) {
            var item = eval(data);
            showTabs('2', false);
            $('#i_temp_no').val(item.TEMP_NO);
            $('#i_temp_nm').val(item.TEMP_NM);
            $('#i_temp_tp_cd').val(item.TEMP_TP_CD);
            $('#i_temp_content').val(item.TEMP_CONTENT);
        }
    });
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
    <c:import url="/view.do?viewName=location&layout=common" />

    <div class="tab">
        <ul>
            <li id="tab1_top" class="on"><span><a href="#" id="tab1_top_title">템플릿 목록</a></span></li>
            <li id="tab2_top" class="off"><span><a href="#" id="tab2_top_title">템플릿 생성</a></span></li>
        </ul>
    </div>

    <div id="tab1_page">
        <div class="bbs_search">
            <form name="f_cond" id="f_cond" onsubmit="return false">
               <input type="hidden" name="s_temp_tp_cd" id="s_temp_tp_cd" value="10" />
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr id="d_cond">
                <th width="80">템플릿명</th>
                <td width="180"><input type="text" class="text" name="s_temp_nm" id="s_temp_nm" style="width:350px;" /></td>
                <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
            </tr>
            </table>
            </form>
        </div>
        
        <div class="bbs_grid" style="height:640px">
            <table id="g_templete" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="40">번호</th>
                        <th>템플릿명</th>
                        <th width="80">등록일자</th>
                    </tr> 
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="tab2_page">
        <div class="bbs_search">
            <form name="f_templete" id="f_templete">
            <table id="g_selector" class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <colgroup>
                <col width="150"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <td colspan="2">
                    <div style="border:2px solid skyblue; padding:5px;">
                        <p>회원아이디 : $[LOGIN_ID]$</p>
                        <p>회원이름 : $[MEMBER_NM]$</p>
                        <p>&nbsp;</p>
                        <p style="color:red;">※ 대소문자가 구별되니 주의하시길 바랍니다.</p>
                    </div>
                </td>
            </tr>
            <tr>
                <th class="point">템플릿명</th>
                <td><input type="text" name="i_temp_nm" id="i_temp_nm" class="text" style="width:350px"/>
                    <input type="hidden" name="i_temp_no" id="i_temp_no"/>
                    <input type="hidden" name="i_temp_tp_cd" id="i_temp_tp_cd" value="10" />
                </td>
            </tr>
            <tr>
                <th>템플릿내용</th>
                <td><textarea name="i_temp_content" id="i_temp_content" style="width:100%" rows="35"></textarea></td>
            </tr>
            </tr>
            <tr>
                <td colspan="4" class="center">
                    <a href="#" class="btn_s" id="btn_mod"><span>저장</span></a>
                    <a href="#" class="btn_s" id="btn_del"><span>삭제</span></a>
                    <a href="#" class="btn_s" id="btn_ins"><span>저장</span></a>
                </td>
            </tr>
            </tbody>
            </table>
            </form>
        </div>
    </div>
</div>    
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<script type="text/javascript">
//var categoryTemplete;

$(document).ready(function() {
    $('#btn_sel').click(function() {doSearch();});
    $('#btn_mod').live("click", function() {modifyBoard();});
    $('#btn_del').live("click", function() {removeBoard();});
    $('#btn_ins').live("click", function() {appendBoard();});
    $('#btn_category_ins').click(function(){appendCategory();});
    $('#btn_category_upd').live("click", function(){modifyCategory(this)});
    $('#btn_category_del').live("click", function(){removeCategory(this)});
    $('#tab1_top_title').click(function() {showTabs('1');});
    $('#tab2_top_title').click(function() {showTabs('2',true);});
    $('#tab2_page').hide();
    $("#t_new_category").hide();
    //initTableHeader('g_admin', 2, 150);   
    //initSiteSelector("g_selector", 3);
    
    $('#f_admin').validate({
        rules: {
            i_board_nm: {required:true, maxlength:25},
            i_board_tp_cd: {required:true},
            i_board_id: {required:true, maxlength:20}
        },
        messages: {},
        errorPlacement: function(error, element) {   
            if (!element.is(":radio") && !element.is(":checkbox"))
                error.insertAfter(element);
        }
     });
    
    //categoryTemplete = $('#t_category').find('tbody').html();
    //$('#t_category').find('tbody').html('');
    
    /*
    $('#btn_category_ins').click(function(){
        var tr = $(categoryTemplete);
        tr.find('input[name=i_order_seq]').numeric();
        tr.appendTo($('#t_category').find('tbody'));
    });
    */
    /*
    $('#btn_category_del').live('click', function(){
        var tr = $(this).parent().parent();
        var del_no = tr.find('input[name=i_category_no]').val();
        
        var article_cnt = tr.find('input[name=i_article_cnt]').val();
        if(parseInt(article_cnt) > 0){
            alert('해당 카테고리에 게시글이 존재해서 삭제할 수 없습니다.');
            return;
        }
        
        if(!confirm('삭제하시겠습니까?')){
            return;
        }
        
        tr.remove();
        if(del_no != ""){
            var delNo = $('<input type="hidden" name="i_del_category_no" />').val(del_no);
            delNo.appendTo($('#f_admin'));
        }
    });
    */
});

function showTabs(no, isNew) {
    initTabs(2, no);
    if (no == '1') {
        $('#tab2_top_title').html('게시판 생성');
    }        
    else {
        // 신규
        if (isNew) {
            formReset('f_admin'); //$('#f_admin')[0].reset();
            $('#btn_del').hide();
            $('#btn_mod').hide();
            $('#btn_ins').show();
            $('#tab2_top_title').html('게시판 생성');
            
            $("#g_category tbody").html("");
        }
        // 수정
        else {
            $('#btn_del').show();
            $('#btn_mod').show();
            $('#btn_ins').hide();
            $('#tab2_top_title').html('게시판 수정');
        }
    }
}
// 검색
function doSearch() {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/boardList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_board tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").html(item.BOARD_TP_CD_NM).appendTo(tr);
                    $("<td></td>").addClass("left").html("<a href='javascript:loadBoard(\""+item.BOARD_NO+"\")'>"+val(item.BOARD_NM)+"</a>").appendTo(tr);
                    $("<td></td>").addClass("left").html(item.BOARD_ID).appendTo(tr);
                    $("<td></td>").html((item.CATEGORY_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html((item.MEM_WRITE_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html((item.MEM_COMMENT_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html((item.EMAIL_REPLY_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html((item.SMS_REPLY_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html((item.FILE_UPLOAD_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html((item.EDITER_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html((item.USE_YN=='Y'?'사용':'미사용')).appendTo(tr);
                    $("<td></td>").html(item.REG_DATE).appendTo(tr);
                    tr.appendTo($("#g_board tbody"));
                }
                paintGrid("g_board");
            }
        } 
    });
}

// 신규생성
function appendBoard() {
    if (!$('#f_admin').validate().form()) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/insertBoard.json'/>",
        data: formSerialize("#f_admin"),
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

function modifyBoard() {
    if (!$('#f_admin').validate().form()) return;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/updateBoard.json'/>",
        data: formSerialize("#f_admin"),
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

function removeBoard() {
    if (!confirm('정말 삭제 하시겠습니까?')) return;    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/deleteBoard.json'/>",
        data: formSerialize("#f_admin"),
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

function loadBoard(rid) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/board.json'/>",
        data: 'board_no='+rid,
        dataType: 'json',
        success: function(data) {
            $("input:radio").removeAttr("checked");
            $("input:checkbox").removeAttr("checked");
            
            var item = eval(data);
            $('#i_board_no').val(item.BOARD_NO);
            $('#i_board_nm').val(item.BOARD_NM);
            $('#i_board_tp_cd').val(item.BOARD_TP_CD);
            $('#i_board_id').val(item.BOARD_ID);
            $("input:radio[name=i_category_yn][value="+item.CATEGORY_YN+"]").attr("checked","checked");
            $("input:radio[name=i_mem_write_yn][value="+item.MEM_WRITE_YN+"]").attr("checked","checked");
            $("input:radio[name=i_mem_comment_yn][value="+item.MEM_COMMENT_YN+"]").attr("checked","checked");
            $("input:radio[name=i_email_reply_yn][value="+item.EMAIL_REPLY_YN+"]").attr("checked","checked");
            $("input:radio[name=i_sms_reply_yn][value="+item.SMS_REPLY_YN+"]").attr("checked","checked");
            $("input:radio[name=i_file_upload_yn][value="+item.FILE_UPLOAD_YN+"]").attr("checked","checked");
            $("input:radio[name=i_editer_yn][value="+item.EDITER_YN+"]").attr("checked","checked");
            $("input:radio[name=i_use_yn][value="+item.USE_YN+"]").attr("checked","checked");
            
            //카테고리 로드
            loadCategory(item.BOARD_NO);
            
            showTabs('2', false);
        }
    });
}

//카테고리 로드
function loadCategory(rno) {
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/categoryList.json'/>",
        data: "board_no="+rno,
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
            if (list) {
                $("#g_category tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var tr = $("<tr></tr>");
                    $("<td></td>").html(i+1).appendTo(tr);
                    $("<td></td>").addClass("left").append($("<input type='text' name='i_category_nm' class='text' style='width:98%'/>").val(item.CATEGORY_NM)).appendTo(tr);
                    $("<td></td>").addClass("left").append($("<input type='text' name='i_order_seq' class='text right' style='width:60px'/>").val(item.ORDER_SEQ)).appendTo(tr);
                    var td = $("<td></td>");
                    td.append($("<input type='hidden' name='h_category_no'/>").val(item.CATEGORY_NO));
                    td.append($("<input type='hidden' name='h_article_cnt'/>").val(item.ARTICLE_CNT));                    
                    td.append("<a href='#' id='btn_category_upd' class='btn_s'><span>수정</span></a> <a href='#' id='btn_category_del' class='btn_s'><span>삭제</span></a>");
                    td.appendTo(tr);
                    tr.appendTo($("#g_category tbody"));
                }
            }
        } 
    });
}

// 카테고리 등록
function appendCategory() {
    if ($("#t_new_category").css('display') == 'none') {
        $("#t_new_category").fadeIn();
        $("#i_new_category_nm").focus();
        return;
    }
    if ($("#i_new_category_nm").val() == "") {
        alert("카테고리명을 입력하세요");
        $("#i_new_category_nm").focus();
        return;
    }
    if ($('#i_new_order_seq').val() == '') {
        alert('카테고리순서를 입력하세요');
        $('#i_new_order_seq').focus();
        return;
    }
    if ($("#i_board_no").val() == "") {
        alert("게시판 생성 후 카테고리를 추가 하세요");
        return;
    }
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/insertCategory.json'/>",
        data: 'board_no='+$("#i_board_no").val()+'&category_nm='+$("#i_new_category_nm").val()+'&order_seq='+$('#i_new_order_seq').val(),
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 추가되었습니다');
                loadCategory($("#i_board_no").val());
                $("#i_new_category_nm").val("");
                $("#i_new_order_seq").val("");
                $("#t_new_category").hide();
            }
        }
    });
}

function removeCategory(me) {
    var tr = $(me).parent().parent();
    var category_no = tr.find('input[name=h_category_no]').val();
    var article_cnt = tr.find('input[name=h_article_cnt]').val();
    if (parseInt(article_cnt) > 0) {
        alert("해당 카테고리에 게시글이 존재해서 삭제할 수 없습니다");
        return;
    }        
    if (!confirm("정말 삭제하시겠습니까?")) {
        return;
    }
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/deleteCategory.json'/>",
        data: 'board_no='+$("#i_board_no").val()+'&category_no='+category_no,
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 삭제되었습니다');
                loadCategory($("#i_board_no").val());
            }
        }
    });
}

function modifyCategory(me) {
    var tr = $(me).parent().parent();
    var category_no = tr.find('input[name=h_category_no]').val();
    var category_nm = tr.find('input[name=i_category_nm]').val();
    var order_seq = tr.find('input[name=i_order_seq]').val();
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm401/updateCategory.json'/>",
        data: 'board_no='+$("#i_board_no").val()+'&category_no='+category_no+'&category_nm='+val(category_nm)+'&order_seq='+order_seq,
        dataType: 'json',
        success: function(data) {
            if (data) {
                alert('정상적으로 수정되었습니다');
                loadCategory($("#i_board_no").val());
            }
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
            <li id="tab1_top" class="on"><span><a href="#" id="tab1_top_title">게시판 목록</a></span></li>
            <li id="tab2_top" class="off"><span><a href="#" id="tab2_top_title">게시판 생성</a></span></li>
        </ul>
    </div>

    <div id="tab1_page">
        <div class="bbs_search">
            <form name="f_cond" id="f_cond" onsubmit="return false">
            <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <tr id="d_cond">
                <th width="80">게시판유형</th>
                <td width="180">
                    <select name="s_board_tp_cd" id="s_board_tp_cd">
                        <option value="">전체</option>
                        <c:forEach var="item" items="${boardTpList}" >
                        <option value="${item.MINOR_CD}">${item.CD_NM}</option>
                        </c:forEach> 
                    </select>
                </td>
                <th width="80">게시판명</th>
                <td width="180"><input type="text" class="text" name="s_board_nm" id="s_board_nm" style="width:350px;" /></td>
                <td class="right"><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
            </tr>
            </table>
            </form>
        </div>
        
        <div class="bbs_grid" style="height:640px">
            <table id="g_board" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <th width="40">번호</th>
                        <th width="100">게시판유형</th>
                        <th>게시판명</th>
                        <th width="100">게시판아이디</th>
                        <th width="60">카테고리</th>
                        <th width="60">회원글작성</th>
                        <th width="60">댓글</th>
                        <th width="60">이메일답변</th>
                        <th width="60">SMS답변</th>
                        <th width="60">첨부파일</th>
                        <th width="60">에디터</th>
                        <th width="60">사용여부</th>
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
            <form name="f_admin" id="f_admin">
            <table id="g_selector" class="bbs_search" cellpadding="0" cellspacing="0" border="0">
            <colgroup>
                <col width="150"/>
                <col width="250"/>
                <col width="150"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th class="point">게시판명</th>
                <td><input type="text" name="i_board_nm" id="i_board_nm" class="text" style="width:150px"/>
                    <input type="hidden" name="i_board_no" id="i_board_no"/>
                </td>
            </tr>
            <tr>
                <th>게시판유형</th>
                <td>
                    <select name="i_board_tp_cd" id="i_board_tp_cd">
                        <option value="">선택</option>
                        <c:forEach var="item" items="${boardTpList}" >
                        <option value="${item.MINOR_CD}">${item.CD_NM}</option>
                        </c:forEach> 
                    </select>
                </td>
                <th class="point">게시판아이디</th>
                <td><input type="text" name="i_board_id" id="i_board_id" class="text" style="width:150px;ime-mode:disabled;"/></td>
            </tr>
            <tr>
                <th>회원글작성여부</th>
                <td>
                    <input type="radio" name="i_mem_write_yn" value="Y"/> 사용
                    <input type="radio" name="i_mem_write_yn" value="N" checked/> 미사용
                </td>
                <th>댓글여부</th>
                <td>
                    <input type="radio" name="i_mem_comment_yn" value="Y"/> 사용
                    <input type="radio" name="i_mem_comment_yn" value="N" checked/> 미사용
                </td>
            </tr>
            <tr>
                <th>이메일답변여부</th>
                <td>
                    <input type="radio" name="i_email_reply_yn" value="Y"/> 사용
                    <input type="radio" name="i_email_reply_yn" value="N" checked/> 미사용
                </td>
                <th>SMS답변여부</th>
                <td>
                    <input type="radio" name="i_sms_reply_yn" value="Y"/> 사용
                    <input type="radio" name="i_sms_reply_yn" value="N" checked/> 미사용
                </td>
            </tr>
            <tr>
                <th>첨부파일여부</th>
                <td>
                    <input type="radio" name="i_file_upload_yn" value="Y"/> 사용
                    <input type="radio" name="i_file_upload_yn" value="N" checked/> 미사용
                </td>
                <th>에디터사용여부</th>
                <td>
                    <input type="radio" name="i_editer_yn" value="Y"/> 사용
                    <input type="radio" name="i_editer_yn" value="N" checked/> 미사용
                </td>
            </tr>
            <tr>
                <th>카테고리여부</th>
                <td>
                    <input type="radio" name="i_category_yn" value="Y"/> 사용
                    <input type="radio" name="i_category_yn" value="N" checked/> 미사용
                </td>
                <th>사용여부</th>
                <td>
                    <input type="radio" name="i_use_yn" value="Y" checked/> 사용
                    <input type="radio" name="i_use_yn" value="N"/> 미사용
                </td>
            </tr>
            <tr>
                <td colspan="4" class="center">
                    <a href="#" class="btn_s" id="btn_mod"><span>저장</span></a>
<!--                <a href="#" class="btn_s" id="btn_del"><span>삭제</span></a> -->
                    <a href="#" class="btn_s" id="btn_ins"><span>저장</span></a>
                </td>
            </tr>
            </tbody>
            </table>
            </form>
        </div>
        
        <div class="tab_s">
            <ul>
                <li id="tab1_top_s" class="on"><span><a href="#" id="tab1_top_title_s">카테고리</a></span></li>
            </ul>
        </div>
        <div id="tab1_page_s" class="bbs_search_c">
            <div class="txtStyle01">
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td align="right"><span id="t_new_category" class="bar" style="font-weight:normal"> 카테고리명/순서&nbsp;&nbsp;<input type="text" class="text" id="i_new_category_nm"/> / <input type="text" class="text right" id="i_new_order_seq" style="width:50px"/>&nbsp;</span>&nbsp;</td>
                        <td align="right" width="90"><a href="#" class="btn_s2" id="btn_category_ins"><span>카테고리추가</span></a></td>
                    </tr>
                </table>
            </div>
            <div class="bbs_list" style="height:366px">
                <table id="g_category" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
                    <thead>
                    <tr>
                        <th width="40">번호</th>
                        <th>카테고리명</th>
                        <th width="80">순서</th>
                        <th width="100">수정삭제</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 
                    <tr>
                        <td></td>
                        <td>
                            <input type="hidden" name="i_category_no"/>
                            <input type="hidden" name="i_article_cnt" value="0"/>
                            <input type="text" name="i_category_nm" class="text"/>
                        </td>
                        <td><input type="text" name="i_order_seq" maxlength="3" class="text" style="width:30px;"/></td>
                        <td><a href="#" class="btn_s right" id="btn_category_upd"><span>수정</span></a> <a href="#" class="btn_s right" id="btn_category_del"><span>삭제</span></a></td>
                    </tr>
                     -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>    
</body>
</html>

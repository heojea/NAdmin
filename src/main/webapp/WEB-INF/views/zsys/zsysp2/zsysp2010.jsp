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
    $('#s_cond10').hide();
    $('#btn_sel').click(function() {doSearch();});    
    $('#s_addr_divn_cd').change(function(){
        setSearchCond($('#s_addr_divn_cd').val());
    });
    $('#s_sido_cd').change(function(){
        setGugunOptionList($(this).val());
    });
    
    $("input").keypress(function(e){
        if (e.which == 13) {
            doSearch();
        }
    });
     
});

// test 이고 아직 시도 구군 동명 코드를 안따서 일단은
// 하드코딩으로 처리한다. 추후 검색조건이 코드로 바뀌면 변경 코딩 필요
function setSearchCond(cond_val) {
    $('#s_dong_nm').val('');
    $('#s_street_nm').val('');
    if(cond_val == '10'){
        $('#s_sido_cd').val('');
        $('#s_gugun_cd').val('');
        $('#s_cond10').show();
        $('#s_cond20').hide();
    }else{
        $('#s_sido_cd').val('');
        $('#s_gugun_cd').val('');
        $('#s_cond10').hide();
        $('#s_cond20').show();
    }
    //리스트 초기화
    $("#g_ziplist tbody").html("");
    /*
    var tr = $("<tr bgcolor='#ffffff'></tr>");
    $("<td colspan=3 align='center'></td>").html("").appendTo(tr);
    tr.appendTo($("#g_ziplist tbody"));
    */
}

// 검색
function doSearch() {
    
    
    $.ajax({
        type: 'POST',
        url: "<c:url value='/zsys/zsysp201/selectZipList.json'/>",
        data: formSerialize("#f_cond"),
        dataType: 'json',
        success: function(data) {
            var list = eval(data); 
           
            if (list == null || list == ''){
                $("#g_ziplist tbody").html("");
                var tr = $("<tr bgcolor='#ffffff'></tr>");
                $("<td colspan=3 align='center'></td>").html("조회된 데이터가 없습니다.").appendTo(tr);
                tr.appendTo($("#g_ziplist tbody"));
                return;
            }
                
            if (list) {
                $("#g_ziplist tbody").html("");
                for (var i = 0; i < list.length; i++) {
                    var item = eval(list[i]);
                    var tr = $("<tr bgcolor='#ffffff'></tr>");
                    $("<td width='80' align='center'></td>").html(i+1).appendTo(tr);
                    $("<td width='100' align='center'></td>").html(item.POST_NO.substr(0,3)+"-"+item.POST_NO.substr(3,3)).appendTo(tr);
                    $("<td></td>").html("<a href='javascript:chooseAddr(\""+item.POST_NO+"\", \""+item.ADDR_NM+"\",\""+item.ZIP_SEQ+"\")'>"+val(item.ADDR_NM_VIEW)).appendTo(tr);
                   
                    tr.appendTo($("#g_ziplist tbody"));
                }
                paintGrid();
            }
        } 
    });
}

function setGugunOptionList(val) {
    $("#s_gugun_cd").html('<option value="">구군선택</option>');
    $.ajax({
        type: 'POST',
        url: "<c:url value='/zsys/zsysp201/selectGugunList.json'/>",
        data: 'sido_cd='+val,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);  
            if (list) {                       
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $('<option></option>');
                    opt.val(item.GUGUN_CD);
                    opt.html(item.GUGUN_NM);
                    opt.appendTo($("#s_gugun_cd"));
                }
            }
        }
    });
}

function chooseAddr(post_no, addr_nm,zip_seq) {
    $(opener.document).find('#'+'${returnPostNo}').val( post_no.substr(0,3)+'-'+post_no.substr(3,3) ); 
    $(opener.document).find('#'+'${returnAddr}').val( addr_nm ); 
    $(opener.document).find('#'+'${returnZipSeq}').val( zip_seq ); 
    close();
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap" style="min-width:0px; width:930px;">
    <div class="h2"><h2>우편번호 조회</h2></div>

    <div class="bbs_search">
        <form name="f_cond" id="f_cond" onsubmit="return false">
        <table class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <tr id="d_cond">
            <th width="80">검색 구분</th>
            <td width="180">
                <select name="s_addr_divn_cd" id="s_addr_divn_cd">
                    <option value="20">도로명주소</option>
                    <option value="10">지번주소</option>
                </select>
            </td>
            <td colspan=4>
                <div id="s_cond10">동명 : <input type="text" id="s_dong_nm" name="s_dong_nm"></div>
                <div id="s_cond20">
               <select name="s_sido_cd" id="s_sido_cd">
                    <option value="">시도선택</option>
                    <c:forEach var="sido" items="${sidoList}">
                        <option value="${sido.SIDO_CD}">${sido.SIDO_NM}</option>                            
                    </c:forEach>
                </select>
                <select name="s_gugun_cd" id="s_gugun_cd">
                    <option value="">구군선택</option>
                </select>
                                 도로명 : <input type="text" id="s_street_nm" name="s_street_nm">                                
                </div>
            </td>
            <td class="right" ><a href="#" class="btn" id="btn_sel"><span>조회</span></a></td>
        </tr>
        </table>
        </form>
    </div>
        
    <div class="bbs_grid" style="height:354px;overflow-y:auto;margin-bottom:0">
        <table id="g_ziplist" class="bbs_grid" cellpadding="0" cellspacing="0" border="0">
            <thead>
            <tr>
                <th width="20">NO.</th>
                <th width="80">우편번호</th>
                <th width="400">주소</th>
            </tr>                
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>    
</body>
</html>














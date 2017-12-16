<%@ page contentType="text/javascript;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

var imageUploadPopUrl = "<c:url value='/view.do?viewName=editorImage&layout=common'/>";

function initSiteCond(txt) {
    if ($("#s_site_id option").size() > 1) return;
    $.ajax({
        type: "POST",
        url: "<c:url value='/pcom/siteList.json'/>",
        data: "?",
        dataType: "json",
        async: false,
        success: function(data) {
            var list = eval(data);            
            if (list) {
                var th = $("<th></th>").html("사이트").css("width","80px");
                var td = $("<td></td>").css("width", "220px");    
                var sel = $("<select></select>").attr("name", "s_site_id").attr("id", "s_site_id").html("<option value=''>"+(txt==""?"전체":txt)+"</option>");
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $("<option></option>");
                    opt.val(item.SITE_ID);
                    opt.html(item.SITE_NM);
                    opt.appendTo(sel);
                }
                sel.appendTo(td);
                var inp = $("<input></input>").addClass("text2").attr("name", "s_site_id_hp").attr("id", "s_site_id_hp").css("width", "45px").css("margin-left", "3px").css("background", "#D6DEF9").appendTo(td);
                td.prependTo($("#d_cond"));
                th.prependTo($("#d_cond"));
            }
        }        
    });
    
    // 사이트명 셀렉트 박스 검섹
    $('#s_site_id_hp').keyup(function(e) {
        var val = $(this).val();
        if (val == '') return;
        
        $('#s_site_id option').each(function() {
            if ($(this).text().indexOf(val) > -1) {
                $(this).attr("selected", true);
                $('#s_site_id').change();
            }
        });
        if (e.which == 13) {
            doSearch();            
        }
        return false;
    });

}

function getRoleOptionList(obj, all, txt, def) {
    obj.html(all? '<option value="">'+(txt? txt:'전체')+'</option>':'');
    $.ajax({
        type: 'POST',
        url: "<c:url value='/ztad/ztadm202/roleList.json'/>",
        data: 'active_yn=Y',
        dataType: 'json',
        success: function(data) {
            var list = eval(data);  
            if (list) {                       
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $('<option></option>');
                    opt.val(item.ROLE_ID);
                    opt.html(item.ROLE_NM);
                    if (def && item.ROLE_ID == def)
                    opt.attr("selected", true);
                    opt.appendTo(obj);
                }
            }
        }
    });
}

function getRoleCheckboxList(aid, obj) {
    (obj).html("");
    $.ajax({ 
        type: 'POST',
        url: "<c:url value='/ztad/ztadm202/roleList.json'/>",
        data: 'admin_id='+aid+'&active_yn=Y',
        dataType: 'json',
        success: function(data) {
            var list = eval(data);
            if (list) {
                var txt = '';
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    $("<input type='checkbox'/>").attr("name", "i_role_id_"+item.ROLE_ID).attr("id", "i_role_id_"+item.ROLE_ID).val(item.ROLE_ID).attr("checked", (item.CHECKED == 'Y')).appendTo(obj);
                    $("<label></label>").attr("for", "i_role_id_"+item.ROLE_ID).css("padding-right", "10px").html(item.ROLE_NM).appendTo(obj);
                }
            }
        }
    }); 
}

function getCarStoreCheckboxList(sid, param, aid, obj) {
    (obj).html("");
    if (sid == '')
            return;
    var p1 = param.store_tp_cd||"";
    var p2 = param.store_tp_grp_cd||"";        
    $.ajax({ 
        type: 'POST',
        url: "<c:url value='/pcar/pcarm101/carStoreList.json'/>",
        data: 'site_id='+sid+'&mgr_no='+aid+'&use_yn=Y&store_tp_cds='+p1+'&store_tp_grp_cd='+p2,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);
            if (list) {
                var txt = '';
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    $("<input type='checkbox'/>").attr("name", "i_store_cd_"+item.STORE_CD).attr("id", "i_store_cd_"+item.STORE_CD).val(item.STORE_CD).attr("checked", (item.CHECKED == 'Y')).appendTo(obj);
                    $("<label></label>").attr("for", "i_store_cd_"+item.STORE_CD).css("padding-right", "10px").html(item.STORE_NM).appendTo(obj);
                }
            }
        }
    }); 
}

function getSiteOptionList(obj, all, txt, def) {
    obj.html(all? '<option value="">'+(txt||'전체')+'</option>':'');
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pcom/siteList.json'/>",
        data: '?',
        dataType: 'json',
        success: function(data) {
            var list = eval(data);            
            if (list) {
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $("<option></option>");
                    opt.val(item.SITE_ID);
                    opt.html(item.SITE_NM);
                    if (def && item.SITE_ID == def)
                    opt.attr("selected", true);
                    opt.appendTo(obj);
                }
            }
        } 
    });
}    

function getCarGrpOptionList(sid, obj, all, txt, def, call) {
    obj.html(all? '<option value="">'+(txt||'전체')+'</option>':'');
    if (sid == '')
        return;        
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pcar/pcarm201/carGroupList.json'/>",
        data: 'site_id='+sid+'&use_yn=Y',
        dataType: 'json',
        success: function(data) {
            var list = eval(data);  
            if (list) {                       
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $('<option></option>');
                    opt.val(item.CAR_GRP_CD);
                    opt.html(item.CAR_GRP_NM);
                    if (def && item.CAR_GRP_CD == def)
                    opt.attr("selected", true);
                    opt.appendTo(obj);
                }
                
                if (call) {
                    eval(call+"()");
                }
            }            
        }
    });
}

function getCarModelOptionList(sid, gid, obj, all, txt, def, call) {
    obj.html(all? '<option value="">'+(txt||'전체')+'</option>':'');
    if (sid == '')
        return;        
    $.ajax({
        type: "POST",
        url: "<c:url value='/pcar/pcarm203/carModelList.json'/>",
        data: "site_id="+sid+"&car_grp_cd="+(gid||"")+"&use_yn=Y",
        dataType: "json",
        async: false,
        success: function(data) {
            var list = eval(data);  
            if (list) {
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $('<option></option>');
                    opt.val(item.CAR_MODEL_NO);
                    opt.html(item.CAR_MODEL_NM);
                    if (def && item.CAR_MODEL_NO == def)
                    opt.attr("selected", true);
                    opt.appendTo(obj);
                }
                
                if (call) {
                    eval(call+"()");
                }
            }            
        }
    });
}

function getCarOptionList(sid, param, obj, all, txt, def, call) {
    obj.html(all? '<option value="">'+(txt||'전체')+'</option>':'');
    var p1 = param.car_model_no||"";
    var p2 = param.car_grp_no||"";
    var p3 = param.store_cd||"";
    var p4 = param.car_sts_cd||"";
    if (sid == "")
        return;        
    $.ajax({
        type: "POST",
        url: "<c:url value='/pcar/pcarm202/carMstList.json'/>",
        data: "site_id="+sid+"&car_model_no="+p1+"&car_grp_cd="+p2+"&store_cd="+p3+"&car_sts_cd="+p4,
        dataType: "json",
        async: false,
        success: function(data) {
            var list = eval(data);  
            if (list) {
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $('<option></option>');
                    opt.val(item.CAR_ID);
                    opt.html(item.CAR_NM+" ("+item.CAR_NO+")");
                    if (def && item.CAR_ID == def)
                    opt.attr("selected", true);
                    opt.appendTo(obj);
                }
                
                if (call) {
                    eval(call+"()");
                }
            }            
        }
    });
}

/*****************************************************************
* 함수명    : 권역별 지점 목록 조회
* 파라미터 : sid   - 사이트아이디
* 		   param - Ajax 파라미터
*          obj   - 권역코드
*          all   - Select 박스 Option 디폴트 설정값(true:전체,false:'') 
******************************************************************/
function getCarStoreOptionList(sid, param, obj, all) {
	// 사이트아이디 미존재
    if(sid == '' || sid == undefined) {
    	return;
    }
    // Option 디폴트 설정
    obj.html(all ? '<option value="">'+('전체')+'</option>' : '');
    
    // 파라미터 셋팅
    var paramData = "site_id=" + sid + "&area_cd=" + param.area_cd;
    
    // Ajax : 지점 목록 조회
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pcom/carStoreList.json'/>",
        data: paramData,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);
            if(list) {// 지점 목록이 존재할 경우                       
                for(var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $('<option></option>');
                    opt.val(item.STORE_CD);
                    opt.html(item.STORE_NM);
                    opt.appendTo(obj);
                }
            }
        }
    });
}

function getStoreNmOptionList(sid, param, obj, all, txt, def, call) {
    obj.html(all? '<option value="">'+(txt||'전체')+'</option>':'');
    if (sid == '')
        return;
    var p1 = param.area_tp_cd||"";
    var p2 = param.area_tp_grp_cd||"";        
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pcar/pcarm103/carStoreList.json'/>",
        data: 'site_id='+sid+'&use_yn=Y&area_tp_cds='+p1+'&sarea_tp_grp_cd='+p2,
        dataType: 'json',
        success: function(data) {
            var list = eval(data);  
            if (list) {                       
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var opt = $('<option></option>');
                    opt.val(item.AREA_CD);
                    opt.html(item.AREA_NM);
                    if (def && item.AREA_CD == def)
                    opt.attr("selected", true);
                    opt.appendTo(obj);
                }
                
                if (call) {
                    eval(call+"()");
                }
            }
        }
    });
}

function getDate(opt) {
    var item;
    opt = opt||{};
    var format1 = opt.format1||"";   // format1 형태로 현재날짜 받아옴  '%Y-%m-%d'
    var format2 = opt.format2||"";   // term2 만큼 year를 계산하여 format2 형태로 날짜를 받아옴
    var term2 = opt.term2||"";
    var format3 = opt.format3||"";   // term3 만큼 month를 계산하여 format3 형태로 날짜를 받아옴
    var term3 = opt.term3||"";
    var format4 = opt.format4||"";   // term4 만큼 day를 계산하여 format4 형태로 날짜를 받아옴
    var term4 = opt.term4||"";
    var format5 = opt.format5||"";   // term5 만큼 hour를 계산하여 format5 형태로 날짜를 받아옴
    var term5 = opt.term5||"";
    var start_dy = opt.start_dy||""; // start_dy ~ end_dy 차이를 계산함
    var end_dy = opt.end_dy||"";
    $.ajax({
        type: "POST",
        url: "<c:url value='/pcom/date.json'/>",
        data: "format1="+encodeURIComponent(format1)+"&format2="+encodeURIComponent(format2)+"&format3="+encodeURIComponent(format3)+"&format4="+encodeURIComponent(format4)+"&format5="+encodeURIComponent(format5)+"&term2="+term2+"&term3="+term3+"&term4="+term4+"&term5="+term5+"&start_dy="+start_dy+"&end_dy="+end_dy,
        dataType: "json",
        async: false,
        success: function(data) {
            item = eval(data);
        }
    });
    return item;
}

function initUploadFile(obj, url, hobj, iobj, post, iw, ih, ext, btxt) {
    obj.uploadify({
        "swf" : "${cfn:getString('system.static.path')}/images/jquery/plugins/uploadify/uploadify.swf",
        "uploader" : url,
        "cancelImage" : "${cfn:getString('system.static.path')}/images/jquery/plugins/uploadify/uploadify-cancel.png",
        "auto" : true,
        "fileTypeExts" : (ext? ext : "*.jpg;*.jpeg;*.png;*.gif;*.bmp"),
        "fileSizeLimit" : "20240KB",
        "buttonText" : (btxt? btxt : "이미지 첨부"),
        "height" : 20,
        "formData" : post,
        "onUploadSuccess" : function(file, data, response) {
            //alert(file.name);
            var list = eval(data);
            var item = list[0];
            //alert(item.fileName);
            //alert(item.filePath+item.fileName);
            hobj.val(item.fileName);
            iobj.attr("src", item.filePath+item.fileName);
            iobj.css("width", iw+"px").css("height",ih+"px").css("border", "1px solid #777777");
        },
        "onUploadError" : function(file, errorCode, errorMsg, errorString) {
            alert(file.name+"을 업로드시 실패 하였습니다");
        }
    });
}    

function initUploadAttachFile(obj, url, hobj, iobj, tobj, lobj, post, ext, btxt) {
    obj.uploadify({
        "swf" : "${cfn:getString('system.static.path')}/images/jquery/plugins/uploadify/uploadify.swf",
        "uploader" : url,
        "cancelImage" : "${cfn:getString('system.static.path')}/images/jquery/plugins/uploadify/uploadify-cancel.png",
        "auto" : true,
        "fileTypeExts" : (ext? ext : "*.*"),
        "fileSizeLimit" : "20240KB",
        "buttonText" : (btxt? btxt : "파일 첨부"),
        "height" : 20,
        "formData" : post,
        "onUploadSuccess" : function(file, data, response) {
            var list = eval(data);
            var item = list[0];
            hobj.val(item.fileName);
            iobj.val(file.name);
            tobj.html(file.name);
            lobj.fadeIn(5000);            
        },
        "onUploadError" : function(file, errorCode, errorMsg, errorString) {
            alert(file.name+"을 업로드시 실패 하였습니다");
        }
    });
}

function openController(sid, cid) {
    centerPopupWindow('<c:url value='/controller.do'/>?site_id='+sid+'&car_id='+cid, 'controller', {width:527,height:900,scrollBars:'YES'});
}

function openReturn(sid, cid, oid){
    centerPopupWindow('<c:url value='/openReturn.do'/>?site_id='+sid+'&car_id='+cid+'&site_order_id='+oid, 'openReturn', {width:350,height:350,scrollbars:'no'});
}

function openadminNfc(sid, cid, oid){
    centerPopupWindow('<c:url value='/openadminNfc.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openadminNfc', {width:350,height:20,scrollbars:'no'});
}

function opentouch(sid, cid, oid){
    centerPopupWindow('<c:url value='/opentouch.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'opentouch', {width:350,height:20,scrollbars:'no'});
}

function openReserveConfig(sid, cid, oid){
    centerPopupWindow('<c:url value='/openReserveConfig.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openReserveConfig', {width:500,height:500,scrollbars:'no'});
}

function openaterminalUpdate(sid, cid, oid){
    centerPopupWindow('<c:url value='/openaterminalUpdate.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openaterminalUpdate', {width:350,height:140,scrollbars:'no'});
}

function openDistUpdate(sid, cid, oid){
    centerPopupWindow('<c:url value='/openDistUpdate.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openDistUpdate', {width:350,height:170,scrollbars:'no'});
}

function openFirmWareUpdate(sid, cid, oid){
    centerPopupWindow('<c:url value='/openFirmWareUpdate.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openFirmWareUpdate', {width:350,height:300,scrollbars:'no'});
}

function openReserveForce(sid, cid, oid){
    centerPopupWindow('<c:url value='/openreserveForce.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openreserveForce', {width:350,height:200,scrollbars:'no'});
}

function openReserveEdit(sid, cid, oid, tid){
    centerPopupWindow('<c:url value='/openreserveEdit.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid+'&order_id='+tid, 'openreserveEdit', {width:350,height:200,scrollbars:'no'});
}

function openReserveSearch(sid, cid, oid){
    centerPopupWindow('<c:url value='/openReserveSearch.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openReturn', {width:930,height:260,scrollbars:'yes'});
}

function openReserveComplete(sid, cid, oid, tid){
	centerPopupWindow('<c:url value='/openReserveComplete.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid+'&order_id='+tid, 'openReturn', {width:350,height:200,scrollbars:'no'});
}

function openLocationMap(sid, cid, oid){
    centerPopupWindow('<c:url value='/openLocationMap.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openReturn', {width:465,height:380,scrollbars:'yes'});
}

function openRfid(sid, cid, oid){
    centerPopupWindow('<c:url value='/openRfid.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openReturn', {width:350,height:300,scrollbars:'yes'});
}

function openadminNfcEdit(sid, cid, oid){
    centerPopupWindow('<c:url value='/openadminNfc.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openReturns', {width:350,height:150,scrollbars:'no'});
}

function openinsertHpno(sid, cid, oid){
    centerPopupWindow('<c:url value='/openinsertHpno.do'/>?site_id='+sid+'&car_id='+cid+'&car_mgr_no='+oid, 'openReturns', {width:350,height:150,scrollbars:'no'});
}

function openCal(inputId, minId, maxId) {
    var jq = "#"+inputId;
    if(minId && maxId){
        jq = "#"+minId+",#"+maxId;
    }
    $(jq).datepicker($.extend({}, calendarDefaultOption, {
        minObjId: minId,
        maxObjId: maxId,
        onSelect : function(selectedDate, inst){
                        instance = $( this ).data( "datepicker" );
                        var option = this.id == instance.settings.minObjId ? "minDate" : "maxDate",
                                 date = $.datepicker.parseDate(
                                         instance.settings.dateFormat || $.datepicker._defaults.dateFormat,
                                         selectedDate, 
                                         instance.settings );
                        <%-- 
                        DESC : startDt가 endDt를 넘어서 입력못하도록 하던 로직을 주석처리 
                        var obj = (option == 'minDate') ? instance.settings.maxObjId : instance.settings.minObjId;
                        $('#' + obj ).datepicker( "option", option, date );
             			--%>
                        $(this).change();
                    }
    }));
    $("#"+inputId).focus();
}

function popMember(memberNo){
    centerPopupWindow('<c:url value='/zmem/zmemp301/main.do'/>?member_no='+memberNo, 'popMember', {width:1100,height:805,scrollbars:'no'});
}

function popOrder(orderId){
    centerPopupWindow('<c:url value='/zmem/zmemp303/main.do'/>?order_id='+orderId, 'popOrder', {width:1100,height:630,scrollbars:'no'});
}

function newPopOrder(orderId){
    centerPopupWindow('<c:url value='/zmem/zmemm902/main.do'/>?order_id='+orderId, 'popOrder', {width:1200,height:630,scrollbars:'no'});
}

function popReOrder(orderId){
    centerPopupWindow('<c:url value='/zmem/zmemp303/reOrder.do'/>?order_id='+orderId, 'popReOrder', {width:1080,height:800,scrollbars:'no'});
}

function popArticleReply(rid){
    centerPopupWindow('<c:url value='/zmem/zmemp304/main.do'/>?article_no='+rid, 'popArticleReply', {width:900,height:800,scrollbars:'no'});
}

function popMemberSearch(cbf){
    centerPopupWindow('<c:url value='/zmem/zmemp501/main.do'/>?cbf='+cbf, 'popMemberSearch', {width:1070,height:540,scrollbars:'no'});
}

function popMemberSearch2(cbf){
    centerPopupWindow('<c:url value='/zmem/zmemp503/main.do'/>?cbf='+cbf, 'popMemberSearch', {width:1070,height:540,scrollbars:'no'});
}

function popMemberSearchMulti(cbf){
    centerPopupWindow('<c:url value='/zmem/zmemp502/main.do'/>?cbf='+cbf, 'popMemberSearchMulti', {width:1070,height:660,scrollbars:'no'});
}

function popSms(rid) {
    centerPopupWindow("<c:url value='/ztad/ztadp501/main.do'/>?temp_no="+rid, "popSms", {width:750,height:375});
}

function popEmail(rid) {
    centerPopupWindow("<c:url value='/ztad/ztadp502/main.do'/>?temp_no="+rid, "popEmail", {width:750,height:375});
}

function popOrderSearch(cbf, member_no) {
    centerPopupWindow("<c:url value='/zmem/zmemp302/main.do'/>?cbf="+cbf + (member_no!=null?'&sub_member_no='+member_no:''), "popOrderSearch", {width:1070,height:800});
}

function popCorpSearch(cbf) {
    centerPopupWindow("<c:url value='/zmem/zmemp305/main.do'/>?cbf="+cbf, "popOrderSearch", {width:950,height:500});
}

function popModPass(admin_id) {
    centerPopupWindow("<c:url value='/ztad/ztadp101/main.do'/>?admin_id="+admin_id, "popModPass", {width:400,height:191});
} 

function popCarChangeOrder(orderId){
    centerPopupWindow('<c:url value='/zmem/zmemp303/carChangeOrder.do'/>?order_id='+orderId, 'popCarChangeOrder', {width:800,height:600,scrollbars:'no'});
}


function openPlayer(param) {
    //var root = "${cfn:getString('file.play.url')}";
    //var src = root  + "/" + param.src.substring(0,8) + "/" + param.src;
    var src = param.src;
    var mode = param.mode||"sidebyside";
    var scaleMode = param.scaleMode||"fit";
    var themeColor = param.themeColor||"0395d3";
    var frameColor = param.frameColor||"333333";
    var fontColor = param.fontColor||"cccccc";
    var autostart = param.autostart||true;
    var width = param.width||774;
    var height = param.height||469;
    var link = param.link||"";
    var embed = param.embed||"";
    
    centerPopupWindow(src, "player", {width:795,height:485,scrollbars:"no"});
}

function getMonConfig(sid, mid) {
    var item;
    $.ajax({
        type: 'POST',
        url: "<c:url value='/pmon/pmonm401/monConfig.json'/>",
        data: 'site_id='+sid+'&mon_tp_cd='+mid,
        dataType: 'json',
        async: false,
        success: function(data) {
            item = eval(data);  
        }
    });
    return item;
}

/*****************************************************************
* 함수명    : 엑셀다운로드
* 파라미터 : tbId    - 테이블ID
*          chkNm   - 체크박스 NAME 명
* 		   excelNm - 엑셀명 
******************************************************************/
function excelFileDownload(tbId, chkNm, excelNm) {
	if($('input[name='+chkNm+']').is(":checked")== false) {
		alert('선택된 항목이 없습니다.');
		return;
	}
	var $table = $(tbId);
	var $headerCells = $table.find('thead th');
    var $rows = $table.find('tbody tr');
	
    var headers = new Array();
    var rows = new Array();
    var temp = '';
    var flag = true;
    
    $headerCells.each(function(k, v){
    	if(k != 0) {
    		headers[k-1] = $(this).text();	
    	}
    });
    
    $rows.each(function(row,v) {
    	$(this).find('td').each(function(cell, v) {
    		if($(this).parent().find('td input[name='+chkNm+']').is(':checked') == true) {
	    		if(cell != 0) {
	    			if(flag) {
		    			if(cell == 1) {
		    				temp = temp + $(this).text();
	        			}else {
	        				temp = temp + '|' + $(this).text();	
	        			}
	        			flag = false;
	        		}else {
	        			temp = temp + '|' + $(this).text();
	        		}
	    		}
	    	}
    	});
    });
    
    var params = 'excel_nm='+excelNm
               + '&headers='+headers
               + '&rows='+temp;
	
	var url = "<c:url value='/excelDownload.do'/>?"+params;
	$(location).attr('href', url);
}
/*****************************************************************
* 함수명    : 엑셀다운로드 체크박스 없는 화면
* 파라미터 : tbId    - 테이블ID
* 		   excelNm - 엑셀명 
*          params  - 조회조건 파라미터
******************************************************************/
function excelFileDownloadBig(tbId, excelNm, sParams) {
	var $table = $(tbId);
	var $headerCells = $table.find('thead th');
    
    var headers = new Array();
    
    $headerCells.each(function(k, v){
    	headers[k] = $(this).text();
    });
    
    var params ='excel_nm='+excelNm
               +'&headers='+headers
               +'&'+ sParams;
	
	var url = "<c:url value='/excelDownloadBig.do'/>?"+params;
	$(location).attr('href', url);
}

/*****************************************************************
* 함수명    : 엑셀다운로드 체크박스 있는 화면
* 파라미터 : tbId    - 테이블ID
*          excelNm - 엑셀명 
*          params  - 조회조건 파라미터
******************************************************************/
function excelFileDownloadBigCheck(tbId, excelNm, sParams) {
    var $table = $(tbId);
    var $headerCells = $table.find('thead th');
    
    var headers = new Array();
    
    $headerCells.each(function(k, v){
        if(k ==0){
        
        }else{
            headers[k-1] = $(this).text();
        }
    });
    
    var params ='excel_nm='+excelNm
               +'&headers='+headers
               +'&'+ sParams;
    
    var url = "<c:url value='/excelDownloadBig.do'/>?"+params;
    $(location).attr('href', url);
}


/**
 * ajax 호출 후 공통 에러.
 * @param xhRequest
 * @param ErrorText
 * @param thrownError
 */
function gfn_ajaxError(xhRequest, ErrorText, thrownError)
{
	if(xhRequest.status=='406')
	{
		alert('세션이 종료되었습니다.\n\n로그인 후 다시 이용해 주세요.');
		top.location.href = '<c:url value='/'/>';
	}
	else if(xhRequest.status=='404')
	{
		alert('알수 없는 요청입니다.\n\n요청정보가 올바른지 확인해 주세요.');
	}
	else
	{
		alert('서버에서 에러가 발생했습니다.\n\n관리자에게 문의해 주세요.');
	}
}
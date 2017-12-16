
/**
 * Ajax call setup
 */
function ajaxSetup() {
    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader("AJAX", true);
        },
        
        error: function(xhr, status, err) {
/*            alert(xhr.status);
            //Unauthorized 
            if (xhr.status == 401) {
                alert('go 401 page');
            }
            //Forbidden
            else if (xhr.status == 403) {
                alert('go 403 page');
            }
            //Not Acceptable (세션종료) 
            else if (xhr.status == 406) {
                alert('go login page');
            }
            else {
                alert(xhr.responseText);
            }*/
        }
    });
}
         
/**
 * Fixed header setup
 * @param id
 */
/*
function fixedTableSetup(id) {
    new superTable(id, {
        cssSkin : "sDefault",
        fixedCols : 1
    });
}
*/
/**
 * dynamic table row insert/delete
 * @param index
 */
/*
function removeTableRow(id, index){
    var btr = $("#"+id+" > tbody > tr");
    $(btr[index]).remove();
}

function appendTableRow(id, text){
    $("#"+id+" > tbody").append(text);
}

function initTableRow(id) {
    var size = getTableRowCount(id);
    for (var i = 0; i < size; i++) {
        removeTableRow(id, 0);
    }
}

function getTableRowCount(id){
    return ( $("#"+id+" > tbody tr").length );
}

function getTableCellCount(id, rowIndex){
    return ( $($("#"+id+" > tbody tr")[rowIndex]).children("td, th").length );
}

function appendColsGroup(id, w1, w2) {
    $('<col style="width:'+(w1||'100px')+'"/><col style="width:'+(w2||'220px')+'"/>').prependTo($("#"+id));
}

function appendConds(id, title, html, w1, w2) {
    $("<th width='"+(w1||"80")+"'>"+title+"</th><td width='"+(w2||"150")+"'>"+html+"</td>").prependTo($("#"+id));
}
*/

function val(val) {
    if (val == null) return '';
    try{
        return (val.replace(/"/g,'')).replace(/'/gi,'');
    }catch(e){
        return val;
    }
}

function el(eid) {
    return document.getElementById(eid);
}

function initTabs(cnt, no, sub) {
    if (!sub) {
        for (var i = 0; i < gvclonetables.length; i++) {
            var clone = gvclonetables[i];
            clone.hide();
        }
    }
    for (var i = 1; i <= cnt; i++) {
        if (i == no) {
            if ($('#tab'+i+'_top'+(sub||'')).hasClass("off")) {
                $('#tab'+i+'_top'+(sub||'')).removeClass("off");
                $('#tab'+i+'_top'+(sub||'')).addClass("on");
            }
        }
        else {
            if ($('#tab'+i+'_top'+(sub||'')).hasClass("on")) {
                $('#tab'+i+'_top'+(sub||'')).removeClass("on");
                $('#tab'+i+'_top'+(sub||'')).addClass("off");
            }
        }        
        $('#tab'+i+'_page'+(sub||'')).hide();
    }
    $('#tab'+no+'_page'+(sub||'')).show();
}

function initSubTabs(cnt, no) {
    initTabs(cnt, no, "_s");
}

function initTableHeader(id, s, w) {
    if (!gvsa) return;
    var arr = new Array();
    var len = $($("#"+id+" > thead tr")[0]).children("th").length;
    for (var i = 0; i < len; i++) {
        var wid = $($($("#"+id+" > thead tr")[0]).children("th")[i]).attr('width');
        var tit = $($($("#"+id+" > thead tr")[0]).children("th")[i]).html();
        if (wid) 
            arr[i] = '<th width="'+wid+'">'+tit+'</th>';
        else
            arr[i] = '<th>'+tit+'</th>';
    }
    $($("#"+id+" > thead > tr")[0]).remove();
    
    var text = '';
    for (var i = 0; i < len; i++) {
        if (i == s-1)
            text += '<th width="'+w+'">사이트</th>';
        text += arr[i];
    }
    $("#"+id+" > thead").append('<tr>'+text+'</tr>');
    //alert($($("#"+id+" > thead tr")[0]).html());
}

function initSiteSelector(id, cols, call) {
    if (!gvsa) return;
    var html = $("#"+id+" > tbody").html();
    $("#"+id+" > tbody").html("");
    var tr = $("<tr></tr>");
    $("<th class='point'></th>").html("사이트").appendTo(tr);
    $("<td "+(cols > 1? "colspan='"+cols+"'":"")+"></td>").html('<select name="i_site_id" id="i_site_id"></select> <input type="text" class="text2" name="i_site_id_hp" id="i_site_id_hp" style="width:50px"/>').appendTo(tr);
    tr.appendTo($("#"+id+" > tbody"));
    $("#"+id+" > tbody").html($("#"+id+" > tbody").html()+html);
    
    
    //var txt = '<th class="point">사이트명</th><td '+(cols > 1? 'colspan="'+cols+'"':'')+'><select name="i_site_id" id="i_site_id" style="width:159px"></select><input type="text" class="text" name="i_site_id_hp" id="i_site_id_hp" style="width:50px"/></td>';
    //$("#"+id+" > tbody").append(txt); 
    // 사이트 옵션 만들기
    getSiteOptionList($("#i_site_id"), true, "선택");
    
    // 사이트 helper
    $('#i_site_id_hp').keyup(function(e) {
        var val = $(this).val();
        if (val == '') return;
        
        $('#i_site_id option').each(function() {
            if ($(this).text().indexOf(val) > -1) {
                $(this).attr("selected", true);
                $('#i_site_id').change();
            }
        });
    });
    
    $('#s_site_id_hp').focus();
    
    if (call) eval(call+"()");
}

function formSerialize(id) {
    var disabled = $(":disabled");
    $(":disabled").each(function() {
        $(this).removeAttr("disabled");
    });
    
    var form = $('<form></form>');
    var sc = $(id).serializeArray();

    for (var i = 0; i < sc.length; i++) {
        //alert(sc[i].name);
        var el = $("<input type='hidden'/>");
        if (sc[i].name.indexOf("i_") == 0)
            el.attr('name', sc[i].name.substring("i_".length));
        else if (sc[i].name.indexOf("h_") == 0)
            el.attr('name', sc[i].name.substring("h_".length));
        else if (sc[i].name.indexOf("s_") == 0)
            el.attr('name', sc[i].name.substring("s_".length));
        else if (sc[i].name.indexOf("a_") == 0)
            el.attr('name', sc[i].name.substring("a_".length));
        else
            el.attr('name', sc[i].name);
        
        if (sc[i].name.indexOf("_dy") > -1)
            el.val(sc[i].value.replace(/-/gi,''));
        else
            el.val(sc[i].value);
        el.appendTo(form);
    }
    
    disabled.attr("disabled", true);
    
    form.appendTo($("body"));
    return form.serialize();
}

function formatDate(dt) {
    var val = '';  
    if (dt == '' || dt == null || dt == 'undefined'){
        return val;
    }
    if (dt.length == 14) {
        val = dt.substring(0,4)+'-'+dt.substring(4,6)+'-'+dt.substring(6,8)+' '+dt.substring(8,10)+':'+dt.substring(10,12)+':'+dt.substring(12,14);
    }
    else if (dt.length == 12) {
        val = dt.substring(0,4)+'-'+dt.substring(4,6)+'-'+dt.substring(6,8)+' '+dt.substring(8,10)+':'+dt.substring(10,12);
    }
    else if (dt.length == 8) {
        val = dt.substring(0,4)+'-'+dt.substring(4,6)+'-'+dt.substring(6,8);
    }
    else if (dt.length == 6) {
        val = dt.substring(0,4)+'-'+dt.substring(4,6);
    }
    return val;
}

function centerPopupWindow(targetUrl, windowName, properties) {
    var childWidth = properties.width;
    var childHeight = properties.height;
    var childTop = (screen.height - childHeight) / 2 - 50;    // 아래가 가리는 경향이 있어서 50을 줄임
    var childLeft = (screen.width - childWidth) / 2;
    var popupProps = "width=" + childWidth + ",height=" + childHeight + ", top=" + childTop + ", left=" + childLeft;
    if (properties.scrollBars == "YES") {
        popupProps += ", scrollbars=yes";
    }

    var popupWin = window.open(targetUrl, windowName, popupProps);
    popupWin.focus();
}

function getToday() {
   var now = new Date();
   var year= now.getFullYear();
   var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
   var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
   return year + '-' + mon + '-' + day;
}

function formatNumber(val) {
    return String(val).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
}

function getParameter(name) {
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)"; 
    var regex = new RegExp( regexS ); 
    var results = regex.exec(window.location.href);
    if (results == null)
        return ""; 
    else 
        return results[1];
}

function getCalDate(date, term) {
    var selArry;
    if (date.indexOf("-") > 0) {
        selArry = date.split("-");
    }
    else {
        selArry = [];
        selArry.push(date.substring(0,4));
        selArry.push(date.substring(6,8));
        selArry.push(date.substring(10,12));
    }    
    var d1 = new Date(selArry[0],selArry[1]-1,selArry[2]);
    var d2 = new Date(d1.valueOf()+(24*60*60*1000*term));
    
    var dash = "";
    if (date.indexOf("-")) {
        dash = "-";
    }
    return d2.getFullYear()+dash+(d2.getMonth() < 9? "0"+(d2.getMonth()+1):d2.getMonth()+1)+dash+(d2.getDate() < 10? "0"+d2.getDate():d2.getDate());
}

function selDisplay(icon){
    var tr = $(icon).parent().parent();
    tr.parent().find('td').css('background-color', '');
    tr.find('td').css('background-color', '#FFFFC8');
}










/**
 * table tr OnmouseOver color -- Start
*/
function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      oldonload();
      func();
    };
  }
}

function paintGrid(id) {
    //stripeTables();
    //highlightRows();
    $("#"+id+" tbody tr:odd").addClass("odd");
    $("#"+id+" tbody tr").mouseover(function() {
        $(this).addClass("highlight");
    });
    $("#"+id+" tbody tr").mouseout(function() {
        $(this).removeClass("highlight");
    });
}

function formReset(frmId){
    $('#'+frmId)[0].reset();
    $('#'+frmId).find('input[type=hidden]').each(function(){
        $(this).val('');
    });
}

function cutString(str, len, suffix) {
    var cutStr = "";
    if(str != null && len > 0) {
        if(len < str.length)
            cutStr = str.substring(0, len);
        else
            cutStr = str;
        
        if(cutStr.length < str.length) {
            cutStr += suffix;
        }
    }
    return cutStr;
}

/**
 * table tr OnmouseOver color -- Start
*/
function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      oldonload();
      func();
    };
  }
}

function paintGrid(id) {
    //stripeTables();
    //highlightRows();
    $("#"+id+" tbody tr:odd").addClass("odd");
    $("#"+id+" tbody tr").mouseover(function() {
        $(this).addClass("highlight");
    });
    $("#"+id+" tbody tr").mouseout(function() {
        $(this).removeClass("highlight");
    });
}

function _goPage(p, funcName){
    //if(p) $('#page').val(p);
    //eval(funcName+'()');
    eval(funcName+'('+p+')');
}

function paintPager(page, cpp, totalCnt, funcName){
	
    var pageBlockCnt = 10;
    
    //var startBlockNum = (Math.floor(page/(pageBlockCnt-0+1)) * pageBlockCnt) + 1;
    var currentPageNum = Math.ceil(page/pageBlockCnt);
    var startBlockNum = (currentPageNum - 1) * pageBlockCnt + 1;
    
    
    var endBlockNum = (Math.ceil(page/pageBlockCnt) * pageBlockCnt);
    var lastBlockNum = Math.ceil(totalCnt/cpp);
    if(endBlockNum > lastBlockNum){
        endBlockNum = lastBlockNum;
    }
    var prev = page - 1; if(prev < 1) prev = 1;
    var next = page -0 + 1; if(next > lastBlockNum) next = lastBlockNum;
    
    if(funcName == null) funcName = 'doSearch';
    
    var pagerHtml = '';
    //pagerHtml += '<input type="hidden" name="page" id="page" value="' +page+ '"/>';
    pagerHtml += '<select name="cpp" id="cpp" class="right" style="width:60px;height:18px" onchange="_goPage(1, \''+funcName+'\');">';
    pagerHtml += '    <option value="10" '+ (cpp==10?'selected':'') +' >10건</option>';
    pagerHtml += '    <option value="20" '+ (cpp==20?'selected':'') +' >20건</option>';
    pagerHtml += '    <option value="30" '+ (cpp==30?'selected':'') +' >30건</option>';
    pagerHtml += '</select>';
    pagerHtml += '<span class="right">페이지당 조회건수&nbsp;</span>';
    pagerHtml += '';
    pagerHtml += '<span class="fst"><a href="javascript:_goPage(1, \'' +funcName+ '\');">첫페이지</a></span>';
    pagerHtml += '<span class="pre"><a href="javascript:_goPage('+prev+ ', \'' +funcName+ '\');">이전페이지</a></span>';
    
    for(var i=startBlockNum ;i<=endBlockNum;i++){
        if(i > lastBlockNum) continue;
        if( i == page )
            pagerHtml += '<span class="bar"><a href="javascript:_goPage('+i+ ', \'' +funcName+ '\');" class="current">' +i+ '</a></span>';
        else
            pagerHtml += '<span class="bar"><a href="javascript:_goPage('+i+ ', \'' +funcName+ '\');">' +i+ '</a></span>';
    }
    pagerHtml += '<span class="nxt"><a href="javascript:_goPage('+next+ ', \'' +funcName+ '\');">다음페이지</a></span>';
    pagerHtml += '<span class="end"><a href="javascript:_goPage('+lastBlockNum+ ', \'' +funcName+ '\');">끝페이지</a></span>';
    
    return pagerHtml;
}

function cutString(str, len, suffix) {
    var cutStr = "";
    if(str != null && len > 0) {
        if(len < str.length)
            cutStr = str.substring(0, len);
        else
            cutStr = str;
        
        if(cutStr.length < str.length) {
            cutStr += suffix;
        }
    }
    return cutStr;
}

function selDisplay(icon){
    var tr = $(icon).parent().parent();
    tr.parent().find('td').css('background-color', '');
    tr.find('td').css('background-color', '#FFFFC8');
}

/**
 * 주어진 Time 과 y년 m월 d일 h시 차이나는 Time을 리턴

 * ex) var time = form.time.value; //String(yyyy-mm-dd HH:ss)
 *     alert(shiftTime(time,0,0,-100,0));
 *     => 2000/01/01 00:00 으로부터 100일 전 Time
 */
function shiftTime(time, y, m, d, h) { //moveTime(time,y,m,d,h)
    var date = toTimeObject(time);
//alert (date + "##" + h);
    
    date.setFullYear(date.getFullYear() + y); //y년을 더함
    date.setMonth(date.getMonth() + m); //m월을 더함
    date.setDate(date.getDate() + d); //d일을 더함
    date.setHours(date.getHours() + h); //h시를 더함
    
//alert (h + "##" + parseInt(h));
    if (h > parseInt(h)) {
        date.setMinutes(date.getMinutes() + (h - parseInt(h)) * 100);
    }

    return toTimeString(date);
}

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String(yyyy-mm-dd HH:ss)
 */
function toTimeObject(time) { //parseTime(time)
    var year = time.substr(0, 4);
    var month = time.substr(5, 2) - 1; // 1월=0,12월=11
    var day = time.substr(8, 2);
    var hour = time.substr(11, 2);
    var min = time.substr(14, 2);

    return new Date(year, month, day, hour, min);
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year = date.getFullYear();
    var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
    var day = date.getDate();
    var hour = date.getHours();
    var min = date.getMinutes();

    if (("" + month).length == 1) {
        month = "0" + month;
    }
    if (("" + day).length == 1) {
        day = "0" + day;
    }
    if (("" + hour).length == 1) {
        hour = "0" + hour;
    }
    if (("" + min).length == 1) {
        min = "0" + min;
    }

    return ("" + year + "-" + month + "-" + day + " " + hour + ":" + min);
}

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String(yyyy-mm-dd HH:ss)
 */
function toTimeObject(time) { //parseTime(time)
    var year = time.substr(0, 4);
    var month = time.substr(5, 2) - 1; // 1월=0,12월=11
    var day = time.substr(8, 2);
    var hour = time.substr(11, 2);
    var min = time.substr(14, 2);

    return new Date(year, month, day, hour, min);
}

/**
 * 두 Time이 몇 시간 차이나는지 구함

 * time1이 time2보다 크면(미래면) minus(-)
 */
function getHourInterval(time1, time2) {
    var date1 = toTimeObject(time1);
    var date2 = toTimeObject(time2);
    var hour = 1000 * 3600; //1시간

    //return parseInt((date2 - date1) / hour, 10);
    return (date2 - date1) / hour;
}

function formReset(frmId){
    $('#'+frmId)[0].reset();
    $('#'+frmId).find('input[type=hidden]').each(function(){
        $(this).val('');
    });
}

/**
 * 
 * @param startDy 'yyyy/MM/dd'
 * @param endDy 'yyyy/MM/dd'
 * @returns {Number} days
 */
function getDays(startDy, endDy) {
	var sDate = new Date(startDy);
    var eDate = new Date(endDy);
    var days = (eDate.getTime() - sDate.getTime()) / (1000*60*60*24);
    return days;
}

function getDateAxisTickNumber(startDy, endDy) {
	var num = getDays(startDy, endDy);
	if (num > 10) num = 10;
    else if (num < 2) num = 2;
    return num;
}

/**
 * paymethod common code
 * @param param1
 * @param param2
 * @param param3
 */
function goAction(param1, param2, param3){
	 var selectTagObj = $("#" + param1);
	 var existVal = selectTagObj.val();
	 $.ajax({
	        type: 'POST',        
	        url:  param3,
	        data: param2 ,
	        dataType: 'json',
	        
	        /* success logic  */
	        success: function(data) {
	        	selectTagObj.find('option').each(function() {
	        	    if(this.value != "")$(this).remove();
	            });
	        	
	        	for(var i=0 ; i < data.length ; i++){
	        		var selectedV = existVal == data[i].cd ? "selected" : "";
	        		var html = "<option value=\"" + data[i].cd + "\"  "  + selectedV + ">" + data[i].cd_nm + "</option>";
	        		selectTagObj.append(html);
	        	}
	        },
	        error :function(data){
	        	alert("fail~")
	        }
	    });
}
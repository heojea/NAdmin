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
    $('#btn_ok').click(function() {insImg();});
    $('#btn_cancel').click(function() {self.close();});
    
    initUploadFile($("#uploadFile1"), "<c:url value='/zcom/uploadFile.do'/>", {"dir" : "editor"});
    
    initUploader();
});

function initUploadFile(obj, url, post, iw, ih, ext, btxt) {
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
            var list = eval(data);
            var item = list[0];
            $("#physical_file1_nm").val(item.fileName);
            $("#physical_file1_size").val(item.fileSize);
            $("#logical_file1_nm").val(item.originFileName);
            $("#img_file1_src").attr("src", item.filePath+item.fileName);
            $("#img_file1_src").css("width", iw+"px").css("height",ih+"px").css("border", "1px solid #777777");
        },
        "onUploadError" : function(file, errorCode, errorMsg, errorString) {
            alert(file.name+"을 업로드시 실패 하였습니다");
        }
    });
}

function initUploader(){
    var _opener = PopupUtil.getOpener();
    if (!_opener) {
        alert('잘못된 경로로 접근하셨습니다.');
        return;
    }
    
    var _attacher = getAttacher('image', _opener);
    registerAction(_attacher);
}

function insImg(){
   opener.Editor.focus();
    
   var imgPath = $('#img_file1_src').attr('src');
   var fileNm = $('#logical_file1_nm').val();
   var fileSize = $('#physical_file1_size').val();
   
   if (typeof(execAttach) == 'undefined') { //Virtual Function
       alert('execAttach ERROR');
       return;
   }
   
   var _mockdata = {
           'imageurl': imgPath,
           'filename': fileNm,
           'filesize': fileSize,
           'imagealign': 'C',
           'originalurl': imgPath,
           'thumburl': imgPath
       };
   execAttach(_mockdata);
   closeWindow();
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap" style="min-width:0px; width:325px;">
    <div class="h2"><h2>이미지업로드</h2></div>

    <div class="bbs_search">
        <table id="g_selector" class="bbs_search" cellpadding="0" cellspacing="0" border="0">
        <tbody>
        <tr>
            <td>
                <input type="file" name="uploadFile1" id="uploadFile1" />
                <input type="hidden" name="logical_file1_nm" id="logical_file1_nm"/>
                <input type="hidden" name="physical_file1_nm" id="physical_file1_nm"/>
                <input type="hidden" name="physical_file1_size" id="physical_file1_size"/>
            </td>
        </tr>
        <tr>
            <td>
                <div style="float:right; margin-top:-30px; margin-right:5px;">
                    <a href="#" class="btn_s" id="btn_ok"><span>확인</span></a>
                    <a href="#" class="btn_s" id="btn_cancel"><span>취소</span></a>
                </div>
                <div style="overflow:auto; width:320px; height:200px;">
                    <img id="img_file1_src" src="" onerror="this.src='${cfn:getString('system.static.path')}/images/common/blank.gif';" style="border:1px solid #dddddd" />
                </div>
            </td>
        </tr>
        </tbody>
        </table>
    </div>
</div>    
</body>
</html>

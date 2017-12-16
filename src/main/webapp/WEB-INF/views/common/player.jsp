<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<title>동영상 플레이어</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="${cfn:getString('system.static.path')}/js/swfobject.js"></script>
<script type="text/javascript">
var flashvars = {
    src: "${param.src}" ,
    autostart: "${param.autostart}",
    themeColor: "${param.themeColor}" ,
    mode: "${param.mode}",
    scaleMode: "${param.scaleMode}" ,
    frameColor: "${param.frameColor}" ,
    fontColor: "${param.fontColor}" ,
    link: "${param.link}" ,
    embed: "${param.embed}" 
};
var params = {allowFullScreen: 'true'};
var attributes = {id: 'myPlayer',name: 'myPlayer'};
swfobject.embedSWF("${cfn:getString('system.static.path')}/images/player/flashPlayer.swf", "myPlayerGoesHere", ${param.width} ,${param.height} , '9.0.0', "${cfn:getString('system.static.path')}/images/player/expressInstall.swf", flashvars, params, attributes);
</script>
</head>
<body style="margin:10px 0 0 10px" bgcolor="#000000">
   <div id="myPlayerGoesHere">
       <a href="http://www.adobe.com/go/getflashplayer">
       <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
       </a>
   </div>
</body>
</html>

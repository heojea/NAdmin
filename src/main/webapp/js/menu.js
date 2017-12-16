// Left Frame : 폈다 접었다 
function resizeMenu() { 
    if ( parent.document.getElementById('totalWin').cols == '200, *' ) { 
        parent.document.getElementById('totalWin').cols = '20, *';
        document.bgColor = "#ffffff"
        document.getElementById('leftClose').style.display= 'none';
        document.getElementById('leftOpen').style.display= 'block';
    } else { 
        parent.document.getElementById('totalWin').cols = '200, *';
        document.bgColor = '#efece0';
        document.getElementById('leftClose').style.display= 'block';
        document.getElementById('leftOpen').style.display= 'none';
    } 
}

// Left Menu : 화면 사이즈에 맞게 height  잡아주기
function resizeLeft(){ 
    var menuHeight = document.documentElement.clientHeight - 45;
    document.getElementById('LeftList').style.height = menuHeight +'px';
}

// Left Menu : onClick
function viewMenu(id) {
    if( document.getElementById(id).className == "on" ) {
        document.getElementById(id).className = "off";
        return;
    } else {
        document.getElementById(id).className = "on";
    }
}

// Right Frame : 컨텐츠 접기, 펴기
function CloseNOpen(div,img,tab) {
    if( document.getElementById(div).style.display == "" ||   document.getElementById(div).style.display == "block" ) {
        document.getElementById(div).style.display = "none";
        document.getElementById(img).src="images/common/btn_open.gif";
        document.getElementById(tab).className= "h3 marginB10";
        return;
    } else {
        document.getElementById(div).style.display = "";
        document.getElementById(img).src="images/common/btn_close.gif";
        document.getElementById(tab).className= "h3";
    }
}

// Right Frame : tab명, 몇번째, 총 id 수
function TabView(tab,name,line){
    for (var i = 1; i <= line; i++) {
        document.getElementById(tab+i).style.display='none'
        document.getElementById(tab+"li_"+i).className= 'off';
    }
    document.getElementById(tab+name).style.display='block';
    document.getElementById(tab+"li_"+name).className= 'on';
}



// 아이프레임 전체 리사이징
function iframeResize(objId){
    var frame = window.frames[objId.name];
    var idObj =  document.getElementById(objId.id)

    idObj.style.height = frame.document.documentElement.scrollHeight + 10 + "px";
}

function iframeOnload(id){ document.getElementById(id).onload(); }



// POPUP (mypage - 주소, myname - 팝업명, w - 가로, h - 세로, scroll - 스크롤 yes no)
function OpenWindow(mypage, myname, w, h, scroll) {
    var winl = (screen.width - w) / 2;
    var wint = (screen.height - h) / 2;
    winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
    win = window.open(mypage, myname, winprops)
    if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
    return win;
}

/**
 * table tr OnmouseOver color -- End
*/
<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<head>
<title>��һ���~~</title>

<style type="text/css">
	html,body {
		    padding: 0 !important;
			margin: 0 !important;
		    background-color:#ffffff;
		    width:100%;
		    height:100%;
		    font-family:"΢���ź�";
		    overflow-x:auto;
		     background-size: 100% 100%;
			background-position:top center;
		    background-color:#F0F0F0;
		    background-image: url(images/flygame/b_g.png);
		    background-repeat:no-repeat;
		}
		
		*{margin:0; padding:0;}
		a{text-decoration: none;}
		img{max-width: 100%; height: auto;}
		.weixin-tip{display: none; position: fixed; left:0; top:0; bottom:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80);  height: 100%; width: 100%; z-index: 100;}
		.weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}
		</style>
</head>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script>
wx.config({
    debug: false, // ��������ģʽ,���õ�����api�ķ���ֵ���ڿͻ���alert��������Ҫ�鿴����Ĳ�����������pc�˴򿪣�������Ϣ��ͨ��log���������pc��ʱ�Ż��ӡ��
    appId: '${appid}', // ������ںŵ�Ψһ��ʶ
    timestamp:'${timestamp}', // �������ǩ����ʱ���
    nonceStr: '${nonceStr}', // �������ǩ���������
    signature: '${signature}',// ���ǩ��������¼1
    jsApiList: [
    	'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ',
        'onMenuShareWeibo','hideMenuItems',  'showMenuItems', 'hideAllNonBaseMenuItem',
        'showAllNonBaseMenuItem', 'translateVoice', 'startRecord',  'stopRecord',
        'onRecordEnd','playVoice','pauseVoice','stopVoice','uploadVoice','downloadVoice',
        'chooseImage','previewImage','uploadImage','downloadImage','getNetworkType',
        'openLocation','getLocation','hideOptionMenu','showOptionMenu','closeWindow',
        'scanQRCode', 'chooseWXPay','openProductSpecificView','addCard','chooseCard','openCard'
        ] // �����Ҫʹ�õ�JS�ӿ��б�����JS�ӿ��б����¼2
});

wx.hideMenuItems({
    menuList: ['menuItem:share:appMessage','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:openWithQQBrowser','menuItem:copyUrl','menuItem:openWithSafari'] // Ҫ���صĲ˵��ֻ�����ء������ࡱ�͡������ࡱ��ť������menu�����¼3
});

var linkurl="";
var imgUrl = "";
var desc='����˭�ŵĻһ����Ϳ��Գ�Ϊ˭�ĺû��ѣ�����ͣ��ȯ�����ȯ���������';
var title ='����${carnumber}���ڴ�һ������������ĺû���';
var url  ='http://s.tingchebao.com/zld/';
//var url  ='http://yxiudongyeahnet.vicp.cc/zld/';
linkurl= url +'carowner.do?action=getobonus&id=${bonusid}';
imgUrl = url+'images/flygame/share_b.png';

wx.ready(function() {
	//alert(title);alert(linkurl);alert(imgUrl);
	function sharetofriend(){
		wx.onMenuShareAppMessage({
		    title: title, // �������
		    desc: desc, // ��������
		    link: linkurl, // ��������
		    imgUrl: imgUrl, // ����ͼ��
		    type: '', // ��������,music��video��link������Ĭ��Ϊlink
		    dataUrl: '', // ���type��music��video����Ҫ�ṩ�������ӣ�Ĭ��Ϊ��
		    success: function () { 
		        // �û�ȷ�Ϸ����ִ�еĻص�����
		    	//wx.closeWindow();
		    	document.getElementById("togame").submit();
		    },
		    cancel: function () { 
		        // �û�ȡ�������ִ�еĻص�����
		        //document.getElementById("togame").submit();
		    	//$(".weixin-tip").hide();
		    }
		});
	}
	
	
	function sharetocircle(){//���͵�����Ȧ
		//alert(title);alert(linkurl);alert(imgUrl);
		wx.onMenuShareTimeline({
		    title: title, // �������
		    link: linkurl, // ��������
		    imgUrl: imgUrl, // ����ͼ��
		    success: function () { 
		        // �û�ȷ�Ϸ����ִ�еĻص�����
		    	//wx.closeWindow();
		    	document.getElementById("togame").submit();
		    },
		    cancel: function () { 
		        // �û�ȡ�������ִ�еĻص�����
		       // document.getElementById("togame").submit();
		    	//$(".weixin-tip").hide();
		    }
		});
	}
	try{sharetocircle();sharetofriend();}catch(e){};
});
//'menuItem:share:appMessage',
function shareinfo(){
	wx.hideMenuItems({
	    menuList: ['menuItem:share:appMessage','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:openWithQQBrowser','menuItem:copyUrl','menuItem:openWithSafari'] // Ҫ���صĲ˵��ֻ�����ء������ࡱ�͡������ࡱ��ť������menu�����¼3
	});
	var sourcetag = navigator.userAgent
	//alert(sourcetag);
	if(navigator.userAgent.indexOf("MicroMessenger")!=-1){
		var winHeight =document.getElementById('body').offsetHeight;
		//alert(winHeight);
		function is_weixin() {
		    var ua = navigator.userAgent.toLowerCase();
		    if (ua.match(/MicroMessenger/i) == "micromessenger") {
		        return true;
		    } else {
		        return false;
		    }
		}
		var isWeixin = is_weixin();
		if(isWeixin){
			document.getElementById("weixin-tip").style.display='block';
            document.getElementById("android").style.height=parseInt(winHeight/1.2)+"px";
            document.getElementById("ios").style.height=parserInt(winHeight/2)+"px";
		}
	}else if(sourcetag.indexOf("Android")!=-1){//����android
		window.share.share(linkurl,title,desc,imgUrl)
	}else if(sourcetag.indexOf("iPhone")!=-1){//����iphone
		var u = 'http://s.tingchebao.com';
		//var u='http://yxiudongyeahnet.vicp.cc';
		location = u+'?desc='+desc+'&title='+title+'&imgurl='+imgUrl+'&url='+linkurl;
	}
}
</script>
<body id='body' >
<div class="weixin-tip" id='weixin-tip'>
		<p>
			<img id="android" style="height:500px;" src="images/wxpublic/mask_android1.png" />
			<img id="ios" style="height:400px;" src="images/wxpublic/mask_ios1.png" />
		</p>
	</div>
	<div> </div>
<form action="flygame.do?action=${page}" method='post' id='togame'>
		<input type='hidden' name='tid' value='${tid}'/>
		<input type='hidden' name='uin' value='${uin}'/>
		<input type='hidden' name='agin' value='score'/>
</form>
</body>
<script>

var userAgent = navigator.userAgent.toLowerCase();
if(userAgent.match(/iphone os/i) == "iphone os"){
	document.getElementById("android").style.display = "none";
}else{
	document.getElementById("ios").style.display = "none";
}
var tid = '${tid}';
if(tid=='-1'){
	document.getElementById("action").value='pregame';
}
shareinfo();
</script>
</html>
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
<style type="text/css">
		html,body {
		    padding: 0 !important;
			margin: 0 !important;
		    background-color:#ffffff;
		    width:100%;
		    height:100%;
		    font-family:"΢���ź�";
		    overflow-x:hidden !important;
		    background-size: 100% 100%;
			background-position:top center;
		    background-color:#4DD2A7;
		    background-image: url(images/game/game_b.jpg);
		    background-repeat:no-repeat;
		}
		a{text-decoration: none;}
	img{max-width: 100%; height: auto;}
	.weixin-tip{display: none; 
		position: fixed; 
		left:0; top:0; bottom:0; 
		background: rgba(0,0,0,0.8);
		filter:alpha(opacity=80); 
		height: 100%; 
		width: 100%; 
		background-repeat:no-repeat;
		z-index: 100;}
	.weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}
		</style>
</head>
<script src="js/jquery.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script type="text/javascript">
wx.config({
    debug: false, // ��������ģʽ,���õ�����api�ķ���ֵ���ڿͻ���alert��������Ҫ�鿴����Ĳ�����������pc�˴򿪣�������Ϣ��ͨ��log���������pc��ʱ�Ż��ӡ��
    appId: '${appid}', // ������ںŵ�Ψһ��ʶ
    timestamp:'${timestamp}', // �������ǩ����ʱ���
    nonceStr: '${nonceStr}', // �������ǩ���������
    signature: '${signature}',// ���ǩ��������¼1
    jsApiList: [
    	'checkJsApi',
        'onMenuShareTimeline',
        'onMenuShareAppMessage',
        'onMenuShareQQ',
        'onMenuShareWeibo',
        'hideMenuItems',
        'showMenuItems',
        'hideAllNonBaseMenuItem',
        'showAllNonBaseMenuItem',
        'translateVoice',
        'startRecord',
        'stopRecord',
        'onRecordEnd',
        'playVoice',
        'pauseVoice',
        'stopVoice',
        'uploadVoice',
        'downloadVoice',
        'chooseImage',
        'previewImage',
        'uploadImage',
        'downloadImage',
        'getNetworkType',
        'openLocation',
        'getLocation',
        'hideOptionMenu',
        'showOptionMenu',
        'closeWindow',
        'scanQRCode',
        'chooseWXPay',
        'openProductSpecificView',
        'addCard',
        'chooseCard',
        'openCard'
        ] // �����Ҫʹ�õ�JS�ӿ��б�����JS�ӿ��б����¼2
});
</script>
<script type="text/javascript">
	wx.ready(function() {
		function sharetofriend(){
			wx.onMenuShareAppMessage({
			    title: 'ͣ���������򵥣����ͺ��������', // �������
			    desc: '΢��֧��3�����', // ��������
			    link: 'http://yxiudongyeahnet.vicp.cc/zld/carinter.do?action=getwxbonus&id=', // ��������
			    imgUrl: 'http://yxiudongyeahnet.vicp.cc/zld/images/bonus/wx_order_bonu.png', // ����ͼ��
			    type: '', // ��������,music��video��link������Ĭ��Ϊlink
			    dataUrl: '', // ���type��music��video����Ҫ�ṩ�������ӣ�Ĭ��Ϊ��
			    success: function () { 
			        // �û�ȷ�Ϸ����ִ�еĻص�����
			    	wx.closeWindow();
			    },
			    cancel: function () { 
			        // �û�ȡ�������ִ�еĻص�����
			    	$(".weixin-tip").hide();
			    }
			});
		}
		
		function sharetocircle(){//���͵�����Ȧ
			wx.onMenuShareTimeline({
			    title: 'ͣ���������򵥣����ͺ��������', // �������
			    link: 'http://yxiudongyeahnet.vicp.cc/zld/carinter.do?action=getwxbonus&id=', // ��������
			    imgUrl: 'http://yxiudongyeahnet.vicp.cc/zld/images/bonus/wx_order_bonu.png', // ����ͼ��
			    success: function () { 
			        // �û�ȷ�Ϸ����ִ�еĻص�����
			    	wx.closeWindow();
			    },
			    cancel: function () { 
			        // �û�ȡ�������ִ�еĻص�����
			    	$(".weixin-tip").hide();
			    }
			});
		}
		//�ж��Ƿ���Է������������
		//document.getElementById("shareimage").style.display = "";//��ʾ���ͼƬ
		sharetofriend();
		try{sharetocircle();}catch(e){};
	});
	function share(){
		var winHeight = $(window).height();
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
			$(".weixin-tip").css("height",winHeight);
            $(".weixin-tip").show();
		}
	}
</script>
<body id='body'>
	<div class="weixin-tip">
		<p>
			<img id="android" style="height:500px;" src="images/wxpublic/mask_android.png" />
			<img id="ios" style="height:500px;" src="images/wxpublic/mask_ios.png" />
		</p>
	</div>
	<div id="sale" style="position:absolute;">
		<img id='saleimg' src='images/game/win.png'/>
	</div>
	<div id="words1" style="position:absolute;color:#FFFFFF" >
		��ϲ
	</div>
	<div id="words2" style="position:absolute;color:#FFFFFF" >
		ͣ����ս���֣�ͣ��ȯ��5��
	</div>
	<div id="words3" style="position:absolute;color:#EDC500" >
		���100�����������Ϸ��Ȩ
	</div>
	<div id="star" style="position:absolute;" >
		<img id='starimg' src='images/game/star.png' />
	</div>
	<div id="words4" style="position:absolute;color:#FFFFFF;text-align:center;width:100%" >
		��${alluser}�������У�����������${sort}
	</div>
	<div id="share" style="position:absolute;" onclick='share();'>
		<img id='shareimg' src='images/game/sharfriend.png' />
	</div>
</body>
<script>
var h = document.getElementById('body').offsetHeight;
var w = document.getElementById('body').offsetWidth;

document.getElementById("sale").style.left=parseInt(w*0.34)+"px";
document.getElementById("sale").style.top=parseInt(h*0.162)+"px";
document.getElementById("saleimg").style.width=parseInt(w*0.32)+"px";

document.getElementById("words1").style.left=parseInt(w*0.422)+"px";
document.getElementById("words1").style.top=parseInt(h*0.492)+"px";
document.getElementById("words1").style.fontSize=parseInt(w*0.082)+"px";

document.getElementById("words2").style.left=parseInt(w*0.180)+"px";
document.getElementById("words2").style.top=parseInt(h*0.562)+"px";
document.getElementById("words2").style.fontSize=parseInt(w*0.052)+"px";

document.getElementById("words4").style.top=parseInt(h*0.622)+"px";
document.getElementById("words4").style.fontSize=parseInt(w*0.032)+"px";

document.getElementById("star").style.left=parseInt(w*0.122)+"px";
document.getElementById("star").style.top=parseInt(h*0.739)+"px";
document.getElementById("starimg").style.width=parseInt(w*0.082)+"px";

document.getElementById("words3").style.left=parseInt(w*0.21)+"px";
document.getElementById("words3").style.top=parseInt(h*0.739)+"px";
document.getElementById("words3").style.fontSize=parseInt(w*0.05)+"px";

document.getElementById("share").style.left=parseInt(w*0.122)+"px";
document.getElementById("share").style.top=parseInt(h*0.81)+"px";
document.getElementById("shareimg").style.width=parseInt(w*0.752)+"px";


</script>
</html>
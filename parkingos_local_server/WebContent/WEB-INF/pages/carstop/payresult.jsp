<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>֧���ɹ�</title>
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
		    background-color:#F5F5F5;
		    font-size:14px;
		}
	*{margin:0; padding:0;}
	a{text-decoration: none;}
	img{max-width: 100%; height: auto;}
	.weixin-tip{display: none; position: fixed; left:0; top:0; bottom:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80);  height: 100%; width: 100%; z-index: 100;}
	.weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}
</style>
<style type="text/css">
.error {text-align:center;margin-top:10%;}
.success{
	width:100px;
	height:100px;
}
.bonus{
	width:60px;
	height:70px;
}
</style>
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
			    desc: '������ȯ���Է�����!', // ��������
			    link: 'http://s.tingchebao.com/zld/carowner.do?action=getobonus&id=${bonusid}', // ��������
			    imgUrl: 'http://s.tingchebao.com/zld/images/bonus/order_bonu.png', // ����ͼ��
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
		//�ж��Ƿ���Է������������
		var bonusid = '${bonusid}';//���id
		if(bonusid != "-1"){
			document.getElementById("sendbonus").style.display = "";//��ʾ�����ť
			sharetofriend();
		}
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var userAgent = navigator.userAgent.toLowerCase();
		if(userAgent.match(/iphone os/i) == "iphone os"){
			document.getElementById("android").style.display = "none";
		}else{
			document.getElementById("ios").style.display = "none";
		}
		
	});
</script>
<script type="text/javascript">
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
</head>
<body style="background-color:#F0F0F0;">
<div class="weixin-tip">
		<p>
			<img id="android" style="height:500px;" src="images/wxpublic/mask_android.png" />
			<img id="ios" style="height:500px;" src="images/wxpublic/mask_ios.png" />
		</p>
	</div>
<div class="error">
<div id='d3' style=''>
		<div style='width:80%;margin:3px auto;text-align:center'><br/><br/><img id='opic' src='images/wxpublic/success.gif' border='0'  style='width:100px;height:100px'  /></div>
		<div style='height:70px;line-height:30px;text-align:center;margin-top:10px;'><b>֧���ɹ�</b><br/><b>��${amount}</b><font color='red'>${ispay}</font></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:110px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;�������</div><div style='width:160;float:right;color:#000000'><b>${id}</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:110px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;����״̬</div><div style='width:160;float:right;color:#000000'><b>�ѽ���</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:110px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;��ʼʱ��</div><div style='width:160;float:right;color:#000000'><b>${btime}</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:110px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;����ʱ��</div><div style='width:160;float:right;color:#000000'><b>${etime}</b>&nbsp;&nbsp;&nbsp;</div></div>
		<!-- <div><div style='width:97%;height:40px;border-radius:2px;margin:40px auto;background:green;color:#FFFFFF;text-align:center;line-height:40px;border-radius: 5px;' id='cbutton' onclick="vieworder()">�鿴����</div></div> -->
	</div>
<div id="sendbonus" style="float:right;margin-right:20px;margin-top:-52px;display:none;"><img class="bonus" onClick="share()" src="images/wxpublic/sendbonus.png"/></div>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0"/>
	<title>���ٶ�ҳ���ͨ�õ�ͣ��ȯ��duang~</title>
	<script type="text/javascript">
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) != "micromessenger"){
			window.location.href = "http://s.tingchebao.com/zld/error.html";
		}
	</script>
	<script src="js/jquery.js" type="text/javascript">//���</script>
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>

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
		    background-image: url(images/bonus/bg.png);
		    background-repeat:no-repeat;
		    -webkit-user-select: none;
		    -moz-user-select: none;
		}
		.logo{
			width:100px;
			height:24px;
			margin:10px;
			background-size: 100% 100%;
			background-position:top center;
		    background-color:none;
		    background-image: url(images/bonus/logo.png);
		    background-repeat:no-repeat;
		}
		.cloud{
			width:220px;
			height:135px;
			margin:0px auto;
			background-size: 100% 100%;
			background-position:top center;
		    background-color:none;
		    background-image: url(images/bonus/cloud.png);
		    background-repeat:no-repeat;
		}
		.redmail{
			width:240px;
			height:243px;
			margin:0px auto;
			background-size: 100% 100%;
			background-position:bottom center;
		    background-color:none;
		    background-image: url(images/bonus/redmail.png);
		    background-repeat:no-repeat;
		}
		.word{
			color:#EEB84B;
			margin:0px auto;
			font-weight:700;
			font-size:13px;
			width:240px;
			text-align:center;
			padding-top:60px;
		}
		.phonenumber1{
			margin:22px auto 0px auto;
			width: 240px;
			text-align:center;
		}
		.phonenumber2{
			margin:0px auto 0px auto;
			width: 240px;
			text-align:center;
		}
		
		.telnumber{
			width: 160px;
			min-height: 30px;
			background:#fff;
			border:1px solid #ccc;
			border-right:none;
			border-radius: 5px;
		}
		
		.code{
			width: 100px;
			min-height: 30px;
			background:#fff;
			border:1px solid #ccc;
			border-right:none;
			
			-webkit-border-bottom-left-radius: 5px;
			border-bottom-left-radius: 5px;
			-webkit-border-top-left-radius: 5px;
			border-top-left-radius: 5px;
		}
		.bt{
			margin:40px auto 0px auto;
			width: 240px;
			text-align:center;
		}
		.next{
			text-align:center;
			width: 163px;
			min-height: 30px;
			color:#D28D43;
			font-weight:700;
			font-size:15px;
			background:#F5E758;
			border:1px solid #F9F188;
			border-right:none;
			border-radius: 5px;
		}
		.getcode{
			margin:8px auto 0px auto;
			text-align:center;
			width: 60px;
			min-height: 30px;
			color:#D28D43;
			font-weight:700;
			font-size:16px;
			background:#F5E758;
			border:1px solid #F9F188;
			border-right:none;
			
			-webkit-border-bottom-right-radius: 5px;
			border-bottom-right-radius: 5px;
			-webkit-border-top-right-radius: 5px;
			border-top-right-radius: 5px;
		}
		.attention{
			bottom: 0px;
		    margin: 0 auto;
		    position: fixed;
		}
		.info{
			display:none;
		}
	</style>
	<script>
		function sub(){
			window.open("http://a.app.qq.com/o/simple.jsp?pkgname=com.tq.zld");
		}
	</script>

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
		function sharetofriend(){//���͸�����
			wx.onMenuShareAppMessage({
			    title: '���ٶ�ҳ���ͨ�õ�ͣ��ȯ�����ܴ��', // �������
			    desc: 'ͣ�������˴����', // ��������
			    link: 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx08c66cac888faa2a&redirect_uri=http%3a%2f%2fs.tingchebao.com%2fzld%2fwxpaccount.do%3faction%3dregbonus&response_type=code&scope=snsapi_base&state=123#wechat_redirect', // ��������
			    imgUrl: 'http://s.tingchebao.com/zld/images/bonus/order_bonu.png', // ����ͼ��
			    type: '', // ��������,music��video��link������Ĭ��Ϊlink
			    dataUrl: '', // ���type��music��video����Ҫ�ṩ�������ӣ�Ĭ��Ϊ��
			    success: function () { 
			        // �û�ȷ�Ϸ����ִ�еĻص�����
			    },
			    cancel: function () { 
			        // �û�ȡ�������ִ�еĻص�����
			    }
			});
		}
		
		function sharetocircle(){//���͵�����Ȧ
			wx.onMenuShareTimeline({
			    title: '���ٶ�ҳ���ͨ�õ�ͣ��ȯ�����ܴ��', // �������
			    link: 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx08c66cac888faa2a&redirect_uri=http%3a%2f%2fs.tingchebao.com%2fzld%2fwxpaccount.do%3faction%3dregbonus&response_type=code&scope=snsapi_base&state=123#wechat_redirect', // ��������
			    imgUrl: 'http://s.tingchebao.com/zld/images/bonus/order_bonu.png', // ����ͼ��
			    success: function () { 
			        // �û�ȷ�Ϸ����ִ�еĻص�����
			    },
			    cancel: function () { 
			        // �û�ȡ�������ִ�еĻص�����
			    }
			});
		}
		
		sharetofriend();
		sharetocircle();
	});
</script>

</head>
<body >
<script type="text/javascript"
src="http://zb.weixin.qq.com/nearbycgi/addcontact/BeaconAddContactJsBridge.js">
</script>
<script type="text/javascript">
function attention(){
	BeaconAddContactJsBridge.ready(function(){
		//�ж��Ƿ��ע
		BeaconAddContactJsBridge.invoke('checkAddContactStatus',{} ,function(apiResult){
			if(apiResult.err_code == 0){
				/* var status = apiResult.data;
				if(status == 1){
					alert('�ѹ�ע');
				}else{
					alert('δ��ע');
					//��ת����עҳ
				  BeaconAddContactJsBridge.invoke('jumpAddContact');
				} */
				BeaconAddContactJsBridge.invoke('jumpAddContact');
			}else{
//				alert(apiResult.err_msg)
			}
		});
 	});
}
</script>
<div style='display:none'><img src="http://s.tingchebao.com/zld/images/bonus/weixilogo_300.png"/></div>
	<div class="logo"></div>
	<div class="cloud"></div>
	<div class="redmail" id="nobonus">
		<div class="word" id='pword'></div>
		<div class="bt" style="color:#F5E758;font-size:16px;">ֻ�����û�������Ŷ��</div>
		<div class="bt"><input type="button" id="colsubmit" onClick="attention()" class="next" value="�����ע����"></input></div>
	</div>
<!-- 	<div class="attention"><img style="width: 100%; height: 110px;" src="images/wxpublic/attentionus.jpg" /></div> -->

</body>
</html>

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
<script type="text/javascript">
	var ua = navigator.userAgent.toLowerCase();
	if (ua.match(/MicroMessenger/i) != "micromessenger"){
		window.location.href = "http://s.tingchebao.com/zld/error.html";
	}
</script>
<link rel="stylesheet" href="css/prepay.css?v=2">
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
.error {text-align:center;}
.success{
	width:100px;
	height:100px;
}
.bonus{
	width:60px;
	height:70px;
}

.share{
	border-radius:5px;
	width:96%;
	margin-left:2%;
	height:40px;
	margin-top:3%;
	font-size:15px;
	background-color:#04BE02;
	color:white;
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
			<img id="android" style="height:450px;" src="images/wxpublic/mask_android.png" />
			<img id="ios" style="height:450px;" src="images/wxpublic/mask_ios.png" />
		</p>
	</div>
<div class="error">
<div id='d3' style=''>
		<div style='text-align:center;font-size:20px;margin-top:20px;'><b>${comname }</b></div>
		<div style="margin-top:10px;">
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:70px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;Ԥ������</div><div style='width:70;float:right;'><b>${total}Ԫ</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:70px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;ʵͣ����</div><div style='width:70;float:right;'><b>${prepay}Ԫ</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div class="back hide" style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:70px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;${back_dp}</div><div style='width:160;float:right;'><b>${addmoney}Ԫ</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:10px;line-height:20px;background-color:#F0F0F0;'>&nbsp;</div>
		
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:70px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;�������</div><div style='width:160;float:right;'><b>${orderid}</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:70px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;����״̬</div><div style='width:160;float:right;'><b>�ѽ���</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:70px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;��ʼʱ��</div><div style='width:160;float:right;'><b>${btime}</b>&nbsp;&nbsp;&nbsp;</div></div>
		<div style='height:30px;line-height:20px;background-color:#FFFFFF;'><div style='height:8px;color:#747474'></div><div style='width:70px;float:left;color:#9C9A9B'>&nbsp;&nbsp;&nbsp;����ʱ��</div><div style='width:160;float:right;'><b>${etime}</b>&nbsp;&nbsp;&nbsp;</div></div>
		</div>
		<div style="text-align:center;margin-top:2%;" class="wxticket3 hide">
			<img style="height:90px;width:150px;" src="images/wxpublic/wxticket.png">
			<div style="margin-top:2%;color:#04BE02;">��ϲ���5��3��ȯ���������ȡ</div>
		</div>
		<div style="text-align:center;margin-top:2%;" class="wxticket5 hide">
			<img style="height:90px;width:150px;" src="images/wxpublic/wxticket5.png">
			<div style="margin-top:2%;color:#04BE02;">��ϲ���5��5��ȯ���������ȡ</div>
		</div>
		<div style="text-align:center;margin-top:2%;" class="tcbticket hide">
			<img style="height:90px;width:150px;" src="images/bonus/quan.png">
			<div style="margin-top:2%;color:#04BE02;">��ϲ���ͣ��ȯ���������ȡ</div>
		</div>
		<div style="text-align:center;margin-top:2%;" class="first_ticket hide">
			<img style="height:100px;width:200px;" src="images/wxpublic/ticket36.png">
			<div style="margin-top:2%;color:#F8B974;">��ϲ���ͣ����${bonus_money}Ԫ����������������ȡ</div>
		</div>
		<div class="hide sharebutton">
			<input type="button" class="share" onClick="share()" value="ȥ����">
		</div>
	</div>
</div>
<script type="text/javascript">
	var addmoney = "${addmoney}";
	addmoney = parseFloat(addmoney);
	if(addmoney > 0){
		$(".back").removeClass("hide");
	}
</script>
<script type="text/javascript">
	var bonus_type = "${bonus_type}";
	var bonusid = "${bonusid}";//���id
	var bonus_money = "${bonus_money}";
	var first_flag = "${first_flag}";
	var bonus_bnum = "${bonus_bnum}";
	var link = "http://s.tingchebao.com/zld/carowner.do?action=getobonus&id=${bonusid}";
	var imgUrl = "http://s.tingchebao.com/zld/images/bonus/order_bonu.png";
	var desc = "${desc}";
	var title = "${title}";
	if(first_flag == "1"){
		title = "ͣ�������˴����";
		imgUrl = "http://s.tingchebao.com/zld/images/wxpublic/first.png";
		desc = "����ͣ�������û������"+bonus_money+"Ԫ��������������"+bonus_bnum+"��С��飬�ֿ��У�������";
	}
	if(bonus_type == "1"){
		link = "http://s.tingchebao.com/zld/carinter.do?action=getwxbonus&id=${bonusid}";
		imgUrl = "http://s.tingchebao.com/zld/images/bonus/wx_order_bonu.png";
		desc = "΢��֧��"+bonus_money+"�����";
	}
	wx.ready(function() {
		function sharetofriend(){
			wx.onMenuShareAppMessage({
			    title: title, // �������
			    desc: desc, // ��������
			    link: link, // ��������
			    imgUrl: imgUrl, // ����ͼ��
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
			    title: title, // �������
			    link: link, // ��������
			    imgUrl: imgUrl, // ����ͼ��
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
		
		if(bonusid != "-1"){
			if(bonus_type == "1"){
				if(bonus_money == "5"){
					$(".wxticket5").removeClass("hide");
				}else if(bonus_money == "3"){
					$(".wxticket3").removeClass("hide");
				}
			}else{
				if(first_flag == "1"){
					$(".first_ticket").removeClass("hide");
				}else{
					$(".tcbticket").removeClass("hide");
				}
			}
			
			$(".sharebutton").removeClass("hide");
			sharetofriend();
			sharetocircle();
		}
	});
</script>
</body>
</html>

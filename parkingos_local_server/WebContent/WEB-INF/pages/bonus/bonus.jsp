<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0"/>
	<title>���ٶ�ҳ���ͨ�õ�ͣ��ȯ��duang~</title>
	<script type="text/javascript" src="mobileRes/iscroll-lite.js"></script>
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
		.phonenumber{
			margin:22px auto 0px auto;
			width: 240px;
			text-align:center;
		}
		
		.phonenumber input{
			width: 160px;
			min-height: 30px;
			background:#fff;
			border:1px solid #ccc;
			border-right:none;
			border-radius: 5px;
		}
		.bt{
			margin:8px auto 0px auto;
			width: 240px;
			text-align:center;
		}
		.bt button{
			width: 163px;
			min-height: 33px;
			color:#D28D43;
			font-weight:700;
			font-size:16px;
			background:#F5E758;
			border:1px solid #F9F188;
			border-right:none;
			border-radius: 5px;
		}
	</style>
</head>
<body >
<div style='display:none'><img src="http://s.tingchebao.com/zld/images/bonus/weixilogo_300.png"/></div>
	<div class="logo"></div>
	<div class="cloud"></div>
	<div class="redmail" id="inputdiv">
		<div class="word" id='pword'>�����ֻ��ţ�����Զ������˻�</div>
		<div class="phonenumber" ><input id="phonenumber" type="tel" onclick='movepage()'/></div>
		<div class="bt"><button onclick="sub()">�򿪿���</button></div>
	</div>
	<form action="carowner.do?action=${action}&id=${id}" id ="subform" method="post">
		<input type='hidden' id ="mobile" name="mobile"/>
		<input type='hidden' id ="uid" name="uid" value="${uid }"/>
		<input type='hidden' id ="rand" name="rand"/>
	</form>
</body>
<script  language="javascript">
	function sub(){
		//var url = "carowner.do?action=${action}&id=${id}&mobile=";
		var phone = document.getElementById("phonenumber").value||"���������";
		//�����ж����ֻ�����
		document.getElementById("mobile").value=phone;
		document.getElementById("rand").value=Math.random()+"&action=${action}&id=${id}";
		document.getElementById("subform").submit();
		//location = url+phone+"&r="+Math.random();
	}
	var type = '${type}';
	if(type=='-4'){//���벻�Ϸ�
		document.getElementById("pword").innerHTML='�ֻ��Ų��Ϸ�!���������룡';
		document.getElementById("phonenumber").value='${mobile}';
		document.getElementById("phonenumber").select();
	}
	function movepage(){
		setTimeout(function(){document.getElementById("inputdiv").scrollIntoView()},500);
	}

</script>
<script>
var imgUrl = 'http://s.tingchebao.com/zld/images/bonus/weixilogo_300.png';  // �����չʾ��һ��ͼƬ        
var lineLink = 'http://s.tingchebao.com/zld/carowner.do?action=${action}&id=${id}'; // ����������ת��ҳ���ַ             
var descContent = 'ͣ��û���գ�����ͣ�����������ҳ�λ��һ�������ѣ����������գ�';  // ������������Ϣ      
var shareTitle = '���ٶ�ҳ���ͨ�õ�ͣ��ȯ��duang~';  // �����ı���       
var appid = '';  // Ӧ��id,����п����û�о�����                
function shareFriend() {            
	WeixinJSBridge.invoke('sendAppMessage',{                
		"appid": appid,                
		"img_url": imgUrl,                
		"img_width": "200",                
		"img_height": "200",                
		"link": lineLink,                
		"desc": descContent,                
		"title": shareTitle            
		}, 
		function(res) {                //_report('send_msg', res.err_msg);  // ���ǻص�����������ע�͵�          
		})       
		}        
		function shareTimeline() {            
			WeixinJSBridge.invoke('shareTimeline',{                
				"img_url": imgUrl,               
				"img_width": "200",                
				"img_height": "200",                
				"link": lineLink,                
				"desc": descContent,                
				"title": shareTitle            
				}, function(res) {                   //_report('timeline', res.err_msg); // ���ǻص�����������ע�͵�            
				});        
			}        
		function shareWeibo() {            
			WeixinJSBridge.invoke('shareWeibo',{                
				"content": descContent,                
				"url": lineLink,            
				}, function(res) {                //_report('weibo', res.err_msg);            
				});        
		}       
			// ��΢���������������ڲ���ʼ����ᴥ��WeixinJSBridgeReady�¼���        
	document.addEventListener('WeixinJSBridgeReady', 
		function onBridgeReady() {           
			// ���͸�����            
			WeixinJSBridge.on('menu:share:appmessage', 
				function(argv){                
			shareFriend();            
			});            
			// ��������Ȧ            
			WeixinJSBridge.on('menu:share:timeline', function(argv){
				shareTimeline();            
				});           
			// ����΢��          
			WeixinJSBridge.on('menu:share:weibo', function(argv){ 
					shareWeibo();            
				});        
		}, 	false);
</script>
</html>

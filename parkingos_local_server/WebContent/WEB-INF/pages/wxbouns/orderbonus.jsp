<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0"/>
	<title>����${carnumber}�����</title>
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
		    background-image: url(images/bonus/wx_bonus_bg.jpg);
		    background-repeat:no-repeat;
		}
		.cloud{
			width:80px;
			height:80px;
			margin:0px auto;
			margin-top:60px;
			background-size: 100% 100%;
			background-position:top center;
		    background-color:none;
		    background-image: url(images/bonus/ob_logo.png);
		    background-repeat:no-repeat;
		}
		.word{
			margin:0px auto;
			font-weight:500;
			font-size:18px;
			width:300px;
			text-align:center;
			padding-top:10px;
		}
		.wword{
			color:#cea86a;
			margin:0px auto;
			font-weight:500;
			font-size:20px;
			font-family:"�п�  ���� ΢���ź�";
			width:300px;
			text-align:center;
		}
		.kword{
			margin:0px auto;
			margin-top:50px;
			font-size:15px;
			width:300px;
			text-align:center;
		}
		.redmail{
			width:100px;
			height:100px;
			margin:10px auto;
			background-size: 100% 100%;
			background-position:bottom center;
		    background-color:none;
		    background-image: url(images/bonus/wx_qiang.png);
		    background-repeat:no-repeat;
		}
	</style>
</head>
<body>
<div id='wx_pic' style='margin:0 auto;display:none;'>
<img src='images/bonus/order_bonu.png' />
</div>
	<div class="cloud"></div>
	<div class="word">΢�ų���${carnumber}</div>
	<div style='margin:10px auto;text-align:center'><font size='2' color='#333333'>����һ�ͣ��${bonus_money}��ȯ���ֿ��У�������</font></br></div>
	<div class="wword"><span id='bwords'>ͣ����΢��֧��ר��</span></div>
	<div class="redmail" onclick="getbons()" id='caipic'></div>
	<div class="kword" onclick="viewbonus()">������ҵ�����></div>
	<form action="carinter.do?action=getwxbonus&id=${id}" id ="subform" method="post">
		<input type='hidden' id ="operate" name="operate"/>
	</form>
</body>
<script language="javascript">
var isover = '${isover}';
if(isover=='0'){
	document.getElementById("bwords").innerHTML='<br/>�����ˣ���������ˣ�<br/><br/><br/><br/><br/>';
	document.getElementById("bwords").style.fontSize='20px';
	document.getElementById("caipic").style.display='none';
}
function viewbonus(){//�鿴�������
	document.getElementById("operate").value="caibonuslist";
	document.getElementById("subform").submit();
	//location.href ='carowner.do?action=obonuslist&bid=${bid}&uin=${uin}&totalmoney=${totalmoney}&bnum=${bnum}';
};
function getbons(){//�����
	location ="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx08c66cac888faa2a&redirect_uri=http%3A%2F%2Fs.tingchebao.com%2Fzld%2Fcarinter.do%3Faction%3Dgetwxbonus%26id%3D${id}%26operate%3Dcaibonus&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
	//location ="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx7cc6fd2efd5144e3&redirect_uri=http%3A%2F%2Fyxiudongyeahnet.vicp.cc%2Fzld%2Fcarinter.do%3Faction%3Dgetwxbonus%26id%3D${id}%26operate%3Dcaibonus&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
};
</script >

</html>

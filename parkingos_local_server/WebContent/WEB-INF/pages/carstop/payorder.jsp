<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<title>֧������</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<script src="js/tq.js?0817" type="text/javascript">//���</script>

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
		}
.content{
		width:100%;
		font-family:"΢���ź�", sans-serif, Arial, Verdana;
		font-size:15px;
		line-height:40px;
		height:100%;
		background-color:#F5F5F5;
		}
.statebackg{
		height:10%;
};
</style>
</head>
<body>

<div id="content" class="content" >
	<div id='d1'>
		<div class='statebackg'><div style='height:10px;color:#9C9A9B;'></div><span style='margin-top:15px;margin-left:18px;font-size:16px;color:#9C9A9B;' valgin='center'><b>����״̬ ���ȴ�֧��</b></span></div>
		<div style='height:1px;background-color:#E6E6E6;'></div>
		<div style="height:40%; text-align: center; font-weight:700; background-color: rgb(245, 245, 245);"> <br/>������<br/><font style="font-size:35px;">��${total}</font><br/>&nbsp;</div>
		<div style='height:10%;background-color:#FFFFFF;color:#9C9A9B;' ><div style='height:8px'></div>&nbsp;&nbsp;&nbsp;<b>��ʼʱ�䣺&nbsp;&nbsp;&nbsp;&nbsp;${btime}</b></div>
		<div style='height:1px;background-color:#E6E6E6;'></div>
		<div style='height:10%;background-color:#FFFFFF;color:#9C9A9B;' ><div style='height:8px'></div>&nbsp;&nbsp;&nbsp;<b>����ʱ�䣺&nbsp;&nbsp;&nbsp;&nbsp;${etime}</b></div>
		<div ><div style='width:97%;height:40px;margin:40px auto;text-align:center;background-color:green;color:#FFFFFF;font-size:15px;' id='abutton' onclick="prepay()">ͣ����֧��</div></div>
	</div>
	<div id='d2' style='display:none'>
		<div class='statebackg'><div style='height:10px;color:#9C9A9B;'></div><span style='margin-top:15px;margin-left:20px;font-size:16px;color:#9C9A9B;' valgin='center'><b>����״̬ ���ȴ�֧��</b></span></div>
		<div style='height:1px;background-color:#E6E6E6;'></div>
		<div style="height:35%; text-align: center; font-weight:700; background-color: rgb(245, 245, 245);"> <br/>������<br/><font style="font-size: 35px;">��${total}</font><br/>&nbsp;</div>
		<div style='height:10%;background-color:#FFFFFF;color:#9C9A9B;'><div style='height:8px'></div>&nbsp;&nbsp;&nbsp;ͣ���Ż�ȯ����${ticket}</div>
		<div style='height:1px;background-color:#E6E6E6;'></div>
		<div style='height:10%;background-color:#FFFFFF;color:#9C9A9B;'><div style='height:8px'></div>&nbsp;&nbsp;&nbsp;���֧������<span id="balance"></span></div>
		<div style='height:1px;background-color:#E6E6E6;'></div>
		<div style='height:10%;background-color:#FFFFFF;color:green;font-size:22px;' ><div style='height:8px'></div>&nbsp;&nbsp;&nbsp;ʵ�����<span id="paymoney"></span></div>
		<div ><div style='width:97%;height:40px;border:1px solid #000000;margin:40px auto;text-align:center;background-color:green;color:#FFFFFF;font-size:15px;' id='pbutton' onclick="paytieckt(1)">ȥ����</div></div>
	</div>
</div>
</body>
<script type="text/javascript">
var getobj=function(id){return document.getElementById(id)};
var total = ${total};//�ܽ��
var ticket= ${ticket};//�Ż�ȯ

if(total<ticket)
  ticket=total;
var paytotal = total-ticket;//Ӧ�����
var balance = ${balance};
//alert("total:"+total+",ticket:"+ticket+",paytotal:"+paytotal+",balance:"+balance);
function prepay(){
	if(balance+ticket>=total){
		getobj('d1').style.display='none';
		getobj('balance').innerText = total-ticket;
		getobj('d2').style.display='';
		getobj('paymoney').innerText =total-ticket;
	}
}
function paytieckt(type){
	//alert(type);
	if(type==1||type==0){
		//alert(type);
		location='attendant.do?action=topay&id=${id}&uin=${uin}&uid=${uid}&ptype='+type+'&total='+total+'&ticketid=${ticketid}&ticket_money='+ticket;
	}
	else 
		location='attendant.do?action=weixinpay&id=${id}&uin=${uin}&uid=${uid}&ptype='+type+'&total='+total+'&ticketid=${ticketid}&ticket_money='+ticket;

}

if(balance+ticket<total){
	getobj('abutton').innerHTML="<div onclick='paytieckt(0)' style='width:40%;float:left;text-align:center;background-color:#FDFAFB;color:#C2C0C1'><b>�ֽ�֧��</b></div><div style='width:5%;float:left;background-color:#F5F5F5;'>&nbsp;&nbsp;</div><div onclick='paytieckt(2)' style='width:55%;float:left;text-align:center'>΢��֧��</div>";
	getobj('abutton').onclick=function(){};
}
</script>
</html>

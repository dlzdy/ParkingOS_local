<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>ͣ����</title>
<script type="text/javascript">
	var ua = navigator.userAgent.toLowerCase();
	if (ua.match(/MicroMessenger/i) != "micromessenger"){
		window.location.href = "http://s.tingchebao.com/zld/error.html";
	}
</script>
<style type="text/css">
.body {
	background: #F0F0F0;
}

.carnumber {
	width: 100%;
	height: 38px;
	text-indent: 10px;
	font-size: 15px;
	border: 1px solid #F0F0F0;
	margin-top: 5px;
}

.code {
	width: 70%;
	height: 38px;
	text-indent: 10px;
	font-size: 15px;
	border: 1px solid #F0F0F0;
	margin-top: 5px;
	margin-top: 5px;
}

.colsubmit {
	width: 99%;
	height: 41px;
	border: 1px solid #F0F0F0;
	margin-top: 50px;
	background-color: #00B75E;
	color: white;
	font-size: 15px;
	
	-webkit-border-bottom-left-radius: 8px;
	border-bottom-left-radius: 8px;
	-webkit-border-bottom-right-radius: 8px;
	border-bottom-right-radius: 8px;
	border-top: 0;
	-webkit-border-top-left-radius: 8px;
	border-top-left-radius: 8px;
	-webkit-border-top-right-radius: 8px;
	border-top-right-radius: 8px;
}

.error {
	color: red;
	font-size: 15px;
}

.info {
	display: none;
}

.toptitle {
	color: #666;
	font-size: 20px;
}
</style>
<script src="js/jquery.js" type="text/javascript">//���</script>
<script type="text/javascript">
var topage ='${topage}';
function check(){
	var car_number = document.getElementById("carnumber").value;
	car_number = car_number.toUpperCase();
	var city = car_number.charAt(0);
	var array = new Array( "��", "��", "��", "��", "��", "³",
				"��", "��", "ԥ", "��", "��", "��", "��", "��", "��", "��", "��", "��",
				"��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��",
				"��", "��", "��", "ʹ", "��", "��", "��", "��", "��", "��","��", "��", "��", "��", "WJ", "��", "��", "��","ˮ", "��", "��", "ͨ" );  
	var m = /^[A-Z]{1}[A-Z_0-9]{5}$/;
	car_number_char = car_number.substr(1);
	if(array.toString().indexOf(city) > -1){
		if(city == "ʹ"){
			m = /^[A-Z_0-9]{6}$/;
		}
		if(!car_number_char.match(m)){
			document.getElementById("error").innerHTML = "���ƺŲ���ȷ";
			return false;
		}
	}else{
		document.getElementById("error").innerHTML = "���ƺŲ���ȷ";
		return false;
	}
	car_number = encodeURI(car_number);
	var mobile = document.getElementById("mobile").value;
 	jQuery.ajax({
			type:"post",
			url:"carlogin.do",
			data:{'action':'addcar','mobile':mobile,'carnumber':car_number},
		    async:false,
		    success:function(result){
				if(result == -9){
					document.getElementById("error").innerHTML = "�ó��ƺ��ѱ�ע��<br>�ڹ��ں��ڵ������ϵ�ͷ������";
				}else if(result != 3){
						document.getElementById("error").innerHTML = "�󶨳���ʧ��";
				}else{
					if(topage=='wantstop'){
						location = 'attendant.do?action=wantstop&openid=${openid}';
					}else
						$("#carnumberform")[0].submit();
				}
		      }
		}); 
} 

$(function () {
	$("#colsubmit").bind("click", function (){
		check();
	})
}) 
</script>
</head>
<body style="background-color:#F0F0F0;">
<div style="width:99%;">
	<div style="text-align:center;margin-top:20px;"><b class='toptitle'>����İ���</b></div>
	<div style="margin-top: 20px;">
		<form action="${action}" method="post" id="carnumberform">
			<input type="text" name="openid" class="info" value="${openid}">
			<input type="text" id="mobile" name="mobile" class="info" value="${mobile}">
			<input type="text" placeholder="�����복�ƺ�" id="carnumber" name="carnumber" maxlength="7" class="carnumber">
			<div style="text-align:center;">
				<input type="button" id="colsubmit" value="���" class="colsubmit">
			</div>
		</form>
	</div>
	<div style="text-align:center;margin-top:20px;">
		<span id="error" class="error"></span>
	</div>
</div>
</body>
</html>

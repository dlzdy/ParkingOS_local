<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<title>��ǰ����</title>
<script type="text/javascript">
	var ua = navigator.userAgent.toLowerCase();
	if (ua.match(/MicroMessenger/i) != "micromessenger"){
		window.location.href = "http://s.tingchebao.com/zld/error.html";
	}
</script>
<script src="js/jquery.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/prepay.css?v=2">
<style type="text/css">
.error {
	color: red;
	font-size: 15px;
	margin-top:5%;
}
.noorder{
	text-align:center;
	color:red;
	margin-top:55%;
}
.wx_pay{
	border-radius:5px;
	width:96%;
	margin-left:2%;
	height:40px;
	margin-top:5%;
	font-size:15px;
	background-color:#04BE02;
	color:white;
}
</style>
 <style type="text/css">
<!--
ul{ margin:0; padding:0; list-style-type:none;} 
ul#navlist{font:12px verdana;padding-bottom: 13px;}
ul#navlist li span{ background: #FBFBFB;}
ul#navlist li{float: left; height: 30px; border: 0px solid red; width: 100%;}
ul#navlist .list1{border-bottom: 1px solid red;width: 100%;margin-bottom: -15px;}
#navlist a{display: block;color: red;text-decoration: none;padding: 8px 5px;width: 100%;text-align: center;}
-->
</style>
<script type="text/javascript">
			//ÿ�����һ��class
			function addClass(currNode, newClass){
		        var oldClass;
		        oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
		        if(oldClass !== null) {
				   newClass = oldClass+" "+newClass; 
				}
				currNode.className = newClass; //IE ��FF��֧��
    		}
			
			//ÿ���Ƴ�һ��class
			function removeClass(currNode, curClass){
				var oldClass,newClass1 = "";
		        oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
		        if(oldClass !== null) {
				   oldClass = oldClass.split(" ");
				   for(var i=0;i<oldClass.length;i++){
					   if(oldClass[i] != curClass){
						   if(newClass1 == ""){
							   newClass1 += oldClass[i]
						   }else{
							   newClass1 += " " + oldClass[i];
						   }
					   }
				   }
				}
				currNode.className = newClass1; //IE ��FF��֧��
			}
			
			//����Ƿ������ǰclass
			function hasClass(currNode, curClass){
				var oldClass;
				oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
				if(oldClass !== null){
					oldClass = oldClass.split(" ");
					for(var i=0;i<oldClass.length;i++){
					   if(oldClass[i] == curClass){
						   return true;
					   }
				   }
				}
				return false;
			}
</script>
</head>
<body>
	<!-- �ҵĳ���[[ -->
		<dl class="my-lpn hide">
			<dt class="title">�ҵĳ��ƺ���</dt>
			<dd class="lpn">${car_number}<a class="change-btn" href="wxpfast.do?action=sweepcom&comid=${comid}&openid=${openid}&bind_flag=${bind_flag}&change=1">�޸�</a></dd>
		</dl>
		<!-- �ҵĳ���]] -->
	<section class="main">
		
		<form method="post" action="wxpfast.do?action=beginprepay" role="form" id="prepayform" class="confirm">
			<fieldset>
			<div class="info-area">	
				<dl class="totle" style="border-bottom:0px">
					<dt class="totle-title">Ԥ��ͣ����</dt>
					<dd class="totle-num" style="color:#04BE02;">��<span id="ttotal">${total}</span></dd>
					<ul class="nfc" id="navlist">
						<li class="list1"></li>
						<li class="list2"><a href=""><span>Ԥ����ɺ��ٽ������շ�Ա���㣬���ۿ�</span></a></li>
					</ul>
					<div class="nonfc hide" style="border-bottom: 1px solid #E0E0E0;"></div>
				</dl>
				
				<ul class="info-list" style="padding-top:1px;">
					<li class="list prepay hide"><span class="list-title">��Ԥ�����</span><span class="list-content">${pretotal}Ԫ</span></li>
					<li class="list"><span class="list-title">��ͣʱ��</span><span class="list-content">${parktime}</span></li>
					<li class="list"><span class="list-title">�볡ʱ��</span><span class="list-content">${start_time}</span></li>
					<li class="list"><span class="list-title car_number hide">���ƺ���</span><span class="list-content">${car_number}</span></li>
				</ul>
				
				<ul class="info-list hide">
					<li class="list"><input id="openid" name="openid" value="${openid}" /></li>
					<li class="list"><input id="ntime" name="ntime" value="${ntime}" /></li>
					<li class="list"><input id="orderid" name="orderid" value="${orderid}"></li>
					<li class="list"><input type="text" id="total" name="total" value="${total}"></li>
					<li class="list"><input type="text" name="uid" value="${uid}"></li>
				</ul>
			</div>
			<div class="leave" style="text-align:center;margin-top:20px;">
				���뵽���ڽɷѻ��У�<select name="leaving_time"
					style="width:95px;height:25px;padding-top:3px;font-size:17px;padding-left:6px;color:#04BE02;"
					id="leaving_time">
					<option value="0">0����</option>
					<option value="5">5����</option>
					<option value="10">10����</option>
					<option selected="selected" value="15">15����</option>
					<option value="30">30����</option>
					<option value="60">1Сʱ</option>
					<option value="120">2Сʱ</option>
					<option value="240">4Сʱ</option>
					<option value="360">6Сʱ</option>
					<option value="480">8Сʱ</option>
					<option value="600">10Сʱ</option>
					<option value="720">12Сʱ</option>
				</select>
			</div>
			<%--
			<a href="#" id="wx_pay" onclick='payorder();' class="btn btn-green">ȷ��</a>
			--%>
			<input type="button" id="wx_pay" onclick='payorder();' class="wx_pay" value="ȥԤ��">
			<div class="tips"></div>
			</fieldset>
		</form>
		<div style="text-align:center;" id="error" class="error"></div>
		<div class="wxpay-logo"></div>
	</section>
	<section class="noorder hide">
		<div>��ǰ�޶���</div>
	</section>
</body>
<script type="text/javascript">

function getprice(){
	var leaving_time = document.getElementById("leaving_time").value;
//	alert("ticketid="+ticketid);
//	alert("������"+orderid+",ntime:"+ntime+",Ԥ��"+leaving_time+"����֮���뿪");
	jQuery.ajax({
		type : "post",
		url : "wxpfast.do",
		data : {
			'orderid' : '${orderid}',
			'ntime' : '${ntime}',
			'leaving_time' : leaving_time,
			'action' : 'getprice'
		},
		async : false,
		success : function(result) {
			if(result == "-1"){//������
				document.getElementById("error").innerHTML = "��ȡͣ����ʧ��";
			}
			var jsonData = eval("(" + result + ")");
			var total = jsonData.total;//�ܽ��

			document.getElementById("total").value = total;
			document.getElementById("ttotal").innerHTML = total;
			if(parseFloat(total) <= 0){//ͣ����0Ԫ
//				alert("Ԥ֧���������ܽ��");
				$(".wx_pay").addClass("hide");
				addClass(document.getElementById("wx_pay"),"wait");
				document.getElementById("error").innerHTML = leaving_time+"����֮���볡���";
				return false;
			}else{
				$(".wx_pay").removeClass("hide");
				removeClass(document.getElementById("wx_pay"),"wait");
				document.getElementById("error").innerHTML = "";
			}
		}
});
}
</script>
<script type="text/javascript">
	var leaving_time = document.getElementById("leaving_time").value;
	leaving_time = parseInt(leaving_time);
	document.getElementById("leaving_time").value = 15;
	if(leaving_time != 15){//ҳ�淵��ʱ���»�ȡ15���ӵļ۸�
		getprice();
	}
</script>
<script type="text/javascript">
	var orderid = "${orderid}";
	if(orderid == "-1"){
		$(".main").addClass("hide");
		$(".noorder").removeClass("hide");
	}
	$("#leaving_time").bind("change", function(){
		getprice();
	});
</script>
<script type="text/javascript">
	var type="${type}";
	var bind_flag = "${bind_flag}";
	var car_number="${car_number}";
	var total = "${total}";
	var pre_state = "${pre_state}";
	var sweepcom_flag = "${sweepcom_flag}";
	var addtype = "${addtype}";
	if(sweepcom_flag == "1" && bind_flag == "0" || addtype == "1"){
		$(".my-lpn").removeClass("hide");
		$(".nfc").addClass("hide");
		$(".nonfc").removeClass("hide");
	}
	if(pre_state == "1"){
		addClass(document.getElementById("wx_pay"),"wait");
		$(".wx_pay").addClass("hide");
		$(".leave").addClass("hide");
		$(".prepay").removeClass("hide");
		$(".nfc").addClass("hide");
		$(".nonfc").removeClass("hide");
		document.getElementById("error").innerHTML = "����Ԥ֧�����������ٴ�Ԥ֧��";
	}
	
	if(parseFloat(total) <= 0){
		addClass(document.getElementById("wx_pay"),"wait");
		document.getElementById("error").innerHTML = "15����֮���볡���";
	}
//	alert("���ƺ�:"+car_number);
	if(car_number != ""){
		$(".car_number").removeClass("hide");
	}
	if(type != "0"){
		$(".wx_pay").addClass("hide");
		$(".leave").addClass("hide");
		addClass(document.getElementById("wx_pay"),"wait");
		document.getElementById("error").innerHTML = "�ⲻ�����Ķ���";
	}
	
	function payorder(){
		if(hasClass(document.getElementById("wx_pay"),"wait")){
			return;
		}
		addClass(document.getElementById("wx_pay"),"wait");
		$("#prepayform")[0].submit();
	}
</script>

</html>

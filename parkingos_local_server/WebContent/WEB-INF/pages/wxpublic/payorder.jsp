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
<link rel="stylesheet" href="css/prepay.css?v=1">
<style type="text/css">
.error {
	color: red;
	font-size: 15px;
	margin-top:5%;
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
.noorder{
	text-align:center;
	color:red;
	margin-top:55%;
}
</style>

</head>
<body>&nbsp; 
	<!-- �Ʒѷ�ʽ������[[ -->
	<div class="mask billing-mask hide">
		<div class="content">
			<div class="billing-title">ͣ���ѼƷѷ�ʽ</div>

			<ul class="info-list billing-list">
				<li class="list"><span class="list-title">�� 1 Сʱ�շ�</span><span class="list-content">10.00 Ԫ</span></li>
				<li class="list"><span class="list-title">���� 1 Сʱ�շ�</span><span class="list-content">1��5.00 Ԫ</span></li>
				<li class="list totle-list"><span class="list-title">�ϼ�</span><span class="list-content"><span class="green-font">15.00</span> Ԫ</span></li>
			</ul>

			<dl class="rules">
				<dt class="rules-title">�շѹ���</dt>
				<dd class="rules-main">��һ������&nbsp;8&nbsp;ʱ��&nbsp;22&nbsp;ʱ������&nbsp;8&nbsp;ʱ��&nbsp;18&nbsp;ʱ��5&nbsp;Ԫ&nbsp;/&nbsp;Сʱ ; ����&nbsp;18&nbsp;ʱ��&nbsp;22&nbsp;ʱ���������ռ��ڼ���&nbsp;8&nbsp;ʱ��&nbsp;22ʱ��10&nbsp;Ԫ&nbsp;/&nbsp;Сʱ; ȫ��&nbsp;22&nbsp;ʱ������&nbsp;8&nbsp;ʱ��4&nbsp;Ԫ&nbsp;/&nbsp;Сʱ������޼�&nbsp;10&nbsp;Ԫ; 24&nbsp;Сʱ����޼�&nbsp;80&nbsp;Ԫ&nbsp;/&nbsp;�졣</dd>
			</dl>

			<a href="#" class="btn btn-white close-btn">��&nbsp;&nbsp;��</a>
		</div>
		
	</div>
	<!-- �Ʒѷ�ʽ������]] -->

	<section class="main" id="orderinfo" style="margin-top:-20px;">
		<form method="post" action="wxpfast.do?action=beginprepay" role="form" id="prepayform" class="confirm">
			<fieldset>
			<div class="info-area">	
				<dl class="totle">
					<dt class="totle-title">ͣ����</dt>
					<dd class="totle-num">��${total}</dd>
				</dl>
				<ul class="info-list">
					<li class="list"><span class="list-title">��ͣʱ��</span><span class="list-content">${parktime}</span></li>
					<li class="list"><span class="list-title">�볡ʱ��</span><span class="list-content">${start_time}</span></li>
					<li class="list"><span class="list-title car_number hide">���ƺ���</span><span class="list-content">${car_number}</span></li>
				</ul>
				
				<ul class="info-list hide">
					<li class="list"><input id="openid" name="openid" value="${openid}" /></li>
					<li class="list"><input id="orderid" name="orderid" value="${orderid}"></li>
					<li class="list"><input type="text" id="total" name="total" value="${total}"></li>
					<li class="list"><input type="text" name="uid" value="${uid}"></li>
					<li class="list"><input type="text" id="paytype" name="paytype" value="1"></li>
				</ul>
			</div>
			<input type="button" id="wx_pay" class="wx_pay" value="֧��">
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
//	alert("������");
	var orderid= "${orderid}";
	var bind_flag = "${bind_flag}";
	var car_number="${car_number}";
	var total = "${total}";
//	alert("���ƺ�:"+car_number);
	if(orderid == "-1"){
		$(".main").addClass("hide");
		$(".noorder").removeClass("hide");
	}
	if(car_number != ""){
		$(".car_number").removeClass("hide");
	}
	$(".wx_pay").bind("click", function(){
		if(hasClass(document.getElementById("wx_pay"),"wait")){
			return;
		}
		addClass(document.getElementById("wx_pay"),"wait");
		$("#prepayform")[0].submit();
	});
</script>
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
</html>

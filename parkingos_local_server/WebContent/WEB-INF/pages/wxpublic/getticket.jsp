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
<title>��ȡͣ��ȯ</title>
<script type="text/javascript">
	var ua = navigator.userAgent.toLowerCase();
	if (ua.match(/MicroMessenger/i) != "micromessenger"){
		window.location.href = "http://s.tingchebao.com/zld/error.html";
	}
</script>
<script src="js/jquery.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/prepay.css?v=3">
<style type="text/css">
.error {
	color: red;
	font-size: 15px;
	margin-top:5%;
}
.info{
	display:none;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    -webkit-appearance: none;
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

.wx_public{
	border-radius:5px;
	width:96%;
	margin-left:2%;
	height:40px;
	margin-top:3%;
	font-size:15px;
	background-color:white;
}
.noorder{
	text-align:center;
	color:red;
	margin-top:55%;
}
</style>
</head>
<body>
	<div class="ticketpics" style="margin-left:5%;margin-top: 20px;">
		<div>
			<img src="images/wxpublic/ticket_limit.png" style="width:80px;height:80px;"/>
			<span style="line-height:45px;">�ɹ���ȡ${nickname}(${uid})�ĳ���ר��ȯ</span>
		</div>
	</div>
	
	<section class="main">
		<form method="post" action="" role="form" class="form lpn-form" id="payform">
			<fieldset>
				<div class="input-area">
					<dl class="form-line">
						<dt class="label">ר��ȯ��</dt>
						<dd class="element lpn-element">
							<span class="arrow-down"><!-- ͼ�� --></span>

							<input readOnly="true" class="text" style="color:#04BE02;" type="text"  value="${ticket_money}Ԫ">
						</dd>
					</dl>
					
					<dl class="form-line">
						<dt class="label">��ʹ��ͣ������</dt>
						<dd class="element lpn-element">
							<span class="arrow-down"><!-- ͼ�� --></span>

							<input readOnly="true" class="text" style="color:#04BE02;" type="text" value="${cname}">
						</dd>
					</dl>
				</div>
				<input type="button" class="wx_pay" onclick='check("t");' value="����ȯ����" />
				<input type="button" class="wx_public" onclick='check("p");' value="���빫�ں�" />
			</fieldset>
		</form>
		<div style="text-align:center;" id="error" class="error"></div>
	</section>
	<section class="noorder hide">
		<div>�ö�ά����ʧЧ</div>
	</section>
	<script type="text/javascript">
		var codeflag = "${codeflag}";//�Ƿ���˻�
		if(codeflag == "1"){
			$(".main").addClass("hide");
			$(".ticketpics").addClass("hide");
			$(".noorder").removeClass("hide");
		}
		
		function check(target){
			if(target == "t"){
				window.open("${url}");
			}else if(target == "p"){
				window.open("http://mp.weixin.qq.com/s?__biz=MzA4MTAxMzA2Mg==&mid=205938292&idx=1&sn=76c6259270d762df187a187fac9e9a8d#wechat_redirect");
			}
		}
	</script>
</body>
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

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>����${nickname}(���:${uid})</title>
<script type="text/javascript"> 
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) != "micromessenger"){
			window.location.href = "http://s.tingchebao.com/zld/error.html";
		}
	</script>
<link rel="stylesheet" type="text/css" href="css/jquery.mobile-1.3.2.min.css?v=1" />
<link rel="stylesheet" type="text/css" href="css/list.css?v=12" />
<script src="js/jquery.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<style type="text/css">
#scroller li {
    padding:0 10px;
    height:45px;
    line-height:45px;
    background-color:white;
    font-size:14px;
    margin-top:0px;
}
</style>

<style type="text/css">
.money{
	margin-left:10px;
	border-width:0;
	font-size:16px;
}

.wx_pay{
	border-radius:3px;
	width:98%;
	margin-left:1%;
	height:40px;
	margin-top:32px;
	font-size:15px;
	background-color:#38B074;
	color:white;
	border: 1px solid #F0F0F0;
}

.hide{
	display:none;
}

.error {
	color: red;
	font-size: 15px;
	margin-top:0px;
}

.wxpay-logo {
	content: "";
	background: url(images/wxpublic/wxpay_logo.png) no-repeat;
	width: 71px;
	height: 19px;
	display: inline-block;
	-webkit-background-size: 71px 19px;
	background-size: 71px 19px;
	-moz-transform: translateX(-50%);
	-webkit-transform: translateX(-50%);
	-ms-transform: translateX(-50%);
	transform: translateX(-50%);
	margin: 20px 0 20px 50%;
}
</style>
<style type="text/css">
	.unselected{
		border:1px solid #38B074;
		color : #38B074;
	}
	.sel_total{
		font-size:20px;
		text-align:center;
		padding-top:5px;
		padding-bottom:5px;
		border-radius:2px;
		background-color:#FFFFFF;
		outline:medium;
		padding-left:22px;
		padding-right:22px;
	}
	.selected{
		border:1px solid #38B074;
		background-color:#38B074;
		color:white;
	}
	
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button {
    	-webkit-appearance: none;
	}
	
	.company_name{
		text-decoration:none;
		color:#6D6D6D;
		font-size:16px;
	}
	.noorder1{
		text-align:center;
		color:red;
		margin-top:55%;
		font-size:16px;
	}
	.noorder2{
		text-align:center;
		color:red;
		margin-top:55%;
		font-size:16px;
	}
</style>
</head>
<body style="background-color:#EEEEEE;">
<div id="wrapper" style="margin-top:-45px;">
<form method="post" role="form" action="wxpfast.do?action=reward" id="payform">
	<div id="scroller">
		<ul id="thelist">
			<li style="margin-top:32px;"><div class="company_name">
					<span>���ͽ��</span><input type="number" id="total" class="money" name="total" value="3" />
				</div>
			</li>
			<div style="margin-top:32px;">
				<span class="sel_total unselected">1</span><span
					class="sel_total unselected">2</span><span
					class="sel_total selected">3</span><span
					class="sel_total unselected">4</span>
			</div>
			<div style="display:none;">
				<input type="text" name="openid" value="${openid}" />
				<input type="text" name="uid" value="${uid}" />
				<input type="text" name="orderid" value="${orderid}" />
			</div>
			<input type="button" id="paysubmit" class="wx_pay"
				onclick='check();' value="ȥ����" />
			<div class="wxpay-logo"></div>
			<div style="text-align:center;" id="error" class="error"></div>
		</ul>
	</div>
</form>
</div>
<section class="noorder1 hide">
		<div>�ö����Ѵ���</div>
	</section>
	<section class="noorder2 hide">
		<div>ÿ��ֻ�ܶ�ͬһ�շ�Ա����һ��</div>
</section>
<script type="text/javascript">
	var reward_flag = "${reward_flag}";
	if(reward_flag == "1"){
		$("#wrapper").addClass("hide");
		$(".noorder1").removeClass("hide");
	}else if(reward_flag == "2"){
		$("#wrapper").addClass("hide");
		$(".noorder2").removeClass("hide");
	}
	//��ҳ�������
	var width = $(window).width();
	var w = Math.round((width - 56*4)/5);
	var objs = $(".sel_total");
	for(var i=0;i<objs.length;i++){
		var obj = objs[i];
		obj.style.marginLeft = w + "px";
	}
	
	//ѡ����
	$(".sel_total").bind("click", function(){
		var total=this.innerHTML;
		for(var i=0;i<objs.length;i++){
			var obj = objs[i];
			removeClass(obj,"selected");
			addClass(obj,"unselected");
		}
		removeClass(this,"unselected");
		addClass(this,"selected");
		
		document.getElementById("total").value = total;
	})
</script>
<script type="text/javascript">
	$("#total").keydown(function (e) {
            numberformat(this);
        });
	
	function check(){
		var total = document.getElementById("total").value;
		if(total == "" || parseFloat(total) <=0){
			document.getElementById("error").innerHTML = "��������ȷ���";
			return;
		}
		$("#payform")[0].submit();
	}
	    
	function numberformat(domInput) {
	    $(domInput).css("ime-mode", "disabled");
	    $(domInput).bind("keypress", function (e) {
	        var code = (e.keyCode ? e.keyCode : e.which);  //���ݻ�� IE   
	        if (!$.browser.msie && (e.keyCode == 0x8))  //����� ����ʹ���˸��  
	        {
	            return;
	        }
	        return code >= 48 && code <= 57 || code == 46;
	    });
	    $(domInput).bind("blur", function () {
	        if (this.value.lastIndexOf(".") == (this.value.length - 1)) {
	            this.value = this.value.substr(0, this.value.length - 1);
	        } else if (isNaN(this.value)) {
	            this.value = " ";
	        }
	    });
	    $(domInput).bind("paste", function () {
	        var s = clipboardData.getData('text');
	        if (!/\D/.test(s));
	        value = s.replace(/^0*/, '');
	        return false;
	    });
	    $(domInput).bind("dragenter", function () {
	        return false;
	    });
	    $(domInput).bind("keyup", function () {
	        this.value = this.value.replace(/[^\d.]/g, "");
	        //���뱣֤��һ��Ϊ���ֶ�����.
	        this.value = this.value.replace(/^\./g, "");
	        //��ֻ֤�г���һ��.��û�ж��.
	        this.value = this.value.replace(/\.{2,}/g, ".");
	        //��֤.ֻ����һ�Σ������ܳ�����������
	        this.value = this.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
	      	//ֻ����������С��
	        this.value = this.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); 
	    });
	}
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
</body>
</html>

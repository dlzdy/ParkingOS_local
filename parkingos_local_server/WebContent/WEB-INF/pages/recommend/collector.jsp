<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>ע��ɹ�</title>
<style type="text/css">
.fixed-bottom{
    position: fixed; bottom:10px; _top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0)-10));right:5px; 
}
      
.fixed{
    _position: absolute; _bottom: auto;
}
.download {width:70%;height:41px;margin-top:10px;background-color:#27c766;font-size:17px;color:white;}
</style>
<script src="js/jquery.js" type="text/javascript">//���</script>
<script src="js/qrcode.js" type="text/javascript">//���</script>
<script src="js/jquery.qrcode.js" type="text/javascript">//���</script>
<script type="text/javascript"> 
var pid = "${uin}";
var name = "${nickname}";
$(function () { 
	$("#div_div").qrcode(utf16to8("http://www.tingchebao.com?pid="+pid+"&name="+name)); 
}) 
function utf16to8(str) { //ת�� 
	var out, i, len, c; 
	out = ""; 
	len = str.length; 
	for (i = 0; i < len; i++) { 
		c = str.charCodeAt(i); 
		if ((c >= 0x0001) && (c <= 0x007F)) { 
			out += str.charAt(i); 
		} else if (c > 0x07FF) { 
			out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F)); 
			out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F)); 
			out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F)); 
		} else { 
			out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F)); 
			out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F)); 
		} 
	} 
	return out;
} 

window.setInterval(function(){
	jQuery.ajax({
		type:"post",
		url:"regparker.do?action=getbalance",
		data:{'uin':pid},
        async:false,
        success:function(result){
        	if(result != null && result != ""){
        		var data = eval("("+result+")");
        		//���
        		var balance = data.balance;
        		//ͣ����
        		var epaymoney = data.epaymoney;
        		//ͣ��������
        		var backmoney = data.backmoney;
        		var back = document.getElementById("backmoney");
        		//����ǰҳ����ʾ�ķ��ֽ��
        		var oldebackmoney = parseFloat(back.innerHTML);
        		//���µķ��ֽ��
    			var newebackmoney = parseFloat(backmoney);
    			var epay = document.getElementById("epaymoney");
    			//����ǰҳ����ʾ��ͣ���ѽ��
    			var oldepaymoney = parseFloat(epay.innerHTML);
    			//���µ�ͣ���ѽ��
    			var newepaymoney = parseFloat(epaymoney);
    			if(newebackmoney > oldebackmoney && newepaymoney > oldepaymoney){
    				alert("��ϲ���յ�"+(newepaymoney - oldepaymoney).toFixed(2) + "Ԫͣ����,����"+(newebackmoney - oldebackmoney).toFixed(2)+"Ԫ");
    			}else if(newepaymoney > oldepaymoney){
    				alert("��ϲ���յ�"+(newepaymoney - oldepaymoney).toFixed(2) + "Ԫͣ����");
    			}
    			document.getElementById("epaymoney").innerHTML = newepaymoney;
    			document.getElementById("backmoney").innerHTML = newebackmoney;
    			document.getElementById("balance").innerHTML = balance;
        	}
        }
    });
},5000);
</script>
</head>
<body style="background-color:#F0F0F0;">
<div style="text-align:center;">
<div id="epaymoney" style="display:none;">${epaymoney}</div>
<div id="backmoney" style="display:none;">${backmoney}</div>
<div><img src="images/client_menu_icons/collector.png" style="width:80px;height:80px;"/></div>
<div style="margin-top:2%;font-size:15px;">${nickname}����ţ�${uin}��</div>
<div id="div_div" style="margin:auto;margin-top:5%;"></div> 
<div style="margin-top:2%;font-size:15px;">ͣ����ɨһɨ����֧��</div>
<div style="margin-top:8%;">
<div style="font-size:17px;">�˻���<span style="color:green;" id="balance">${balance}</span>Ԫ</div>
<input type="button" id="download" value="����App�����շ�����" class="download" onclick="location.href='regparker.do?action=download'" >
<div style="margin-top:5px;"><span style="color:green;font-size:15px;">�˺������ѷ��������ֻ�</span></div>
</div>
<div class="fixed-bottom fixed" style="text-align:right;font-size:15px;">�ͷ��绰��010-53423545</div>
</div>
</body>
</html>

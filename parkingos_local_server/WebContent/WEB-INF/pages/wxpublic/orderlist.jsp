<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>�ҵĶ���</title>
	<script type="text/javascript">
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) != "micromessenger"){
			window.location.href = "http://s.tingchebao.com/zld/error.html";
		}
	</script>
	
    <link rel="stylesheet" type="text/css" href="css/jquery.mobile-1.3.2.min.css?v=1" />
	<link rel="stylesheet" type="text/css" href="css/list.css?v=6" />
	<script src="js/jquery.js"></script>
	<script src="js/wxpublic/jquery.mobile-1.3.2.min.js"></script>
	<script src="js/wxpublic/iscroll.js"></script>
	<script src="js/orderlist.js?v=6"></script>
<style type="text/css">
#scroller li {
    padding:0 10px;
    height:70px;
    line-height:35px;
    background-color:#FFFFFF;
    font-size:14px;
    margin-top:1px;
}


a{
	text-decoration:none;
	color:#5F5F5F;
}

#header {
    position:absolute; z-index:2;
    top:0; left:0;
    width:100%;
    height:45px;
    line-height:45px;
    background-color:#F3F3F3;
    padding:0;
    font-size:20px;
    text-align:center;
}

.red{
	color:red;
}
</style>
</head>
<body>
	<div id="wrapper" style="margin-top:-45px;">
		<div id="scroller">
			<div id="pullDown" class="idle">
				<span class="pullDownIcon"></span>
				<span class="pullDownLabel">����ˢ��...</span>
			</div>

			<ul id="thelist">
			</ul>
			<div id="pullUp" class="idle">
				<span class="pullUpIcon"></span>
				<span class="pullUpLabel">�������ظ���...</span>
			</div>
		</div>
	</div>
	<div id="footer"></div>
	<input id="mobile" type="text" style="display:none;" value="${mobile}"/>
	<input id="domain" type="text" style="display:none;" value="${domain}"/>
</body>
</html>

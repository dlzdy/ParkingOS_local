<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>�����˳�������</title>
<style type="text/css">
.content{width:350px;margin:10px auto;font-family:"΢���ź�", sans-serif, Arial, Verdana;font-size:12px;line-height:20px;}
.title{width:100px;margin:10px auto;line-height:33px;}
.boot{font-size:10px;line-height:14px;}
a{color:#000;text-decoration:none;cursor:pointer;}
hr{color:#5544ff;line-height:1px;}
</style>
</head>
<body>
<div id="content" class="content" >
<span style="margin:3px auto;">
</span>
<div style='line-height:30px;font-size:16px;'>
<a  onclick='goanswer("1")' href="#">���ʹ���ֻ�֧��ͣ����&nbsp;&gt;</a></br>
<hr />
<a  onclick='goanswer("2")' href="#">VIP��������뼰ʹ��&nbsp;&gt;</a></br>
<hr />
<a  onclick='goanswer("3")' href="#">�˻���γ�ֵ&nbsp;&gt;</a></br>
<hr />
<a  onclick='goanswer("4")' href="#">ͣ��ȯ���ʹ��&nbsp;&gt;</a></br>
<hr />
<a  onclick='goanswer("5")' href="#">VIP����ʧ��ô��&nbsp;&gt;</a></br>
<hr />
<a  onclick='goanswer("6")' href="#">��ͼ����ʾ�����г����������ֻ�֧��ô&nbsp;&gt;</a></br>
<hr />
<a  onclick='goanswer("7")' href="#">���ڳ�����֧��ͣ����֧����ô��&nbsp;&gt;</a></br>
<hr />
<a  onclick='goanswer("8")' href="#">ͣ��ȯ��λ�ȡ&nbsp;&gt;</a></br>
<hr />
</div>
 
</div>
 <form action="collectorrequest.do?action=uplogfile" enctype='multipart/form-data'>
 ѡ���ļ���<input type='file' /></br>
 <input type='submit' name='�ϴ�' />
 </form>
</body>

<script type="text/javascript">

function goanswer(id){
	location = "answer.jsp?q="+id;
}
</script>
</html>

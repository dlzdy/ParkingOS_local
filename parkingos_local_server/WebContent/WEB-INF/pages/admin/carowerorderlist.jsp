<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ϣ</title>
</head>
<body>
<div id="carinforobj" style="width:100%;height:100%;margin:0px;">
	<table style="border:1px #f3f3f3 solid">
		<tr><td align='center'  width='100px'>���</td><td align='center'  width='200px'>ͣ����</td>
		<td align='center'  width='200px'>����</td>
		<td align='center'  width='200px'>���</td></tr>
		<c:forEach items="${list}" var='order' varStatus="col"> 
				<tr><td align='center' height='30px'>${col.index+1}</td>
				<td align='center' height='30px'>${order}</td>
				<td align='center' height='30px'>${order}</td>
				<td align='center' height='30px'>${order}</td></tr>
		</c:forEach>
	</table>
</div>
</body>
</html>

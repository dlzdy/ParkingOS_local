<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�շ�Ա����</title>
<script src="js/jquery.js" type="text/javascript">//��</script>

</head>
<body>
	<from action = "config.do?action=editadminpass">
		<div>
			<div>������</div><input id = "newpass"></input>
			<div>ȷ������</div><input id = "newpass2"></input>
		</div>
		<button id = "save">����</button>
		<button id = "clear">���</button>
	</from>
<script type="text/javascript">
	$("#clear").click(function(){
		$("#newpass").val("");
		$("#newpass2").val("");
	});
	
	$("#save").click(function(){
		var new1 = $("#newpass").val();
		var new2 = $("#newpass2").val();
		//alert("http://localhost:8080/zld/initLocal.do?action=editadminpass&newpass1="+new1+"newpass2="+new2);
		if(new1!=new2){
			alert("���벻һ��");
			return;
		}
		if(new1.length<6){
			alert("����̫��");
			return;
		}
		$.post("config.do?",
		    {"action":"editadminpass","newpass1":new1,"newpass2":new2},
			function(data){
		    	if(data>0){
		    		alert("�޸ĳɹ�");
		    	}else{
		    		alert("�޸�ʧ��");
		    	}
	   			
	  		}
	  	);
	});
</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�޸�ͣ����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
</head>
<body>
<script src="js/tq.js?08137" type="text/javascript">//����</script>
<script src="js/tq.public.js?08031" type="text/javascript">//����</script>
<script src="js/tq.window.js?008136" type="text/javascript">//����</script>
<script src="js/tq.form.js?08301" type="text/javascript">//��</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/jquery.js" type="text/javascript">//��֤</script>

<div id="alllayout">
	<div style="width:100%;float:left;height:0px;border-bottom:1px solid #ccc" id="top"></div>
	<div>
</div>
	<div style="width:100%;float:left;">
    	<div id="right" style="width:auto;border-left:1px solid #ccc;float:left"></div>
	</div>
</div>	
</div>
	<button id='init'>��ʼ��</button>
</div>	


</body>
<script type="text/javascript">
$("#init").click(function(){
	$.post("http://localhost:8080/zld/initLocal.do", 
		{},
		function(data){
   			alert(data);
  		}
  	);
});
//ȡ�ֶ�
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}];
var etc_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
var Obj = document.getElementById("alllayout");
var topO = document.getElementById("top");
var rightO = document.getElementById("right");

rightO.style.width = T.gww()  + "px";
rightO.style.height = T.gwh() - 50 + "px";

T.bind(window,"resize",function(){
    rightO.style.width = T.gww() + "px";
    rightO.style.height = T.gwh() - 50 + "px"
})


var fields = [
		{fieldcnname:"�������",fieldname:"comid",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"������Կ",fieldname:"secret",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
	];


var comid="";
var maxmoney = 0;
var total=0;
var cominfo= eval('${cominfo}');
for(var i=0;i<cominfo.length;i++){
		if(cominfo[i].name=="id"){
			comid =cominfo[i].value;
		}
		if(cominfo[i].name=="money"){
			maxmoney =cominfo[i].value;
		}
		if(cominfo[i].name=="total_money"){
			total =cominfo[i].value;
		}
}

function getEditFields(){
	var e_f = [];
	for(var j=0;j<fields.length;j++){
		for(var i=0;i<cominfo.length;i++){
			if(cominfo[i].name==fields[j].fieldname){
				fields[j].fieldvalue=cominfo[i].value;
				e_f.push(fields[j]);
				break;
			}
			if(fields[j].inputtype=='select')
				fields[j].width=200;
		}
	}
	return e_f;
}

function getFields(){
	var fs = getEditFields();
	var mfs = [
		{kindname:"������Ϣ",kinditemts:fs.slice(0,2)},
		];
	return mfs;
}



var accountForm =
new TQForm({
	formname: "opconfirm",
	formObj:rightO,
	suburl:"config.do?action=edit&id="+comid,
	method:"POST",
	//dbbuttons:[true,false],
	buttons:getTopButtons(),
	Callback:function(f,r,c,o){
		
			T.loadTip(1,"�޸ĳɹ���",3,null);
		
	},
	formAttr:[{
		formitems:getFields()
	}]
});
accountForm.C();

function getTopButtons(){
	var bus = [];
	
	return bus;
}



</script>


</html>
<script type="text/javascript">
T.maskTip(0,"","");//���ؽ���
</script>
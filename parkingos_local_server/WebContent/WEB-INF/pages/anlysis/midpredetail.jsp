<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?0817" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>
<body>
<div id="midpredetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var uin="${uin}";
var type="${type}";
var btime="${btime}"
var etime="${etime}";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hide:true},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",hide:true},
		{fieldcnname:"ͣ������",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"end_time",fieldvalue:'',inputtype:"date",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ͣ��ʱ��",fieldname:"park_time",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",hide:true},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":4,"value_name":"�ֽ�"},{"value_no":5,"value_name":"������"},{"value_no":6,"value_name":"�̼ҿ�"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�ѽ���"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"Ԥ������",fieldname:"pre_time",fieldvalue:'',inputtype:"date",twidth:"100" ,height:"",hide:true},
		{fieldcnname:"Ԥ֧�����",fieldname:"amount",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",hide:true},
		{fieldcnname:"����ȯ�ֿ۽��",fieldname:"umoney",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",hide:true},
		{fieldcnname:"����ȯ����",fieldname:"ticket_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":3,"value_name":"��ʱȯ"},{"value_no":4,"value_name":"ȫ��ȯ"}],twidth:"100" ,height:"",hide:true},
		{fieldcnname:"����ȯ���(Сʱ)",fieldname:"ticket_money",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",hide:true,
			process:function(value,cid,id){
					if(value == "0"){
						return "";
					}else{
						return value;
					}
				}
		},
		{fieldcnname:"�鿴����ȯͼƬ",fieldname:"ticketid",fieldvalue:'',inputtype:"text",twidth:"150" ,height:"",hide:true,
			process:function(value,cid,id){
					if(value == ""){
						return "";
					}else{
						return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴ͼƬ</a>";
					}
				}}
	];
var _midpredetailT = new TQTable({
	tabletitle:"�̻��Ż�ȯ",
	ischeck:false,
	tablename:"money_tables",
	dataUrl:"midpreanlysis.do",
	iscookcol:false,
	param:"action=querydetail&uin="+uin+"&type="+type+"&btime="+btime+"&etime="+etime,
	tableObj:T("#midpredetailobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}

function viewdetail(type,value,id){
	var light = parent.parent.document.getElementById('visitpic');
	var flag = false;
	if(light == null){
		flag = true;
		var light = parent.parent.parent.document.getElementById('visitpic');
	}
	var childNodes = light.childNodes;
	for(var i=0;i<childNodes.length;i++){
		light.removeChild(childNodes[i]);
	}
	var img1 = new Image();
	img1.src="midpreanlysis.do?action=downloadpic&shopticket_id="+value;
	light.appendChild(img1);
	if(flag){
		parent.parent.parent.document.getElementById('light').style.display='block';
		parent.parent.parent.document.getElementById('fade').style.display='block'
	}else{
		parent.parent.document.getElementById('light').style.display='block';
		parent.parent.document.getElementById('fade').style.display='block'
	}
	return null;
}
_midpredetailT.C();
</script>

</body>
</html>

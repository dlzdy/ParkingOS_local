<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ͨ���û�</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>

</head>
<body>
<div id="easypassdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}";
var etime="${etime}";
var total = '${total}';
var parkid=${parkid};
var tip = "��ͨ���û�";
var _mediaField = [
		{fieldcnname:"���",fieldname:"comid",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��������",fieldname:"company_name",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"nickname",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"����",fieldname:"nfc_uuid",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"ע��ʱ��",fieldname:"create_time",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"��ʱ��",fieldname:"update_time",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"ͣ��"}] , twidth:"100" ,height:"",issort:false,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>ͣ��</font>";
				else 
					return "����";
			}}
	];
var _easypassdetailT = new TQTable({
	tabletitle:tip,
	ischeck:false,
	tablename:"easypassdetail_tables",
	dataUrl:"easypass.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=easypassdetail&parkid="+parkid+"&btime="+btime+"&etime="+etime,
	tableObj:T("#easypassdetailobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:false
});

function coutomsearch(){
	var html=    "ʱ�䣺"+btime+" �� "+etime+"���ϼƣ�<font color='red'>"+total+"</font> ��";
	return html;
}

_easypassdetailT.C();
</script>

</body>
</html>

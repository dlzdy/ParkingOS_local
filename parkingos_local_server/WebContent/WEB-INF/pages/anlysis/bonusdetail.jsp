<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>NFC��¼</title>
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
<div id="bonusdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >

var details=${details};//{"page":1,"total":2,"rows": [{"id":"1","cell":["ͨ����","ҵ����ѯ"]},{"id":"2","cell":["������","�ۺ����"]}]};

var _bonusdetailT = new TQTable({
	tabletitle:"��������",
	ischeck:false,
	tablename:"bonusdetail_tables",
	dataUrl:"bonusanly.do",
	iscookcol:false,
	dataorign:1,
	hotdata:details,
	quikcsearch:'${tips}',
	dbuttons:false,
	buttons:false,
	searchitem:false,
	param:"action=quickquery",
	tableObj:T("#bonusdetailobj"),
	allowpage:false,
	fit:[true,true,true],
	tableitems: [
		{fieldcnname:"����",fieldname:"car",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��������",fieldname:"cdate",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"ͣ����",fieldname:"cname",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"������",fieldname:"total",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"֧����ʽ",fieldname:"ptype",inputtype:"select",noList:[{"value_no":0,"value_name":"��֧ͨ��"},{"value_no":1,"value_name":"ֱ�����շ�Ա"}], twidth:"200",issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"collect",inputtype:"text", twidth:"100",issort:false}
	],
	isoperate:false
});
_bonusdetailT.C();

</script>

</body>
</html>

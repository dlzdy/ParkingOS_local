<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����б�</title>
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
<div id="parkdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var parkid=${parkid};
var tip = "�����б�";
var _mediaField = [
		{fieldcnname:"���",fieldname:"comid",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"����",fieldname:"company_name",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"�����ֻ���",fieldname:"mobile",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��������",fieldname:"car_number",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"����",fieldname:"comment",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"����",fieldname:"create_time",inputtype:"text", twidth:"150" ,issort:false}
	];
var _parkdetailT = new TQTable({
	tabletitle:tip,
	ischeck:false,
	tablename:"parkdetail_tables",
	dataUrl:"parkpraise.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=commentlist&parkid="+parkid,
	tableObj:T("#parkdetailobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:false
});

function coutomsearch(){
	var html= "";
	return html;
}

_parkdetailT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ֱ���б�</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<style>
a { text-decoration:none; color:#f30; }
</style>

</head>
<body>
<div id="directdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}";
var etime="${etime}";
var parkid="${parkid}";

	var states = [ {
		"value_no" : -1,
		"value_name" : "����"
	}, {
		"value_no" : 0,
		"value_name" : "���"
	}, {
		"value_no" : 1,
		"value_name" : "֧����"
	}, {
		"value_no" : 2,
		"value_name" : "΢��"
	}, {
		"value_no" : 3,
		"value_name" : "����"
	}, {
		"value_no" : 4,
		"value_name" : "���+֧����"
	}, {
		"value_no" : 5,
		"value_name" : "���+΢��"
	}, {
		"value_no" : 6,
		"value_name" : "���+����"
	}, {
		"value_no" : 7,
		"value_name" : "ͣ������ֵ"
	}, {
		"value_no" : 8,
		"value_name" : "ͣ��������"
	}, {
		"value_no" : 9,
		"value_name" : "΢�Ź��ں�"
	}, {
		"value_no" : 10,
		"value_name" : "΢�Ź��ں�+���"
	}, {
		"value_no" : 11,
		"value_name" : "΢�Ŵ���ȯ"
	}, {
		"value_no" : 12,
		"value_name" : "Ԥ֧������"
	} ];
	var _mediaField = [ {
		fieldcnname : "ID",
		fieldname : "id",
		inputtype : "text",
		twidth : "150",
		issort : false,
		fhide : true
	}, {
		fieldcnname : "�շ�Ա",
		fieldname : "nickname",
		inputtype : "text",
		twidth : "100",
		issort : false
	}, {
		fieldcnname : "�������",
		fieldname : "uin",
		inputtype : "text",
		twidth : "100",
		issort : false
	}, {
		fieldcnname : "���ƺ�",
		fieldname : "car_number",
		inputtype : "text",
		twidth : "100",
		issort : false
	}, {
		fieldcnname : "�����ֻ���",
		fieldname : "mobile",
		inputtype : "text",
		twidth : "100",
		issort : false
	}, {
		fieldcnname : "���",
		fieldname : "amount",
		inputtype : "text",
		twidth : "150",
		issort : false
	}, {
		fieldcnname : "֧��ʱ��",
		fieldname : "create_time",
		inputtype : "text",
		twidth : "200",
		issort : false
	}, {
		fieldcnname : "֧������",
		fieldname : "pay_type",
		fieldvalue : '',
		inputtype : "select",
		noList : states,
		twidth : "200",
		height : "",
		issort : false
	}, ];
	var _directdetailT = new TQTable({
		tabletitle : "ֱ���б�",
		ischeck : false,
		tablename : "directdetail_tables",
		dataUrl : "mobileanlysis.do",
		iscookcol : false,
		buttons : false,
		param : "action=directpaydetail&btime=" + btime + "&etime=" + etime
				+ "&parkid=" + parkid,
		tableObj : T("#directdetailobj"),
		fit : [ true, true, true ],
		tableitems : _mediaField,
		allowpage : false,
		isoperate : false
	});

	_directdetailT.C();
</script>

</body>
</html>

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
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>

</head>
<body>
<div id="sharesortdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">

var details=${details};//{"page":1,"total":2,"rows": [{"id":"1","cell":["ͨ����","ҵ����ѯ"]},{"id":"2","cell":["������","�ۺ����"]}]};

var _sharesortdetailT = new TQTable({
	tabletitle:"��������",
	ischeck:false,
	tablename:"sharesortdetail_tables",
	dataUrl:"sharesort.do",
	iscookcol:false,
	dataorign:1,
	hotdata:details,
	quikcsearch:'${tips}',
	dbuttons:false,
	buttons:false,
	searchitem:false,
	param:"action=quickquery",
	tableObj:T("#sharesortdetailobj"),
	allowpage:false,
	fit:[true,true,true],
	tableitems: [
			{fieldcnname:"����",fieldname:"sdate",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
			{fieldcnname:"�������",fieldname:"lala_scroe",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",hide:true},
			{fieldcnname:"NFCˢ��",fieldname:"nfc_score",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",hide:true},
			{fieldcnname:"���ƻ���",fieldname:"pai_score",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",hide:true},
			{fieldcnname:"�����۷�",fieldname:"praise_scroe",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",hide:true},
			{fieldcnname:"�ڸڻ���",fieldname:"online_scroe",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",hide:true},
			{fieldcnname:"�Ƽ�����",fieldname:"recom_scroe",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",hide:true}
		],
	isoperate:false
});
_sharesortdetailT.C();
</script>
</body>
</html>

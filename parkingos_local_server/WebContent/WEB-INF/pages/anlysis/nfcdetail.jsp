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
<div id="nfcdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}";
var etime="${etime}";
var otype='${otype}';
var total = '${total}';
var parkid=${parkid};
var tip = "NFC��ʷ����";
if(otype == 'cn'){
	tip = "NFC��ǰ����";
}else if(otype == 'hz'){
	tip = "���Ƶ�ǰ����";
}else if(otype == 'cz'){
	tip = "���Ƶ�ǰ����";
}else if(otype == 'e'){
	tip = "�ӵ�";
}
var _mediaField = [
		{fieldcnname:"ͣ������",fieldname:"create_time",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��������",fieldname:"end_time",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"ͣ��ʱ��",fieldname:"duration",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"ͣ����",fieldname:"cname",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"������",fieldname:"total",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"NFC����",fieldname:"nfc_uuid",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"carnumber",inputtype:"text", twidth:"100",issort:false}
	];
var _nfcdetailT = new TQTable({
	tabletitle:tip,
	ischeck:false,
	tablename:"nfcdetail_tables",
	dataUrl:"nfcanlysis.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=parkdetail&parkid="+parkid+"&btime="+btime+"&etime="+etime+"&otype="+otype,
	tableObj:T("#nfcdetailobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:false
});

function coutomsearch(){
	var html=    "ʱ�䣺"+btime+" �� "+etime+"���ϼƣ�<font color='red'>"+total+"</font> Ԫ";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}

_nfcdetailT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>΢��֧������ֵ�ͻ�Աͳ��</title>
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
<div id="chargeanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var _mediaField = [
		{fieldcnname:"ID",fieldname:"id",inputtype:"text", twidth:"200" ,issort:false,fhide:true},
		{fieldcnname:"�����",fieldname:"residuemoney",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�ܳ�ֵ����",fieldname:"tcount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�ܳ�ֵ���",fieldname:"tamount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"֧������ֵ����",fieldname:"zfbcount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"֧������ֵ���",fieldname:"zfbamount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"΢�ų�ֵ����",fieldname:"wxcount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"΢�ų�ֵ���",fieldname:"wxamount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"΢�Ź��ںų�ֵ����",fieldname:"wxpcount",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"΢�Ź��ںų�ֵ���",fieldname:"wxpamount",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"΢��֧����Ա��",fieldname:"wxvip",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"΢�Ź��ں�֧����Ա��",fieldname:"wxpvip",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"֧����֧����Ա��",fieldname:"zfbvip",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"΢�ź�֧����֧����Ա��",fieldname:"bothvip",inputtype:"text", twidth:"150",issort:false}
	];
var _chargeanlysisT = new TQTable({
	tabletitle:"΢��֧������ֵ�ͻ�Աͳ��",
	ischeck:false,
	tablename:"chargeanlysis_tables",
	dataUrl:"charge.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#chargeanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true
});

function coutomsearch(){
	var html = "ʱ�䣺<input id='coutom_btime' value='' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' "+
				"value=' �� ѯ '/>";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}

function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	_chargeanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
}

_chargeanlysisT.C();
</script>
</body>
</html>

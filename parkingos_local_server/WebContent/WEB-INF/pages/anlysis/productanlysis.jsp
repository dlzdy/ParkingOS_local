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
<script src="js/tq.form.js?0817" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>

</head>
<body>
<div id="productanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var btime="${btime}"
var etime="${etime}";
var mobile = '${mobile}';
var carnumber='${carnumber}';
var viewtype="custom";
var tip = "�����ѯ";
var _mediaField = [
		{fieldcnname:"�ײ�����",fieldname:"p_name",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"��������",fieldname:"create_time",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"carnumber",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�ֻ���",fieldname:"mobile",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�۸�",fieldname:"price",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��� ",fieldname:"total",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��Ч��",fieldname:"exprise",inputtype:"text", twidth:"200",issort:false}
	];
var _productanlysisT = new TQTable({
	tabletitle:"�ײ�ͳ��",
	ischeck:false,
	tablename:"productanlysis_tables",
	dataUrl:"productanlysis.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#productanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html=    "<input type='button' onclick='searchtomonth();' value='����'/>&nbsp;&nbsp;ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='"+etime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;���ƺţ�<input id='carnumber' style='width:100px'/>&nbsp;&nbsp;�ֻ���<input id='mobile'  style='width:100px'/>&nbsp;&nbsp;<input type='button' onclick='searchdata();' value=' �� ѯ '/>&nbsp;&nbsp;<span id='total_money'></span>";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}

function searchtomonth(){
	viewtype='tomonth';
	tip = "����ͳ��";
	_productanlysisT.C({
		cpage:1,
		tabletitle:"����ͳ��",
		extparam:"&action=query&type=tomonth"
	})
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	mobile = T("#mobile").value;
	carnumber = T("#carnumber").value
	var cn=encodeURI(encodeURI(carnumber));
	viewtype="custom";
	_productanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime+"&mobile="+mobile+"&carnumber="+cn
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	T("#mobile").value=mobile;
	T("#carnumber").value=carnumber;
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_productanlysisT.C();
</script>

</body>
</html>

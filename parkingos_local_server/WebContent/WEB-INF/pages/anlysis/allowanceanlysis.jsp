<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������ͣ����ͳ��</title>
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
<div id="allowanceanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var _mediaField = [
		{fieldcnname:"ID",fieldname:"id",inputtype:"text", twidth:"200" ,issort:false,fhide:true},
		{fieldcnname:"���������",fieldname:"lala",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�������ٷֱ�",fieldname:"lala_percent",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"ʵ��ͣ����(ȥ����ͣ��ȯ)",fieldname:"parking",inputtype:"text", twidth:"250",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					var tmoney =  _allowanceanlysisT.GD(trId,'ticket');
//					alert(value+","+tmoney);
					return value-tmoney;
				}else
					return value;
			}},
		{fieldcnname:"ʵ��ͣ���Ѱٷֱ�",fieldname:"parking_percent",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"����������",fieldname:"allowance",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"����������ٷֱ�",fieldname:"allowance_percent",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"ͣ��ȯ������",fieldname:"ticket",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"ͣ��ȯ������ٷֱ�",fieldname:"ticket_percent",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"��ͨȯ������",fieldname:"tcb0ttotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"ר��ȯ������",fieldname:"tcb1ttotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"������ȯ������",fieldname:"rewardttotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"����ȯ������",fieldname:"wx3ttotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"����ȯ������",fieldname:"wx5ttotal",inputtype:"text", twidth:"100",issort:false}
	];
var _allowanceanlysisT = new TQTable({
	tabletitle:"������ͣ����ͳ��",
	ischeck:false,
	tablename:"allowanceanlysis_tables",
	dataUrl:"allowance.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#allowanceanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true
});

function coutomsearch(){
	var html = "ʱ�䣺<input id='coutom_btime' value='' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;����<select id='cityflag' ><option value='-1'>ȫ��</option><option value='0'>����</option><option value='1'>����</option><option value='2'>�ൺ</option></select>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' "+
				"value=' �� ѯ '/>";
	return html;
}

function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	var city = T("#cityflag").value;
	var city_b = 0;
	var city_e = 659004;
	if(city == "0"){
		city_b = 110000;
		city_e = 110229;
	}else if(city == "1"){
		city_b = 370100;
		city_e = 370181;
	}else if(city == "2"){
		city_b = 370200;
		city_e = 370214;
	}
	_allowanceanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime+"&city_b="+city_b+"&city_e="+city_e
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	T("#cityflag").value = city;
}

_allowanceanlysisT.C();
</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����Ԥ֧��</title>
<link href="css/zTreeStyle1.css" rel="stylesheet" type="text/css">
<link href="css/demo.css" rel="stylesheet" type="text/css">
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
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
</head>
<body>
<div id="workobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var uin = "${uin}";
var btime="${btime}"
var etime="${etime}";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"�ϰ�ʱ��",fieldname:"start_time",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"�°�ʱ��",fieldname:"end_time",inputtype:"text", twidth:"150",issort:false},
		{fieldcnname:"�ֽ𶩵���",fieldname:"cashcount",inputtype:"text", twidth:"150",issort:false,
			process:function(value,cid,id){
					return "<a href=# onclick=\"detail(4,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
				}},
		{fieldcnname:"�ֽ��ܶ�",fieldname:"cashamount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"������������",fieldname:"upaycount",inputtype:"text", twidth:"150",issort:false,
			process:function(value,cid,id){
					return "<a href=# onclick=\"detail(5,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
				}},
		{fieldcnname:"�������ܶ�",fieldname:"upayamount",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�̼ҿ�������",fieldname:"cardcount",inputtype:"text", twidth:"150",issort:false,
			process:function(value,cid,id){
					return "<a href=# onclick=\"detail(6,'"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
				}},
		{fieldcnname:"�̼ҿ��ܶ�",fieldname:"cardamount",inputtype:"text", twidth:"100",issort:false}
	];
var _workT = new TQTable({
	tabletitle:"����Ԥ֧��",
	ischeck:false,
	tablename:"work_tables",
	dataUrl:"midpreanlysis.do",
	iscookcol:false,
	buttons:false,
	param:"action=workdetail&uin="+uin+"&btime="+btime+"&etime="+etime,
	tableObj:T("#workobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true
});

function detail(type,value,id){
	var start_time =_workT.GD(id,"start_time");
	var end_time =_workT.GD(id,"end_time");
	var tip = "����Ԥ֧��������¼";
	Twin({
		Id:"midpre_detail_"+id,
		Title:tip,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='midpre_detail_'"+id+" id='midpre_detail_'"+id+" src='midpreanlysis.do?action=detail&uin="+uin+"&btime="+start_time+"&etime="+end_time+"&type="+type+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

_workT.C();
</script>
</body>
</html>

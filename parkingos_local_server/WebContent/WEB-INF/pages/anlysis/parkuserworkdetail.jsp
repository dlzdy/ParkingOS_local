<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�շ�Ա���°��¼</title>
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
<div id="workdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var btime="${btime}";
var etime="${etime}";
var total = '${total}';
var pmoney = '${pmoney}';
var pmobile = '${pmobile}';
var pay_type = "${pay_type}";
var otype = "${otype}";
var viewtype="workcustom";
var uid=${uid};
var count=${count};

var tip = "��������";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"30",issort:false},
		{fieldcnname:"����վ",fieldname:"worksite_id",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�ϰ�ʱ��",fieldname:"start_time",inputtype:"text", twidth:"130",issort:false},
		{fieldcnname:"�°�ʱ��",fieldname:"end_time",inputtype:"text", twidth:"130" ,issort:false},
		{fieldcnname:"��������",fieldname:"ordertotal",inputtype:"text", twidth:"70",issort:false,
			process:function(value,cid,id){
					if(value==0){
						return value;
					}else{
						return "<a href=# onclick=\"viewdetail('h','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
					}
				}},
		{fieldcnname:"�¿�������",fieldname:"monthcount",inputtype:"text", twidth:"70" ,issort:false},
		{fieldcnname:"Ӧ�ս��",fieldname:"total",inputtype:"text", twidth:"90",issort:false},
		{fieldcnname:"�ֽ�֧��",fieldname:"money",inputtype:"text", twidth:"90",issort:false,
			process:function(value,cid,id){
					if(value==0){
						return value;
					}else{
						return "<a href=# onclick=\"viewdetail('h','"+value+"','"+cid+"',1)\" style='color:blue'>"+value+"</a>";
					}
				}},
		{fieldcnname:"ͣ����֧��",fieldname:"pmoney",inputtype:"text", twidth:"90",issort:false},
		{fieldcnname:"����Ԥ֧��",fieldname:"centerprepay",inputtype:"text", twidth:"90",issort:false},
		{fieldcnname:"����ȯ֧��",fieldname:"ticketpay",inputtype:"text", twidth:"90",issort:false},
		{fieldcnname:"��ѽ��",fieldname:"free",inputtype:"text", twidth:"90",issort:false,
			process:function(value,cid,id){
				if(value==0.0){
					return value;
				}else{
					return "<a href=# onclick=\"viewdetail('h','"+value+"','"+cid+"',8)\" style='color:blue'>"+value+"</a>";
				}
			}}
	];

//var otype="worksite_id-start_time-end_time-ordertotal-total-money-pmoney-free";

var _parkuserworkdetailT = new TQTable({
	tabletitle:tip,
	ischeck:false,
	tablename:"workdetail_tables",
	dataUrl:"orderanly.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:false,
	param:"action=workdetail&uid="+uid+"&btime="+btime+"&etime="+etime+"&otype="+otype+"&count="+count+"&pay_type="+pay_type,
	tableObj:T("#workdetailobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:false,
	isoperate:false
});




function viewdetail(type,value,id,pay_type,start_time,end_time){
	var start_time =_parkuserworkdetailT.GD(id,"start_time");
	var end_time =_parkuserworkdetailT.GD(id,"end_time");
	var total =_parkuserworkdetailT.GD(id,"total");
	var money =_parkuserworkdetailT.GD(id,"money");
	var pmoney =_parkuserworkdetailT.GD(id,"pmoney");
	var free =_parkuserworkdetailT.GD(id,"free");
	//alert(start_time);
	var tip = "��������";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip,
		Width:T.gww()-50,
		Height:T.gwh()-25,
		sysfunI:id,
		Content:"<iframe name='parkorder_detail_'"+id+" id='parkorder_detail_'"+id+" src='orderanly.do?action=detail&otype="+viewtype+"&uid="+uid+"&btime="+start_time+"&etime="+end_time+"&total="+total+"&count="+value+"&count="+total+"&pmobile="+pmoney+"&pmoney="+money+"&free="+free+"&pay_type="+pay_type+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
		})
}

_parkuserworkdetailT.C();
</script>

</body>
</html>

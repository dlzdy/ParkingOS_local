<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ͨ��ͳ��</title>
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
<div id="easypassobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}"
var etime="${etime}";
var _mediaField = [
		{fieldcnname:"�������",fieldname:"comid",inputtype:"text", twidth:"200" ,issort:false,fhide:true},
		{fieldcnname:"ͣ����",fieldname:"company_name",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"�г�רԱ",fieldname:"nickname",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"����",fieldname:"total",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('e','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}}
	];
var _easypassT = new TQTable({
	tabletitle:"��ͨ���û�",
	ischeck:false,
	tablename:"easypass_tables",
	dataUrl:"easypass.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#easypassobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html=    "ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='"+etime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' "+
				"value=' �� ѯ '/>";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	//alert(btime);
	//alert(etime);
	_easypassT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
}

function viewdetail(type,value,id){
	//alert(type+","+value);
	var total =_easypassT.GD(id,"total");
	var park =_easypassT.GD(id,"company_name");
	var tip = "��ͨ���û�";
	Twin({
		Id:"easypass_detail_"+id,
		Title:tip+"  --> ͣ������"+park,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='easypass_detail_'"+id+" id='easypass_detail_'"+id+" src='easypass.do?action=detail&parkid="+id+"&btime="+btime+"&etime="+etime+"&total="+total+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_easypassT.C();
</script>

</body>
</html>

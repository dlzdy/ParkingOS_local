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
<script src="js/tq.form.js?0817" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>

</head>
<body>
<div id="parkdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var otype='${otype}';
var parkid='${parkid}';
var tip = "�����б�";
if(otype == 'b'){
	tip = "�����б�";
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"comid",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"����ID",fieldname:"uin",inputtype:"text", twidth:"150" ,issort:false,fhide:true},
		{fieldcnname:"����",fieldname:"company_name",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"�����ֻ���",fieldname:"mobile",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"��������",fieldname:"car_number",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"����",fieldname:"praise",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,
			process:function(value,trId,colId){
				if(value==1){
					return "��";
				}else if(value==0){
					return "��";
				}else{
					return "";
				}
			}},
		{fieldcnname:"��������",fieldname:"mcount",inputtype:"text", twidth:"200",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
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
	param:"action=parkdetail&parkid="+parkid+"&otype="+otype,
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

function viewdetail(value,id){
	var company_name =_parkdetailT.GD(id,"company_name");
	var tip = "�����б�";
	Twin({
		Id:"parkcomment_detail_"+id,
		Title:tip+"  --> ͣ������"+company_name,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='parkcomment_detail_'"+id+" id='parkcomment_detail_'"+id+" src='parkpraise.do?action=comment&parkid="+parkid+"&uin="+id+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

_parkdetailT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�������</title>
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
<div id="moneyobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var hbonus='${hbonus}';
var htips = "�򿪽��շ������";
if(hbonus=='1'){
	htips = "�رս��շ������";
}
var cmesg='${cmesg}';
var cmesgtips = "���շ�Ա��Ϣ";
if(cmesg=='1'){
	cmesgtips = "�ر��շ�Ա��Ϣ";
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ͣ����",fieldname:"company_name",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",hide:true,shide:true},
		{fieldcnname:"��Ա����",fieldname:"car_number",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hide:true,hide:true},
		{fieldcnname:"��Ա�绰",fieldname:"mobile",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false,hide:true},
		{fieldcnname:"ժҪ",fieldname:"remark",fieldvalue:'',inputtype:"text",twidth:"270" ,height:"",hide:true},
		{fieldcnname:"֧������",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"�˺����"},{"value_no":1,"value_name":"֧����"},{"value_no":2,"value_name":"΢��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"���+֧����"},{"value_no":5,"value_name":"���+΢��"},{"value_no":6,"value_name":"���+����"}],twidth:"100" ,height:"",hide:true},
		{fieldcnname:"��ֵ",fieldname:"recharge",fieldvalue:'',inputtype:"text",twidth:"100",height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"consum",fieldvalue:'',inputtype:"text",twidth:"100",height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"withdraw",fieldvalue:'',inputtype:"text", twidth:"100",height:"",issort:false,shide:true}
	];
var _moneyT = new TQTable({
	tabletitle:"�������",
	ischeck:false,
	tablename:"money_tables",
	dataUrl:"account.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#moneyobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_moneyT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"money_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "money_search_f",
					formObj:tObj,
					formWinId:"money_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("money_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_moneyT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{dname:htips,icon:"edit_add.png",onpress:function(Obj){
		Tconfirm({
			Title:"��ʾ��Ϣ",
			Ttype:"alert",
			Content:"���棺��ȷ��Ҫ <font color='red'>"+htips+"</font>��",
			OKFn:function(){
			T.A.sendData("account.do?action=hbonous&hbonus="+hbonus,"GET","",
				function(ret){
					if(ret=="1"){
						location = "account.do";
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
					}
				},0,null)
			}
		});
	}}
	,
	{dname:cmesgtips,icon:"edit_add.png",onpress:function(Obj){
		Tconfirm({
			Title:"��ʾ��Ϣ",
			Ttype:"alert",
			Content:"���棺��ȷ��Ҫ <font color='red'>"+cmesgtips+"</font>��",
			OKFn:function(){
			T.A.sendData("account.do?action=cmessage&cmesg="+cmesg,"GET","",
				function(ret){
					if(ret=="1"){
						location = "account.do";
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
					}
				},0,null)
			}
		});
	}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}
_moneyT.C();
</script>

</body>
</html>

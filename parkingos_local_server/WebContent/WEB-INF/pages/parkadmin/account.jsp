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
<div id="parkaccountobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">

var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit();
}
var total  = ${total};
var parkusers= eval(T.A.sendData("getdata.do?action=getuser&id=${comid}"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"200" ,height:""},
		//{fieldcnname:"��Ա����",fieldname:"carnumber",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",hide:true},
		{fieldcnname:"�շ�Ա",fieldname:"uid",fieldvalue:'',inputtype:"select",noList:parkusers,twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ժҪ",fieldname:"remark",fieldvalue:'',inputtype:"text",twidth:"270" ,height:"",hide:true,issort:false},
		{fieldcnname:"���",fieldname:"amount",fieldvalue:'',inputtype:"text",twidth:"100",height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�շ�"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ͣ��������"}],twidth:"100" ,height:"",hide:true}
	];
var _parkaccountT = new TQTable({
	tabletitle:"�������,��ʷ�ܽ�${total},��ǰ�˻���${money}",
	ischeck:false,
	tablename:"money_tables",
	dataUrl:"parkaccount.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#parkaccountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkaccountT.tc.tableitems,function(o,j){
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
						_parkaccountT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}
_parkaccountT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���Ƽ���ѯ</title>
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
<div id="recomviewobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true,shide:true},
		{fieldcnname:"�Ƽ���",fieldname:"pid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"�Ƽ��˽�ɫ",fieldname:"auth_flag",fieldvalue:'',inputtype:"select",noList:[{"value_no":"-1","value_name":"ȫ��"},{"value_no":"2","value_name":"�շ�Ա"},{"value_no":"4","value_name":"����"}], twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"���Ƽ���",fieldname:"nid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"���Ƽ��˽�ɫ",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"����"},{"value_no":"1","value_name":"�շ�Ա"}], twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"�Ƽ�����",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"΢�Ź��ں�",fieldname:"openid",fieldvalue:'',inputtype:"text", twidth:"250" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", noList:[{"value_no":"-1","value_name":"ȫ��"},{"value_no":"0","value_name":"�Ƽ���"},{"value_no":"1","value_name":"�Ƽ��ɹ�"}],twidth:"100" ,height:"",issort:false,edit:false}
	];
var _recomviewT = new TQTable({
	tabletitle:"���Ƽ���ѯ",
	ischeck:false,
	tablename:"recomview_tables",
	dataUrl:"recomview.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#recomviewobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [
			{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
			T.each(_recomviewT.tc.tableitems,function(o,j){
				o.fieldvalue ="";
			});
			Twin({Id:"recomview_search_w",Title:"�����Ƽ�",Width:550,sysfun:function(tObj){
					TSform ({
						formname: "recomview_search_f",
						formObj:tObj,
						formWinId:"recomview_search_w",
						formFunId:tObj,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("recomview_search_w");} }
						],
						SubAction:
						function(callback,formName){
							_recomviewT.C({
								cpage:1,
								tabletitle:"�߼��������",
								extparam:"&action=highquery&"+Serializ(formName)
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
_recomviewT.C();
</script>

</body>
</html>

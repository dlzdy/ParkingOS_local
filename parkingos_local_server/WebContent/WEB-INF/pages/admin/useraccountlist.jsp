<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���������ʺ�</title>
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
<div id="useraccountobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var comid='${comid}';
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false},
		{fieldcnname:"�շ�Ա",fieldname:"uin",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false},
		{fieldcnname:"�ʺ�",fieldname:"card_number",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���֤",fieldname:"user_id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ʺ�����",fieldname:"atype",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"���п�"},{"value_no":1,"value_name":"֧����"},{"value_no":2,"value_name":"΢��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"bank_name",fieldvalue:'',inputtype:"select",noList:banks, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"area",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����֧��",fieldname:"bank_pint",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"�ѽ���"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"note",fieldvalue:'',inputtype:"multi",twidth:"200" ,height:"",issort:false}
	];
var rules=[
		{name:"card_number",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		//{name:"mobile",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		{name:"name",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
		];
var _useraccountT = new TQTable({
	tabletitle:"�����ʺŹ������ˣ�",
	ischeck:false,
	tablename:"useraccount_tables",
	dataUrl:"useraccount.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	quikcsearch:coutomsearch(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#useraccountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bus = [];
	return false;
}
function getAuthIsoperateButtons(){
	 var bts = [];
	/* bts.push({name:"",
		rule:function(id){
			var state =_useraccountT.GD(id,"state");
			if(state==1){
				this.name="����";
			}else{
				this.name="����";
			}
			return true;
		},
		fun:function(id){
		var state =_useraccountT.GD(id,"state");
		var vname = _useraccountT.GD(id,"name");
		var card_number =  _useraccountT.GD(id,"card_number");
		var type = "����";
		if(state==1){
			type = "����";
		}
		Tconfirm({
			Title:"��ʾ��Ϣ",
			Ttype:"alert",
			Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> "+vname+"���ʺţ�"+card_number+"����",
			OKFn:function(){
			T.A.sendData("useraccount.do?action=editstate&id="+id+"&state="+state,"GET","",
				function(ret){
					if(ret=="1"){
						T.loadTip(1,type+"�ɹ���",2,"");
						_useraccountT.C();
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
					}
				},0,null)
			}
		});
	}}); */
	bts.push({name:"�༭",
		fun:function(id){
		T.each(_useraccountT.tc.tableitems,function(o,j){
			o.fieldvalue = _useraccountT.GD(id)[j]
		});
		Twin({Id:"collector_edit_w",Title:"�༭",Width:350,sysfun:function(tObj){
			var uid = _useraccountT.GD(id,"uin");
					Tform({
						formname: "collector_f",
						formObj:tObj,
						recordid:"collector_id",
						suburl:"useraccount.do?action=editacc&from=vip&id="+id+"&uid="+uid,
						method:"POST",
						dbuttonname:["����"],
						formAttr:[{
							formitems:[{kindname:"",kinditemts:_mediaField}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("collector_edit_w");} }
						],
						Coltype:2,
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"����ɹ���",2,"");
								TwinC("collector_account_edit_w");
								_useraccountT.M();
							}else{
								T.loadTip(1,"����ʧ��",2,o)
							}
						}
						});	
					}
				})
	}});
	if(bts.length <= 0){return false;}
	return bts; 
	//return false;
}

function coutomsearch(){
	
	var html=   "<font color='red'>�����ʺ��ڿͻ��˰�</font> ";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}

_useraccountT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����˺�</title>
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
<div id="comaccountobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var comid='${comid}';
var type=${type};//0��˾�˻� 1�����˻� 2�Թ��˻�
var ishide =true;
if(type==2)//�Թ��˻�Ҫ��ʾ���ֶ�
	ishide=false;
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"��˾���",fieldname:"comid",fieldvalue:'',defaultValue:comid,inputtype:"text",twidth:"200" ,height:"",issort:false,edit:false,fhide:true},
		{fieldcnname:"����(�����п��Ǽǵ�һ��)",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"200" ,height:""},
		//{fieldcnname:"�շ�Ա",fieldname:"uin",fieldvalue:'',inputtype:"text", twidth:"100" ,height:""},
		{fieldcnname:"�˺�",fieldname:"card_number",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�˺�����",fieldname:"atype",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"���п�"},{"value_no":1,"value_name":"֧����"},{"value_no":2,"value_name":"΢��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"area",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������",fieldname:"bank_name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����֧��",fieldname:"bank_pint",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"��˾"},{"value_no":1,"value_name":"����"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"�ѽ���"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�տ���������",fieldname:"city",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:ishide,fhide:ishide},
		{fieldcnname:"���㷽ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:ishide,fhide:ishide},
		{fieldcnname:"������",fieldname:"pay_date",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:ishide,fhide:ishide},
		{fieldcnname:"��;",fieldname:"use",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:ishide,fhide:ishide},
		{fieldcnname:"�շ��к�",fieldname:"bank_no",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:ishide,fhide:ishide},
		{fieldcnname:"��ע",fieldname:"note",fieldvalue:'',inputtype:"multi",twidth:"200" ,height:"",issort:false}
	];
var rules=[
		{name:"card_number",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		{name:"mobile",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""},
		{name:"bank_name",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
		];
var _comaccountT = new TQTable({
	tabletitle:"���ֺŹ�����˾��",
	ischeck:false,
	tablename:"comaccount_tables",
	dataUrl:"comaccount.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	
	//searchitem:true,
	param:"action=query&comid="+comid+"&type=${type}",
	tableObj:T("#comaccountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bus = [];
	bus.push({dname:"����˺�",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"comaccount_add",Title:"����˺�",Width:550,sysfun:function(tObj){
				Tform({
					formname: "comaccount_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"comaccount.do?action=create&type=${type}",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("comaccount_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("comaccount_add");
							_comaccountT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}});
	return bus;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"",
		rule:function(id){
			var state =_comaccountT.GD(id,"state");
			if(state==1){
				this.name="����";
			}else{
				this.name="����";
			}
			return true;
		},
		fun:function(id){
		var state =_comaccountT.GD(id,"state");
		var vname = _comaccountT.GD(id,"name");
		var card_number =  _comaccountT.GD(id,"card_number");
		var type = "����";
		if(state==1){
			type = "����";
		}
		Tconfirm({
			Title:"��ʾ��Ϣ",
			Ttype:"alert",
			Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> "+vname+"���˺ţ�"+card_number+"����",
			OKFn:function(){
			T.A.sendData("comaccount.do?action=editstate&id="+id+"&state="+state,"GET","",
				function(ret){
					if(ret=="1"){
						T.loadTip(1,type+"�ɹ���",2,"");
						_comaccountT.C();
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
					}
				},0,null)
			}
		});
	}});
	bts.push({name:"�༭",fun:function(id){
		T.each(_comaccountT.tc.tableitems,function(o,j){
			o.fieldvalue = _comaccountT.GD(id)[j]
		});
		Twin({Id:"camera_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "camera_edit_f",
					formObj:tObj,
					recordid:"camera_id",
					suburl:"comaccount.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_comaccountT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("camera_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("camera_edit_"+id);
							_comaccountT.M()
						}else{
							T.loadTip(1,ret,2,o)
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


_comaccountT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>NFC����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?075417" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>

<body>
<div id="nfcmanageobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var comid = ${comid};
//var parkings= eval(T.A.sendData("parking.do?action=getparkings"));
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"�շ�Ա",fieldname:"nickname",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"ͣ����",fieldname:"company_name",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false,shide:true},
		{fieldcnname:"����",fieldname:"nfc_uuid",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false,shide:true},
		{fieldcnname:"ע��ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",issort:false,hide:true},
		{fieldcnname:"��ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",issort:false,hide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"ͣ��"}] , twidth:"100" ,height:"",issort:false,
			process:function(value,trId,colId){
				if(value==1)
					return "<font color='red'>ͣ��</font>";
				else 
					return "����";
			}}
	];
var rules =[{name:"nfc_uuid",type:"",url:"",requir:true,warn:"",okmsg:""}];
var _nfcmanageT = new TQTable({
	tabletitle:"NFC����",
	ischeck:false,
	tablename:"nfcmanage_tables",
	dataUrl:"nfcmanage.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#nfcmanageobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"���NFC",icon:"edit_add.png",onpress:function(Obj){
		T.each(_nfcmanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"nfcmanage_add",Title:"���NFC",Width:550,sysfun:function(tObj){
				Tform({
					formname: "nfcmanage_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"nfcmanage.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("nfcmanage_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("nfcmanage_add");
							_nfcmanageT.M();
						}else if(ret==0){
							T.loadTip(1,"���ʧ�ܣ����Ժ����ԣ�",2,"");
						}else{
							T.loadTip(1,"���ʧ�ܣ�",2,"");
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_nfcmanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"nfcmanage_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "nfcmanage_search_f",
					formObj:tObj,
					formWinId:"nfcmanage_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("nfcmanage_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_nfcmanageT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{dname:"��ͨ���û�",icon:"edit_add.png",onpress:function(Obj){
			_nfcmanageT.C({
				cpage:1,
				tabletitle:"ȫ���Ƽ�",
				extparam:"&action=sutong"
			})}
		
		}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_nfcmanageT.tc.tableitems,function(o,j){
			o.fieldvalue = _nfcmanageT.GD(id)[j]
		});
		Twin({Id:"nfcmanage_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "nfcmanage_edit_f",
					formObj:tObj,
					recordid:"nfcmanage_id",
					suburl:"nfcmanage.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_nfcmanageT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("nfcmanage_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("nfcmanage_edit_"+id);
							_nfcmanageT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"����/ͣ��",
		rule:function(id){
			var state =_nfcmanageT.GD(id,"state");
			if(state==0){//״̬������
				this.name="ͣ��";
			}else
				this.name="����";
			return true
		 },
		fun:function(id){
		var id_this = id ;
		var state =_nfcmanageT.GD(id,"state");
		var conmessage="����";
		if(state==0){//״̬������
			conmessage="ͣ��";
		}
		Tconfirm({Title:"ȷ��"+conmessage+"��",Content:"ȷ��"+conmessage+"��",OKFn:function(){T.A.sendData("nfcmanage.do?action=modify","post","selids="+id_this+"&state="+state,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,conmessage+"�ɹ���",2,"");
					_nfcmanageT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_nfcmanageT.C();
</script>

</body>
</html>

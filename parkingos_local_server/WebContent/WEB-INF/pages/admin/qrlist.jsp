<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ά�����</title>
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
<div id="qrmanageobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<script language="javascript">
var role=${role};
function getworksite(){
	return eval(T.A.sendData("getdata.do?action=getworksite"));
}
var worksites = getworksite();
function getpark(){
	return eval(T.A.sendData("getdata.do?action=getWorksitePark"));
}
var parklist = getpark();
var worksites = getworksite();
var typelist = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"�շ�Ա"},{"value_no":0,"value_name":"NFC"},{"value_no":2,"value_name":"��λ��ά��"},{"value_no":3,"value_name":"����Ա"},{"value_no":4,"value_name":"������ά��"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"��ά��",fieldname:"code",inputtype:"text", twidth:"270" ,issort:false},
		{fieldcnname:"ע������",fieldname:"ctime",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"����ͣ����",fieldname:"comid",inputtype:"cselect",noList :parklist,target:'wid',action:'getworksite', twidth:"180" ,issort:false},
		{fieldcnname:"���ڹ���վ",fieldname:"wid",inputtype:"select",noList:worksites, twidth:"80" ,issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"uid",inputtype:"text", twidth:"180" ,issort:false},
		{fieldcnname:"״̬ ",fieldname:"state",inputtype:"select", twidth:"50",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"ͣ��"},{"value_no":0,"value_name":"����"}] ,issort:false},
		{fieldcnname:"����",fieldname:"type",inputtype:"select", twidth:"150",noList:typelist ,issort:false},
		{fieldcnname:"�Ƿ�ʹ��",fieldname:"isuse",inputtype:"select",noList:[{"value_no":"1","value_name":"��ʹ��"},{"value_no":"0","value_name":"δʹ��"}]}
	];
var _qrmanageT = new TQTable({
	tabletitle:"��ά�����",
	ischeck:false,
	tablename:"qrmanage_tables",
	dataUrl:"qrmanage.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#qrmanageobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"ע���ά��",icon:"edit_add.png",onpress:function(Obj){
		T.each(_qrmanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"qrmanage_add_w",Title:"��Ӷ�ά��",Width:550,sysfun:function(tObj){
				var fields = _mediaField;
				if(fields.length<10)
					fields.push({fieldcnname:"����",fieldname:"count",inputtype:"text",twidth:"80"});
				Tform({
					formname: "qrmanage_addt_f",
					formObj:tObj,
					recordid:"id",
					suburl:"qrmanage.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:fields}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("qrmanage_add_w");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(parseInt(ret)>1){
							T.loadTip(1,"�ɹ����"+ret+"����",2,"");
							TwinC("qrmanage_add");
							_qrmanageT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_qrmanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"qrmanage_search_w",Title:"������ά��",Width:550,sysfun:function(tObj){
			var f = _mediaField;
			if(f==10)
				f[9].hide=true;
				TSform ({
					formname: "qrmanage_search_f",
					formObj:tObj,
					formWinId:"qrmanage_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:f}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("qrmanage_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_qrmanageT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},{dname:"������ά��",icon:"toxls.gif",onpress:function(Obj){
	
		Twin({Id:"parkwithdraw_search_w",Title:"������ά��",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "parkwithdraw_export_f",
					formObj:tObj,
					formWinId:"parkwithdraw_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:typelist}]}]
					}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="qrmanage.do?action=excle&"+Serializ(formName)
						TwinC("parkwithdraw_search_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})
	}},{dname:"�޸�ʹ��״̬",icon:"toxls.gif",onpress:function(Obj){
	
		Twin({Id:"qr_edit_w",Title:"�޸�ʹ��״̬",Width:480,sysfun:function(tObj){
		
			Tform({
					formname: "qr_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"qrmanage.do?action=isuse",
					method:"POST",
					dbuttonname:["ȷ���޸�"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[
						{fieldcnname:"�Ƿ�ʹ��",fieldname:"isuse",fieldvalue:'1',inputtype:"select",noList:[{"value_no":"1","value_name":"��ʹ��"},{"value_no":"0","value_name":"δʹ��"}]},
						{fieldcnname:"��ʼ���",fieldname:"bid",inputtype:"text"},
						{fieldcnname:"�������",fieldname:"eid",inputtype:"text"}
						]}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���޸�",icon:"cancel.gif", onpress:function(){TwinC("qr_edit_w");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(parseInt(ret)>1){
							T.loadTip(1,"�ɹ����"+ret+"����",2,"");
							TwinC("qr_edit_w");
							_qrmanageT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
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
	bts.push({name:"�༭",fun:function(id){
		T.each(_qrmanageT.tc.tableitems,function(o,j){
			o.fieldvalue = _qrmanageT.GD(id)[j]
		});
		Twin({Id:"qrmanage_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "qrmanage_edit_f",
					formObj:tObj,
					recordid:"qrmanage_id",
					suburl:"qrmanage.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_qrmanageT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("qrmanage_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("qrmanage_edit_"+id);
							_qrmanageT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("qrmanage.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_qrmanageT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_qrmanageT.C();
</script>

</body>
</html>

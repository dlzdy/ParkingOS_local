<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ��Ա����</title>
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
<div id="collectorobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
function getauditor (){
	var auditors = eval(T.A.sendData("getdata.do?action=getauditors"));
	return auditors;
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"��ɫ",fieldname:"role_name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true,shide:true},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"����"},{"value_no":3,"value_name":"������"},{"value_no":4,"value_name":"������"},{"value_no":5,"value_name":"�޼�ֵ"}] ,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"ע������",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"150" ,height:"",issort:false,edit:false},
		{fieldcnname:"����ͣ����",fieldname:"comname",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false,shide:true},
		{fieldcnname:"���",fieldname:"balance",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�׵����",fieldname:"firstorderquota",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������ȯ���",fieldname:"rewardquota",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�Ƽ������",fieldname:"recommendquota",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"ͣ����ȯ���",fieldname:"ticketquota",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1.00,"value_name":"������"},{"value_no":0,"value_name":"������ȯ"},{"value_no":1,"value_name":"1"},{"value_no":2,"value_name":"2"}],twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�ڸ�״̬",fieldname:"online_flag",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":23,"value_name":"�ڸ�"}] ,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�����",fieldname:"collector_auditor",fieldvalue:'',inputtype:"select",noList:getauditor(),action:"",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�Ƽ����",fieldname:"recommend",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�Ƽ����"}] ,twidth:"80" ,height:"",issort:false,fhide:true}
	];
var _editField = [
		
		{fieldcnname:"�׵����",fieldname:"firstorderquota",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������ȯ���",fieldname:"rewardquota",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�Ƽ������",fieldname:"recommendquota",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"ͣ����ȯ���",fieldname:"ticketquota",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1.00,"value_name":"������"},{"value_no":0,"value_name":"������ȯ"},{"value_no":1,"value_name":"1"},{"value_no":2,"value_name":"2"}],twidth:"80" ,height:"",issort:false}
	];
var _collectorT = new TQTable({
	tabletitle:"ͣ��Ա����",
	//ischeck:false,
	tablename:"collector_tables",
	dataUrl:"collector.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#collectorobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_collectorT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"collector_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "collector_search_f",
					formObj:tObj,
					formWinId:"collector_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("collector_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_collectorT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},{ dname:  "���Ͷ���", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _collectorT.GS();
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ���ֻ�",2,"");
			return;
		}
		/* else {
			ids=sids.split(",");
			if(ids.length>100){
				T.loadTip(1,"�ֻ��������100��",2,"");
				return;
			}
		} */
		Twin({Id:"send_message_w",Title:"���Ͷ���",Width:550,sysfun:function(tObj){
			Tform({
				formname: "send_message_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"collector.do?action=sendmesg",
				method:"POST",
				Coltype:2,
				dbuttonname:["����"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"ͣ��Ա���",fieldname:"ids",fieldvalue:sids,inputtype:"multi",height:"80",edit:false},
					{fieldcnname:"��������",fieldname:"message",fieldvalue:'',inputtype:"multi",height:"100",issort:false}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"���ͳɹ���",2,"");
						TwinC("send_message_w");
					}else{
						T.loadTip(1,"����ʧ��",2,o);
					}
				}
			});	
			}
		})
		
	}},
	{dname:"����ͣ��Ա",icon:"edit_add.png",onpress:function(Obj){
			_collectorT.C({
				cpage:1,
				tabletitle:"����ͣ��Ա",
				extparam:"&action=withdraw"
			})}
		
	},
	{dname:"�����ͣ��Ա",icon:"edit_add.png",onpress:function(Obj){
		location = "collector.do?action=validateuser";
		}
	},
	{dname:"����ͣ��Ա�˻�",icon:"edit_add.png",onpress:function(Obj){
		location = "collector.do?action=useraccount";
		}
	}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_collectorT.tc.tableitems,function(o,j){
			o.fieldvalue = _collectorT.GD(id)[j]
		});
		Twin({Id:"collector_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "collector_edit_f",
					formObj:tObj,
					recordid:"collector_id",
					suburl:"collector.do?action=editquota&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_collectorT.tc.tableitems}],
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("member_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("collector_edit_"+id);
							_collectorT.M();
						}else{
							T.loadTip(1,"�༭ʧ�ܣ�",2,o)
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("collector.do?action=delcollector","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_collectorT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	bts.push({name:"",
		rule:function(id){
			var state =_collectorT.GD(id,"state");
			if(state==1){
				this.name="����";
			}else{
				this.name="����";
			}
			return true;
		},
		fun:function(id){
		var state =_collectorT.GD(id,"state");
		var vname = _collectorT.GD(id,"nickname");
		var type = "����";
		if(state==1){
			type = "����";
		}
		Tconfirm({
			Title:"��ʾ��Ϣ",
			Ttype:"alert",
			Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> "+vname+"��",
			OKFn:function(){
			T.A.sendData("collector.do?action=delete&id="+id+"&state="+state,"GET","",
				function(ret){
					if(ret=="1"){
						T.loadTip(1,type+"�ɹ���",2,"");
						_collectorT.C();
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
					}
				},0,null)
			}
		});
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_collectorT.C();
</script>

</body>
</html>

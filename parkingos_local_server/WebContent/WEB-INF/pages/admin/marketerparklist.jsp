<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ��������</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?5555" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<script src="js/tq.newtree.js?1014" type="text/javascript"></script>

</head>
<body>
<div id="marketerparkobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
function getMarketers (){
	var markets = eval(T.A.sendData("marketerpark.do?action=getmarketers"));
	return markets;
}
function getBizcircles(){
	var bizs = eval(T.A.sendData("marketerpark.do?action=getbizs"));
	return bizs;
}
var role=${role};
var marketers=getMarketers();
var bizcircles = getBizcircles();
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"40" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"180" ,height:"",issort:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ϵ��",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"��ϵ���ֻ�",fieldname:"cmobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"������ҵ",fieldname:"property",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"park_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"stop_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"ƽ������"},{"value_no":1,"value_name":"��������"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�ܽ��",fieldname:"total_money",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,hide:true},
		{fieldcnname:"��ǰ���",fieldname:"money",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,hide:true},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"select",noList:marketers, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������Ȧ",fieldname:"biz_id",fieldvalue:'',inputtype:"select",noList:bizcircles, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�ͻ�����",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"marketerpark.do?action=localdata",edit:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'&&parseInt(value)>0){
					var local = T.A.sendData("marketerpark.do?action=getlocalbycode&code="+value);
					return local;
				}else
					return value;
			}},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�����"},{"value_no":2,"value_name":"δ���"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"nfc",fieldname:"nfc",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"etc",fieldname:"etc",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"Ԥ��",fieldname:"book",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"���ڵ���",fieldname:"navi",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"֧���¿�",fieldname:"monthlypay",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",fhide:true,hide:true,shide:true},
		{fieldcnname:"",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",fhide:true,hide:true,shide:true}
	];
var _addField = [
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"������ҵ",fieldname:"property",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"marketerpark_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"stop_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"ƽ������"},{"value_no":1,"value_name":"��������"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"marketerpark_total",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,hide:true},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"select",noList:marketers, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"������Ȧ",fieldname:"biz_id",fieldvalue:'',inputtype:"select",noList:bizcircles, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ͻ�����",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"marketerpark.do?action=localdata",edit:true},
		{fieldcnname:"nfc",fieldname:"nfc",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"etc",fieldname:"etc",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"Ԥ��",fieldname:"book",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"���ڵ���",fieldname:"navi",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"֧���¿�",fieldname:"monthlypay",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",fhide:true,hide:true,shide:true},
		{fieldcnname:"",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",fhide:true,hide:true,shide:true}
	];
var rules =[
		{name:"company_name",type:"",url:"",requir:true,warn:"����Ϊ��!",okmsg:""}
		];
var _marketerparkT = new TQTable({
	tabletitle:"�����ͣ����",
	ischeck:false,
	tablename:"marketerpark_tables",
	dataUrl:"marketerpark.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#marketerparkobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"ע��ͣ����",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"marketerpark_add",Title:"���ͣ����",Width:550,sysfun:function(tObj){
				Tform({
					formname: "marketerpark_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"marketerpark.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("marketerpark_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("marketerpark_add");
							_marketerparkT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_marketerparkT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
			if(o.fieldname=='strid'||o.fieldname=='nickname'||o.fieldname=='cmobile')
				o.shide=true;
		});
		Twin({Id:"marketerpark_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "marketerpark_search_f",
					formObj:tObj,
					formWinId:"marketerpark_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("marketerpark_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_marketerparkT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{dname:"�����ͣ����",icon:"edit_add.png",onpress:function(Obj){
		//this.dname='<font color="red">�����ͣ����</font>';
		_marketerparkT.C({cpage:1,tabletitle:"�����ͣ����",
			extparam:"&action=quickquery&state=0"
		})
	
	}},
	{dname:"δ���ͣ����",icon:"edit_add.png",onpress:function(Obj){
		_marketerparkT.C({cpage:1,tabletitle:"δ���ͣ����",
			extparam:"&action=quickquery&state=2"
		})
	}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_marketerparkT.tc.tableitems,function(o,j){
			if(o.fieldname=='city'){
				var code = _marketerparkT.GD(id)[j];
				var local = T.A.sendData("marketerpark.do?action=getlocalbycode&code="+code);	
				o.fieldvalue = code+"||"+local;
			}else
				o.fieldvalue = _marketerparkT.GD(id)[j]
		});
		Twin({Id:"marketerpark_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "marketerpark_edit_f",
					formObj:tObj,
					recordid:"marketerpark_id",
					suburl:"marketerpark.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_marketerparkT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("marketerpark_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("marketerpark_edit_"+id);
							_marketerparkT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("marketerpark.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_marketerparkT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	bts.push({name:"����",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"ͣ��������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"parksetting.do?id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	if(bts.length <= 0){return false;}
	return bts;
}
_marketerparkT.C();
</script>

</body>
</html>

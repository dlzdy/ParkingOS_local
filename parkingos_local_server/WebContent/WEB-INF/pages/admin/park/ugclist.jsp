<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>UGCͣ��������</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?033434" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<script src="js/tq.newtree.js?1014" type="text/javascript"></script>

</head>
<body>
<div id="ugcparkingobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
function getMarketers (){
	var markets = eval(T.A.sendData("getdata.do?action=markets"));
	return markets;
}
function getBizcircles(){
	var bizs = eval(T.A.sendData("parking.do?action=getbizs"));
	return bizs;
}
var role=${role};
var marketers=getMarketers();
var bizcircles = getBizcircles();
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var etc_states=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
var etc_add_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]

var isfixed = false;
if(role==7)
	isfixed=true;
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"40" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"180" ,height:"",issort:false},
		{fieldcnname:"ͣ�����绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"������ҵ",fieldname:"mcompany",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"ugcparking_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"},{"value_no":3,"value_name":"����/����"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"stop_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"ƽ������"},{"value_no":1,"value_name":"��������"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"ugcparking_total",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��ʷ������",fieldname:"total_money",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,hide:true},
		{fieldcnname:"��ǰ���",fieldname:"money",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,hide:true},
		{fieldcnname:"���г�רԱ�ĳ���",fieldname:"no_marketer",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"���г�רԱ"}], twidth:"60" ,height:"",issort:false,fhide:true},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"select",noList:marketers, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"������Ȧ",fieldname:"biz_id",fieldvalue:'',inputtype:"select",noList:bizcircles, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�ͻ�����",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"ugcparking.do?action=localdata",edit:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'&&parseInt(value)>0){
					var local = T.A.sendData("ugcparking.do?action=getlocalbycode&code="+value);
					return local;
				}else
					return value;
			}},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�����"},{"value_no":2,"value_name":"δ���"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�Ƿ�У��",fieldname:"isfixed",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δУ��"},{"value_no":1,"value_name":"��У��"},{"value_no":2,"value_name":"����У��"},{"value_no":3,"value_name":"һ��δͨ��"},{"value_no":4,"value_name":"����δͨ��"},{"value_no":5,"value_name":"����δͨ��"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"NFC",fieldname:"nfc",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"ETC",fieldname:"etc",fieldvalue:'',inputtype:"select",noList:etc_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"Ԥ��",fieldname:"book",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"���ڵ���",fieldname:"navi",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"֧���¿�",fieldname:"monthlypay",fieldvalue:'',inputtype:"select",noList:states, twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"ҹ��ͣ��",fieldname:"isnight",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"֧��"},{"value_no":1,"value_name":"��֧��"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"����֧��",fieldname:"epay",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"֧��"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false},
		{fieldcnname:"�շ�Ա�ڸ�״̬",fieldname:"is_hasparker",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"���ڸ�"},{"value_no":1,"value_name":"�ڸ�"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"��ͼ��ʾ",fieldname:"isview",fieldvalue:'',defaultValue:'��ʾ||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����ʾ"},{"value_no":1,"value_name":"��ʾ"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"δ����������������",fieldname:"invalid_order",fieldvalue:'',inputtype:"text", twidth:"150" ,height:""},
		{fieldcnname:"���ִ�С��",fieldname:"car_type",fieldvalue:'',defaultValue:'������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�Ƿ�������ѽ��㶩��",fieldname:"passfree",fieldvalue:'',defaultValue:'����||0',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"������"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"activity",fieldvalue:'',defaultValue:'ȫ��||-1',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"û�л"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"����ͨ��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����",fieldname:"activity_content",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�ϴ���",fieldname:"upload_uin",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,issort:false}
		];

var _ugcparkingT = new TQTable({
	tabletitle:"�����UGCͣ����",
	ischeck:false,
	tablename:"ugcparking_tables",
	dataUrl:"parking.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&state=0&ptype=1",
	tableObj:T("#ugcparkingobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	var bus = [];
	if(role!=6&&role!=8)
	bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_ugcparkingT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
			if(o.fieldname=='strid'||o.fieldname=='nickname'||o.fieldname=='cmobile')
				o.shide=true;
		});
		Twin({Id:"ugcparking_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "ugcparking_search_f",
					formObj:tObj,
					formWinId:"ugcparking_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("ugcparking_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_ugcparkingT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	
	bus.push({dname:"����ͣ��������",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do";
	}});
	bus.push({dname:"�����UGCͣ����",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do?action=ugc&state=0";
	}});
	bus.push({dname:"δ���UGCͣ����",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do?action=ugc&state=2";
	}});
	return bus;
}
function getAuthIsoperateButtons(){
	var bts = [];
	if(role!=6&&role!=8)
	bts.push({name:"�༭",fun:function(id){
		var fixed = _ugcparkingT.GD(id,"isfixed");
		T.each(_ugcparkingT.tc.tableitems,function(o,j){
			if(o.fieldname=='city'){
				var code = _ugcparkingT.GD(id)[j];
				var local = T.A.sendData("parking.do?action=getlocalbycode&code="+code);	
				o.fieldvalue = code+"||"+local;
			}else
				o.fieldvalue = _ugcparkingT.GD(id)[j]
		});
		;
		Twin({Id:"ugcparking_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "ugcparking_edit_f",
					formObj:tObj,
					recordid:"ugcparking_id",
					suburl:"parking.do?action=modify&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_ugcparkingT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("ugcparking_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("ugcparking_edit_"+id);
							_ugcparkingT.M()
						}else if(ret=="-1"){
							T.loadTip(1,"��γ���ظ���",2,o);
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
		if(fixed=='1'&&role!=7){//�Ѷ�λ�������޸ľ�γ��
			T("#ugcparking_edit_f_address").disabled=true;
			T("#ugcparking_edit_f_address_showmap").disabled=true;
		}
	}});
if(role!=6&&role!=7&&role!=8)
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("ugcparking.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_ugcparkingT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	bts.push({name:"����ʾ",
		rule:function(id){
				var state =_ugcparkingT.GD(id,"isview");
				if(state==1){
					this.name="����ʾ";
				}else{
					this.name=" &nbsp;��  ʾ      ";
				}
				return true;
			},
		tit:"�����Ƿ����ֻ��ͻ��˵�ͼ����ʾ",
		fun:function(id){
			var state =_ugcparkingT.GD(id,"isview");
			var type = "��ʾ���ֻ���ͼ";
			if(state==1){
				type = "����ʾ���ֻ���ͼ";
			}
			Tconfirm({
				Title:"��ʾ��Ϣ",
				Ttype:"alert",
				Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> ��",
				OKFn:function(){
				T.A.sendData("ugcparking.do?action=isview&id="+id+"&isview="+state,"GET","",
					function(ret){
						if(ret=="1"){
							T.loadTip(1,"����"+type+"�ɹ���",2,"");
							_ugcparkingT.C();
						}else{
							T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
						}
					},0,null)
				}
			});
		}});
	if(role!=6&&role!=8)
	bts.push({name:"����",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"ͣ��������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"parksetting.do?id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
		
	bts.push({name:"��λ����",fun:function(id){
		var pname = _ugcparkingT.GD(id,"company_name");
		Twin({
			Id:"client_detail_"+id,
			Title:"��λ����  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"parklalaanly.do?action=parkidle&pname="+encodeURI(encodeURI(pname))+"&comid="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	if(bts.length <= 0){return false;}
	return bts;
}
_ugcparkingT.C();
</script>

</body>
</html>

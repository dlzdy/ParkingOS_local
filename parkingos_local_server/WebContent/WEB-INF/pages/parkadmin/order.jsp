<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
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
<div id="orderobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<script language="javascript">
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var comid = ${comid};
var collectors = eval(T.A.sendData("order.do?action=getalluser"));
var freereasons = eval(T.A.sendData("order.do?action=getfreereasons"));
function getpass (){
	var pass = eval(T.A.sendData("getdata.do?action=getcompass&comid=${comid}"));
	return pass;
}
var pass = getpass();
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"NFCˢ��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"�ֻ�ɨ��"},{"value_no":3,"value_name":"ͨ��ɨ��"},{"value_no":4,"value_name":"ֱ��"},{"value_no":5,"value_name":"�¿�"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:true},
		{fieldcnname:"ʱ��",fieldname:"duration",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�˻�֧��"},{"value_no":1,"value_name":"�ֽ�֧��"},{"value_no":2,"value_name":"�ֻ�֧��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����Ԥ֧���ֽ�"},{"value_no":5,"value_name":"����Ԥ֧��������"},{"value_no":6,"value_name":"����Ԥ֧���̼ҿ�"},{"value_no":8,"value_name":"���"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ԭ��",fieldname:"freereasons",fieldvalue:'',inputtype:"select",noList:freereasons ,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false},
		{fieldcnname:"�տ���",fieldname:"uid",fieldvalue:'',inputtype:"select", noList:collectors, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ֧��"},{"value_no":1,"value_name":"��֧��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�鿴����ͼƬ",fieldname:"id",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
			}},
		{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"out_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false}
	];
var _searchField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"NFCˢ��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"�ֻ�ɨ��"},{"value_no":3,"value_name":"ͨ��ɨ��"},{"value_no":4,"value_name":"ֱ��"},{"value_no":5,"value_name":"�¿�"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:true},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�˻�֧��"},{"value_no":1,"value_name":"�ֽ�֧��"},{"value_no":2,"value_name":"�ֻ�֧��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����Ԥ֧���ֽ�"},{"value_no":5,"value_name":"����Ԥ֧��������"},{"value_no":6,"value_name":"����Ԥ֧���̼ҿ�"},{"value_no":8,"value_name":"���"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ԭ��",fieldname:"freereasons",fieldvalue:'',inputtype:"select",noList:freereasons ,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false},
		{fieldcnname:"�տ���",fieldname:"uid",fieldvalue:'',inputtype:"select", noList:collectors, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ֧��"},{"value_no":1,"value_name":"��֧��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�鿴����ͼƬ",fieldname:"id",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
			}},
		{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"out_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false}
	];
var _excelField = [
		{fieldcnname:"������ʽ",fieldname:"c_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"NFCˢ��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"�ֻ�ɨ��"},{"value_no":3,"value_name":"ͨ��ɨ��"},{"value_no":4,"value_name":"ֱ��"},{"value_no":5,"value_name":"�¿�"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"end_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:true},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�˻�֧��"},{"value_no":1,"value_name":"�ֽ�֧��"},{"value_no":2,"value_name":"�ֻ�֧��"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����Ԥ֧���ֽ�"},{"value_no":5,"value_name":"����Ԥ֧��������"},{"value_no":6,"value_name":"����Ԥ֧���̼ҿ�"},{"value_no":8,"value_name":"���"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false},
		{fieldcnname:"�տ���",fieldname:"uid",fieldvalue:'',inputtype:"select", noList:collectors, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ֧��"},{"value_no":1,"value_name":"��֧��"}] ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"in_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"out_passid",fieldvalue:'',inputtype:"select",noList:pass, twidth:"100" ,height:"",issort:false}
	];
var _excelField = [
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"number", height:"",issort:false},
	];
var _orderT = new TQTable({
	tabletitle:"��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
	//ischeck:false,
	tablename:"order_tables",
	dataUrl:"order.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#orderobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	if(parseInt(role)==15||parseInt(role)==3){
		return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_orderT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"order_search_w",Title:"��������",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "order_search_f",
					formObj:tObj,
					formWinId:"order_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_searchField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("order_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_orderT.C({
							cpage:1,
							tabletitle:"�߼��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}}
	]
	}else{
		return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_orderT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"order_search_w",Title:"��������",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "order_search_f",
					formObj:tObj,
					formWinId:"order_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_searchField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("order_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_orderT.C({
							cpage:1,
							tabletitle:"�߼��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${parkinfo}",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},{dname:"��������",icon:"toxls.gif",onpress:function(Obj){
	
		Twin({Id:"order_export_w",Title:"��������<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "order_export_f",
					formObj:tObj,
					formWinId:"order_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_excelField}],
					}],
					//formitems:[{kindname:"",kinditemts:_excelField}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="order.do?action=exportExcel&comid="+comid+"&rp="+2147483647+"&fieldsstr="+"id__c_type__car_number__create_time__end_time__duration__pay_type__total__uid__state__id__in_passid__out_passid&"+Serializ(formName)
						TwinC("order_export_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})
	}},{dname:"0Ԫ����",icon:"toxls.gif",onpress:function(Obj){
		var sids = _orderT.GS();
		//var a = _orderT.GSByField("c_type");
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ�񶩵�",2,"");
			return;
		}
		Tconfirm({Title:"ȷ��0Ԫ���㶩����",Content:"ȷ��0Ԫ������ѡ������",OKFn:function(){
			T.A.sendData("order.do?action=completezeroorder","post","ids="+sids,
		function complete(ret){
			T.loadTip(1,"����ɹ�"+ret+"��",2,"");
			location.reload();
		}
		)}})
	}}
	]
	}
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}

function viewdetail(type,value,id){
	var car_number =_orderT.GD(id,"car_number");
	var tip = "����ͼƬ";
	Twin({
		Id:"carpics_detail_"+id,
		Title:tip+"  --> ���ƣ�"+car_number,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}
_orderT.C();
</script>

</body>
</html>

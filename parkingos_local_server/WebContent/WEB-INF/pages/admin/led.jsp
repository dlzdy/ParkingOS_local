<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>LED������</title>
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
<div id="ledobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var comid = ${comid};
function getWorksites (){
	var worksites = eval(T.A.sendData("led.do?action=getworksites&comid="+comid));
	return worksites;
}
var worksites = getWorksites();
var moveMode = [{"value_no":0,"value_name":"����Ӧ"},{"value_no":1,"value_name":"���������ƶ�"},{"value_no":2,"value_name":"���������ƶ�"},{"value_no":3,"value_name":"���������ƶ�"},{"value_no":4,"value_name":"���������ƶ�"},{"value_no":5,"value_name":"��������չ��"},{"value_no":6,"value_name":"��������չ��"},{"value_no":7,"value_name":"��������չ��"},{"value_no":8,"value_name":"��������չ��"},{"value_no":9,"value_name":"������ʾ"},{"value_no":10,"value_name":"���м�������չ��"},{"value_no":11,"value_name":"���������м�չ��"},{"value_no":12,"value_name":"���м�������չ��"},{"value_no":13,"value_name":"���������м�չ��"},{"value_no":14,"value_name":"��˸"},{"value_no":15,"value_name":"�Ұ�Ҷ"}];
var moveSpeed = [{"value_no":0,"value_name":"0"},{"value_no":1,"value_name":"1"},{"value_no":2,"value_name":"2"},{"value_no":3,"value_name":"3"},{"value_no":4,"value_name":"4"},{"value_no":5,"value_name":"5"},{"value_no":6,"value_name":"6"},{"value_no":7,"value_name":"7"},{"value_no":8,"value_name":"8"}];
var dwellTime = [{"value_no":0,"value_name":"0s"},{"value_no":1,"value_name":"1s"},{"value_no":2,"value_name":"2s"},{"value_no":3,"value_name":"3s"},{"value_no":4,"value_name":"4s"},{"value_no":5,"value_name":"5s"}];
var ledColor = [{"value_no":0,"value_name":"����ɫ"},{"value_no":1,"value_name":"˫��ɫ"}];
var showColor = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"},{"value_no":2,"value_name":"��"}];
var typeFace = [{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"����"},{"value_no":3,"value_name":"����"},{"value_no":4,"value_name":"����"},{"value_no":5,"value_name":"����"}];
var typeSize = [{"value_no":0,"value_name":"12��12"},{"value_no":1,"value_name":"16��16"},{"value_no":2,"value_name":"24��24"},{"value_no":3,"value_name":"32��32"},{"value_no":4,"value_name":"48��48"},{"value_no":5,"value_name":"64��64"},{"value_no":6,"value_name":"80��80"},{"value_no":7,"value_name":"96��96"}];
var _field = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false,edit:false,fhide:true},
		{fieldcnname:"ip��ַ",fieldname:"ledip",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�˿ں�",fieldname:"ledport",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ز�UID",fieldname:"leduid",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ƶ���ʽ",fieldname:"movemode",fieldvalue:'',inputtype:"select",noList:moveMode,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ƶ��ٶ�",fieldname:"movespeed",fieldvalue:'',inputtype:"select",noList:moveSpeed,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"ͣ��ʱ��",fieldname:"dwelltime",fieldvalue:'',inputtype:"select",noList:dwellTime,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"��ʾ����ɫ",fieldname:"ledcolor",fieldvalue:'',inputtype:"select",noList:ledColor,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"��ɫ",fieldname:"showcolor",fieldvalue:'',inputtype:"select",noList:showColor,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"typeface",fieldvalue:'',inputtype:"select",noList:typeFace,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"�ֺ�",fieldname:"typesize",fieldvalue:'',inputtype:"select",noList:typeSize,twidth:"50" ,height:"",issort:false},
		{fieldcnname:"�ز�����",fieldname:"matercont",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��",fieldname:"width",fieldvalue:'',inputtype:"text",twidth:"50" ,height:"",issort:false},
		{fieldcnname:"��",fieldname:"height",fieldvalue:'',inputtype:"text",twidth:"50" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��ͨ��"},{"value_no":1,"value_name":"��λ��"}],twidth:"80" ,height:"",issort:false},
		{fieldcnname:"ת���˿�",fieldname:"rsport",fieldvalue:'',inputtype:"select",noList:[{"value_no":1,"value_name":"rs232-1"},{"value_no":2,"value_name":"rs232-2"},{"value_no":3,"value_name":"rs485"}],twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��������վ",fieldname:"worksite_id",fieldvalue:'',inputtype:"cselect",noList:worksites,target:"passid",action:"getpass",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����ͨ��",fieldname:"passid",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"160" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'passid');
			}},
		];
var rules =[{name:"passid",requir:true}];
var _ledT = new TQTable({
	tabletitle:"LED������",
	ischeck:false,
	tablename:"led_tables",
	dataUrl:"led.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#ledobj"),
	fit:[true,true,true],
	tableitems:_field,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"���LED��",icon:"edit_add.png",onpress:function(Obj){
		T.each(_ledT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"led_add",Title:"���LED��",Width:550,sysfun:function(tObj){
				Tform({
					formname: "led_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"led.do?action=create&comid="+comid,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_field}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("led_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("led_add");
							_ledT.M();
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
	
	}}]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_ledT.tc.tableitems,function(o,j){
			o.fieldvalue = _ledT.GD(id)[j]
		});
		Twin({Id:"led_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "led_edit_f",
					formObj:tObj,
					recordid:"led_id",
					suburl:"led.do?action=edit&id="+id+"&comid="+comid,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_ledT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("led_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("led_edit_"+id);
							_ledT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("led.do?action=delete","post","selids="+id_this+"&comid="+comid,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_ledT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"led.do?action=getname&passid="+value,
    		method:"GET",//POST or GET
    		param:"",//GETʱΪ��
    		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
    		dataType:"0",//0text,1xml,2obj
    		success:function(ret,tipObj,thirdParam){
    			if(ret){
					updateRow(pid,colname,ret);
    			}
				else
					updateRow(pid,colname,value);
			},//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
    		failure:function(ret,tipObj,thirdParam){
				return false;
			},//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
    		thirdParam:"",//�ص������еĵ���������
    		tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
    		waitTip:"���ڻ�ȡͨ������...",
    		noCover:true
		})
	}else{
		return "��"
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}

/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_ledT.UCD(rowid,name,value);
}

_ledT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͨ������</title>
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
<div id="passobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var comid = ${comid};
function getWorksites (){
	var worksites = eval(T.A.sendData("passedit.do?action=getworksites&comid="+comid));
	return worksites;
}
function getBrake(id){
	var brake = eval(T.A.sendData("passedit.do?action=getbrake&passid="+id));
	return brake;
}
var worksites = getWorksites();
var _mediaField = [
		{fieldcnname:"ͨ��ID",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false,fhide:true},
		{fieldcnname:"����",fieldname:"passname",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ͨ������",fieldname:"passtype",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"},{"value_no":2,"value_name":"����"}], twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������վ",fieldname:"worksite_id",fieldvalue:'',inputtype:"select",noList:worksites, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"˵��",fieldname:"description",fieldvalue:'',inputtype:"text", twidth:"500" ,height:"",issort:false}
	];
var rules =[{name:"passname",requir:true},{name:"worksite_name",requir:true}];
var _passT = new TQTable({
	tabletitle:"ͨ������",
	ischeck:false,
	tablename:"pass_tables",
	dataUrl:"passedit.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=passquery&comid="+comid,
	tableObj:T("#passobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"���ͨ��",icon:"edit_add.png",onpress:function(Obj){
		T.each(_passT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"pass_add",Title:"���ͨ��",Width:550,sysfun:function(tObj){
				Tform({
					formname: "pass_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"passedit.do?action=create&comid="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("pass_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("pass_add");
							_passT.M();
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
		T.each(_passT.tc.tableitems,function(o,j){
			o.fieldvalue = _passT.GD(id)[j]
		});
		Twin({Id:"pass_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "pass_edit_f",
					formObj:tObj,
					recordid:"pass_id",
					suburl:"passedit.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_passT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("pass_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("pass_edit_"+id);
							_passT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("passedit.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_passT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	
	bts.push({name:"��բ",fun:function(id){
		T.each(_passT.tc.tableitems,function(o,j){
			o.fieldvalue = _passT.GD(id)[j]
		});
		Twin({Id:"pass_brake_"+id,Title:"��բ",Width:550,sysfunI:id,sysfun:function(id,tObj){
				var brake = getBrake(id)[0];
				Tform({
					formname: "pass_brake",
					formObj:tObj,
					recordid:"pass_id",
					suburl:"passedit.do?action=brake&passid="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[
							{fieldcnname:"����",fieldname:"brake_name",fieldvalue:brake.brake_name,inputtype:"text", twidth:"200" ,height:"",issort:false},
							{fieldcnname:"���ں�",fieldname:"serial",fieldvalue:brake.serial,inputtype:"text", twidth:"200" ,height:"",issort:false},
							{fieldcnname:"�豸��ַ",fieldname:"ip",fieldvalue:brake.ip,inputtype:"text", twidth:"200" ,height:"",issort:false}]}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���ɹ�",icon:"cancel.gif", onpress:function(){TwinC("pass_brake_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�����ɹ���",2,"");
							TwinC("pass_brake_"+id);
							_passT.M()
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
}
_passT.C();
</script>

</body>
</html>


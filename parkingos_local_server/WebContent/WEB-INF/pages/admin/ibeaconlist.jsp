<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Ibeacon����</title>
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
<div id="ibeaconobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var parkid=${parkid};
function getcompass(){
	return eval(T.A.sendData("getdata.do?action=getcompass"));
}
function getpark(){
	return eval(T.A.sendData("getdata.do?action=getIbeaconPark"));
}
var passlist = getcompass();
var parklist = getpark();
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"Ibeacon���",fieldname:"ibcid",inputtype:"text", twidth:"270" ,issort:false},
		{fieldcnname:"ע������",fieldname:"reg_time",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"����ͣ����",fieldname:"comid",inputtype:"cselect",noList :parklist,target:'pass',action:'getcompass', twidth:"180" ,issort:false},
		{fieldcnname:"����ͨ��",fieldname:"pass",inputtype:"select",noList:passlist, twidth:"180" ,issort:false},
		{fieldcnname:"major",fieldname:"major",inputtype:"text",twidth:"50" ,issort:false},
		{fieldcnname:"minor",fieldname:"minor",inputtype:"text",twidth:"50" ,issort:false},
		{fieldcnname:"״̬ ",fieldname:"state",inputtype:"select", twidth:"50",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"����"},{"value_no":0,"value_name":"ͣ��"}] ,issort:false},
		{fieldcnname:"γ��",fieldname:"lat",inputtype:"text", twidth:"80" ,issort:false},
		{fieldcnname:"����",fieldname:"lng",inputtype:"text", twidth:"80" ,issort:false}
		
	];
var rules =[{name:"strid",type:"ajax",url:"ibeacon.do?action=check&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""}];
function viewpic(name){
	var url = 'viewpic.html?name='+name;
	Twin({Id:"ibeacon_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
var _ibeaconT = new TQTable({
	tabletitle:"Ibeacon����",
	ischeck:false,
	tablename:"ibeacon_tables",
	dataUrl:"ibeacon.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&parkid="+parkid,
	tableObj:T("#ibeaconobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"ע��Ibeacon",icon:"edit_add.png",onpress:function(Obj){
		T.each(_ibeaconT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"ibeacon_add",Title:"���Ibeacon",Width:550,sysfun:function(tObj){
				Tform({
					formname: "ibeacon_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"ibeacon.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("ibeacon_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("ibeacon_add");
							_ibeaconT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_ibeaconT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"ibeacon_search_w",Title:"����Ibeacon",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "ibeacon_search_f",
					formObj:tObj,
					formWinId:"ibeacon_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("ibeacon_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_ibeaconT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
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
		T.each(_ibeaconT.tc.tableitems,function(o,j){
			o.fieldvalue = _ibeaconT.GD(id)[j]
		});
		Twin({Id:"ibeacon_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "ibeacon_edit_f",
					formObj:tObj,
					recordid:"ibeacon_id",
					suburl:"ibeacon.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_ibeaconT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("ibeacon_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("ibeacon_edit_"+id);
							_ibeaconT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("ibeacon.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_ibeaconT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_ibeaconT.C();
</script>

</body>
</html>

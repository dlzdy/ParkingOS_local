<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����Ա����</title>
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
<div id="parkattendantobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var _mediaField = [
		{fieldcnname:"�˺�",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"����",fieldname:"nickname",inputtype:"text", twidth:"150" ,issort:false,edit:false},
		{fieldcnname:"����ͣ����",fieldname:"comid",inputtype:"showmap", twidth:"150" ,issort:false,edit:false},
		{fieldcnname:"��������",fieldname:"reg_time",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"�����¼ ",fieldname:"logon_time",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"�޸����� ",fieldname:"utime",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"����",fieldname:"driver_year",inputtype:"text", twidth:"50" ,issort:false},
		{fieldcnname:"״̬ ",fieldname:"state",inputtype:"select", twidth:"50",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":5,"value_name":"ͣ��"}] ,issort:false},
		{fieldcnname:"֤����",fieldname:"driver_pic",inputtype:"text",twidth:"150" ,issort:false,
		process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>"+value+"</a>";
				}else
					return value;
			}},
		{fieldcnname:"��Ƭ",fieldname:"pic_url",inputtype:"date", twidth:"150" ,edit:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>"+value+"</a>";
				}else
					return value;
			}
		},
		{fieldcnname:"��ע",fieldname:"resume",inputtype:"text", twidth:"150" ,issort:false}
		
	];
var rules =[{name:"strid",type:"ajax",url:"parkattendant.do?action=check&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""}];
function viewpic(name){
	var url = 'viewpic.html?name='+name;
	Twin({Id:"parkattendant_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
var _parkattendantT = new TQTable({
	tabletitle:"����Ա����",
	ischeck:false,
	tablename:"parkattendant_tables",
	dataUrl:"parkattendant.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#parkattendantobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	/* return [{dname:"ע�Ჴ��Ա",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkattendantT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"parkattendant_add",Title:"��Ӳ���Ա",Width:550,sysfun:function(tObj){
				Tform({
					formname: "parkattendant_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"parkattendant.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parkattendant_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("parkattendant_add");
							_parkattendantT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}}
	,
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkattendantT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"parkattendant_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "parkattendant_search_f",
					formObj:tObj,
					formWinId:"parkattendant_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parkattendant_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_parkattendantT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}}
	] */
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_parkattendantT.tc.tableitems,function(o,j){
			o.fieldvalue = _parkattendantT.GD(id)[j]
		});
		Twin({Id:"parkattendant_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "parkattendant_edit_f",
					formObj:tObj,
					recordid:"parkattendant_id",
					suburl:"parkattendant.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_parkattendantT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("parkattendant_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("parkattendant_edit_"+id);
							_parkattendantT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	/* bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("parkattendant.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_parkattendantT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}}); */
	bts.push({name:"�ϴ���Ƭ",fun:function(id){
		var url ="upload.html?url=parkattendant&action=uploadpic&table=carstop_pics&type=0&id="+id;
		Twin({Id:"parkattendant_edit_"+id,Title:"�ϴ���Ƭ",Width:350,Height:200,sysfunI:id,
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				_parkattendantT.M();
			}
			})
	}});
	bts.push({name:"�ϴ�֤����",fun:function(id){
		var url ="upload.html?url=parkattendant&action=uploadpic&table=carstop_pics&type=1&id="+id;
		Twin({Id:"parkattendant_edit_"+id,Title:"�ϴ�֤����",Width:350,Height:200,sysfunI:id,
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				_parkattendantT.M();
			}
			})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_parkattendantT.C();
</script>

</body>
</html>

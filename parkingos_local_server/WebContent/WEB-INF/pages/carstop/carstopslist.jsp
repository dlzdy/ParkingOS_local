<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���������</title>
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
<script src="js/tq.newtree.js?1014" type="text/javascript"></script>

</head>
<body>
<div id="carstopsobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"����",fieldname:"name",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"λ��",fieldname:"address",inputtype:"showmap", twidth:"150" ,issort:false},
		{fieldcnname:"���ڳ���",fieldname:"city",fieldvalue:"",inputtype:"select",noList:[],dataurl:"parking.do?action=localdata",edit:true,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'&&parseInt(value)>0){
					var local = T.A.sendData("parking.do?action=getlocalbycode&code="+value);
					return local;
				}else
					return value;
			}},
		{fieldcnname:"��������",fieldname:"ctime",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"�޸����� ",fieldname:"utime",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"�𲽼�",fieldname:"start_price",inputtype:"text", twidth:"50" ,issort:false},
		{fieldcnname:"��߼�",fieldname:"max_price",inputtype:"text",twidth:"50" ,issort:false},
		{fieldcnname:"�۸�",fieldname:"next_price",inputtype:"text",twidth:"50" ,issort:false},
		{fieldcnname:"״̬ ",fieldname:"state",inputtype:"select", twidth:"50",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":5,"value_name":"ͣ��"}] ,issort:false},
		{fieldcnname:"���� ��",fieldname:"creator",inputtype:"text",twidth:"70" ,issort:false,edit:false},
		{fieldcnname:"��Ƭ",fieldname:"pic",inputtype:"date", twidth:"150" ,edit:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>"+value+"</a>";
				}else
					return value;
			}
		},
		{fieldcnname:"γ��",fieldname:"latitude",inputtype:"text", twidth:"80" ,issort:false,edit:false},
		{fieldcnname:"����",fieldname:"longitude",inputtype:"text", twidth:"80" ,issort:false,edit:false},
		{fieldcnname:"��ע",fieldname:"resume",inputtype:"text", twidth:"150" ,issort:false}
		
	];
var rules =[{name:"strid",type:"ajax",url:"carstops.do?action=check&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""}];
function viewpic(name){
	var url = 'viewpic.html?name='+name;
	Twin({Id:"carstops_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
var _carstopsT = new TQTable({
	tabletitle:"���������",
	ischeck:false,
	tablename:"carstops_tables",
	dataUrl:"carstops.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#carstopsobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"ע�Ჴ����",icon:"edit_add.png",onpress:function(Obj){
		T.each(_carstopsT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"carstops_add",Title:"��Ӳ�����",Width:550,sysfun:function(tObj){
				Tform({
					formname: "carstops_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"carstops.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("carstops_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("carstops_add");
							_carstopsT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_carstopsT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"carstops_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "carstops_search_f",
					formObj:tObj,
					formWinId:"carstops_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("carstops_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_carstopsT.C({
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
		T.each(_carstopsT.tc.tableitems,function(o,j){
			o.fieldvalue = _carstopsT.GD(id)[j]
		});
		Twin({Id:"carstops_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "carstops_edit_f",
					formObj:tObj,
					recordid:"carstops_id",
					suburl:"carstops.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_carstopsT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("carstops_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("carstops_edit_"+id);
							_carstopsT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("carstops.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_carstopsT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	bts.push({name:"�ϴ���Ƭ",fun:function(id){
		var url ="upload.html?url=carstops&action=uploadpic&table=carstop_pics&id="+id;
		Twin({Id:"carstops_edit_"+id,Title:"�ϴ���Ƭ",Width:350,Height:200,sysfunI:id,
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				_carstopsT.M();
			}
			})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_carstopsT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������۸�۸����</title>
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
<div id="carstopspriceobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
function getCstops(){
	return eval(T.A.sendData("carstopsprice.do?action=getcids"));
}
var role=${role};
var cstops = getCstops();
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"����",fieldname:"cid",inputtype:"select", noList:cstops,twidth:"150" ,issort:false},
		{fieldcnname:"����",fieldname:"type",inputtype:"select", twidth:"50",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��ͣ"},{"value_no":1,"value_name":"��ͣ"}] ,issort:false},
		{fieldcnname:"�׼۸�",fieldname:"first_price",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"�׼Ƽ۵�λ(����)",fieldname:"first_unit",inputtype:"text",twidth:"120" ,issort:false},
		{fieldcnname:"�۸�",fieldname:"next_price",inputtype:"text",twidth:"100" ,issort:false},
		{fieldcnname:"�Ƽ۵�λ (����)",fieldname:"next_unit",inputtype:"text", twidth:"120",issort:false},
		{fieldcnname:"�Żݼ۸�",fieldname:"fav_price",inputtype:"text",twidth:"100" ,issort:false},
		{fieldcnname:"�ŻݼƼ۵�λ (����)",fieldname:"fav_unit",inputtype:"text", twidth:"120",issort:false},
		{fieldcnname:"��߼۸�",fieldname:"top_price",inputtype:"text",twidth:"100" ,issort:false},
		{fieldcnname:"���� ��",fieldname:"creator",inputtype:"text",twidth:"70" ,issort:false,edit:false},
		{fieldcnname:"��ע",fieldname:"resume",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��������",fieldname:"ctime",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"�޸����� ",fieldname:"utime",inputtype:"date", twidth:"128" ,issort:false,edit:false}
		
	];
var rules =[{name:"strid",type:"ajax",url:"carstopsprice.do?action=check&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""}];
function viewpic(name){
	var url = 'viewpic.html?name='+name;
	Twin({Id:"carstopsprice_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
var _carstopspriceT = new TQTable({
	tabletitle:"������۸����",
	ischeck:false,
	tablename:"carstopsprice_tables",
	dataUrl:"carstopsprice.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#carstopspriceobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"ע�Ჴ����۸�",icon:"edit_add.png",onpress:function(Obj){
		T.each(_carstopspriceT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"carstopsprice_add",Title:"��Ӳ�����۸�",Width:550,sysfun:function(tObj){
				Tform({
					formname: "carstopsprice_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"carstopsprice.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("carstopsprice_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("carstopsprice_add");
							_carstopspriceT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_carstopspriceT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"carstopsprice_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "carstopsprice_search_f",
					formObj:tObj,
					formWinId:"carstopsprice_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("carstopsprice_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_carstopspriceT.C({
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
		T.each(_carstopspriceT.tc.tableitems,function(o,j){
			o.fieldvalue = _carstopspriceT.GD(id)[j]
		});
		Twin({Id:"carstopsprice_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "carstopsprice_edit_f",
					formObj:tObj,
					recordid:"carstopsprice_id",
					suburl:"carstopsprice.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_carstopspriceT.tc.tableitems}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("carstopsprice_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("carstopsprice_edit_"+id);
							_carstopspriceT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("carstopsprice.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_carstopspriceT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_carstopspriceT.C();
</script>

</body>
</html>

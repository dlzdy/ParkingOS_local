<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��Ա����</title>
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
<div id="vipuserobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<script language="javascript">
var role=${role};
if(parseInt(role)==15||parseInt(role)==3){
	window.onload = jslimit()
}
var comid = ${comid};
var pnames= eval(T.A.sendData("getdata.do?action=getpname&comid="+comid));
var month_select = [];
for(var i=1;i<36;i++){
	month_select.push({"value_no":i,"value_name":i});
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"���²�Ʒ����",fieldname:"p_name",fieldvalue:'',inputtype:"select",noList:pnames, twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����˻�",fieldname:"uin",fieldvalue:'',inputtype:"number", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��ַ",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
		{fieldcnname:"���ƺ���",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"230" ,height:"",issort:false,edit:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
					return setname(trId,'car_number');
				}},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"150" ,height:""},
		{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"date",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"e_time",fieldvalue:'',inputtype:"date", twidth:"150" ,height:"",edit:false},
		{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false},
		{fieldcnname:"����",fieldname:"months",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",edit:false,fhide:true,shide:true},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
	];
var _addField = [
		{fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"select", noList:pnames,twidth:"180" ,height:"",issort:false},
		{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����(ѡ��)",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"��ַ(ѡ��)",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
		//{fieldcnname:"���ƺ���",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"sdate",twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"select",noList:month_select, twidth:"150" ,height:"",issort:false},
		//{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"�����Ѵ���ʱ",fieldname:"flag",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��ʾ���Ʋ�һ��"},{"value_no":1,"value_name":"�����ֳ���"}], twidth:"180" ,height:"",issort:false}
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
	];
var _editField = [
         		{fieldcnname:"���²�Ʒ",fieldname:"p_name",fieldvalue:'',inputtype:"select", noList:pnames,twidth:"180" ,height:"",issort:false},
         		{fieldcnname:"�����ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
         		{fieldcnname:"����(ѡ��)",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
				{fieldcnname:"��ַ(ѡ��)",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
         		//{fieldcnname:"���ƺ���",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
         		{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"sdate",twidth:"150" ,height:"",issort:false},
         		{fieldcnname:"��������",fieldname:"months",fieldvalue:'',inputtype:"select",noList:month_select, twidth:"150" ,height:"",issort:false},
         		//{fieldcnname:"���",fieldname:"total",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
         		//{fieldcnname:"�����Ѵ���ʱ",fieldname:"flag",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��ʾ���Ʋ�һ��"},{"value_no":1,"value_name":"�����ֳ���"}], twidth:"180" ,height:"",issort:false}
         		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false}
         	];
var rules =[{name:"p_name",type:"",url:"",requir:true,warn:"��ѡ���Ʒ",okmsg:""},
			{name:"mobile",type:"ajax",url:"vipuser.do?action=checkmobile&mobile=",requir:true,warn:"����д�û���ʵ�ֻ����룬�����������ֻ������ص�¼ͣ������ÿ����һ���û���������5Ԫ",okmsg:""},
			{name:"car_number",type:"",url:"",requir:true,warn:"�����복��",okmsg:""},
			{name:"b_time",type:"",url:"",requir:true,warn:"��ѡ��ʱ��",okmsg:""}
			//{name:"total",type:"",url:"",requir:true,warn:"��������",okmsg:""}
			];
var _vipuserT = new TQTable({
	tabletitle:"VIP��Ա����",
	ischeck:false,
	tablename:"vipuser_tables",
	dataUrl:"vipuser.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#vipuserobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	if(parseInt(role)==15||parseInt(role)==3){
		return [{dname:"ע���Ա ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_vipuserT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"vipuser_add",Title:"ע���Ա<font style='color:red;'>����д��ʵ�����ֻ����������ص�¼ͣ����������������5Ԫ����</font>",Width:550,sysfun:function(tObj){
				Tform({
					formname: "vipuser_add_f",
					formObj:tObj,
					formWinId:"vipuser_add_w",
					formFunId:tObj,
					recordid:"id",
					Coltype:2,
					suburl:"vipuser.do?action=create&comid="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("vipuser_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("vipuser_add");
							_vipuserT.M();
						}else if(ret==-1){
							T.loadTip(1,"���ʧ�ܣ�",2,"");
						}else if(ret==-2){
						 	T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
						}else 
							T.loadTip(2,ret,7,"");
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_vipuserT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"vipuser_search_w",Title:"������Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "vipuser_search_f",
					formObj:tObj,
					formWinId:"vipuser_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("vipuser_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_vipuserT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}}
	]
	}else{
		return [{dname:"ע���Ա ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_vipuserT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"vipuser_add",Title:"ע���Ա<font style='color:red;'>����д��ʵ�����ֻ����������ص�¼ͣ����������������5Ԫ����</font>",Width:550,sysfun:function(tObj){
				Tform({
					formname: "vipuser_add_f",
					formObj:tObj,
					formWinId:"vipuser_add_w",
					formFunId:tObj,
					recordid:"id",
					Coltype:2,
					suburl:"vipuser.do?action=create&comid="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("vipuser_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("vipuser_add");
							_vipuserT.M();
						}else if(ret==-1){
							T.loadTip(1,"���ʧ�ܣ�",2,"");
						}else if(ret==-2){
						 	T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
						}else 
							T.loadTip(2,ret,7,"");
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_vipuserT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"vipuser_search_w",Title:"������Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "vipuser_search_f",
					formObj:tObj,
					formWinId:"vipuser_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("vipuser_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_vipuserT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},{dname:"������Ա",icon:"toxls.gif",onpress:function(Obj){
	
		Twin({Id:"vipuser_export_w",Title:"������Ա<font style='color:red;'>�����û�����ã�Ĭ��ȫ������!��</font>",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "vipuser_export_f",
					formObj:tObj,
					formWinId:"vipuser_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[{fieldcnname:"���²�Ʒ����",fieldname:"p_name",fieldvalue:'',inputtype:"select",noList:pnames}
						,{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date"},{fieldcnname:"��ʼʱ��",fieldname:"b_time",fieldvalue:'',inputtype:"date"}
						,{fieldcnname:"����ʱ��",fieldname:"e_time",fieldvalue:'',inputtype:"date"}
						]}],
					}],
					//formitems:[{kindname:"",kinditemts:_excelField}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="vipuser.do?action=exportExcel&comid="+comid+"&rp="+2147483647+"&fieldsstr="+"id__p_name__mobile__uin__car_number__create_time__b_time__e_time__total__months__remark"+Serializ(formName)
						TwinC("vipuser_export_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})
	}}
	]
	}
	
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		var p_name = _vipuserT.GD(id,"p_name");
		var mobile = _vipuserT.GD(id,"mobile");
		var name = _vipuserT.GD(id,"name");
		var address = _vipuserT.GD(id,"address");
		//var car_number = _vipuserT.GD(id,"car_number");
		var b_time = _vipuserT.GD(id,"b_time");
		var months = _vipuserT.GD(id,"months");
		var remark = _vipuserT.GD(id,"remark");
		
		Twin({Id:"vipuser_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "vipuser_edit_f",
					formObj:tObj,
					recordid:"vipuser_id",
					suburl:"vipuser.do?comid="+comid+"&action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_editField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("vipuser_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("vipuser_edit_"+id);
							_vipuserT.M();
						}else if(ret==-1){
							T.loadTip(1,"�༭ʧ�ܣ�",2,"");
						}else if(ret==-2){
						 	T.loadTip(2,"��Ʒ�ѳ�����Ч�ڣ�������ѡ���Ʒ����Ĺ���������",7,"");
						}else 
							T.loadTip(2,ret,7,"");
					}
				});	
				T("#vipuser_edit_f_p_name").value=p_name;
				T("#vipuser_edit_f_mobile").value=mobile;
				T("#vipuser_edit_f_name").value=name;
				T("#vipuser_edit_f_address").value=address;
				//T("#vipuser_edit_f_car_number").value=car_number;
				T("#vipuser_edit_f_b_time").value=b_time;
				T("#vipuser_edit_f_months").value=months;
				T("#vipuser_edit_f_remark").value=remark;
			}
		})
	}}); 
	bts.push({name:"�޸ĳ���",fun:function(id){
		var uin =_vipuserT.GD(id,"uin");
		var cars = T.A.sendData("vipuser.do?action=getcar&uin="+uin);
		Twin({Id:"vipuser_addcar_"+id,Title:"�޸ĳ���",Width:450,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "vipuser_addcar_f",
					formObj:tObj,
					recordid:"vipuser_id",
					suburl:"vipuser.do?action=addcar&uin="+uin,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[{fieldcnname:"���ƺ���(������ƣ���,����)",fieldname:"carnumber",inputtype:"text",width:"300"}]}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ����ӳ���",icon:"cancel.gif", onpress:function(){TwinC("vipuser_addcar_"+id);} }
					],
					Callback:function(f,rcd,ret,o){
						if(parseInt(ret)>0){
							T.loadTip(1,"�޸���"+ret+"�����ƣ�",2,"");
							TwinC("vipuser_addcar_"+id);
							_vipuserT.M();
						}else {
							T.loadTip(2,ret,7,"");
						}
					}
				});	
			}
		})
		T("#vipuser_addcar_f_carnumber").value=cars;
	}});
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("vipuser.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_vipuserT.M();
				}else if(ret=="-1"){
					T.loadTip(1,"�˳����ѹ����������������²�Ʒ",2,"");
				}else if(ret=="-2"){
					T.loadTip(1,"�˳�������ɾ�����¿���ɾ��",2,"");
				}else if(ret=="-3"){
					T.loadTip(1,"ɾ������ʧ�ܣ��¿���ɾ��",2,"");
				}else {
					T.loadTip(1,ret,2,"");
				}
				_vipuserT.M();
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}

function setname(pid,colname){
	var uin = _vipuserT.GD(pid,"uin");
	T.A.C({
		url:"vipuser.do?action=getcar&uin="+uin,
	  		method:"GET",//POST or GET
	  		param:"",//GETʱΪ��
	  		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
	  		dataType:"0",//0text,1xml,2obj
	  		success:function(ret,tipObj,thirdParam){
	  			if(ret&&ret!='null'){
					updateRow(pid,colname,ret);
	  			}
		},//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
	  		failure:function(ret,tipObj,thirdParam){
			return false;
		},//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
	  		thirdParam:"",//�ص������еĵ���������
	  		tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
	  		waitTip:"���ڻ�ȡ�������...",
	  		noCover:true
	})
	return "<font style='color:#666'>��ȡ��...</font>";
}

/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
		_vipuserT.UCD(rowid,name,value);
}

_vipuserT.C();
</script>

</body>
</html>

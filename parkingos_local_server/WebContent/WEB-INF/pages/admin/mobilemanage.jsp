<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ֻ�����</title>
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
<div id="mobilemanageobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var comid = ${comid};
var markets = getMarkets();
function getMarkets(){
	var childs = eval(T.A.sendData("getdata.do?action=markets"));
	return childs;
}
//var parkings= eval(T.A.sendData("parking.do?action=getparkings"));
/*

		 *  id bigint NOT NULL,
			  imei character varying(25), -- �ֻ�����
			  num character varying(15), -- �ֻ�����
			  mode character varying(100), -- �ֻ��ͺ�
			  price numeric(5,2), -- �۸�
			  create_tiime bigint, -- ���ʱ��
			  editor character varying(50), -- �����
			  distru_date bigint, -- ����ʱ��
			  uid bigint, -- �г�רԱ
			  comid bigint, -- ͣ����
			  uin bigint, -- ����ǩ�����ʺ�
			  money_3 numeric(5,2), -- �����ս�����
			  order_3 integer, -- �����ն�������
			  CONSTRAINT mobile_tb_pkey PRIMARY KEY (id)
  
		 
*/

var _field = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"�ֻ�����",fieldname:"imei",fieldvalue:'',inputtype:"text", twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�ֻ�����",fieldname:"num",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ��ͺ�",fieldname:"mode",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ��۸�",fieldname:"price",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"130" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"distru_date",fieldvalue:'',inputtype:"date",twidth:"130" ,height:"",issort:false},
		{fieldcnname:"�����",fieldname:"editor",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"cselect",noList:markets,target:"comid",action:"getpark",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ͣ����",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:[],target:"uin",action:"getuser",twidth:"160" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'parkname','comid');
			}},
		{fieldcnname:"����ǩ����",fieldname:"uin",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"100" ,height:"",issort:false,
			process:function(value,pid){
				return setcname(value,pid,'parkername','uin');
			}},
		{fieldcnname:"�����ս�����",fieldname:"money_3",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�����ն�������",fieldname:"order_3",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false}
		
	];
var _addfield = [
		{fieldcnname:"�ֻ��ͺ�",fieldname:"mode",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�ֻ�����",fieldname:"imei",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�ֻ�����",fieldname:"num",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�ֻ��۸�",fieldname:"price",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�����",fieldname:"editor",fieldvalue:'',defaultValue:'${nickname}',inputtype:"text",twidth:"160" ,height:"",issort:false,edit:false}
	];
var _editfield = [
		{fieldcnname:"�ֻ�����",fieldname:"imei",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
		{fieldcnname:"�ֻ�����",fieldname:"num",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�ֻ��ͺ�",fieldname:"mode",fieldvalue:'',inputtype:"text",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"cselect",noList:markets,target:"comid",action:"getpark",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"ͣ����",fieldname:"comid",fieldvalue:'',inputtype:"cselect",noList:[],target:"uin",action:"getuser",twidth:"160" ,height:"",issort:false},
		{fieldcnname:"����ǩ����",fieldname:"uin",fieldvalue:'',inputtype:"select",noList:[],twidth:"160" ,height:"",issort:false}
	];

var rules =[{name:"nfc_uuid",type:"",url:"",requir:true,warn:"",okmsg:""}];

var _mobilemanageT = new TQTable({
	tabletitle:"�ֻ�����",
	ischeck:false,
	tablename:"mobilemanage_tables",
	dataUrl:"mobilemanage.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#mobilemanageobj"),
	fit:[true,true,true],
	tableitems:_field,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"����ֻ�",icon:"edit_add.png",onpress:function(Obj){
		T.each(_mobilemanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"mobilemanage_add",Title:"����ֻ�",Width:550,sysfun:function(tObj){
				Tform({
					formname: "mobilemanage_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"mobilemanage.do?action=create",
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addfield}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("mobilemanage_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("mobilemanage_add");
							_mobilemanageT.M();
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
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_mobilemanageT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"mobilemanage_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "mobilemanage_search_f",
					formObj:tObj,
					formWinId:"mobilemanage_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_field}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("mobilemanage_search_w");} }
					],
					SubAction:
					function(callback,formName){
						//alert(Serializ(formName));
						_mobilemanageT.C({
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
		var imei = _mobilemanageT.GD(id,"imei");
		var mode = _mobilemanageT.GD(id,"mode");
		var num = _mobilemanageT.GD(id,"num");
		
		Twin({Id:"mobilemanage_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "mobilemanage_edit_f",
					formObj:tObj,
					recordid:"mobilemanage_id",
					suburl:"mobilemanage.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_editfield}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("mobilemanage_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("mobilemanage_edit_"+id);
							_mobilemanageT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
				T("#mobilemanage_edit_f_imei").value=(imei);
				T("#mobilemanage_edit_f_mode").value=(mode);
				T("#mobilemanage_edit_f_num").value=(num);
			}
		})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
function setcname(value,pid,type,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"getdata.do?action=getvalue&type="+type+"&id="+value,
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
    		waitTip:"���ڻ�ȡ����...",
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
	_mobilemanageT.UCD(rowid,name,value);
}

_mobilemanageT.C();
</script>

</body>
</html>

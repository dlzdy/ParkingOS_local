<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ͻ�����</title>
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
<div id="carowerobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
function getbonustypes (){
	var bonustypes = eval(T.A.sendData("getdata.do?action=getbonustypes"));
	return bonustypes;
}
var bonustypes =getbonustypes();
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"50" ,height:"",hide:true},
		//{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ע������",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"�����¼����",fieldname:"logon_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"ý����Դ",fieldname:"media",fieldvalue:'',inputtype:"select", noList:bonustypes ,twidth:"100" ,height:"",issort:false},
		{fieldcnname:"΢�Ź��ں�",fieldname:"wxp_openid",fieldvalue:'',inputtype:"text", twidth:"250" ,height:"",issort:false},
		{fieldcnname:"�Ƿ��г���",fieldname:"hascarnum",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�г���"},{"value_no":1,"value_name":"�޳���"}] ,twidth:"200" ,height:"",issort:false,fhide:true},
		{fieldcnname:"�ͻ���",fieldname:"client_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"Android"},{"value_no":1,"value_name":"Ios"}] ,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�汾��",fieldname:"version",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�Ƿ�����֤",fieldname:"isauth",fieldvalue:'',inputtype:"select", noList:[{"value_no":-2,"value_name":"��Ч���� "},{"value_no":-1,"value_name":"��֤δͨ��"},{"value_no":0,"value_name":"δ��֤"},{"value_no":1,"value_name":"����֤"},{"value_no":2,"value_name":"��֤��"}] ,twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true},
		{fieldcnname:"��ʻ��1",fieldname:"pic_url1",fieldvalue:'',inputtype:"date", twidth:"240" ,height:"",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>"+value+"</a>";
				}else
					return value;
			}},
		{fieldcnname:"��ʻ��2",fieldname:"pic_url2",fieldvalue:'',inputtype:"text", twidth:"250" ,height:"",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>"+value+"</a>";
				}else
					return value;
			}},
		{fieldcnname:"ͣ��ȯ���",fieldname:"ticket_state",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��ͣ��ȯ"},{"value_no":1,"value_name":"ͣ��ȯ������"}] ,twidth:"200" ,height:"",issort:false,fhide:true}
//		{fieldcnname:"δʹ�õ�ͣ��ȯ����",fieldname:"id",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"200" ,height:"",issort:false,shide:true,
//			process:function(value,pid){
//				return setcname(value,pid,'id');
//				return "<a href=# onclick=\"viewdetail('hn','"+setcname(value,pid,'id')+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
//			}}
	];
var _carowerT = new TQTable({
	tabletitle:"��Ա����",
	//ischeck:false,
	tablename:"carower_tables",
	dataUrl:"carower.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#carowerobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function viewpic(name){
	var url = 'viewpic.html?name='+name+'&db=user_dirvier_pics'+'&r='+Math.random();
	Twin({Id:"carstops_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"camera.do?action=getname&passid="+value,
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
    		waitTip:"���ڻ�ȡȯ����...",
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
	_carowerT.UCD(rowid,name,value);
}

function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_carowerT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"carower_search_w",Title:"�����ͻ�",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "carower_search_f",
					formObj:tObj,
					formWinId:"carower_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("carower_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_carowerT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{ dname:  "���Ͷ���", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _carowerT.GS();
		var ids="";
		if(!sids){
			T.loadTip(1,"����ѡ���ֻ�",2,"");
			return;
		}
		/* else {
			ids=sids.split(",");
			if(ids.length>100){
				T.loadTip(1,"�ֻ��������100��",2,"");
				return;
			}
		} */
		Twin({Id:"send_message_w",Title:"���Ͷ���",Width:550,sysfun:function(tObj){
			Tform({
				formname: "send_message_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"carower.do?action=sendmesg",
				method:"POST",
				Coltype:2,
				dbuttonname:["����"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"�ͻ����",fieldname:"ids",fieldvalue:sids,inputtype:"multi",height:"80",edit:false},
					{fieldcnname:"��������",fieldname:"message",fieldvalue:'',inputtype:"multi",height:"100",issort:false}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("send_message_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"���ͳɹ���",2,"");
						TwinC("send_message_w");
					}else{
						T.loadTip(1,"����ʧ��",2,o);
					}
				}
			});	
			}
		})
		
	}},
	{ dname:  "ɾ�������˻�", icon: "sendsms.gif", onpress:function(Obj){
		Twin({Id:"delete_user_w",Title:"ɾ�������˻�",Width:550,sysfun:function(tObj){
			Tform({
				formname: "delete_user_f",
				formObj:tObj,
				recordid:"id",
				suburl:"carower.do?action=deleteuser",
				method:"POST",
				Coltype:2,
				dbuttonname:["ɾ��"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"�ֻ�����",fieldname:"mobiles",fieldvalue:'',inputtype:"checkbox",height:"80",noList:[{"value_no":"13641309140","value_name":"13641309140"},{"value_no":"15210810614","value_name":"15210810614"},{"value_no":"15210932334","value_name":"15210932334"},{"value_no":"13331000064","value_name":"13331000064"},{"value_no":"15801482643","value_name":"15801482643"}]}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("delete_user_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"ɾ���ɹ���",2,"");
						TwinC("delete_user_w");
					}else{
						T.loadTip(1,"����ʧ��",2,o);
					}
				}
			});	
			}
		})
		
	}},
	{dname:"����˳���",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do?type=1";
	}},
	{dname:"����˳���",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do?type=2";
	}},
	{dname:"���δͨ������",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do?type=-1";
	}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"��֤ͨ��",fun:function(id){
		var state =_carowerT.GD(id,"is_auth");
		var car_number = _carowerT.GD(id,"car_number");
		if(state==1){//״̬������
			T.loadTip(1,"����֤���������ظ���֤��",2,"");
			return ;
		}
		if('${userid}'!='huxuelian'){
			T.loadTip(1,"��û��Ȩ�ޣ�",2,"");
			return ;
		}
		Tconfirm({Title:"��֤ͨ��",Content:"ȷ����֤ͨ����",OKFn:function(){T.A.sendData("carower.do?action=authuser","post","uin="+id+"&car_number="+encodeURI(encodeURI(car_number))+"&isauth=1",
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"��֤�ɹ���",2,"");
					_carowerT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	/* bts.push({name:"����",fun:function(id){
		Twin({
			Id:"car_number_"+id,
			Title:"������Ϣ",Width:350,
			sysfunI:id,
			Content:"<iframe name='car_number_'"+id+" id='car_number_'"+id+" src='carower.do?action=carnumber&id="+id+"' width='100%' height='150' frameborder='0'  style='overflow:hidden;' ></iframe>"
		})
	}});
	bts.push({name:"����",fun:function(id){
		Twin({
			Id:"car_number_"+id,
			Title:"������Ϣ",Width:650,
			sysfunI:id,
			Content:"<iframe name='order_'"+id+" id='order_'"+id+" src='carower.do?action=orderinfo&id="+id+"' width='100%' height='150' frameborder='0'  style='overflow:hidden;' ></iframe>"
		})
	}}); 
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("carower.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_carowerT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});*/
	if(bts.length <= 0){return false;}
	return bts;
}
_carowerT.C();
</script>

</body>
</html>

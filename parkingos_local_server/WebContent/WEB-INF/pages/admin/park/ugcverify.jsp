<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ��������</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/tq.public.js?0817" type="text/javascript">//���</script>
<script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
<script src="js/tq.form.js?033434" type="text/javascript">//��</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ��</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
<script src="js/tq.newtree.js?1014" type="text/javascript"></script>

</head>
<body>
<div id="verifyparkobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var role=${role};
var states = [{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}]
var etc_states=[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
var etc_add_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]

var isfixed = false;
if(role==7)
	isfixed=true;
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"40" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"�������",fieldname:"vname",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
					return setname(trId,'isname','vname');
				}},
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
		{fieldcnname:"��ϸ��ַ���",fieldname:"vaddr",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
					return setname(trId,'islocal','vaddr');
				}},
		{fieldcnname:"����",fieldname:"resume",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false},
		{fieldcnname:"�������",fieldname:"vresume",fieldvalue:'',inputtype:"text", twidth:"180" ,height:"",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
					return setname(trId,'isresume','vresume');
				}},
		{fieldcnname:"��������",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}],twidth:"60" ,height:"",issort:false},
		{fieldcnname:"�����������",fieldname:"vtype",fieldvalue:'',inputtype:"text",twidth:"90" ,height:"",issort:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
					return setname(trId,'ispay','vtype');
				}},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"����ʱ��",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",hide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�����"},{"value_no":2,"value_name":"δ���"}], twidth:"60" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false},
		{fieldcnname:"�ϴ���",fieldname:"upload_uin",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",edit:false,issort:false}
		];
var _verifyparkT = new TQTable({
	tabletitle:"�����ͣ����",
	ischeck:false,
	tablename:"verifypark_tables",
	dataUrl:"parking.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=ugcquery",
	tableObj:T("#verifyparkobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	var bus = [];
	if(role!=6&&role!=8)
	
	bus.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_verifyparkT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
			if(o.fieldname=='strid'||o.fieldname=='nickname'||o.fieldname=='cmobile')
				o.shide=true;
		});
		Twin({Id:"verifypark_search_w",Title:"����ͣ����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "verifypark_search_f",
					formObj:tObj,
					formWinId:"verifypark_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("verifypark_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_verifyparkT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	bus.push({dname:"����ͣ��������",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do";
	}});
	bus.push({dname:"�����UGCͣ����",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do?action=ugc&state=0";
	}});
	bus.push({dname:"δ���UGCͣ����",icon:"edit_add.png",onpress:function(Obj){
		location = "parking.do?action=ugc&state=2";
	}});
	return bus;
}
function getAuthIsoperateButtons(){
	var bts = [];
	
	bts.push({name:"���ͨ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ�����ͨ����",Content:"ȷ�����ͨ����",OKFn:function(){T.A.sendData("verifypark.do?action=verify","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"��˳ɹ���",2,"");
					_verifyparkT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});

	if(bts.length <= 0){return false;}
	return bts;
}
function setname(pid,type,colname){
	T.A.C({
		url:"parking.do?action=getver&id="+pid+"&type="+type,
	  		method:"GET",//POST or GET
	  		param:"",//GETʱΪ��
	  		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
	  		dataType:"0",//0text,1xml,2obj
	  		success:function(ret,tipObj,thirdParam){
	  			if(ret&&ret!='null'){
	  				if(ret!='0/0'){
	  					var v = "<a href ='#' onclick='viewdetail(\""+pid+"\",\""+type+"\")'>"+ret+"</a>";
						updateRow(pid,colname,v);
	  				}else
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
		_verifyparkT.UCD(rowid,name,value);
}
function viewdetail(id,type){
	//alert(id+","+type);
	var name = _verifyparkT.GD(id,"company_name")
	Twin({
		Id:"vpark_detail_"+id,
		Title:"��������  -->"+name+"&nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
		Content:"<iframe src=\"parking.do?action=verifydetail&id="+id+"&type="+type+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
		Width:T.gww()/2,
		Height:T.gwh()/1.5
	})
}
_verifyparkT.C();
</script>

</body>
</html>

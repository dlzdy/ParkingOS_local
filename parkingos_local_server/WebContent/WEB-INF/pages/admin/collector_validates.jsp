<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ��Ա����</title>
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
<div id="collectorobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
function getauditor (){
	var auditors = eval(T.A.sendData("getdata.do?action=getauditors"));
	return auditors;
}
//δ����շ�Ա
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"����"},{"value_no":3,"value_name":"������"},{"value_no":4,"value_name":"������"},{"value_no":5,"value_name":"�޼�ֵ"}] ,twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ע������",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�շ�Ա�ϴ�ͼƬ����",fieldname:"collector_pics",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",hide:true,shide:true},
		{fieldcnname:"�����",fieldname:"collector_auditor",fieldvalue:'',inputtype:"select",noList:getauditor(),action:"",twidth:"160" ,height:"",issort:false,shide:true},
		{fieldcnname:"��֤ʱ��",fieldname:"logon_time",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",hide:true,shide:true}
	];
var _collectorT = new TQTable({
	tabletitle:"���ͣ��Ա",
	ischeck:false,
	tablename:"collector_tables",
	dataUrl:"collector.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=vquery",
	tableObj:T("#collectorobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_collectorT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"collector_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "collector_search_f",
					formObj:tObj,
					formWinId:"collector_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("collector_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_collectorT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=vquery&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{dname:"����ͣ��Ա����",icon:"edit_add.png",onpress:function(Obj){
		location = "collector.do?action=";
		}
	}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"��ע",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"��ע��¼  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"collector.do?action=getremarks&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	bts.push({name:"���",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"�շ�Ա  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"collector.do?action=vuser&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	if(bts.length <= 0){return false;}
	return bts;
}
_collectorT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ȩ</title>
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
<div id="departobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var uin = ${uin};
var departid = ${departid};
var _mediaField = [
         //�ָ�֮ǰ��ѡ��״̬��������ڵ�һ�У�ѡ��ֵ������"ischecked"
		{fieldcnname:"�Ƿ�ѡ��",fieldname:"checked",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true,fhide:true,shide:true},
		//������
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"��ɫ",fieldname:"role_name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true,shide:true}
	];
var _departT = new TQTable({
	tabletitle:"������Ȩ",
	//ischeck:false,
	tablename:"depart_tables",
	dataUrl:"authsetting.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=departmembers&uin="+uin+"&departid="+departid,
	tableObj:T("#departobj"),
	fit:[true,true,true],
	tableitems:_mediaField
});

function getAuthButtons(){
	return [
	{ dname:  "������Ȩ", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _departT.GS();
		Twin({Id:"save_dataauth_w",Title:"��Ȩ",Width:550,sysfun:function(tObj){
			Tform({
				formname: "save_dataauth_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"authsetting.do?action=dataauth&uin="+uin+"&departid="+departid,
				method:"POST",
				Coltype:2,
				dbuttonname:["��Ȩ"],
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
					{fieldcnname:"��Ա���",fieldname:"ids",fieldvalue:sids,inputtype:"multi",height:"80",edit:false}]}]
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ����Ȩ",icon:"cancel.gif", onpress:function(){TwinC("save_dataauth_w");} }
				],
				Callback:function(f,rcd,ret,o){
					if(ret=="1"){
						T.loadTip(1,"�����ɹ���",2,"");
						TwinC("save_dataauth_w");
					}else{
						T.loadTip(1,"����ʧ��",2,o);
					}
				}
			});	
			}
		})
		
	}}
	]
	return false;
}
_departT.C();
</script>

</body>
</html>

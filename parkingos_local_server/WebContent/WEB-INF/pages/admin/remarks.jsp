<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ע��¼</title>
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
<div id="remarksobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var uin="${uin}";
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
					return setname(value,pid,'uid');
				}},
		{fieldcnname:"��ϵ��",fieldname:"contacts",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false,
			process:function(value,pid){
						return setname(value,pid,'contacts');
					}},
		{fieldcnname:"����",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"150" ,height:"",issort:false},
		{fieldcnname:"��ע����",fieldname:"visit_content",fieldvalue:'',inputtype:"text", twidth:"400" ,height:"",issort:false}
	];
var _remarksT = new TQTable({
	tabletitle:"��ע��¼",
	ischeck:false,
	tablename:"remarks_tables",
	dataUrl:"collector.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:false,
	//searchitem:true,
	param:"action=remarks&uin="+uin,
	tableObj:T("#remarksobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function setname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"collector.do?action=getname&uin="+value,
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
    		waitTip:"���ڻ�ȡ...",
    		noCover:true
		})
	}else{
		return ""
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}

/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_remarksT.UCD(rowid,name,value);
}

function getAuthIsoperateButtons(){
	var bts = [];
	if(bts.length <= 0){return false;}
	return bts;
}
_remarksT.C();
</script>

</body>
</html>

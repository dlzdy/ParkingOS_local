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
//var details=${datas};
var type=${atype};
var title ="����˳���";
if(type==1)
	title="����˳���";
else if(type==-1)
	title="���δͨ��";
var _mediaField = [
		{fieldcnname:"�����˻�",fieldname:"uin",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",hide:true},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"ע������",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
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
		{fieldcnname:"�ϴ�����",fieldname:"create_time",fieldvalue:'',inputtype:"date",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"��ע",fieldname:"remark",fieldvalue:'',inputtype:"text", twidth:"80" ,height:"",issort:false}
	];
var _carowerT = new TQTable({
	tabletitle:title,
	ischeck:false,
	tablename:"carower_tables",
	dataUrl:"carower.do",
	iscookcol:false,
	//hotdata:details,
	//dataorign:1,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=auth&type=${atype}",
	tableObj:T("#carowerobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	return [
	{dname:"����˳���",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do?type=1";
	}},
	{dname:"����˳���",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do?type=2";
	}},
	{dname:"���δͨ������",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do?type=-1";
	}},
	{dname:"���ػ�Ա����",icon:"edit_add.png",onpress:function(Obj){
		location = "carower.do";
	}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts=[];
	if(type==2)
	bts.push({name:"��˳���",fun:function(id){
		Twin({
			Id:"client_detail_"+id,
			Title:"�������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"carower.do?action=preauthuser&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}});
	if(bts.length<1)return false;
	return bts;
}
function viewpic(name){
	var url = 'viewpic.html?name='+name+'&db=user_dirvier_pics'+'&r='+Math.random();
	Twin({Id:"carstops_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
_carowerT.C();

</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
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
<div id="collectorsortobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var ishide=role==5?true:false;
var page_type="toweek";
var _mediaField = [
		{fieldcnname:"���� ",fieldname:"sort",fieldvalue:'',inputtype:"text", twidth:"50" ,height:"",hide:true},
		{fieldcnname:"ͣ��Ա�˺�",fieldname:"uin",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"ͣ����",fieldname:"cname",fieldvalue:'',inputtype:"text", twidth:"250" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"120" ,height:"",hide:true},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,fhide:ishide},
		{fieldcnname:"�г�רԱ",fieldname:"uid",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"share_time",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false,
			process:function(value,trId,colId){
				return "<span title ='����鿴' onclick=\"show_dialog('"+trId+"'); this.style.color='green'\" style='cursor:pointer;_cursor:hand;color:blue'>"+value+"</span>";
			}}
	];
var _collectorsortT = new TQTable({
	tabletitle:"���ܻ�������",
	ischeck:false,
	tablename:"collectorsort_tables",
	dataUrl:"collectorsort.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	isidentifier:false,
	//searchitem:true,
	param:"action=query",
	tableObj:T("#collectorsortobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function getAuthButtons(){
	return [
		{dname:"���ܻ�������",icon:"edit_add.png",onpress:function(Obj){
			page_type="toweek";
			_collectorsortT.C({
				cpage:1,
				tabletitle:"���ܻ�������",
				extparam:"&action=query"
			})}
		
		},{dname:"���ܻ�������",icon:"edit_add.png",onpress:function(Obj){
			page_type="lastweek";
			_collectorsortT.C({
				cpage:1,
				tabletitle:"���ܻ�������",
				extparam:"&action=query&week=last"
			})}
		},{dname:"���»�������",icon:"edit_add.png",onpress:function(Obj){
			page_type="tomonth";
			_collectorsortT.C({
				cpage:1,
				tabletitle:"���»�������",
				extparam:"&action=query&month=tomonth"
			})}
		},{dname:"���»�������",icon:"edit_add.png",onpress:function(Obj){
			page_type="lastmonth";
			_collectorsortT.C({
				cpage:1,
				tabletitle:"���»�������",
				extparam:"&action=query&month=last"
			})}
		}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	//if(role==7||role==0)
	if('${userid}'=='huxuelian')
		bts.push({name:"������",fun:function(id){
			if(page_type!="lastweek"){
				T.loadTip(1,"ֻ�������������з��ţ�",2,"");
				return ;
			}
			var sort = _collectorsortT.GD(id,"sort");
			/* if(sort<16){
				T.loadTip(1,"ǰʮ������������",2,"");
				return ;
			} */
			var score=_collectorsortT.GD(id,"share_time");
			var money = "30";
			if(sort<6){
				money = "150";
			}else if(sort<16){
				money = "100";	
			}else if(score>=70){
				money = "50";	
			}else if(score<35){
				T.loadTip(1,"���ֲ��㣬���ܷ�����",2,"");
				return ;
			}
			var name = _collectorsortT.GD(id,"nickname")+"���շ�Ա�˺ţ�"+id;
			Twin({Id:"send_money_"+id,Title:"����"+sort+"������,����:"+score,Width:310,sysfunI:id,sysfun:function(id,tObj){
					Tform({
						formname: "send_money_f",
						formObj:tObj,
						recordid:"id",
						suburl:"collectorsort.do?action=sendmoney&uid="+id,
						method:"POST",
						dbuttonname:["ȷ������"],
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:[
								{fieldcnname:"���Ž��",fieldname:"money",fieldvalue:money,inputtype:"text", twidth:"200" ,height:"",issort:false}]}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ���ɹ�",icon:"cancel.gif", onpress:function(){TwinC("send_money_"+id);} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"���ųɹ���",2,"");
								TwinC("send_money_"+id);
								//_collectorsortT.M()
							}else{
								T.loadTip(1,ret,2,"");
								TwinC("send_money_"+id);
							}
						}
					});	
				}
			})
		}})
	if(bts.length <= 0){return false;}
	return bts;
}
_collectorsortT.C();

function show_dialog(pid){
	var user = _collectorsortT.GD(pid,"uid");
	var parker = _collectorsortT.GD(pid,"nickname");
	Twin({
		Id:"sort_detail_"+pid,
		Title:"�������� &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
		Content:"<iframe src=\"collectorsort.do?action=detail&ptype="+page_type+"&uid="+encodeURI(encodeURI(user))+"&parker="+encodeURI(encodeURI(parker))+"&pid="+pid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
		Width:700,
		Height:500
	});
}
</script>

</body>
</html>

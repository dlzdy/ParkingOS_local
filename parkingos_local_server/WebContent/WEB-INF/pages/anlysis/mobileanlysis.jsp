<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�������׼�¼</title>
<link href="css/zTreeStyle1.css" rel="stylesheet" type="text/css">
<link href="css/demo.css" rel="stylesheet" type="text/css">
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
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
</head>
<body>
<div id="mobileanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}"
var etime="${etime}";
function showmarketers(){
	var setting = {
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onClick: onClick
			}
		};
	var childs = eval(T.A.sendData("getdata.do?action=markets"));
	var ztreestr = "[{'id':-1,'pId':0,'name':'ȫ��'},";
	for(var i=1;i<childs.length;i++){
		var child = childs[i];
		var id = child.value_no;
		var name = child.value_name;
		ztreestr += "{'id':"+id+",'pId':"+0+",'name':\""+name+"\"},";
	}
	ztreestr = ztreestr.substring(0,ztreestr.length-1);
	ztreestr += "]";
	var zNodes = eval("("+ ztreestr +")");
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	var departObj = $("#marketer");
	var departOffset = $("#marketer").offset();
	$("#menuContent").css({left:departOffset.left + "px", top:departOffset.top + departObj.outerHeight() + "px"}).slideDown("fast");
	$("body").bind("mousedown", onBodyDown);
}

function onBodyDown(event) {
	if (!(event.target.id == "marketer" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
		hideMenu();
	}
}

function beforeClick(treeId, treeNode) {
	var check = (treeNode && !treeNode.isParent);
	if (!check) alert("ֻ��ѡ��Ҷ�ڵ�...");
	return check;
}

function onClick(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var nodes = zTree.getSelectedNodes();
	var nodename = nodes[0].name;
	var nodeid = nodes[0].id;
	var id = nodeid;
	var marketObj = $("#marketer");
	var marketvalueObj = $("#marketvalue");
	marketObj.attr("value", nodename);
	marketvalueObj.attr("value", id);
}

function hideMenu() {
	$("#menuContent").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}
var _mediaField = [
		{fieldcnname:"�������",fieldname:"comid",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"ͣ����",fieldname:"cname",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"�г�רԱ",fieldname:"uname",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"������",fieldname:"total",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"��������",fieldname:"scount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"mpaydetail('hn','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"ֱ�����",fieldname:"damount",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false},
		{fieldcnname:"ֱ������",fieldname:"dtotal",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,cid,id){
					return "<a href=# onclick=\"dpaydetail('dn','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"�ܵ���",fieldname:"alltotal",fieldvalue:'',inputtype:"text",twidth:"200" ,height:"",issort:false}
	];
var _mobileanlysisT = new TQTable({
	tabletitle:"�������׼�¼",
	ischeck:false,
	tablename:"mobileanlysis_tables",
	dataUrl:"mobileanlysis.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#mobileanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html=    "&nbsp;&nbsp;ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='"+etime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;�г�רԱ��<input id='marketer' value='' readonly style='width:150px' onClick=\"showmarketers();\"/></select>"+
				"&nbsp;&nbsp;����<select id='cityflag' style='width:100px'></select>"
				+"&nbsp;&nbsp;<input type='button' onclick='searchdata();' "+
				"value=' �� ѯ '/>&nbsp;&nbsp;�ܵ�����<span style='color:red;' id='count'>"+${count}+"</span>";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}

function todaydata(){
    var now = new Date();
    var year = now.getFullYear();       //��
    var month = now.getMonth() + 1;     //��
    var day = now.getDate();            //��
	btime=year+"-"+month+"-"+day;
	etime = btime;
	_mobileanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
}
function searchdata(){
	btime = T("#coutom_btime").value;
	etime = T("#coutom_etime").value;
	//alert(btime);
	//alert(etime);
	var marketvalue = T("#marketvalue").value;
	var city = T("#cityflag").value;
	var nodename = T("#marketer").value;
	_mobileanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime+"&uid="+marketvalue+"&city="+city
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
	T("#marketer").value = nodename;
	T("#marketvalue").value = marketvalue;
	addcity();
	T("#cityflag").value = city;
	gettotal(btime,etime,marketvalue,city);
}

function gettotal(btime,etime,marketvalue,city){
	jQuery.ajax({
		type:"post",
		url:"mobileanlysis.do?action=gettotal",
		data:{'uid':marketvalue,'btime':btime,'etime':etime,'city':city},
	    async:false,
	    success:function(result){
	    	var countobj = $("#count");
	    	var count = eval("("+result+")");
	    	countobj[0].innerHTML = count.count;
	      }
	});
}

function mpaydetail(type,value,id){
	var park =_mobileanlysisT.GD(id,"cname");
	var tip = "�������׼�¼";
	Twin({
		Id:"mobile_detail_"+id,
		Title:tip+"  --> ͣ������"+park,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='mobile_detail_'"+id+" id='mobile_detail_'"+id+" src='mobileanlysis.do?action=mpaydetail&parkid="+id+"&btime="+btime+"&etime="+etime+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

function dpaydetail(type,value,id){
	var park =_mobileanlysisT.GD(id,"cname");
	var tip = "�������׼�¼";
	Twin({
		Id:"direct_detail_"+id,
		Title:tip+"  --> ͣ������"+park,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='direct_detail_'"+id+" id='direct_detail_'"+id+" src='mobileanlysis.do?action=dpaydetail&parkid="+id+"&btime="+btime+"&etime="+etime+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

function getAuthIsoperateButtons(){
	var bts = [{name:"��������",fun:function(id){
		var pname = _mobileanlysisT.GD(id,"cname");
		var pid = _mobileanlysisT.GD(id,"comid");
		Twin({
			Id:"client_detail_"+id,
			Title:"��������  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"mobileanlysis.do?action=trend&pname="+encodeURI(encodeURI(pname))+"&comid="+pid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}}];
	if(bts.length <= 0){return false;}
	return bts;
}
var marketers = document.getElementById("marketer");
_mobileanlysisT.C();

function addcity(){
	var childs = eval(T.A.sendData("getdata.do?action=getcity"));
	jQuery("#cityflag").empty();
	for(var i=0;i<childs.length;i++){
		var child = childs[i];
		var id = child.value_no;
		var name = child.value_name;
		jQuery("#cityflag").append("<option value='"+id+"'>"+name+"</option>"); 
	}
}
addcity();
</script>
<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:160px;"></ul>
</div>
<div style="display:none;">
<input type="text" id="marketvalue" value="" />
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������¼</title>
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
<div id="nfcanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}"
var etime="${etime}";
var _mediaField = [
		{fieldcnname:"�������",fieldname:"comid",inputtype:"text", twidth:"100" ,issort:false},
		{fieldcnname:"ͣ����",fieldname:"cname",inputtype:"text", twidth:"200",issort:false},
		{fieldcnname:"�г�רԱ",fieldname:"uname",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"�ӵ�����",fieldname:"eorder",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('e','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"NFC������",fieldname:"ntotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"NFC��ʷ����",fieldname:"hncount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"NFC��ǰ����",fieldname:"cncount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('cn','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"���ƽ�����",fieldname:"ztotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"������ʷ����",fieldname:"hzcount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hz','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"���Ƶ�ǰ����",fieldname:"czcount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('cz','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"����ͨ������",fieldname:"jtotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"����ͨ��ʷ����",fieldname:"hjcount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hj','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"����ͨ��ǰ����",fieldname:"cjcount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('cj','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"ֱ��������",fieldname:"hdcount",inputtype:"text", twidth:"100",issort:false,
			process:function(value,cid,id){
				return "<a href=# onclick=\"viewdetail('hd','"+value+"','"+cid+"')\" style='color:blue'>"+value+"</a>";
			}},
		{fieldcnname:"ֱ���������",fieldname:"dtotal",inputtype:"text", twidth:"100",issort:false},
		{fieldcnname:"��ʷ��������",fieldname:"ctotal",inputtype:"text", twidth:"100",issort:false}
	];
var _nfcanlysisT = new TQTable({
	tabletitle:"������¼",
	ischeck:false,
	tablename:"nfcanlysis_tables",
	dataUrl:"nfcanlysis.do",
	iscookcol:false,
	buttons:false,
	quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#nfcanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true,
	isoperate:getAuthIsoperateButtons()
});

function coutomsearch(){
	var html=    "&nbsp;&nbsp;<input type='button' onclick='todaydata();' value=' ���� '/> &nbsp;&nbsp; ʱ�䣺<input id='coutom_btime' value='"+btime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"
				+" - <input id='coutom_etime' value='"+etime+"' style='width:70px' onClick=\"WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true});\"/>"+
				"&nbsp;&nbsp;<input type='button' onclick='searchdata();' "+
				"value=' �� ѯ '/>";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
	return html;
}

function todaydata(){
    var now = new Date();
    var year = now.getFullYear();       //��
    var month = now.getMonth() + 1;     //��
    var day = now.getDate();            //��
	btime=year+"-"+month+"-"+day;
	etime = btime;
	_nfcanlysisT.C({
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
	_nfcanlysisT.C({
		cpage:1,
		tabletitle:"�������",
		extparam:"&action=query&btime="+btime+"&etime="+etime
	})
	T("#coutom_btime").value=btime;
	T("#coutom_etime").value=etime;
}

function viewdetail(type,value,id){
	//alert(type+","+value);
	var total =_nfcanlysisT.GD(id,"total");
	var park =_nfcanlysisT.GD(id,"cname");
	var tip = "NFC��ʷ����";
	if(type=='cn'){
		tip = "NFC��ǰ����";
	}else if(type=='hz'){
		tip = "������ʷ����";
	}else if(type=='cz'){
		tip = "���Ƶ�ǰ����";
	}else if(type=='e'){
		tip = "�ӵ�";
	}else if(type=='hj'){
		tip = "����ͨ��ʷ����";
	}else if(type=='cj'){
		tip = "����ͨ��ǰ����";
	}else if(type=='hd'){
		tip = "ֱ������";
	}
		
	Twin({
		Id:"nfc_detail_"+id,
		Title:tip+"  --> ͣ������"+park,
		Width:T.gww()-100,
		Height:T.gwh()-50,
		sysfunI:id,
		Content:"<iframe name='nfc_detail_'"+id+" id='nfc_detail_'"+id+" src='nfcanlysis.do?action=detail&otype="+type+"&parkid="+id+"&btime="+btime+"&etime="+etime+"&total="+total+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
	})
}

function getAuthIsoperateButtons(){
	var bts = [{name:"��λ����",fun:function(id){
		var pname = _nfcanlysisT.GD(id,"cname");
		var pid = _nfcanlysisT.GD(id,"comid");
		Twin({
			Id:"client_detail_"+id,
			Title:"��λ����  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
			Content:"<iframe src=\"parklalaanly.do?action=parkidle&pname="+encodeURI(encodeURI(pname))+"&comid="+pid+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
			Width:T.gww()-100,
			Height:T.gwh()-50
		})
		}}];
	/* bts.push({name:"ˢ������",fun:function(id){
		var total =_nfcanlysisT.GD(id,"total");
		var park =_nfcanlysisT.GD(id,"cname");
		Twin({
			Id:"nfc_detail_"+id,
			Title:"ˢ������        --> ͣ������"+park,
			Width:T.gww()-100,
			Height:T.gwh()-50,
			sysfunI:id,
			Content:"<iframe name='nfc_detail_'"+id+" id='nfc_detail_'"+id+" src='nfcanlysis.do?action=detail&parkid="+id+"&btime="+btime+"&etime="+etime+"&total="+total+"' width='100%' height='100%' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>"
		})
	}}); */
	if(bts.length <= 0){return false;}
	return bts;
}
_nfcanlysisT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ�����˻�</title>
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
<div id="parkuseraccountanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}"
var etime="${etime}";
var type =[["-1","��ѡ��"],["0","��ֵ"],["1","����"]];
var targets =[["-1","��ѡ��"],["0","���п�"],["1","֧����"],["2","΢��"],["3","ͣ����"],["4","����"]];
function setSelects(data){
	var d = [];
	for(var i=0;i<data.length;i++){
		d.push({"value_no":data[i][0],"value_name":data[i][1]});
	}
	return d;
}
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"200" ,issort:false,fhide:true,shide:true},
		{fieldcnname:"��������",fieldname:"create_time",inputtype:"date", twidth:"200",issort:false},
		{fieldcnname:"�շ�Ա",fieldname:"uin",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"���",fieldname:"amount",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"����",fieldname:"type",inputtype:"select",noList:setSelects(type), twidth:"100",issort:false},
		{fieldcnname:"��Դ/ȥ��",fieldname:"target",inputtype:"select",noList:setSelects(targets), twidth:"100",issort:false},
		{fieldcnname:"˵��",fieldname:"remark",inputtype:"text", twidth:"500",issort:false}
	];
var _parkuseraccountanlysisT = new TQTable({
	tabletitle:"ͣ�������׼�¼",
	ischeck:false,
	tablename:"parkuseraccountanlysis_tables",
	dataUrl:"parkuseraccountaly.do",
	iscookcol:false,
	buttons:getAuthButtons(),
	//quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#parkuseraccountanlysisobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	allowpage:true,
	isoperate:getAuthIsoperateButtons()
});
function getAuthIsoperateButtons(){
	var bts = [];
	
	if(bts.length <= 0){return false;}
	return bts;
}

function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkuseraccountanlysisT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"paccount_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "paccount_search_f",
					formObj:tObj,
					formWinId:"paccount_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("paccount_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_parkuseraccountanlysisT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}}]
}

_parkuseraccountanlysisT.C();



</script>

</body>
</html>

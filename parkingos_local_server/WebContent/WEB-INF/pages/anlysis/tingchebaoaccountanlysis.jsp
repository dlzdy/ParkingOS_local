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
<div id="tcbaccountanlysisobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
var btime="${btime}"
var etime="${etime}";
var type =[{"value_no":"-1","value_name":"��ѡ��"},{"value_no":"0","value_name":"����"},{"value_no":"1","value_name":"֧��"}]
var utype =[{"value_no":"-1","value_name":"��ѡ��"},{"value_no":"0","value_name":"ͣ������ȯ"},{"value_no":"1","value_name":"֧���������"}
,{"value_no":"2","value_name":"΢�ŷ����"}
//,{"value_no":"3","value_name":"��������"}
//,{"value_no":"4","value_name":"��������"}
,{"value_no":"5","value_name":"΢�Ź��ںų�ֵ������"}
,{"value_no":"6","value_name":"ͣ��ȯ�˿�"},{"value_no":"7","value_name":"������ͣ��ȯ����"}];
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"200" ,issort:false,fhide:true,shide:true},
		{fieldcnname:"��������",fieldname:"create_time",inputtype:"date", twidth:"200",issort:false},
		{fieldcnname:"���",fieldname:"amount",inputtype:"number", twidth:"100",issort:false},
		{fieldcnname:"����",fieldname:"utype",inputtype:"select",noList:utype, twidth:"100",issort:false},
		{fieldcnname:"����/֧��",fieldname:"type",inputtype:"select",noList:type, twidth:"100",issort:false},
		{fieldcnname:"˵��",fieldname:"remark",inputtype:"text", twidth:"500",issort:false}
	];
var _tcbaccountanlysisT = new TQTable({
	tabletitle:"ͣ�������׼�¼",
	ischeck:false,
	tablename:"tcbaccountanlysis_tables",
	dataUrl:"tcbaccountaly.do",
	iscookcol:false,
	buttons:getAuthButtons(),
	//quikcsearch:coutomsearch(),
	param:"action=query",
	tableObj:T("#tcbaccountanlysisobj"),
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
		T.each(_tcbaccountanlysisT.tc.tableitems,function(o,j){
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
						_tcbaccountanlysisT.C({
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

_tcbaccountanlysisT.C();



</script>

</body>
</html>

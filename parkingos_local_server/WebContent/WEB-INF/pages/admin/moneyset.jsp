<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����趨</title>
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
<div id="moneysetobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var comid=${comid};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"mtype",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"ͣ����"},{"value_no":1,"value_name":"Ԥ����"},{"value_no":2,"value_name":"ͣ��������"},{"value_no":3,"value_name":"ͣ�����ܽ�"},{"value_no":4,"value_name":"�Ƽ�������"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"֧����",fieldname:"giveto",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��˾�˻�"},{"value_no":1,"value_name":"�����˻�"}],twidth:"200" ,height:"",issort:false}
	];
var _moneysetT = new TQTable({
	tabletitle:"�շ��趨",
	ischeck:false,
	tablename:"moneyset_tables",
	dataUrl:"mset.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#moneysetobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [
	{dname:"����趨",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"mset_add",Title:"����趨",Width:550,sysfun:function(tObj){
				Tform({
					formname: "parking_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"mset.do?action=create&comid="+comid,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("mset_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("mset_add");
							_moneysetT.M();
						}else if(ret=='-2'){
							T.loadTip(1,"�����ظ���� ��",2,"");
						}else {
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [{name:"�༭",fun:function(id){
		T.each(_moneysetT.tc.tableitems,function(o,j){
			o.fieldvalue = _moneysetT.GD(id)[j]
		});
		Twin({Id:"mset_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "mset_edit_f",
					formObj:tObj,
					recordid:"mset_id",
					suburl:"mset.do?action=edit&comid="+comid+"&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_moneysetT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("mset_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("mset_edit_"+id);
							_moneysetT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}},
	{name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("mset.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_moneysetT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}}
	];
	
	if(bts.length <= 0){return false;}
	return bts;
}
_moneysetT.C();
</script>

</body>
</html>

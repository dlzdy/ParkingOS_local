<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����վ����</title>
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
<div id="worksiteobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var comid = ${comid};
var _mediaField = [
		{fieldcnname:"����վID",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false,fhide:true},
		{fieldcnname:"����",fieldname:"worksite_name",fieldvalue:'',inputtype:"text", twidth:"300" ,height:"",issort:false},
		{fieldcnname:"˵��",fieldname:"description",fieldvalue:'',inputtype:"text", twidth:"500" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"net_type",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}], twidth:"100" ,height:"",issort:false}
	];
var rules =[{name:"worksite_name",requir:true}];
var _worksiteT = new TQTable({
	tabletitle:"����վ����",
	ischeck:false,
	tablename:"worksite_tables",
	dataUrl:"worksite.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=worksitequery&comid="+comid,
	tableObj:T("#worksiteobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"��ӹ���վ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_worksiteT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"worksite_add",Title:"��ӹ���վ",Width:550,sysfun:function(tObj){
				Tform({
					formname: "worksite_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"worksite.do?action=create&comid="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}],
						rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("worksite_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("worksite_add");
							_worksiteT.M();
						}else{
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
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_worksiteT.tc.tableitems,function(o,j){
			o.fieldvalue = _worksiteT.GD(id)[j]
		});
		Twin({Id:"worksite_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "worksite_edit_f",
					formObj:tObj,
					recordid:"worksite_id",
					suburl:"worksite.do?comid="+comid+"&action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_worksiteT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("worksite_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("worksite_edit_"+id);
							_worksiteT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("worksite.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_worksiteT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_worksiteT.C();
</script>

</body>
</html>

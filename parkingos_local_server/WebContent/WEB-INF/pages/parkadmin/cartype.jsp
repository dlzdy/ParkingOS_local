<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���͹���</title>
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
<div id="cartypesetobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var cartype='${cartype}';
var htips = "���ִ�С������ǰ�����֣�";
if(cartype=='1'){
	htips =  "�����ִ�С������ǰ���֣�";
}
var role=${role};
var comid=${comid};
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",edit:false,issort:false},
		{fieldcnname:"����",fieldname:"name",fieldvalue:'',inputtype:"text",twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"sort",fieldvalue:'',inputtype:"number",twidth:"100" ,height:"",issort:false}
	];
var _cartypesetT = new TQTable({
	tabletitle:"�����趨",
	ischeck:false,
	tablename:"cartypeset_tables",
	dataUrl:"cartype.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query&comid="+comid,
	tableObj:T("#cartypesetobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [
	{dname:"��ӳ���",icon:"edit_add.png",onpress:function(Obj){
		Tconfirm({
				Title:"��ʾ��Ϣ",
				Ttype:"alert",
				Content:"��ʾ����ӳ�����Ҫ���³�����HD���汾��1.2.5���ϲſ���ʹ�ã�",
				OKFn:function(){
					Twin({Id:"cartype_add",Title:"��ӳ���",Width:550,sysfun:function(tObj){
						Tform({
							formname: "parking_edit_f",
							formObj:tObj,
							recordid:"id",
							suburl:"cartype.do?action=create&comid="+comid,
							method:"POST",
							Coltype:2,
							formAttr:[{
								formitems:[{kindname:"",kinditemts:_mediaField}]
							}],
							buttons : [//����
								{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("cartype_add");} }
							],
							subFun:checkSort,
							Callback:
							function(f,rcd,ret,o){
								if(ret=="1"){
									T.loadTip(1,"��ӳɹ���",2,"");
									TwinC("cartype_add");
									_cartypesetT.M();
								}else if(ret=='-2'){
									T.loadTip(1,"�����ظ���� ��",2,"");
								}else {
									T.loadTip(1,ret,2,o);
								}
							}
						});	
			}
		})
				}
			});
		
	}},
		{dname:htips,icon:"edit_add.png",onpress:function(Obj){
			Tconfirm({
				Title:"��ʾ��Ϣ",
				Ttype:"alert",
				Content:"���棺��ȷ��Ҫ <font color='red'>"+htips+"</font>��",
				OKFn:function(){
				T.A.sendData("cartype.do?action=setusecartype&comid=${comid}&cartype="+cartype,"GET","",
					function(ret){
						if(ret=="1"){
							location = "cartype.do?comid=${comid}";
						}else{
							T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
						}
					},0,null)
				}
			});
		}}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [{name:"�༭",fun:function(id){
		T.each(_cartypesetT.tc.tableitems,function(o,j){
			o.fieldvalue = _cartypesetT.GD(id)[j]
		});
		Twin({Id:"cartype_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "cartype_edit_f",
					formObj:tObj,
					recordid:"cartype_id",
					suburl:"cartype.do?action=edit&comid="+comid+"&id="+id,
					method:"POST",
					Coltype:2,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_cartypesetT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("cartype_edit_"+id);} }
					],
					subFun:checkSort,
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("cartype_edit_"+id);
							_cartypesetT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}},
	{name:"ɾ��",fun:function(id){
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("cartype.do?action=delete","post","id="+id,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_cartypesetT.M()
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
//������
var checkSort=function(formname){
	var val = T("#"+formname+"_sort").value;
	var cid =  T("#"+formname+"_id").value;
	var talbleData = _cartypesetT.oGridData;
	if(talbleData){
		var rows =talbleData.rows; 
		//alert(rows);
		for (var i=0;i<rows.length;i++){
			var id = rows[i].id;
			var fval = _cartypesetT.GD(id,"sort");
			//alert(val+"--->"+fval);
			if(cid==''){//�¼Ӽ�¼
				if(val==fval){
					alert('����ţ�'+val+'�Ѵ��ڣ�');
					return false;
				}
			}else{//�޸ļ�¼
				if(val==fval&&id!=cid){
					alert('����ţ�'+val+'�Ѵ��ڣ�');
					return false;
				}
			}
			
		}
	}
	return true;
}

_cartypesetT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ר��ͣ��ȯ����</title>
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
<div id="parkticketobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"ͣ����",fieldname:"comid",inputtype:"text", twidth:"270" ,issort:false,
			process:function(value,pid){
				return setcname(value,pid,'parkname','comid');
			}},
		{fieldcnname:"����",fieldname:"tnumber",inputtype:"number", twidth:"88" ,issort:false},
		{fieldcnname:"���",fieldname:"money",inputtype:"text",target:'pass',action:'getcompass', twidth:"80" ,issort:false},
		{fieldcnname:"��Ч�ڣ��죩",fieldname:"exptime",inputtype:"number", twidth:"80" ,issort:false},
		{fieldcnname:"��������",fieldname:"haveget",inputtype:"number",twidth:"80" ,issort:false,edit:false}
	];
var _parkticketT = new TQTable({
	tabletitle:"ͣ����ר��ͣ��ȯ",
	ischeck:false,
	tablename:"parkticket_tables",
	dataUrl:"parkticket.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#parkticketobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [{dname:"���ר��ͣ��ȯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkticketT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"parkticket_add",Title:"���ר��ͣ��ȯ",Width:550,sysfun:function(tObj){
				Tform({
					formname: "parkticket_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"parkticket.do?action=create",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parkticket_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"��ӳɹ���",2,"");
							TwinC("parkticket_add");
							_parkticketT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}},
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkticketT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"parkticket_search_w",Title:"����ר��ͣ��ȯ",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "parkticket_search_f",
					formObj:tObj,
					formWinId:"parkticket_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parkticket_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_parkticketT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{dname:"����ͣ��ȯ�鿴",icon:"edit_add.png",onpress:function(Obj){
			location = "ticket.do";
		}
	}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"�༭",fun:function(id){
		T.each(_parkticketT.tc.tableitems,function(o,j){
			o.fieldvalue = _parkticketT.GD(id)[j]
		});
		Twin({Id:"parkticket_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "parkticket_edit_f",
					formObj:tObj,
					recordid:"parkticket_id",
					suburl:"parkticket.do?action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_parkticketT.tc.tableitems}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("parkticket_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("parkticket_edit_"+id);
							_parkticketT.M()
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
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("parkticket.do?action=delete","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_parkticketT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
function setcname(value,pid,type,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"getdata.do?action=getvalue&type="+type+"&id="+value,
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
    		waitTip:"���ڻ�ȡ����...",
    		noCover:true
		})
	}else{
		return "��"
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}
/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_parkticketT.UCD(rowid,name,value);
}
_parkticketT.C();
</script>

</body>
</html>

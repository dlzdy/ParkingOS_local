<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ֹ���</title>
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
<div id="parkwithdrawobj" style="width:100%;height:100%;margin:0px;"></div>
<iframe src="" id ="exportiframe" frameborder="0" style="width:0px;height:0px;"></iframe>
<script language="javascript">
var role=${role};
var _mediaField = [
		{fieldcnname:"��������",fieldname:"cname",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"������",fieldname:"name",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
			/* process:function(value,pid){
				return setcname(value,pid,'uin');
			}}, */
		{fieldcnname:"����",fieldname:"wtype",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":1,"value_name":"��������"},{"value_no":0,"value_name":"��˾����"},{"value_no":2,"value_name":"�Թ�����"}], twidth:"200" ,height:"",hide:true},
		{fieldcnname:"���ֽ��",fieldname:"amount",fieldvalue:'',inputtype:"number", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"��������",fieldname:"update_time",fieldvalue:'',inputtype:"date", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�ȴ�����"},{"value_no":2,"value_name":"������"},{"value_no":3,"value_name":"��֧��"},{"value_no":4,"value_name":"����ʧ��"},{"value_no":5,"value_name":"�ӳٴ���"}], twidth:"200" ,height:"",issort:false
			/* ,process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<font color='green'>"+value+"</font>";
				}else
					return value;
			} */
			}
	];
var _parkwithdrawT = new TQTable({
	tabletitle:"���ֹ���",
	//ischeck:false,
	tablename:"parkwithdraw_tables",
	dataUrl:"parkwithdraw.do",
	iscookcol:false,
	//checktype:"checkbox",
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery",
	tableObj:T("#parkwithdrawobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
var editField=[{fieldcnname:"����״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"�ȴ�����"},{"value_no":2,"value_name":"������"},{"value_no":3,"value_name":"��֧��"},{"value_no":4,"value_name":"����ʧ��"},{"value_no":5,"value_name":"�ӳٴ���"}], twidth:"200" ,height:"",issort:false}];
var excelState=[{"value_no":0,"value_name":"���˵ȴ�����"},
		{"value_no":2,"value_name":"���˴�����"},
		{"value_no":3,"value_name":"������֧��"},
		{"value_no":4,"value_name":"��������ʧ��"},
		{"value_no":5,"value_name":"�����ӳٴ���"},
		
		{"value_no":6,"value_name":"��˾�ȴ�����"},
		{"value_no":8,"value_name":"��˾������"},
		{"value_no":9,"value_name":"��˾��֧��"},
		{"value_no":10,"value_name":"��˾����ʧ��"},
		{"value_no":11,"value_name":"��˾�ӳٴ���"},
		
		{"value_no":12,"value_name":"�Թ����ֵȴ�����"},
		{"value_no":14,"value_name":"�Թ����ִ�����"},
		{"value_no":15,"value_name":"�Թ�������֧��"},
		{"value_no":16,"value_name":"�Թ�����ʧ��"},
		{"value_no":17,"value_name":"�Թ��ӳٴ���"}
	];
function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_parkwithdrawT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"parkwithdraw_search_w",Title:"����",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "parkwithdraw_search_f",
					formObj:tObj,
					formWinId:"parkwithdraw_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",icon:"cancel.gif", onpress:function(){TwinC("parkwithdraw_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_parkwithdrawT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{dname:"��������",icon:"toxls.gif",onpress:function(Obj){
	
		Twin({Id:"parkwithdraw_search_w",Title:"��������",Width:480,sysfun:function(tObj){
				 TSform ({
					formname: "parkwithdraw_export_f",
					formObj:tObj,
					formWinId:"parkwithdraw_export_w",
					formFunId:tObj,
					dbuttonname:["ȷ�ϵ���"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select",noList:excelState}]}]
					}],
					SubAction:
					function(callback,formName){
						T("#exportiframe").src="parkwithdraw.do?action=excle&"+Serializ(formName)
						TwinC("parkwithdraw_search_w");
						T.loadTip(1,"���ڵ��������Ժ�...",2,"");
					}
				});	
			}
		})
	}},
	{ dname:  "��������", icon: "sendsms.gif", onpress:function(Obj){
		var sids = _parkwithdrawT.GS();
		if(!sids){
			T.loadTip(1,"����ѡ��Ҫ���������",2,"");
			return ;
		}
		Twin({Id:"muli_edit_w",Title:"��������",Width:250,sysfun:function(tObj){
			Tform({
				formname: "muli_edit_ff",
				formObj:tObj,
				recordid:"id",
				suburl:"parkwithdraw.do?action=multiedit&ids="+sids,
					method:"POST",
					Coltype:2,
					dbuttonname:["����"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:editField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("muli_edit_w");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="-1"){
							T.loadTip(1,"����ʧ�ܣ�",2,"");
						}else if(parseInt(ret)>0){
							T.loadTip(1,"�ɹ�����"+ret+"����¼��",2,"");
							TwinC("muli_edit_w");
							_parkwithdrawT.M()
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
	bts.push({name:"����",fun:function(id){
		T.each(_parkwithdrawT.tc.tableitems,function(o,j){
			o.fieldvalue = _parkwithdrawT.GD(id)[j]
		});
		Twin({Id:"account_edit_"+id,Title:"����",Width:300,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "account_edit_f",
					formObj:tObj,
					recordid:"account_id",
					suburl:"parkwithdraw.do?action=edit&id="+id,
					method:"POST",
					Coltype:2,
					dbuttonname:["����"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:editField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("account_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("account_edit_"+id);
							_parkwithdrawT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}
	});
	if(bts.length <= 0){return false;}
	return bts;
}

function setcname(value,pid,colname){
	if(value&&value!='-1'&&value!=''){
		T.A.C({
			url:"parkwithdraw.do?action=getusername&uin="+value,
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
		return ""
	};
	return "<font style='color:#666'>��ȡ��...</font>";
}

/*���±������*/
function updateRow(rowid,name,value){
	//alert(value);
	if(value)
	_parkwithdrawT.UCD(rowid,name,value);
}

_parkwithdrawT.C();
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͣ��Ա�˻�����</title>
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
<div id="collector_accountobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
var role=${role};
var datalist=${datalist};
//δ����շ�Ա
var _mediaField = [
		{fieldcnname:"�������",fieldname:"comid",fieldvalue:'',inputtype:"text", twidth:"50" ,height:"",hide:true},
		{fieldcnname:"ͣ����",fieldname:"cname",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",hide:true},
		{fieldcnname:"����",fieldname:"anme",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"�˺�",fieldname:"uin",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"״̬",fieldname:"state",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�Ѵ���"},{"value_no":2,"value_name":"�����"},{"value_no":3,"value_name":"�޼�ֵ"}] ,twidth:"80" ,height:"",issort:false},
		{fieldcnname:"�ϴ�����",fieldname:"ctime",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"utime",fieldvalue:'',inputtype:"date", twidth:"140" ,height:"",issort:false},
		{fieldcnname:"ͼƬ��",fieldname:"pic_name",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"�����",fieldname:"auditor",fieldvalue:'',inputtype:"cselect",noList:[],action:"",twidth:"100" ,height:"",issort:false,shide:true,
			process:function(value,pid){
				return setname(value,pid,'auditor');
			}}
	];
var _collector_accountT = new TQTable({
	tabletitle:"���ͣ�˻�����",
	ischeck:false,
	tablename:"collector_account_tables",
	dataUrl:"collector.do",
	iscookcol:false,
	dataorign:1,
	hotdata:datalist,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=vquery",
	tableObj:T("#collector_accountobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});

function setname(value,pid,colname){
	if(value&&value!='-1'&&value!='null'){
		T.A.C({
			url:"collector.do?action=getname&uin="+value,
    		method:"GET",//POST or GET
    		param:"",//GETʱΪ��
    		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
    		dataType:"0",//0text,1xml,2obj
    		success:function(ret,tipObj,thirdParam){
    			if(ret&&ret!='null'){
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
    		waitTip:"���ڻ�ȡ�����...",
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
	_collector_accountT.UCD(rowid,name,value);
}

function getAuthButtons(){
	return [
	{dname:"��ѯ����",icon:"edit_add.png",onpress:function(Obj){
		T.each(_collector_accountT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"collector_account_search_w",Title:"�����շ�Ա",Width:350,sysfun:function(tObj){
				TSform ({
					formname: "collector_account_search_f",
					formObj:tObj,
					formWinId:"collector_account_search_w",
					formFunId:tObj,
					Coltype:2,
					dbuttonname:["��ʼ��ѯ"],
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[{fieldcnname:"�������",fieldname:"comid",fieldvalue:'',inputtype:"text", twidth:"50" ,height:"",hide:true}]}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ�����",onpress:function(){TwinC("collector_account_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_collector_accountT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=vquery&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}},
	{dname:"����ͣ��Ա����",icon:"edit_add.png",onpress:function(Obj){
		location = "collector.do?action=";
		}
	}
	]
	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
		bts.push({name:"����˻�",
			rule:function(id){
				var state =_collector_accountT.GD(id,"state");
				if(state==1){
					this.name="�޸��˻�";
				}else{
					this.name="����˻�";
				}
				return true;
			},
			fun:function(id){
			Twin({
				Id:"client_detail_"+id,
				Title:"����շ�Ա�˻�  &nbsp;&nbsp;&nbsp;&nbsp;<font color='red'> ��ʾ��˫���رմ˶Ի���</font>",
				Content:"<iframe src=\"collector.do?action=adduseracc&id="+id+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>",
				Width:T.gww()-100,
				Height:T.gwh()-50,
				CloseFn:function(){location='collector.do?action=useraccount';}
			})
		}});
		bts.push({name:"�༭",
			rule:function(id){
				var state =_collector_accountT.GD(id,"state");
				if(state==1){
					return false;
				}else
					return true;
			},
			fun:function(id){
			var state =_collector_accountT.GD(id,"state");
			Twin({Id:"collector_account_edit_w",Title:"�༭",Width:350,sysfun:function(tObj){
					Tform({
						formname: "collector_account_f",
						formObj:tObj,
						recordid:"collector_account_id",
						suburl:"collector.do?action=editpuseracc&id="+id,
						method:"POST",
						dbuttonname:["����"],
						formAttr:[{
							formitems:[{kindname:"",kinditemts:[{fieldcnname:"����״̬",fieldname:"state",fieldvalue:state,inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"δ����"},{"value_no":1,"value_name":"�Ѵ���"},{"value_no":2,"value_name":"�����"},{"value_no":3,"value_name":"�޼�ֵ"}] ,twidth:"200" ,height:"",issort:false}]}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("collector_account_edit_w");} }
						],
						Coltype:2,
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"����ɹ���",2,"");
								TwinC("collector_account_edit_w");
								location='collector.do?action=useraccount';
							}else{
								T.loadTip(1,"����ʧ��",2,o)
							}
						}
						});	
					}
				})
			
		}});
	if(bts.length <= 0){
		return false;
	}
	return bts;
}
_collector_accountT.C();
</script>

</body>
</html>

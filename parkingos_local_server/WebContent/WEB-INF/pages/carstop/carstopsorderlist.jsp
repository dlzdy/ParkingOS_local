<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������������</title>
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
<div id="ctordersobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
function getCstops(){
	return eval(T.A.sendData("carstopsprice.do?action=getcids"));
}
function getUids(){
	return eval(T.A.sendData("ctorders.do?action=getuids"));
}
var cstops = getCstops();
var states = [{"value_no":-1,"value_name":"ȫ��"},
              {"value_no":0,"value_name":"������������"},
              {"value_no":1,"value_name":"����Ա����Ӧ����"},
              {"value_no":2,"value_name":"���ڲ���"},
              {"value_no":3,"value_name":"�������"},
              {"value_no":4,"value_name":"����ȡ������"},
              {"value_no":5,"value_name":"����Ա����Ӧȡ��"},
              {"value_no":6,"value_name":"����Ա����ȡ��"},
              {"value_no":7,"value_name":"�ȴ�֧��"},
              {"value_no":8,"value_name":"֧���ɹ�"},
              {"value_no":9,"value_name":"����ȡ��"}
              ];
var paytype = [{"value_no":-1,"value_name":"ȫ��"},
               {"value_no":0,"value_name":"�ֽ�"},
               {"value_no":1,"value_name":"���"},
               {"value_no":2,"value_name":"΢��"},
               {"value_no":3,"value_name":"���+΢��"}
               ];
var uids = getUids();

var _mediaField = [
		{fieldcnname:"���",fieldname:"id",inputtype:"text", twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"������",fieldname:"cid",inputtype:"select",noList:cstops, twidth:"150" ,issort:false},
		{fieldcnname:"����",fieldname:"car_number",inputtype:"text", twidth:"70" ,issort:false},
		{fieldcnname:"���������µ�",fieldname:"start_time",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"����ʱ��",fieldname:"btime",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"�ӳ���",fieldname:"buid",inputtype:"select",noList:uids,twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"����ȡ���µ� ",fieldname:"end_time",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"ȡ��ʱ�� ",fieldname:"etime",inputtype:"date", twidth:"128" ,issort:false,edit:false},
		{fieldcnname:"ȡ����",fieldname:"euid",inputtype:"select", noList:uids,twidth:"50" ,issort:false,edit:false},
		{fieldcnname:"״̬ ",fieldname:"state",inputtype:"select", twidth:"100",noList: states,issort:false},
		{fieldcnname:"���",fieldname:"amount",inputtype:"text", twidth:"50" ,issort:false},
		{fieldcnname:"������Ƭ",fieldname:"pic",inputtype:"date", twidth:"150" ,edit:false,
			process:function(value,trId,colId){//ֵ����ID(��¼ID)����ID(�ֶ�����)
				if(value!=''&&value!='null'){
					return "<a href='#' onclick='viewpic(\""+value+"\")'>"+value+"</a>";
				}else
					return value;
			}
		},
		{fieldcnname:"����λ��",fieldname:"car_local",inputtype:"text", twidth:"150" ,issort:false},
		{fieldcnname:"��Կ�ױ��",fieldname:"keyno",inputtype:"text",twidth:"80" ,issort:false},
		{fieldcnname:"֧����ʽ",fieldname:"pay_type",inputtype:"select",noList:paytype,twidth:"80" ,issort:false}
	];
var rules =[{name:"strid",type:"ajax",url:"ctorders.do?action=check&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""}];
function viewpic(name){
	var url = 'viewpic.html?name='+name;
	Twin({Id:"ctorders_edit_pic",Title:"�鿴��Ƭ",Width:850,Height:600,sysfunI:"v_pic",
			Content:"<iframe id='tactic_iframe' src='"+url+"' style='width:100%;height:100%;' frameborder='0' ></iframe>",
			buttons :[],
			CloseFn:function(){
				
			}
		})
}
var _ctordersT = new TQTable({
	tabletitle:"������������",
	ischeck:false,
	tablename:"ctorders_tables",
	dataUrl:"ctorders.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=query",
	tableObj:T("#ctordersobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	return [
	{dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"carstopsorder_search_w",Title:"������������",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "carstopsorder_search_f",
					formObj:tObj,
					formWinId:"carstopsorder_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("carstopsorder_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_ctordersT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}}
	]
//	return false;
}
function getAuthIsoperateButtons(){
	var bts = [];
	bts.push({name:"",
		rule:function(id){
			var state =_ctordersT.GD(id,"state");
			if(state==8){
				this.name="   ";
			}else if(state>2&&state!=9)
				this.name="�ֽ�֧��";
			else 
				this.name=" ";
			return true;
		},
		fun:function(id){
			var car_number = _ctordersT.GD(id,"car_number");
			var state =_ctordersT.GD(id,"state");
			var money = eval(T.A.sendData("ctorders.do?action=getmoney&id="+id));
			if(state>2&&state<8){
				Twin({Id:"send_money_"+id,Title:"���㲴����_"+car_number,Width:310,sysfunI:id,sysfun:function(id,tObj){
					Tform({
						formname: "send_money_f",
						formObj:tObj,
						recordid:"id",
						suburl:"ctorders.do?action=paymoney&id="+id+"&state="+state,
						method:"POST",
						dbuttonname:["ȷ������"],
						Coltype:2,
						formAttr:[{
							formitems:[{kindname:"",kinditemts:[
								{fieldcnname:"������",fieldname:"amount",fieldvalue:money,inputtype:"text", twidth:"200" ,height:"",issort:false}]}]
						}],
						buttons : [//����
							{name: "cancel", dname: "ȡ��", tit:"ȡ���ɹ�",icon:"cancel.gif", onpress:function(){TwinC("send_money_"+id);} }
						],
						Callback:
						function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"���ųɹ���",2,"");
								TwinC("send_money_"+id);
								_ctordersT.M()
							}else{
								T.loadTip(1,ret,2,"");
								TwinC("send_money_"+id);
							}
						}
					});	
				}
			})
			}else{
				Tconfirm({
					Title:"��ʾ��Ϣ",
					Ttype:"alert",
					Content:"���棺��ȷ��Ҫ��<font color='red'>"+car_number+"</font> ��Ϊ�ֽ�֧����",
					OKFn:function(){
						T.A.sendData("ctorders.do?action=paymoney&id="+id+"&state="+state,"GET","",
							function(ret){
								if(ret=="1"){
									T.loadTip(1,"�޸ĳɹ���",2,"");
									_ctordersT.C();
								}else{
									T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
								}
							},0,null)
					}
				});
			}
				
		}
	});
		bts.push({name:"",
		rule:function(id){
			var state =_ctordersT.GD(id,"state");
			if(state<2)
				this.name="ȡ��";
			else 
				this.name="   ";
		
			return true;
		},
		fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ȡ����",Content:"ȷ��ȡ����",OKFn:function(){T.A.sendData("attendant.do?action=cancelorder","post","id="+id_this,
			function deletebackfun(ret){
				if(ret=="0"||ret=="1"){
					T.loadTip(1,"ȡ���ɹ���",2,"");
					_ctordersT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_ctordersT.C();
</script>

</body>
</html>

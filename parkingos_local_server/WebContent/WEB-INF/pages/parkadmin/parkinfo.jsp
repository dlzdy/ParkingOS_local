<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�޸�ͣ����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">
</head>
<body>
<script src="js/tq.js?08137" type="text/javascript">//����</script>
<script src="js/tq.public.js?08031" type="text/javascript">//����</script>
<script src="js/tq.window.js?008136" type="text/javascript">//����</script>
<script src="js/tq.form.js?08301" type="text/javascript">//��</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>

<div id="alllayout">
	<div style="width:100%;float:left;height:60px;border-bottom:1px solid #ccc" id="top"></div>
	<div style="width:100%;float:left;">
    	<div id="right" style="width:auto;border-left:1px solid #ccc;float:left"></div>
	</div>
</div>	
<div id="loadtip" style="display:none;"></div>
<div id="cover" style="display:none;"></div>
</body>
<script type="text/javascript">
//ȡ�ֶ�
var add_states = [{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}];
var etc_states=[{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"Ibeacon"},{"value_no":2,"value_name":"ͨ������"},{"value_no":3,"value_name":"�ֻ�����"}]
var Obj = document.getElementById("alllayout");
var topO = document.getElementById("top");
var rightO = document.getElementById("right");

rightO.style.width = T.gww()  + "px";
rightO.style.height = T.gwh() - 50 + "px";

T.bind(window,"resize",function(){
    rightO.style.width = T.gww() + "px";
    rightO.style.height = T.gwh() - 50 + "px"
})


var fields = [
		{fieldcnname:"�������",fieldname:"id",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"company_name",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����ʱ��",fieldname:"create_time",fieldvalue:'',inputtype:"date", twidth:"100" ,height:"",hide:true},
		{fieldcnname:"������ҵ",fieldname:"property",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"parking_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"����"},{"value_no":2,"value_name":"ռ��"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��������",fieldname:"type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"���"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"stop_type",fieldvalue:'',inputtype:"select", noList:[{"value_no":0,"value_name":"ƽ������"},{"value_no":1,"value_name":"��������"}],twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��λ����",fieldname:"parking_total",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����λ��",fieldname:"share_number",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"δ�����������������",fieldname:"invalid_order",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"���ִ�С��",fieldname:"car_type",fieldvalue:'',defaultValue:'������||0',inputtype:"select", noList:[{"value_no":0,"value_name":"������"},{"value_no":1,"value_name":"����"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ѽ��㶩��",fieldname:"passfree",fieldvalue:'',defaultValue:'����||0',inputtype:"select", noList:[{"value_no":0,"value_name":"����"},{"value_no":1,"value_name":"������"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"HD���㰴ť",fieldname:"ishidehdbutton",fieldvalue:'',defaultValue:'��ʾ||0',inputtype:"select", noList:[{"value_no":0,"value_name":"��ʾ"},{"value_no":1,"value_name":"����"}] , twidth:"100" ,height:"",issort:false},
		//13
		{fieldcnname:"��ϸ��ַ",fieldname:"address",fieldvalue:'',inputtype:"showmap", twidth:"200" ,height:"",issort:false},
		{fieldcnname:"����",fieldname:"longitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",edit:false},
		{fieldcnname:"γ��",fieldname:"latitude",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",edit:false},
		{fieldcnname:"�Ƿ��Ѷ�λ",fieldname:"isfixed",fieldvalue:'',inputtype:"select",noList:[{"value_no":0,"value_name":"��"},{"value_no":1,"value_name":"��"}], twidth:"200" ,height:"",edit:false},
		//17
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"��ϵ��",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		//{fieldcnname:"��ϵ���ֻ�",fieldname:"cmobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		//19
		{fieldcnname:"NFC",fieldname:"nfc",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"ETC",fieldname:"etc",fieldvalue:'',inputtype:"select",noList:etc_states, twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"Ԥ��",fieldname:"book",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"���ڵ���",fieldname:"navi",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false},
		{fieldcnname:"֧���¿�",fieldname:"monthlypay",fieldvalue:'',inputtype:"select",noList:add_states, twidth:"60" ,height:"",issort:false,edit:false},
		{fieldcnname:"ҹ��ͣ��",fieldname:"isnight",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":0,"value_name":"֧��"},{"value_no":1,"value_name":"��֧��"}] , twidth:"100" ,height:"",issort:false},
		{fieldcnname:"����֧��",fieldname:"epay",fieldvalue:'',defaultValue:'֧��||0',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"��֧��"},{"value_no":1,"value_name":"֧��"}] , twidth:"60" ,height:"",issort:false},
		{fieldcnname:"����ʶ��ʡ��",fieldname:"firstprovince",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false}
		//24
		//{fieldcnname:"��ʷ������",fieldname:"total_money",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",edit:false},
		//{fieldcnname:"�˺����",fieldname:"money",fieldvalue:'',inputtype:"text", twidth:"200" ,height:"",edit:false}
		
	];
var comid="";
var maxmoney = 0;
var total=0;
var cominfo= eval('${cominfo}');
for(var i=0;i<cominfo.length;i++){
		if(cominfo[i].name=="id"){
			comid =cominfo[i].value;
		}
		if(cominfo[i].name=="money"){
			maxmoney =cominfo[i].value;
		}
		if(cominfo[i].name=="total_money"){
			total =cominfo[i].value;
		}
}
var bHtml = "<div style='margin-top:20px;margin-buttom:20px;margin-left:29px;width:595px;overflow:hidden;'>";
	bHtml += "�༭�˻���Ϣ    &nbsp;&nbsp;&nbsp;&nbsp;��ʷ������:<font color='red'>"+total+"</font>���˺ŵ�ǰ��<font color='red'>"+maxmoney+"</font>���˺ſ�������<font color='red' size=3>"+maxmoney+"</font>";
	bHtml += "</div>";
topO.innerHTML=bHtml;

function getEditFields(){
	var e_f = [];
	for(var j=0;j<fields.length;j++){
		for(var i=0;i<cominfo.length;i++){
			if(cominfo[i].name==fields[j].fieldname){
				fields[j].fieldvalue=cominfo[i].value;
				e_f.push(fields[j]);
				break;
			}
			if(fields[j].inputtype=='select')
				fields[j].width=200;
		}
	}
	return e_f;
}

function getFields(){
	var fs = getEditFields();
	var mfs = [
		{kindname:"������Ϣ",kinditemts:fs.slice(0,13)},
		{kindname:"λ����Ϣ",kinditemts:fs.slice(13,17)},
		{kindname:"��ϵ��ʽ",kinditemts:fs.slice(17,19)},
		{kindname:"������Ŀ",kinditemts:fs.slice(19,26)},
		{kindname:"ʶ�����",kinditemts:fs.slice(26,27)}
		//{kindname:"�˻���Ϣ",kinditemts:fs.slice(21)}
		];
	return mfs;
}



var accountForm =
new TQForm({
	formname: "opconfirm",
	formObj:rightO,
	suburl:"parkinfo.do?action=edit&id="+comid,
	method:"POST",
	//dbbuttons:[true,false],
	buttons:getTopButtons(),
	Callback:function(f,r,c,o){
		if(c=='1'){
			T.loadTip(1,"�޸ĳɹ���",3,null);
		}else
			T.loadTip(1,"����ʧ�ܣ�",3,null);
	},
	formAttr:[{
		formitems:getFields()
	}]
});
accountForm.C();
var _mField = [{fieldcnname:"��������(���:"+maxmoney+")",fieldname:"money",defaultValue:(parseInt(maxmoney)),inputtype:"number",width:200}];

function getTopButtons(){
	var bus = [];
	if(maxmoney>=100)
	bus.push({dname:"��������",icon:"edit_add.png",onpress:function(Obj){
		Twin({Id:"user_account_add",Title:"��������",Width:280,Height:190,sysfun:function(tObj){
				Tform({
					formname: "user_account_edit_f",
					formObj:tObj,
					recordid:"id",
					Coltype:2,
					nmCls:"r",
					//dbbuttons:[true,false],
					suburl:"parkinfo.do?action=withdraw",
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("user_account_add");} }
					],
					Callback:function(f,r,c,o){
						if(c=='1'){
							accountForm.M();
							T.loadTip(1,"��������ɹ���",3,null);
							TwinC("user_account_add");
							location.href="parkinfo.do";
						}else if(c=='-1'){
							T.loadTip(1,"����δ��֧���˺ţ�����ϵ�����繫˾Ϊ�����˺ţ�",3,null);
							TwinC("user_account_add");
						}else
							T.loadTip(1,"����ʧ�ܣ�",3,null);
					}
				});	
			}
		})
	
	}});
	return bus;
}

var isfixed = T("#opconfirm_isfixed").value;
if(isfixed==1){
	T("#opconfirm_address").disabled=true;
	T("#opconfirm_address_showmap").disabled=true;
}

</script>


</html>
<script type="text/javascript">
T.maskTip(0,"","");//���ؽ���
</script>
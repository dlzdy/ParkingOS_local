//����ID��ö���
 function getObj(id){
	if (document.getElementById)
		return document.getElementById(id);
	else{
		if (document.all)
			return document.all(id);
	}
 }
function getParams(){
	var inps = document.getElementsByTagName("input");
	var sels = document.getElementsByTagName("select");
	var te="";
	for(var i=0;i<inps.length;i++){
		if(inps[i].id.indexOf('input')!=-1&&inps[i].name!='')
			te+=inps[i].name+"="+inps[i].value+"&";
	}
	for(var i=0;i<sels.length;i++){
		if(sels[i].id.indexOf('input')!=-1&&sels[i].name!='')
			te+=sels[i].name+"="+sels[i].value+"&";
	}
	return "action=query&"+te.substring(0,te.length-1);
}
//����ż�ѡ��Ŀͻ�
var hasAllOption="ȫ��";
var selectlength = "180px";
function allQuery(obj){
  	var department= getObj('input_department_id').value;
  	if(department==""){
  		 getObj('input_kefu_uin').disabled=true;
  	}else if(department!=''){
		getUserList(obj);
		getObj("userListTd").innerHTML="���ڲ�ѯ...";
  	}
}

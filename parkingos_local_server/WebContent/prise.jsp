<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta name="viewport" content="width=device-width,initial-scale=1.5,minimum-scale=1.5,maximum-scale=1.5,user-scalable=no">
<head>
<title>�齱</title>
<style type="text/css">
.content{
	width:344px;
	height:346px;
	margin:40px auto;
	font-family:"΢���ź�", sans-serif, Arial, Verdana;
	font-size:12px;
	line-height:20px;
	background-image: url('images/prise/back_ground2.png');
}
.btn{
	width:296px;
	height:53px;
	margin:50px auto;
	cursor:pointer;
	_cursor:hand;
	background-image: url('images/prise/confirm2.png');
	}
</style>

<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script type="text/javascript">
function getParam(paramName){
        paramValue = "";
        isFound = false;
        if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=")>1){
            arrSource = unescape(this.location.search).substring(1,this.location.search.length).split("&");
            i = 0;
            while (i < arrSource.length && !isFound){
                if (arrSource[i].indexOf("=") > 0){
                     if (arrSource[i].split("=")[0].toLowerCase()==paramName.toLowerCase()){
                        paramValue = arrSource[i].split("=")[1];
                        isFound = true;
                     }
                }
                i++;
            }   
        }
   return paramValue;
};
var orderid = getParam("id");
//alert(orderid)
</script>
</head>
<body style='width:344px;height:600px;'>
<div id="content" class="content" >
<br/>
<br/>
<div style='margin:10px auto;'>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img id='pimage' style='margin-top:28px' src='images/prise/topp.png' />
</div>
</div> 
<div class='btn' onclick="gogogo()"></div>
</body>
<script>

var images = ["rttp.png","ltbm.png","rtbm.png","lttp.png"];
var last = 0;
var end = 0;
function setimage(){
	if(end==20){
		goend(getIndex());
		return ;
	}
	document.getElementById("pimage").src="images/prise/"+images[last];
	last ++;
	if(last==4)
		last=0;
	setTimeout("setimage()",50)
	end++;
}

function getIndex(){
	var a = Math.random()*10+"";
	a = a.substring(0,1);
	return parseInt(a)%4;
}

function gogogo(){
	if(orderid==-1){
		alert("�������������½��룡");
		return ;
	}
	if(end==20){
		alert("��ǰ�����ѳ齱��");
	}else{
		setimage();
	}
}
function goend(a){
	document.getElementById("pimage").src="images/prise/"+images[a];
	T.A.C({
			url:"getdata.do?action=addlott&orderid="+orderid+"&lott="+a,
    		method:"GET",//POST or GET
    		param:"",//GETʱΪ��
    		async:false,//Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
    		dataType:"0",//0text,1xml,2obj
    		success:function(ret,tipObj,thirdParam){
    			if(ret==1){
					if(a==0){
						T.loadTip(1,"��ϲ�������һԪ��",10,"");
					}else if(a==1){
						T.loadTip(1,"��ϲ������ö�Ԫ��",10,"");
					}else if(a==2){
						T.loadTip(1,"��ϲ���������Ԫ��",10,"");
					}else if(a==3){
						T.loadTip(1,"���ź�����δ�н���",10,"");
					}
    			}else
					T.loadTip(1,"�齱ʧ�ܣ�",10,"");
			},//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
    		failure:function(ret,tipObj,thirdParam){
				return false;
			},//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
    		thirdParam:"",//�ص������еĵ���������
    		tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
    		waitTip:"�����ύ...",
    		noCover:true
		})
	
}
</script>
</html>

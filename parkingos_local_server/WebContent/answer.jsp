<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<title>�����˳�������</title>
<style type="text/css">
.content{width:300px;margin:10px auto;font-family:"΢���ź�", sans-serif, Arial, Verdana;font-size:12px;line-height:20px;}
.title{width:100px;margin:10px auto;line-height:33px;}
.boot{font-size:10px;line-height:14px;}
a{color:#ff99ff;text-decoration:none;cursor:pointer;}
hr{color:#ffeeff;}
</style>
</head>
<body>
<div id="content" class="content" >
<span style="margin:3px auto;">
</span>
<div style='line-height:30px;font-size:17px;'>
<div id="div1" style='display:none;'>
<b>���ʹ���ֻ�֧��ͣ���ѣ�</b><br/><br/>
 VIP����Ա�������ͳ���ʱˢVIP��������˻�����������Զ�֧����<br/>��ͨ��Ա������ʱ��ͣ����App�յ����㶩�������֧�������û�� ����������ɨ���շ�Ա��ά�����֧����</br></div>
 <div id="div2" style='display:none;'>
<b>VIP��������뼰ʹ�ã�</b><br/><br/>
��֧��ͣ����֧���ĳ������շ�Ա���뼴����Ѱ������복��ˢVIP�����ɿ���֧��ͨ�С�<br/></div>
<div id="div3" style='display:none;'>
<b>�˻���γ�ֵ��</b><br/><br/>
���"�ҵ��˻�" ->"��ֵ"��ѡ��֧������΢��֧��������ɳ�ֵ��<br/></div>
<div id="div4" style='display:none;'>
<b>ͣ��ȯ���ʹ�ã�</b><br/><br/>
������ͣ����֧��ͣ����ʱ��Ĭ������ʹ��ͣ��ȯ�����㲿��ʹ�����֧��<br/></div>
<div id="div5" style='display:none;'>
<b>VIP����ʧ��ô�죿</b><br/><br/>
�粻����ʧ������"����"�йر�"�Զ�֧��"��Ȼ��ȥͣ���������¿����ɣ��Ͽ��Զ�ע����<br/></div>
<div id="div6" style='display:none;'>
<b>��ͼ����ʾ�����г����������ֻ�֧��ô��</b><br/><br/>
��ͼ���ϽǵĿ�֧��ͼ��Ϊ��ɫ��״̬ʱ����ͼ����ʾ�ĳ������ǿ����ֻ�֧����<br/></div>
<div id="div7" style='display:none;'>
<b>���ڳ�����֧��ͣ����֧����ô�죿</b><br/><br/>
���ż����������������ǡ�Ҳ��ӭ�����"������30Ԫ"��ͼ���Ƽ��շ�Ա����ͣ���������˽��й����շѣ��Ƽ��ɹ����ǽ�������30Ԫͣ���ѡ�<br/></div>
<div id="div8" style='display:none;'>
<b>ͣ��ȯ��λ�ȡ��</b><br/><br/>
���״�ע������ͣ��ȯ�⣬ÿ��ĵ�һ�ʶ������ǻ᷵3Ԫͣ��ȯ��ͬʱ���Ի�ȡһ�����������ᡣ<br/></div>
<div><br/><br/><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;<span  onclick="backhelp();">���������б�&nbsp;<img src="images/redo.gif"/> </span></div>
</div>
 
</div>

</body>

<script type="text/javascript">
function getParam(paramName)
{
        paramValue = "";
        isFound = false;
        if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=")>1)
        {
            arrSource = unescape(this.location.search).substring(1,this.location.search.length).split("&");
            i = 0;
            while (i < arrSource.length && !isFound)
            {
                if (arrSource[i].indexOf("=") > 0)
                {
                     if (arrSource[i].split("=")[0].toLowerCase()==paramName.toLowerCase())
                     {
                        paramValue = arrSource[i].split("=")[1];
                        isFound = true;
                     }
                }
                i++;
            }   
        }
   return paramValue;
};

var id = getParam("q");

document.getElementById("div"+id).style.display='';

function backhelp(){
	location = "help.jsp"
}
</script>
</html>

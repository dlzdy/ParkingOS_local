<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���������û���ͳ�Ʒ���</title>
<link rel="stylesheet" type="text/css" href="js/anlysis/style.css?v=20100302" />
<script type="text/javascript" src="js/anlysis/jquery.min.js"></script>
<script type="text/javascript" src="js/anlysis/highcharts.js"></script>
<script type="text/javascript" src="js/anlysis/consumeanlysis.js"></script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>

</head>
<body >
<div id="data_container">
<!--������ʼ-->
<div class="top">
<ul class="title"><li class="parentmenu">���������û���ͳ�Ʒ��� &raquo; </li>
</ul>
<ul class="search">
<span id="seconddateinput" class="search_text">
���ڣ�<input  class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true})" type="text" name="endDateSelect" id="btime" align="absmiddle" readonly   />
-<input  class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'%y-%M-01',alwaysUseStartDate:true})" type="text" name="endDateSelect" id="etime" align="absmiddle" readonly   />
</span>
<span class="search_button">
<span class="button_light_green"><button name="" onclick="loaddata()"><span class="confirm"><img src="js/anlysis/spacer.gif" /></span>ȷ��</button></span>
</span>
</ul>
</div>
<!--��������-->
<!--��������ʼ-->
<div class="tooles">
<span id="tips" class="count_tips">&nbsp;&nbsp;����Ϊ��λͳ������</span>
<!-- <span class="tooles_botton">
<span class="button"><button name="" onclick="javascript:print();"><span class="print2"><img src="js/anlysis/spacer.gif" /></span>��ӡ</button></span>
</span> -->
</div>
<!--����������-->
<div class="float_clear"></div><!--�������-->

<script type="text/javascript">
</script>

<div id="chart_container" style="width: 100%; height: 400px; margin:10px auto;float:left"></div>

</body>
</html>

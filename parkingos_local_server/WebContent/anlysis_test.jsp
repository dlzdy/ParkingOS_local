<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ͳ�Ʒ����˵�</title>
<link rel="stylesheet" type="text/css" href="js/anlysis/style.css?v=20100302" />
<script type="text/javascript" src="js/anlysis/jquery.min.js"></script>
<script type="text/javascript" src="js/anlysis/highcharts.js"></script>
<script type="text/javascript" src="js/anlysis/aanalysis.js"></script>
</head>
<body onload=hiddlecontent('currentMon')>
<div id="data_container">
<!--������ʼ-->
<div class="top">
<ul class="title"><li class="parentmenu">����ָ�����Ʒ��� &raquo; </li><li class="currentmenu">�绰���仯����</li><li class="counthelp" title="����鿴����" onclick="javascript:window.open('http://www.tq.cn/help_3.jsp')"><span class="help"><img src="js/js_tq8/images/spacer.gif" /></span>����</li>
</ul>
<ul class="search">
<span class="search_type">
      <select name="department_id"  onChange="allQuery(this)"  id="department_id">
				 <option  selected  value="">ȫ��</option>	  	                     			
				     						<option value='-1'>|--ȫ��</option>
    			     						<option value='10220553'>|--����������</option>
    			     						<option value='10211689'>|--�г���չ��</option>
    			     						<option value='10234447'>|--��Ʒ�з���</option>
    			     						<option value='10235812'>|--�ͻ���Ӫ��</option>
    			     			</select>
	
  <span id='userListTd'><select name="kefu_uin" id='kefu_uin' >
				 <option value="" >ȫ��</option> 
					
		      </select>
		    </span>
			<!--
  <select name="rangeSelect" id="rangeSelect" size="1" onChange="javascript:changeRange(this);" >
    <option value="selfdefine" disabled>�Զ����ѯ&darr;</option>
    <option value="2" >����Ϊ��λ(&nbsp;����&nbsp;)</option>
    <option value="4" >����Ϊ��λ(&nbsp;����&nbsp;)</option>
    <option value="1"  disabled>��ʱΪ��λ(&nbsp;����&nbsp;)</option>
    <option value="3" >����Ϊ��λ(&nbsp;����&nbsp;)</option>
    <option value="5" >����Ϊ��λ(&nbsp;����&nbsp;)</option>
    <option value="quicksearch" disabled>��ݲ�ѯ&darr;</option>
    <option selected="selected" value="currentDay" >���죨���죩</option>
    <option value="preDay" >���죨���죩</option>
    <option value="currentDay1"  disabled>���죨��ʱ��</option>
    <option value="preDay1"  disabled>���죨��ʱ��</option>
    <option value="currentWeek" >���ܣ����죩</option>
    <option value="preWeek" >���ܣ����죩</option>
    <option value="currentMon" >���£����죩</option>
    <option value="preMon" >���£����죩</option>
    <option value="currentSeason" >�����ȣ����죩</option>
    <option value="preSeason" >�ϼ��ȣ����죩</option>
    <option value="currentYear" >���꣨���£�</option>
    <option value="preYear" >ȥ�꣨���£�</option>
  </select>
  
  -->
<select name="rangeSelect" id="rangeSelect" size="1" onChange="javascript:changeRange(this);" >
  <optgroup label="ѡ���ѯ��ʽ&darr;">
    <option  value="2" >������</option>
    <option  value="4" >����</option>
    <option  value="3" >������</option>
    <option  value="5" >����</option>
    </optgroup>
  <optgroup label="���ѡ��&darr;">
    <option  value="currentDay" >����</option>
    <option  value="preDay" >����</option>
    <option  value="currentWeek" >����</option>
    <option  value="preWeek" >����</option>
    <option  value="currentMon" >����</option>
    <option  value="preMon" >����</option>
    <option  value="currentSeason" >������</option>
    <option  value="preSeason" >�ϼ���</option>
    <option  value="currentYear" >����</option>
    <option  value="preYear" >ȥ��</option>
   </optgroup>
  </select>
</span>
<span id="firstdateinput" class="search_text">
<input  class="Wdate" type="text" name="startDateSelect" id="startDateSelect_field" align="absmiddle" readonly  onclick="WdatePicker({maxDate:'%y-%M-%d'});Reset_rangeSelect(0);" />
</span>
<span id="seconddateinput" class="search_text">
<input  class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\\\'startDateSelect_field\\\',{d:1})}'});Reset_rangeSelect(0);" type="text" name="endDateSelect" id="endDateSelect_field" align="absmiddle" readonly   />
</span>
<span class="search_button">
<span class="button_light_green"><button name="" onclick="hiddlecontent('')"><span class="confirm"><img src="js/js_tq8/images/spacer.gif" /></span>ȷ��</button></span>
</span>
</ul>
</div>
<!--��������-->
<!--��������ʼ-->
<div class="tooles">
<span id="tips" class="count_tips">&nbsp;&nbsp;����Ϊ��λͳ�Ʊ�������</span>
<span class="tooles_botton">
<span class="button"><button name="" onclick="javascript:print();"><span class="print2"><img src="js/js_tq8/images/spacer.gif" /></span>��ӡ</button></span>
</span>
</div>
<!--����������-->
<div class="float_clear"></div><!--�������-->

<script type="text/javascript">
</script>

<div id="chart_container" style="width: 100%; height: 400px; margin:10px auto;float:left"></div>

</body>
</html>

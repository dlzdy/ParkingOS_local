<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Ȩ������</title>
<link href="css/zTreeStyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="js/anlysis/style.css?v=20100302" />
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="js/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>
<script src="js/jquery.ztree.exhide-3.5.js" type="text/javascript"></script>
<script type="text/javascript">
		var roleid = ${id};
		var jsonData = ${jsonData};

		var setting = {
			view: {
				selectedMulti: false
			},
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				
			}
		};
		
		function createTree(jsonData) {
			$.fn.zTree.init($("#treeDemo"), setting, jsonData);
		}
		$(document).ready(function(){
			createTree(jsonData);
		});
	</script>
	<script type="text/javascript">
		function save(){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var ckdnodes = zTree.getCheckedNodes(true);
			var authids="[";
			for(var i=0;i<ckdnodes.length;i++){
				var ckdnode = ckdnodes[i];
				var level = ckdnode.level;
				var id = ckdnode.id;
				var pid = ckdnode.pId;
				if(level == 0){
					pid = 0;
				}
				authids = authids + "{'nid':"+id+",'pid':"+pid+"},";
			}
			if(authids.length > 1){
				authids = authids.substring(0,authids.length-1);
			}
			authids += "]";
			var result = T.A.sendData("authsetting.do?action=saveauth&id="+roleid+"&auth="+authids);
			if(result == 1){
				T.loadTip(1,"�����ɹ���",2,"");
			}else{
				T.loadTip(1,"����ʧ�ܣ�",2,"");
			}
		}
	</script>
</head>
<body>
<div id="data_container">
<!--������ʼ-->
<div class="top">
<ul class="title"><li class="parentmenu">Ȩ������</li>
</ul>
<ul class="search">
<div style="margin-left:57px">
<input class="managebutton" onClick="save()" type="button" value="����"/>
</div>
</ul>
</div>
<!--��������-->
<!--��������ʼ-->
<!--����������-->
<div class="float_clear"></div><!--�������-->
<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree" style="margin-left:50px;"></ul>
	</div>
</body>
</html>

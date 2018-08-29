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
<script src="js/jquery.ztree.exedit-3.5.js" type="text/javascript"></script>
<script src="js/jquery.ztree.exhide-3.5.js" type="text/javascript"></script>
<script type="text/javascript">
		var roles = ${roles}
		var setting = {
			view: {
				selectedMulti: false
			},
			edit: {
				enable: true,
				showRemoveBtn: false,
				showRenameBtn: false
			},
			data: {
				keep: {
					parent:true,
					leaf:true
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeDrag: beforeDrag,
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRemove: onRemove
			}
		};
		var className = "dark";
		function beforeDrag(treeId, treeNodes) {
			return false;
		}
		function beforeRemove(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			return confirm("ȷ��ɾ����ɫ -- " + treeNode.name + " ��");
		}
		function onRemove(e, treeId, treeNode) {
		}
		function beforeRename(treeId, treeNode, newName) {
			if (newName.length == 0) {
				alert("��ɫ���Ʋ���Ϊ��.");
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				setTimeout(function(){zTree.editName(treeNode)}, 10);
				return false;
			}
			return true;
		}
		function createTree(jsonData) {
			$.fn.zTree.init($("#treeDemo"), setting, jsonData);
		}
		
		function add(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var allNodes = zTree.getNodes()[0].children;
			var lastNodeId = allNodes[allNodes.length-1].id;
			var newNodeId = (parseInt(lastNodeId)+1) + "";
			var isParent = e.data.isParent;
			var treeNode = zTree.getNodeByTId("1");//���ڵ㣬��ɫ����
			if (treeNode) {
				treeNode = zTree.addNodes(treeNode, {id:(newNodeId), pId:treeNode.id, isParent:isParent, name:"�༭��ɫ����"});
			}
			if (treeNode) {
				zTree.editName(treeNode[0]);
			}
		};
		function edit() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0) {
				T.loadTip(1,"����ѡ��һ����ɫ��",2,"");
				return;
			}
			zTree.editName(treeNode);
		};
		function remove(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0) {
				alert("����ѡ��һ����ɫ");
				return;
			}
			var isremove  = confirm('ȷ��Ҫɾ���ý�ɫ��?')
			if(isremove){
				treeNode.isHidden = true;
				zTree.refresh();
				removeRole(treeNode);
			}
		};
		
		function removeRole(treeNode){
			var roleid = -1;
			if(treeNode){
				var nodeid = treeNode.id;
				roleid = nodeid.substring(2);
			}
			var result = T.A.sendData("authsetting.do?action=removerole&roleid="+roleid);
			if(result == 1){
				T.loadTip(1,"�����ɹ���",2,"");
			}else{
				T.loadTip(1,"����ʧ�ܣ�",2,"");
			}
		}
		
		function saveNodeName(){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = zTree.getSelectedNodes();
			var treeNode = nodes[0];
			var roleid = -1;
			var rolename = "";
			if(treeNode){
				var nodeid = treeNode.id;
				roleid = parseInt(nodeid)%100;
				rolename = treeNode.name;
			}
			var result = T.A.sendData("authsetting.do?action=rolemanage&roleid="+roleid+"&rolename="+rolename);
			if(result == 1){
				T.loadTip(1,"�����ɹ���",2,"");
			}else{
				T.loadTip(1,"����ʧ�ܣ�",2,"");
			}
		}
		$(document).ready(function(){
			createTree(roles);
			$("#addLeaf").bind("click", {isParent:false}, add);
			$("#edit").bind("click", edit);
			$("#remove").bind("click", remove);
		});
	</script>
</head>
<body>
<div id="data_container">
<!--������ʼ-->
<div class="top">
<ul class="title"><li class="parentmenu">��ɫ����</li>
</ul>
<ul class="search">
<div style="margin-left:57px">
<input id="addLeaf" class="managebutton" type="button" value="��ӽ�ɫ"/>&nbsp;
<input id="edit" class="managebutton" type="button" value="�༭��ɫ"/>&nbsp;
<input id="remove" class="managebutton" type="button" value="ɾ����ɫ"/>
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

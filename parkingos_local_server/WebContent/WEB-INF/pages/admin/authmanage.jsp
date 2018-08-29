<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����Ȩ������</title>
<link href="css/zTreeStyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="js/anlysis/style.css?v=20100302" />
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/tq.js?0817" type="text/javascript">//���</script>
<script src="js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="js/jquery.ztree.excheck-3.5.js" type="text/javascript"></script>
<script src="js/jquery.ztree.exedit-3.5.js" type="text/javascript"></script>
<script src="js/jquery.ztree.exhide-3.5.js" type="text/javascript"></script>
<script type="text/javascript">
		var auths = ${auths}
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
			return confirm("ȷ��ɾ��Ȩ�� -- " + treeNode.name + " ��");
		}
		function onRemove(e, treeId, treeNode) {
		}
		function beforeRename(treeId, treeNode, newName) {
			if (newName.length == 0) {
				alert("Ȩ�����Ʋ���Ϊ��.");
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
			var isParent = e.data.isParent;
			var nodes = zTree.getSelectedNodes();
			var treeNode = nodes[0];
			var hasChildren = treeNode.check_Child_State;//�ж��Ƿ����ӽڵ�
			var childid = -1;//�½ڵ�ID
			if(hasChildren == -1){
				var curNodeId = treeNode.id+"";
				childid = parseInt(curNodeId + "1");
			}else{
				var allchildrenNodes = treeNode.children;
				for(var i=0;i<allchildrenNodes.length;i++){
					var childrenid = parseInt(allchildrenNodes[i].id);
					if(childrenid > childid){
						childid = childrenid;
					}
				}
				childid = childid + 1;
			}
			if (treeNode) {
				treeNode = zTree.addNodes(treeNode, {id:(childid), pId:treeNode.id, isParent:isParent, name:"��༭����"});
			}
			if (treeNode) {
				zTree.editName(treeNode[0]);
			} else {
				T.loadTip(1,"Ҷ�ڵ㲻��������ӽڵ㣡",2,"");
			}
		};
		function edit() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0) {
				T.loadTip(1,"����ѡ��һ��Ȩ�ޣ�",2,"");
				return;
			}
			zTree.editName(treeNode);
		};
		function remove(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0) {
				alert("����ѡ��һ��Ȩ��");
				return;
			}
			var hasChildren = treeNode.check_Child_State;//�ж��Ƿ����ӽڵ�
			if(hasChildren == -1){
				var isremove  = confirm('ȷ��Ҫɾ���ý�ɫ��?');
				if(isremove){
					treeNode.isHidden = true;
					zTree.refresh();
					removeAuth(treeNode);
				}
			}else{
				var isChildrenClear = true;
				var children = treeNode.children;
				for(var i=0;i<children.length;i++){
					var child = children[i];
					if(!child.isHidden){
						isChildrenClear = false;
					}
				}
				if(isChildrenClear){
					var isremove  = confirm('ȷ��Ҫɾ���ý�ɫ��?');
					if(isremove){
						treeNode.isHidden = true;
						zTree.refresh();
						removeAuth(treeNode);
					}
				}else{
					T.loadTip(1,"����ɾ���ӽڵ㣡",2,"");
				}
			}
		};
		
		function removeAuth(treeNode){
			var nodeid = -1;
			var pid = -1;
			if(treeNode){
				nodeid = treeNode.id;
				pid = treeNode.pId;
			}
			var result = T.A.sendData("authsetting.do?action=removeauth&nodeid="+nodeid+"&pid="+pid);
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
			var nodeid = -1;
			var pid = -1;
			var nodename = "";
			if(treeNode){
				var nodeid = treeNode.id;
				nodename = treeNode.name;
				pid = treeNode.pId;
				var isparent = treeNode.isParent;
			}
			var result = T.A.sendData("authsetting.do?action=authmanagesave&nodeid="+nodeid+"&pid="+pid+"&nodename="+nodename+"&isparent="+isparent);
			if(result == 1){
				T.loadTip(1,"�����ɹ���",2,"");
			}else{
				T.loadTip(1,"����ʧ�ܣ�",2,"");
			}
		}
		$(document).ready(function(){
			createTree(auths);
			$("#addParent").bind("click", {isParent:true}, add);
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
<ul class="title"><li class="parentmenu">����Ȩ������</li>
</ul>
<ul class="search">
<div style="margin-left:57px">
<input id="addParent" class="managebutton" type="button" value="��Ӹ��ڵ�"/>&nbsp;
<input id="addLeaf" class="managebutton" type="button" value="����ӽڵ�"/>&nbsp;
<input id="edit" class="managebutton" type="button" value="�༭Ȩ��"/>&nbsp;
<input id="remove" class="managebutton" type="button" value="ɾ���ڵ�"/>
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

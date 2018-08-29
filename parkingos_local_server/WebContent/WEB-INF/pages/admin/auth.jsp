<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>��ɫ�б�</title>
	<link href="css/zTreeStyle.css" rel="stylesheet" type="text/css">
	<script src="js/jquery.js" type="text/javascript"></script>	
<script src="js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script src="js/jquery.ztree.exhide-3.5.js" type="text/javascript"></script>
 <style>
	body {
	background-color: white;
	margin:0; padding:0;
	text-align: center;
	}
	div, p, table, th, td {
		list-style:none;
		margin:0; padding:0;
		color:#333; font-size:12px;
		font-family:dotum, Verdana, Arial, Helvetica, AppleGothic, sans-serif;
	}
	#testIframe {margin-left: 10px;}
  </style>
  <SCRIPT type="text/javascript" >
  <!--
  
    var roles = ${roles};
	var demoIframe;

	var setting = {
		view: {
			dblClickExpand: false,
			showLine: true,
			selectedMulti: false
		},
		data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: ""
			}
		},
		callback: {
			beforeClick: function(treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("tree");
				if (treeNode.isParent) {
					zTree.expandNode(treeNode);
					return false;
				} else {
					getUrl(treeNode);
					return true;
				}
			}
		}
	};

	$(document).ready(function(){
		var t = $("#tree");
		t = $.fn.zTree.init(t, setting, roles);
		demoIframe = $("#testIframe");
		demoIframe.bind("load", loadReady);
		var zTree = $.fn.zTree.getZTreeObj("tree");
//		zTree.selectNode(zTree.getNodeByParam("id", 101));

	});

	function loadReady() {
		var bodyH = demoIframe.contents().find("body").get(0).scrollHeight,
		htmlH = demoIframe.contents().find("html").get(0).scrollHeight,
		maxH = Math.max(bodyH, htmlH), minH = Math.min(bodyH, htmlH),
		h = demoIframe.height() >= maxH ? minH:maxH ;
		if (h < 530) h = 530;
		demoIframe.height(h);
	}
	
	function getUrl(treeNode){
		var nid = treeNode.id;
		var pid = treeNode.pId;
		if(pid == "1" && nid == "11"){//��ɫ����
			var url = "authsetting.do?action=rolesetting"
			demoIframe.attr("src",url);
		}else if(pid == "1" && nid == "12"){//���Ź���
			var url = "authsetting.do?action=departmentsetting"
			demoIframe.attr("src",url);
		}else if(pid == "1" && nid == "13"){//����Ȩ�޹���
			var url = "authsetting.do?action=authmanage"
			demoIframe.attr("src",url);
		}else if(pid == "1" && nid == "15"){//��Ա����
			var url = "authsetting.do?action=personmanage"
			demoIframe.attr("src",url);
		}else if(pid == "14"){
			var roleid = nid.substring(2);
			var url = "authsetting.do?action=authsetting&id="+roleid
			demoIframe.attr("src",url);
		}else{
			
		}
	}

  //-->
  </SCRIPT>
</head>

<body>
<TABLE border=0 height=600px align=left>
	<TR>
		<TD width=260px align=left valign=top style="BORDER-RIGHT: #999999 1px solid;background: rgb(249, 249, 249);">
			<ul id="tree" class="ztree" style="width:260px; overflow:auto;"></ul>
		</TD>
		<TD width=100% align=left valign=top><IFRAME ID="testIframe" Name="testIframe" FRAMEBORDER=0 SCROLLING=AUTO width=100%  height=600px SRC=""></IFRAME></TD>
	</TR>
</TABLE>

</body>
</html>
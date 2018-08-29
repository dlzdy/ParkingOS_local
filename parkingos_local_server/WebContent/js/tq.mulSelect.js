/*
	tq.mulSelect.js
	��ѡ�� 2013-06-20
*/
function mulSelect(initArg){
	var t = this;
	var initArg = initArg||{};
	t.uiObj = initArg.uiObj;//�ؼ�����Ķ���
	t.valueObj = initArg.valueObj;//������������(������,��<input>)
	t.nameObj = initArg.nameObj;//�������Ӧ�����ƽ����
	t.selects = initArg.selects;//��ʼ�г���ID����(id1,id2,id3)
	t.onlyFlag = initArg.onlyFlag||"tqmulSelect";//Ψһ��ʶ,�ַ���,�Է�ֹ���ͬ��ؼ���ͻ,���ܰ���"_"
	t.treeData = initArg.treeData;//������
	t.dataUrl = initArg.dataUrl;//����url(���Ӿݷ�������ȡ)
	t.noDataTip = initArg.noDataTip//������ʱ��ʾ

	t.ajaxSearch=initArg.ajaxSearch||false;
	
	
	t.treeDatas = t.treeData||{};//������
	t.treeDatas["root_0"] = {"id":"0","name":"��ѡ��",icon:"root",cktp:false};
	if(!t.uiObj||!t.valueObj){return};
	t.uiObj = typeof(t.uiObj)=="object"?t.uiObj:document.getElementById(t.uiObj);
	t.valueObj = typeof(t.valueObj)=="object"?t.valueObj:document.getElementById(t.valueObj);
	var _Opos = T.gpos(t.uiObj);
	var _w = _Opos.width;
	var _h = _Opos.height;
	var _ms = document.createElement("div");
	var _l = document.createElement("div");
	var _r = document.createElement("div");
	_l.id = "mulSelect_l";
	_r.id = "mulSelect_r";

	_ms.style.width = _w + "px";
	_ms.style.height = _h-4 + "px";
	_ms.style.float = "left";
	_ms.style.border = "1px solid #889DAD";
	_ms.style.background = "#DFE8F6";
	_ms.style.overflow = "hidden";
	_ms.style.position = "relative";
	
	_l.style.width = _w/2 -1 + "px";
	_l.style.height = _h-4 + "px";
	_l.style.cssFloat = "left";
	_l.style.float = "left";
	_l.style.lineHeight = "16px";
	_l.style.overflow = "auto";
	_l.style.position = "relative";
	_l.style.paddingLeft = "1px";
	
	_r.style.width = _w/2 - 2 + "px";
	_r.style.height = _h-4 + "px";
	_r.style.overflow = "hidden";
	_r.style.position = "absolute";
	_r.style.top = "0px";
	_r.style.right = "0px";
	_r.style.borderLeft = "1px solid #889DAD";
	
	t.uiObj.appendChild(_ms);
	_ms.appendChild(_l);
	_ms.appendChild(_r);
	
	var _delFun = function(v){
		if(!v){return};
		mulSelectTree.setCheckByNode(v,false);
		if(T("#mulSelectTree_"+v+"_search")){//�ж������б�
			var ckicon = T("#mulSelectTree_"+v+"_search").getAttribute("ckicon");
			if(ckicon.indexOf("0")==-1){ckicon="C0"}else{ckicon="C1"};
			T("#mulSelectTree_"+v+"_search").src = mulSelectTree.icons[ckicon].src;
		}
	};
	var _clearFun = function(v){
		if(!v){return};
		mulSelectTree.setCheckByNode(v,false);
		mulSelectTree.ClearSearchList();//�ж������б�
	};
	eval(""+t.onlyFlag+"SortDrag = new makeDragSort({"+
		"uiObj:_r,"+
		"sortedIds:'"+t.valueObj.value+"',"+
		"valueObj:t.valueObj,"+
		"onlyFlag:\""+t.onlyFlag+"SortDrag\","+
		"endDragFun:null,"+
		"delFun:_delFun,"+
		"clearFun:_clearFun"+
	"});");


	mulSelectTree = new tqTree({
		treeId:"mulSelectTree",
		isSearch:true,
		dataType:t.dataUrl?1:0,
		dataUrl:t.dataUrl,
		localData:t.treeDatas,
		treeObj:_l,
		ajaxSearch:t.ajaxSearch,
		treeTip:!t.dataUrl?(typeof(t.treeData)!="object"||t.treeData==null?t.noDataTip:""):"",
		//focusExec:false,
		nodeFnArgs:"id,name,type,nodeId,checked,sourcePath,childNodes,relationIndex,checktype,checked,noImport",
		nodeClick:function(){
			var arg = arguments;
			if(arg[6])return;
			mulSelectTree.setCheckByNode(arg[5],true);
			if(T("#mulSelectTree_"+arg[0]+"_search")){//�ж������б�
				var ckicon = arg[9]=="0"?(arg[8]+"1").toUpperCase():(arg[8]+"0").toUpperCase();
				T("#mulSelectTree_"+arg[0]+"_search").src = mulSelectTree.icons[ckicon].src;
				T("#mulSelectTree_"+arg[0]+"_search").setAttribute("ckicon",ckicon);
			}
		},
		checkFun:function(){
			var arg = arguments;
			if(arg[6]||arg[10]){return};
			if(arg[4]=="1"){
				eval(t.onlyFlag+"SortDrag.add_sort(arg[1],arg[0])")
			}else{
				eval(t.onlyFlag+"SortDrag.del_sort(arg[0])")
			}
		},
		isCheck:true,
		loadfun:function(v){
			mulSelectTree.expandAll();//ȫ��չ��
			//mulSelectTree.setCheckByNode(t.selects)
			if(t.nameObj){
				if(t.nameObj.value!=''){
					var _names = t.nameObj.value.split(",");
					var _ids = t.valueObj.value.split(",");
					var _namesL = _names.length;
					for(var l=0;l<_namesL;l++){
						var _name = _names[l];
						var _value = _ids[l];
						eval(t.onlyFlag+"SortDrag.add_sort(_name,_value)")
					};
					mulSelectTree.setCheckByNode(t.valueObj.value)
				}
			}else{
				mulSelectTree.setCheckByNode(t.selects)
				//mulSelectTree.setCheckByNode(t.valueObj.value)
			}
		}
	});
	mulSelectTree._icons.folder = "seats.gif";
	mulSelectTree._icons.file = "seat.gif";
	mulSelectTree._iconsExpand.folder = "seats.gif";
	mulSelectTree.C();
}


function mulSelectZYQ(initArg){
	var t = this;
	var initArg = initArg||{};
	t.uiObj = initArg.uiObj;//�ؼ�����Ķ���
	t.valueObj = initArg.valueObj;//������������(������,��<input>)
	t.selects = initArg.selects;//��ʼ�г���ID����(id1,id2,id3)
	t.onlyFlag = initArg.onlyFlag||"tqmulSelect";//Ψһ��ʶ,�ַ���,�Է�ֹ���ͬ��ؼ���ͻ,���ܰ���"_"
	t.treeData = initArg.treeData;//������
	t.noDataTip = initArg.noDataTip//������ʱ��ʾ
	
	
	t.treeDatas = t.treeData||{};//������
	t.treeDatas["root_0"] = {"id":"0","name":"��ѡ��",icon:"root",cktp:false};
	if(!t.uiObj||!t.valueObj){return};
	t.uiObj = typeof(t.uiObj)=="object"?t.uiObj:document.getElementById(t.uiObj);
	t.valueObj = typeof(t.valueObj)=="object"?t.valueObj:document.getElementById(t.valueObj);
	var _Opos = T.gpos(t.uiObj);
	var _w = _Opos.width;
	var _h = _Opos.height;
	var _ms = document.createElement("div");
	var _l = document.createElement("div");
	var _r = document.createElement("div");
	_l.id = "mulSelect_l";
	_r.id = "mulSelect_r";

	_ms.style.width = _w + "px";
	_ms.style.height = _h-4 + "px";
	_ms.style.float = "left";
	_ms.style.border = "1px solid #889DAD";
	_ms.style.background = "#DFE8F6";
	_ms.style.overflow = "hidden";
	_ms.style.position = "relative";
	
	_l.style.width = _w/2 -1 + "px";
	_l.style.height = _h-4 + "px";
	_l.style.cssFloat = "left";
	_l.style.float = "left";
	_l.style.lineHeight = "16px";
	_l.style.overflow = "auto";
	_l.style.position = "relative";
	_l.style.paddingLeft = "1px";
	
	_r.style.width = _w/2 - 2 + "px";
	_r.style.height = _h-4 + "px";
	_r.style.overflow = "hidden";
	_r.style.position = "absolute";
	_r.style.top = "0px";
	_r.style.right = "0px";
	_r.style.borderLeft = "1px solid #889DAD";
	
	t.uiObj.appendChild(_ms);
	_ms.appendChild(_l);
	_ms.appendChild(_r);
	
	var _delFun = function(v){
		if(!v){return};
		mulSelectTreeZYQ.setCheckByNode(v,false);
		if(T("#mulSelectTreeZYQ_"+v+"_search")){//�ж������б�
			var ckicon = T("#mulSelectTreeZYQ_"+v+"_search").getAttribute("ckicon");
			if(ckicon.indexOf("0")==-1){ckicon="C0"}else{ckicon="C1"};
			T("#mulSelectTreeZYQ_"+v+"_search").src = mulSelectTreeZYQ.icons[ckicon].src;
		}
	};
	var _clearFun = function(v){
		if(!v){return};
		mulSelectTreeZYQ.setCheckByNode(v,false);
		mulSelectTreeZYQ.ClearSearchList();//�ж������б�
	};
	eval(""+t.onlyFlag+"SortDrag = new makeDragSort({"+
		"uiObj:_r,"+
		"sortedIds:'"+t.valueObj.value+"',"+
		"valueObj:t.valueObj,"+
		"onlyFlag:\""+t.onlyFlag+"SortDrag\","+
		"endDragFun:null,"+
		"delFun:_delFun,"+
		"clearFun:_clearFun"+
	"});");

	mulSelectTreeZYQ = 
		new tqTree({
			treeId:"mulSelectTreeZYQ",
			isSearch:true,
			dataType:0,
			localData:t.treeDatas,
			treeObj:_l,
			checkParent:false,
			checkChild:false,
			treeTip:typeof(t.treeData)!="object"||t.treeData==null?t.noDataTip:"",
			//focusExec:false,
			nodeFnArgs:"id,name,type,nodeId,checked,sourcePath,childNodes,relationIndex,checktype,checked,noImport",
			nodeClick:function(){
				var arg = arguments;
				//if(arg[6])return;
				mulSelectTreeZYQ.setCheckByNode(arg[5],true);
				if(T("#mulSelectTreeZYQ_"+arg[0]+"_search")){//�ж������б�
					var ckicon = arg[9]=="0"?(arg[8]+"1").toUpperCase():(arg[8]+"0").toUpperCase();
					T("#mulSelectTreeZYQ_"+arg[0]+"_search").src = mulSelectTreeZYQ.icons[ckicon].src;
					T("#mulSelectTreeZYQ_"+arg[0]+"_search").setAttribute("ckicon",ckicon);
				}
			},
			checkFun:function(){
				var arg = arguments;
				//if(arg[6]||arg[10]){return};
				if(arg[4]=="1"){
					eval("faqSelectSortDrag.add_sort(arg[1],arg[0])")
				}else{
					eval("faqSelectSortDrag.del_sort(arg[0])")
				}
			},
			isCheck:true,
			loadfun:function(v){
				mulSelectTreeZYQ.expandAll();//ȫ��չ��
				mulSelectTreeZYQ.setCheckByNode(faqs)
			}
		});
	mulSelectTreeZYQ.C();

	
}
		
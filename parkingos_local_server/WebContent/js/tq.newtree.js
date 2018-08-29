/*TQtree
	ע��:�ڵ�����Դ����������nodeInit�ж����this.nodes�еĲ�������ͬ(��title��)
	����������ʽ��{pid_id:{id:id,name:name}}  ��ҳ��չ�� {page:1,total:10,rows:{pid_id:{id:id,name:name}}}
	
	ע���е�sourceIdΪrelationIndex��"_"�ָ��ĵڶ���ֵ,������ʹ��sorceIdʱ�����뱣֤���ڵ�Ψһ,��ͬһ�ڵ㲻�ᱻ����ڵ�����
	2013-03-05 ��δ�����չcheckbox��radio��ѡ�ķ�ʽ
	2013-06-21 ��չcheckbox��ع���
	2013-08-31 ��չN�๦��
	2013-12-24 ���Ӵӷ��������� �� ��ҳ����
*/
tqTree = function(o){
	/**********************************
	 ��������
	**********************************/
	this.tc = T.extend({
		Path:"images/Mtree/",//��Դ�ļ�·��
		treeId:"TQtree",//Ψһ��ʶ�������ظ�
		treeObj:null,//����������
		keyBoard:false,//�Ƿ�������̲���
		treeTip:null,//������ʾ
		isSearch:false,//�Ƿ���ʾ����������
		searchLoadAll:true,//����ʱ�ȼ���ȫ������
		seearchUI:null,//��������,Ĭ�����б����򶥲�
		
		isTool:false,//�Ƿ���ʾչ��ȫ��/����ȫ������
		dataUrl:"../tree/demodata.txt",//���������ַ
		method:"get",//��������ʽ
		param:"",//�������,�ɱ�
		searchparam:"",//�������� searchvalue=xxxx
		ajaxSearch:false,//�ӷ���������
		dataType:1,//1��ʾԶ�̶�ȡ,0��ʾ��������
		localData:null,//dataTypeΪ0ʱ,ֱ�Ӹ�ֵ
		focusExec:true,//��λ��ĳ�ڵ�ʱͬʱִ�е���¼�
		nodeClick:null,//ȫ�ֽڵ����¼�����ɵ������ýڵ�fn���Ե���ִ��fn����,����ʱ,ִֻ��fn
		nodeFnArgs:"",//�ڵ��¼��������(id,name,,,,),����nodeClick�Լ�fn
		
		nodeExt:[{name:"",tit:"����",type:"up",condition:[{param:"hasChild",value:false}],iconcls:"icon16 icon16up"},{name:"",tit:"����",type:"down",iconcls:"icon16 icon16down"}],//�ڵ���չ������ť(�ڵ������ұ���ʾ)
		//�����������ĸ�ʽ
		//ע��:conditonΪ�ջ�δ����ʱ,��ʾ���нڵ����Ӵ���չ����
		//���⻹�������ⲿͨ����̬����dom����չ�Զ��尴ť
		//��nodeExtFn���ʹ��
		nodeExtFn:function(){var args = arguments;var type =args[args.length-1]; alert(type)/*alert(args[0]+"___"+args[1])*/},//��չ��ť��Ӧ���¼�����,��nodeExt���ʹ��
		
		nodeExt:false,
		nodeExtFn:false,
		
		loadfun:false,//���������ִ�к���
		isCheck:false,
		checkFun:false,//�Զ���checkbox�¼�
		expandExeChkF:false,//չ��ʱ�Ƿ�ִ���Զ���checkbox�¼�
		expandFun:false,//չ��ʱִ�к���
		checkType:"checkbox",//ȫ�ֳ�ʼ������Ϊcheckbox,radio,�������򲻲���ѡ����ɵ��������ӽڵ�����:cktp(��:��ʼ�Ƿ�ѡ������ckd��true/false)
		checkChild:true,//�Ƿ����ѡ������Ŀ
		checkParent:true,//�Ƿ����ѡ����Ŀ
		treeW:"",//ֵΪautoʱ,��ʾ�Զ����
		treeH:"",//ֵΪautoʱ,��ʾ�Զ��߶�
		MaxH:false,//���߶�(��δ����,����չ)
		MinH:200,//��С�߶� Ĭ�ϱ����Ǵ���30(�������29)������
		ajaxTip:false,//��̬���ݼ���ʱ��ʾ���� dom����
		cutpage:false,//�Ƿ��ҳ
		perpage:300,//ÿҳ����,Ĭ�ϱ������0
		cpage:1,//��ʼ����ǰҳ
		recordtotal:0 //��ҳʱ��������������  ���,��̨����,�ǿɶ����ʼ������
		
	},o);
	var t = this;
	t._d    = ",";//���ӹ�ϵ�ַ������Ϸָ���
	t.divider   = "_";//���ӹ�ϵ�����ַ���,���
	t.colors   = //�ڵ�ѡ����ʽ
	{
		"highLight" : "#FFE6B0",
		"highLightText" : "#000000",
		"border" : "1px solid #FFB951"
	};
	t.icons = {};
	t._icons    = { //�ڵ�ͼ������
		L0        : 'L0.gif',  //��
		L1        : 'L1.gif',  //��
		L2        : 'L2.gif',  //��
		L3        : 'L3.gif',  //��
		L4        : 'L4.gif',  //��
		PM0       : 'P0.gif',  //����
		PM1       : 'P1.gif',  //����
		PM2       : 'P2.gif',  //����
		PM3       : 'P3.gif',  //����
		empty     : 'L5.gif',     //�հ�
		root      : 'root.gif',   //ȱʡ���ڵ�ͼ��
		folder    : 'folder.gif', //ȱʡ�ļ���ͼ��
		file      : 'file.gif',   //ȱʡ�ļ�ͼ��
		wait      : 'wait.gif',   //������
		C0        :'checkbox0.gif',  //δѡ��
		C1        :'checkbox1.gif',  //ѡ��
		C2        :'checkbox2.gif',  //��ѡ��
		R0        :'radio0.gif',   //δѡ��
		R1        :'radio1.gif',   //ѡ��
		R2        :'radio2.gif',   //��ѡ��
		book      :'book.gif',
		books     :'books.gif',
		bookset   :'bookset.gif',
		user      :'user.gif',
		users     :'users.gif',
		blcokuser :'BlockUser.png',
		rmb       :'RMB.gif',
		object    :'Objects.gif',
		home      :'Home.gif',
		webchat   :'webchat.png',
		api       :'Remote.png',
		seat      :'seat.gif',
		seats     :'seats.gif',
		phone     :'phone.gif',
		call      :'call.gif',
		building  :'building.gif',
		music     :'music.gif',
		message   :'msg.gif',
		tree      :'tree.gif',
		star      :'star.gif',
		syslog    :'earthpaper.gif',
		ivr_voice_avigation   :'music.gif',
		ivr_seat_queue :'seats.gif',
		ivr_did   :'did.gif',
		dnis_number_tb     :'phone.gif',
		book      :'book.gif',
		books     :'books.gif',
		bookset   :'bookset.gif',
		user      :'user.gif',
		users     :'users.gif',
		blcokuser :'BlockUser.png',
		rmb       :'RMB.gif',
		object    :'Objects.gif',
		home      :'Home.gif',
		webchat   :'webchat.png',
		api       :'Remote.png',
		seat      :'seat.gif',
		seats     :'seats.gif',
		phone     :'phone.gif',
		call      :'call.gif',
		call1     :'call1.gif',
		building  :'building.gif',
		music     :'music.gif',
		message   :'msg.gif',
		tree      :'tree.gif',
		star      :'star.gif',
		syslog    :'earthpaper.gif',
		media     :'lookpaper.gif'
	};
	t.iconsExpand = {};
	t._iconsExpand = {  //�ڵ�չ��ʱ��ӦͼƬ
		PM0       : 'M0.gif',     //����
		PM1       : 'M1.gif',     //����
		PM2       : 'M2.gif',     //����
		PM3       : 'M3.gif',     //����
		folder    : 'folderopen.gif'
	};
	t.keydown= function(e){ //����������Ӧ�¼�
		var treeId = t.tc.treeId;
		if(!t.tc.keyBoard)return;
		if(!T("#"+treeId+"_treelist"))return;
		e = window.event || e; var key = e.keyCode || e.which;
		var e_tar=e.srcElement?e.srcElement:e.target;
		if(e_tar.id.split("_")[0]!=t.tc.treeId)
		{
		  return;
		};
		switch(key)
		{
			case 37 : eval(treeId).upperNode(); break;  //��
			case 38 : eval(treeId).pervNode();  break;  //��
			case 39 : eval(treeId).lowerNode(); break;  //��
			case 40 : eval(treeId).nextNode();  break;  //��
		}
	};
	t.currentNode = null;//��ǰ��λ�ڵ����
	t.currentPath = "";//��ǰ��λ�ڵ�·��
	t.init = function(){
		t.checkedNodes = [];//��ѡ���������ID����
		t.checkedNode = "";//radio��ʱ��������
		t.index = 0;//�ڵ��ʼ����
		t.nodes = {};//�ڵ㼯��
		t.relation = "";//���ӹ�ϵ�ַ�������
		t.isAllLoad = false;//�ڵ��ǲ���ȫ�����Ѽ������
		t.nodes["0"] = //��ʼ�����ڵ�
		{
			"nodeId": "0",
			"path": "root",
			"isLoad": false,
			"childNodes": [],
			"childPrepose": "",
			"sourcePath": "root",
			"relationIndex": "root"
		};
	}
};
tqTree.prototype = {
	treeData:null,
	orginData:null,
	searchData:null,//�������
	tcBind : function(p){//���������Բ�������
		var l = this.tc;
		this.tc = null;
		this.tc = T.extend(l,p);
		l = null;
	},
	/**********************************
	 ������/�ؽ���(Createtree)
	 @boolean isFresh �Ƿ�Ϊˢ�²���
	**********************************/
	C:function(isFresh){
		if(!this.tc.treeObj){T.loadTip(1,"TREEȱ�ٲ���",2);return}
		var t = this;
		var tc = this.tc;
		
		t.init();
		
		var treeObj = tc.treeObj;
		treeObj.innerHTML = "";
		if(tc.treeTip){
			treeObj.innerHTML = tc.treeTip
		};
		var treeDiv = document.createElement("div");
		
		var treeObjH = treeObj.offsetHeight||1;
		var _treeObjH = treeObjH < tc.MinH ? tc.MinH:treeObjH;
		var searchH = tc.isSearch?29:0;
		var tooleH = tc.isTool?25:0;
		
		tc.isSearch?this.createSearch(_treeObjH - searchH):"";
		tc.isTool?this.createTool():"";
		
		!tc.treeH?
			(treeDiv.style.height = _treeObjH - searchH - tooleH + "px",treeObj.style.overflow = "hidden")
			:
			(!isNaN(parseInt(tc.treeH))?
				treeDiv.style.height = tc.treeH + "px"
				:""
			);
		!isNaN(parseInt(tc.treeW))?
			treeDiv.style.width = tc.treeW + "px"
			:(treeDiv.style.width = "100%")
		treeDiv.style.overflow = "auto";
		treeDiv.id = this.tc.treeId + "_treelist";
		treeDiv.style.position = "relative";
		treeObj.appendChild(treeDiv);
		
		this.M(isFresh);
	},
	/**********************************
	 �г�(MakeTree)
	 @boolean isFresh �Ƿ�Ϊˢ�²���
	**********************************/
	M:function(isFresh){
		var t = this;
		var tc = this.tc;
		
		var treeDiv = T("#"+this.tc.treeId + "_treelist");
		function callback(data){
			if(!treeDiv)return;
			treeDiv.innerHTML = "";
			if("object"!=typeof(data)){T.loadTip(2,"�������ݣ������!<br />�������ݸ�ʽ����",2,tc.ajaxTip||t.tc.treeObj);return};
			//data = {
			//	page:1,
			//	total:2000,
			//	rows:data
			//}
			if(data.page){
				if(data.total==0){
					T.loadTip(2,"�������ݣ������!",2,tc.ajaxTip||t.tc.treeObj);
					return
				};
				tc.recordtotal = parseInt(data.total);
				if(tc.cutpage&&tc.recordtotal>tc.perpage){//������������������ÿҳ��ʾ��ʱ����ʾ��ҳ
					if(!T("#"+ tc.treeId + "_page_cut")){
						t.makepageUI();
						treeDiv.style.height = parseInt(treeDiv.style.height) - 27 + "px";
					};
					var totpage = Math.ceil(parseInt(data.total)/parseInt(tc.perpage));
					t.cutPage(parseInt(data.page),totpage,parseInt(data.total));
				}else{
					if(T("#"+ tc.treeId + "_page_cut")){
						treeDiv.style.height = parseInt(treeDiv.style.height) + 27 + "px";
						T("#"+ tc.treeId + "_page_cut").parentNode.removeChild(T("#"+ tc.treeId + "_page_cut"));
					};
				};
				
				data = data.rows;
			};
			
			t.treeData = data;
			t.orginData = data;
			
			treeDiv.innerHTML = t.I(isFresh);
			if(isFresh&&t.currentPath){t.focus(t.currentPath,false,false,false,true)}//ˢ�º�λ��ԭλ��
			tc.loadfun&&!isFresh?setTimeout(t.tc.treeId+".tc.loadfun()",100):"";//�������ִ�к���
		};
		if(tc.dataType==1){
			var lurl = tc.dataUrl;
			var param = tc.searchparam?tc.param+"&"+tc.searchparam:tc.param;
			var _total = tc.recordtotal!=0?"&tqpagetotal="+tc.recordtotal:"";
			if(tc.method.toUpperCase()=="POST"){
				T.A.sendData(lurl,"POST",param+"&pg="+tc.perpage+"&cp="+tc.cpage+_total,callback,2,tc.ajaxTip||tc.treeObj,"","������...",true);
			}else{
				lurl = lurl.indexOf("?")!=-1?lurl+"&":lurl+"?";
				T.A.sendData(lurl+param+"&pg="+tc.perpage+"&cp="+tc.cpage+_total,"GET","",callback,2,tc.ajaxTip||tc.treeObj,"","������...",true);
			}
		};
		if(tc.dataType==0){
			callback(tc.localData)
		};
	},
	/**********************************
	 ��ʼ��(Init)
	**********************************/
	I: function(isFresh) {
		var t = this;
		this.relaFormat();
		isFresh?"":this.setIconPath(this.tc.Path);
		this.loadChildItem("0");
		var rootChild = this.nodes["0"].childNodes;
		var str = "<a id='"+ this.tc.treeId +"_root' href='javascript:void(0)' style='display: none'></a>";

		if(rootChild.length>0){
			this.nodes["0"].hasChild = true;
			for(var i=0; i<rootChild.length; i++)str += this.node2html(rootChild[i], i==rootChild.length-1);
			setTimeout(this.tc.treeId +".expand('"+ rootChild[0].nodeId +"', true); "+ 
			//this.tc.treeId +".focusStyle('"+ rootChild[0].nodeId +"'); "+ this.tc.treeId +".rootIsEmpty()",10);
			this.tc.treeId +".focusStyle(); "+ this.tc.treeId +".rootIsEmpty()",10);
			//this.tc.treeId +".rootIsEmpty()",10);
		}else{
			return "û������";
		};
		
		this.tc.keyBoard?T("doc").aevt("keydown",t.keydown):"";//���̲���
		
		return "<div class='tqtreeview' "+
		"onclick='"+ this.tc.treeId +".clickFun(event)' "+
		"ondblclick='"+ this.tc.treeId +".dblClickFun(event)' "+
		">"+ str +"</div>";
	},
	/**
	�����ҳ��
	**/
	makepageUI : function(){
		var TNM = this.tc.treeId;
		var tc =  this.tc;
		var treepageDiv = document.createElement("div");
		treepageDiv.id = tc.treeId + "_page_cut";
		treepageDiv.style.borderTop = "1px solid #ccc";
		var treepageDivc = [];
				treepageDivc.push("<TABLE style=\"border:0px;width:100%\" id=\""+TNM+"_footer\" class=\"t-pager\" cellSpacing=\"0\" cellPadding=\"0\">");
					treepageDivc.push("<TBODY>");
						treepageDivc.push("<TR>");
							treepageDivc.push("<TD style='width:100%'>");
								treepageDivc.push("<div class=\"t-pager-buttons\">");
									treepageDivc.push("<SPAN title=\"��ҳ\" id=\""+TNM+"_pbutton_first\" class=\"button16_a  bg_green_hover border_green fl\" style='width:18px;'>");
										treepageDivc.push("&lt;&lt;");
									treepageDivc.push("<\/SPAN>");
									treepageDivc.push("<SPAN title=\"ǰһҳ\" id=\""+TNM+"_pbutton_prev\" class=\"button16_a  bg_green_hover border_green fl\" style='width:18px;'>");
										treepageDivc.push("&lt;");
									treepageDivc.push("<\/SPAN>");
//									treepageDivc.push("<SPAN class=\"t-pager-index fl\">");
//										treepageDivc.push("<INPUT id=\""+TNM+"_pinput_curr\" class=\"t-pager-num fl\" style='width:20px' value=\"0\" type=\"text\" title=\"����ҳ��,���س�����ת\">");
//										treepageDivc.push("<SPAN id=\""+TNM+"_pinput_pages\" class=\"t-pager-pages\">\/0<\/SPAN>");
//									treepageDivc.push("<\/SPAN>");
									treepageDivc.push("<SPAN title=\"��һҳ\" id=\""+TNM+"_pinput_next\" class=\"button16_a  bg_green_hover border_green fl\" style='width:18px;'>");
										treepageDivc.push("&gt;");
									treepageDivc.push("<\/SPAN>");
									treepageDivc.push("<SPAN title=\"ĩҳ\" id=\""+TNM+"_pinput_last\" class=\"button16_a  bg_green_hover border_green fl\" style='width:18px;'>");
										treepageDivc.push("&gt;&gt;");
									treepageDivc.push("<\/SPAN>");
								treepageDivc.push("<\/div>");
								
							treepageDivc.push("<div style=\"float:right;padding:2px 5px 0 0\">");
								treepageDivc.push("<span class=\"icon16 icon16tip fl\"></span><span id=\""+TNM+"_pinput_pages\"></span>");
							treepageDivc.push("<\/div>");
								
//							treepageDivc.push("<div style=\"float:right;padding:2px 5px 0 0\">");
//							//treepageDivc.push("��<span id=\""+TNM+"_pages_total\">0</span>��&nbsp;&nbsp;ÿҳ");
//								treepageDivc.push("<select id=\""+TNM+"_pages_select\">");
//								for(var p=0;p<tc.pagetype.length;p++){
//									treepageDivc.push("<option value="+tc.pagetype[p]+"");
//									tc.pagetype[p] == tc.perpage?treepageDivc.push(" selected=\"selected\""):"";
//									treepageDivc.push(">"+tc.pagetype[p]+"<\/option>");
//								};
//								treepageDivc.push("<\/select>");
//							//treepageDivc.push("��");
//							treepageDivc.push("<\/div>");
							treepageDivc.push("<\/TD>");
						treepageDivc.push("<\/TR>");
					treepageDivc.push("<\/TBODY>");
				treepageDivc.push("<\/TABLE>");
			treepageDiv.innerHTML = treepageDivc.join("");
			this.tc.treeObj.appendChild(treepageDiv);
			treepageDivc = null
	
	},
	/**********************************
	 ������ҳ
	 cp:��ǰҳ��
	 tp:��ҳ��
	 dt:�ܼ�¼��
	**********************************/
	cutPage : function(cp,tp,dt){
		var thisT = this;
		var TNM = this.tc.treeId;
		var btnFirs = document.getElementById(TNM+"_pbutton_first");//��ҳ
		var btnPrev = document.getElementById(TNM+"_pbutton_prev");//��һҳ
		var totPage = document.getElementById(TNM+"_pinput_pages");//��ǰҳ
		var btnNext = document.getElementById(TNM+"_pinput_next");//��һҳ
		var btnLast = document.getElementById(TNM+"_pinput_last");//βҳ
		
		//��ҳ��ť�¼�
		btnFirs.onclick = function(){
			if(cp<2){return};
			thisT.tc.cpage = 1;
			thisT.reloadData();
		};
		if(cp>1){
			btnFirs.title = "�Ϸ�����һҳ";
			btnFirs.className = "button16_a bg_green_hover border_green fl";
		}else{
			btnFirs.title = "�ѵ���ǰ";
			btnFirs.className = "button16_a button_disable fl"
		};
		//��һҳ��ť�¼�
		btnPrev.onclick = function(){
			if(cp<2){return};
			thisT.tc.cpage--;
			thisT.reloadData();
		};
		if(cp>1){
			btnPrev.title = "�Ϸ�һҳ";
			btnPrev.className = "button16_a bg_green_hover border_green fl";
		}else{
			btnPrev.title = "�ѵ���ǰ";
			btnPrev.className = "button16_a button_disable fl"
		};
		//��ҳ����ʾ
		totPage.parentNode.title = "��ǰ��"+cp+"ҳ,��"+dt+"����¼,"+tp+"ҳ,ÿҳ"+thisT.tc.perpage+"��\n����̫��ʱ,��ʹ������";
		totPage.innerHTML = cp;
		//��һҳ��ť�¼�
		btnNext.onclick = function(){
			if(cp>tp-1){return};
			thisT.tc.cpage++;
			thisT.reloadData();
		};
		if(cp<tp){
			btnNext.title = "�·�һҳ";
			btnNext.className = "button16_a bg_green_hover border_green fl";
		}else{
			btnNext.title = "�ѵ����";
			btnNext.className = "button16_a button_disable fl"
		};
		//���һҳ��ť�¼�
		btnLast.onclick = function(){
			if(cp>tp-1){return};
			thisT.tc.cpage = tp;
			thisT.reloadData();
		};
		if(cp<tp){
			btnLast.title = "�·������һҳ";
			btnLast.className = "button16_a bg_green_hover border_green fl"
		}else{
			btnLast.title = "�ѵ����";
			btnLast.className = "button16_a button_disable fl"
		};
		//����
		btnFirs = null;
		btnPrev = null;
		totPage = null;
		btnNext = null;
		btnLast = null;
	},
	/**********************************
	������
	**********************************/
	reloadData : function(p){
		var t = this;
		if(p){
			t.tcBind(p)
		};
		t.init();
		t.tc.keyBoard?T("doc").revt("keydown",t.keydown):"";//���ԭ�Ȱ󶨵��¼�
		t.M();
	},
	/**********************************
	������,��λ��ԭ�ڵ�
	**********************************/
	refresh : function(p){
		var t = this;if(p){
			t.tcBind(p)
		};
		t.init();
		t.tc.keyBoard?T("doc").revt("keydown",t.keydown):"";//���ԭ�Ȱ󶨵��¼�
		t.M(true);
	},
	/**********************************
	������,������в�������������
	**********************************/
	clearData : function(p){
		var t = this;
		if(p){
			t.tcBind(p)
		};
		t.tc.recordtotal = 0;//��������ǰ��¼����
		t.tc.searchparam = '';//������������
		t.tc.cpage = 1;
		t.init();
		t.tc.keyBoard?T("doc").revt("keydown",t.keydown):"";//���ԭ�Ȱ󶨵��¼�
		t.M();
	},
	/**********************************
	 ��������
	**********************************/
	createTool : function(){
		var t = this;
		var toolDiv = document.createElement("div");
		toolDiv.id = this.tc.treeId+"_treetool";
		toolDiv.className = "treetool";
		
		var expandSpan = document.createElement("span");
		var shrinkSpan = document.createElement("span");
		expandSpan.className = "button16_a border_blank hover1 fl";
		expandSpan.style.marginLeft = "2px";
		expandSpan.innerHTML = "+չ��ȫ��";
		
		shrinkSpan.className = "button16_a border_blank hover1 fl";
		shrinkSpan.style.marginLeft = "5px";
		shrinkSpan.innerHTML = "-����ȫ��";
		
		toolDiv.appendChild(expandSpan);
		toolDiv.appendChild(shrinkSpan);
		
		expandSpan.onclick = function(){
			T.cancelBub();
			t.expandAll();
		}
		shrinkSpan.onclick = function(){
			T.cancelBub();
			t.shrinkAll();
		}
		this.tc.treeObj.appendChild(toolDiv);

	},
	/**********************************
	 ��������
	**********************************/
	createSearch : function(resultH){
		var searchDiv = document.createElement("div");
		var seearchUI = this.tc.seearchUI||this.tc.treeObj;
		searchDiv.className = "treesearch";
		var queryhtml =  "<div id=\"querypanel\" class=\"titlepanel\">";
        queryhtml += " <input type=\"text\" id=\""+this.tc.treeId+"_querytext\" class=\"querytext\" value=\"����ؼ���,���س�������\" onfocus=\"if(this.value=='����ؼ���,���س�������'){this.value=''}\" onblur=\"if(this.value==''){this.value='����ؼ���,���س�������'}\" nosub=\"true\"";	
        if(T.ie){
        	 queryhtml += " onkeydown=\""+this.tc.treeId+".searchKeyDown()\" ";	  
        }else{
        	 queryhtml += " onkeypress=\"javascript:"+this.tc.treeId+".searchKeyDown(event)\" ";	  
        }
        queryhtml += " >";	
        queryhtml += " <a href=\"javascript:void(0);\" id=\""+this.tc.treeId+"_btnQuery\" onclick=\""+this.tc.treeId+".btnQuery();\">";
        queryhtml += " <span class=\"uquery\" title=\"����\">&nbsp;<\/span>";
        queryhtml += " <\/a> ";
        queryhtml += " <a href=\"javascript:void(0);\" id=\""+this.tc.treeId+"_btnClearQuery\" style=\"display:none;\" onclick=\""+this.tc.treeId+".btnClearQuery();\">";
        queryhtml += " <span class=\"qdelete\" title=\"ȡ������\" >&nbsp;<\/span>";
        queryhtml += " <\/a>";
        queryhtml +=  " <\/div>";
        
		searchDiv.innerHTML = queryhtml;
		seearchUI.appendChild(searchDiv);
        var searchList = document.createElement("div");
        searchList.innerHTML = "<br />searchList<br />";
        searchList.style.display = "none";
        searchList.style.overflow = "auto";
        searchList.style.height = resultH + "px";
        searchList.id = this.tc.treeId + "_searchList";
		this.tc.treeObj.appendChild(searchList);
	},
	/**********************************
	 ������ť�¼�
	**********************************/
	btnQuery : function(){
		T.cancelBub();
		var querytext = T("#"+this.tc.treeId+"_querytext");
		var btn = T("#"+this.tc.treeId+"_btnQuery");
		var Cbtn = T("#"+this.tc.treeId+"_btnClearQuery");
		var Tlist = T("#"+this.tc.treeId+"_treelist");
		var Slist = T("#"+this.tc.treeId+"_searchList");

		//�����������ݹ�������
		var searchV = T.trim(querytext.value);
		if(searchV==""||searchV=="����ؼ���,���س�������"){
			querytext.value = "";
			querytext.focus();
			T.loadTip(1,"����ؼ���,���س�������",1,this.tc.treeObj)
			return
		};
		
		if(this.tc.recordtotal>this.tc.perpage||this.tc.ajaxSearch){//������������صļ�¼������ÿҳ�г���,�ӷ���������
			this.reloadData({
				cpage:1,
				recordtotal:0,
				searchparam:"searchvalue="+searchV
			});
			btn.style.display = "none";
			Cbtn.style.display = "block";
			return;
		};
		
		var result = this.searchByName(searchV,true);//this.searchByName(searchV,false);
		if(result){
			btn.style.display = "none";
			Cbtn.style.display = "block";
			Tlist.style.display = "none";
			Slist.style.display = "block";
			this.tc.isTool?T("#"+this.tc.treeId+"_treetool").style.display = "none":"";
			
			var _nhtml = "<span style='font-style:Oblique;color:#090;padding-bottom:4px;width:100%;float:left;'>���ҽ��:</span>";
			for(var i in result){
				_nhtml += "<span style='float:left;width:100%;height:20px;overflow:hidden;white-space:nowrap;'>";
				if(this.tc.isCheck&&result[i].checktype){
					var ckicon = (result[i].checktype+result[i].checked).toUpperCase();
					_nhtml += "<img style='float:left;cursor:pointer' src='"+this.icons[ckicon].src+"' ";
					_nhtml += " ckicon='"+ckicon+"'";
					_nhtml += " id='"+this.tc.treeId+"_"+result[i].id+"_search'";
					_nhtml += " onclick=\"return "+ this.tc.treeId +".searchCheck(this,'"+ result[i].sourcePath +"')\" ";
					_nhtml += " />";
				};
					_nhtml += "<span style='white-space:nowrap;overflow:hidden;display:block;line-height:20px;height:20px;margin-left:1px;cursor:pointer'";
					_nhtml += " title='"+result[i].name+"'";
					_nhtml += " onmouseover=\"this.style.background='url(images/commonbgs.gif) repeat-x 0 0px'; \"";
					_nhtml += " onmouseout=\"this.style.background='none';this.style.border='none' \"";
					//_nhtml += " onclick=\"return "+ this.tc.treeId +".nodeClick('"+ result[i].nodeId +"')\" >";
					_nhtml += " onclick=\"return "+ this.tc.treeId +".focusNode('"+ result[i].sourcePath +"',true)\" >";
					_nhtml += result[i].name;
					_nhtml += "</span>"
				_nhtml += "</span>"
			}
			Slist.innerHTML = _nhtml;
			
		}else{
			T.loadTip(1,"��ƥ������",2,this.tc.treeObj)
		}
		querytext.focus();
	},
	/**********************************
	 ȡ����ť�¼�
	**********************************/
	btnClearQuery : function(){
		T.cancelBub();
		var querytext = T("#"+this.tc.treeId+"_querytext");
		var btn = T("#"+this.tc.treeId+"_btnQuery");
		var Cbtn = T("#"+this.tc.treeId+"_btnClearQuery");
		var Tlist = T("#"+this.tc.treeId+"_treelist");
		var Slist = T("#"+this.tc.treeId+"_searchList");
		
		querytext.value = "";
		
		if(this.tc.recordtotal>this.tc.perpage||this.tc.ajaxSearch){//��ϴӷ���������,��ȡ������Ҳ�ӷ��������س�ʼ�����
			this.clearData();
			btn.style.display = "block";
			Cbtn.style.display = "none";
			return;
		};
		
		Slist.innerHTML = "";
		querytext.focus();
		btn.style.display = "block";
		Cbtn.style.display = "none";
		Tlist.style.display = "block";
		Slist.style.display = "none";
		this.tc.isTool?T("#"+this.tc.treeId+"_treetool").style.display = "block":"";
	},
	/**********************************
	 ��������б���������ʱ��
	**********************************/
	ClearSearchList : function(){
		var querytext = T("#"+this.tc.treeId+"_querytext");
		var btn = T("#"+this.tc.treeId+"_btnQuery");
		var Cbtn = T("#"+this.tc.treeId+"_btnClearQuery");
		var Tlist = T("#"+this.tc.treeId+"_treelist");
		var Slist = T("#"+this.tc.treeId+"_searchList");
		
		querytext.value = "";
		Slist.innerHTML = "";
		querytext.focus();
		
		btn.style.display = "block";
		Cbtn.style.display = "none";
		Tlist.style.display = "block";
		Slist.style.display = "none";
		this.tc.isTool?T("#"+this.tc.treeId+"_treetool").style.display = "block":"";
	},
	/**********************************
	 ���������checkbox/radio�¼�
	**********************************/
	searchCheck : function(ckobj,sourcePath){
		this.setCheckByNode(sourcePath);
		var _node = this.getNode(sourcePath);
		var ckicon = (_node.checktype+_node.checked).toUpperCase();
		ckobj.src = this.icons[ckicon].src;
		ckobj.setAttribute("ckicon",ckicon);
	},
	/**********************************
	 ����������¼�
	**********************************/
	searchKeyDown : function(e){
		var querytext = T("#"+this.tc.treeId+"_querytext");
		var e = e || window.event;
		var key = e.keyCode||e.which;
		if (key.toString() == "13") {
			if(T.trim(querytext.value)==""){
				querytext.focus();
				this.btnClearQuery();
			}else{
				this.btnQuery();
			}
		};
	},
	/**********************************
	 �������ӹ�ϵ����(���ӽڵ�����ַ��� root_1)
	**********************************/
	relaFormat : function(){
		var a = new Array();
		for (var id in this.treeData) a[a.length] = id;
		this.relation = a.join(this._d + this._d);
		this.totalNode = a.length; a = null;
	},
	/**********************************
	 ���ڵ����ӽڵ㴦��
	**********************************/
	rootIsEmpty : function(){
		var rootChild = this.nodes["0"].childNodes;
		for(var i=0; i<rootChild.length; i++){
			if(!rootChild[i].isLoad) this.expand(rootChild[i].nodeId);
			if (rootChild[i].name=="")
			{
				var node = rootChild[i].childNodes[0], HasChild  = node.hasChild;
				node.iconExpand  =  rootChild[i].childNodes.length>1 ? HasChild ? "PM0" : "L0" : HasChild ? "PM3" : "L3"
				T("#"+this.tc.treeId +"_expand_"+ node.nodeId).src = this.icons[node.iconExpand].src;
			}
		}
	},
	/**********************************
	�����ӽڵ����
	@string nodeId  �ڵ�Ψһ��ʶ
	@boolean isUpdate  �Ƿ��Ǹ���,��������ԭindex
	**********************************/
	loadChildItem : function(nodeId ,isUpdate){
		var node = this.nodes[nodeId], d = this.divider, _d = this._d;
		var sid = node.relationIndex.substr(node.relationIndex.indexOf(d) + d.length);
		var reg = new RegExp("(^|"+_d+")"+ sid +d+"[^"+_d+d +"]+("+_d+"|$)", "g");
		var cns = this.relation.match(reg), tcn = this.nodes[nodeId].childNodes;
		if (cns){
			reg = new RegExp(_d, "g"); 
			
//			for (var i=0; i<cns.length; i++)
//				tcn[tcn.length] = this.nodeInit(cns[i].replace(reg, ""), nodeId);
/*			for (var i=0; i<cns.length; i++){
				var relationIndexI = cns[i].replace(reg, "");
				var sourcePath = this.setPath(relationIndexI, nodeId);
				var childIndex = isUpdate?(this.getNode(sourcePath)?this.getNode(sourcePath).nodeId:false):false;
				tcn[tcn.length] = this.nodeInit(relationIndexI, nodeId, sourcePath, childIndex);
			}
*/		
			for (var i=0; i<cns.length; i++){
				var relationIndexI = cns[i].replace(reg, "");
				//var _sourcePath = node.sourcePath+"_"//this.setPath(relationIndexI, nodeId);
				tcn[tcn.length] = this.nodeInit(relationIndexI, nodeId, isUpdate);
			}

		};
		node.isLoad = true;
	},
	/**********************************
	���� this.treeData ���ɽڵ���������
	@string relationIndex ���ӽڵ�����ַ��� root_1
	@string parentId  ��ǰ���ڵ�ĸ��ڵ�index
	@boolean isUpdate  �Ƿ��Ǹ���,��������ԭindex
	**********************************/
	nodeInit : function(relationIndex, parentId, isUpdate){
		var source = this.treeData[relationIndex], d = this.divider;
		var name  = source["name"];
		var title  = source["title"];
		var sid   = relationIndex.substr(relationIndex.indexOf(d) + d.length);
		var sourcePath = this.nodes[parentId].sourcePath+"_"+sid;
		
		var nodeId = isUpdate?(this.getNode(sourcePath)?this.getNode(sourcePath).nodeId:false):false;
		if(!nodeId){
			this.index++
			nodeId = this.index
		};
		
		var scheckType = source["cktp"]==false?false:(source["cktp"]?source["cktp"]:this.tc.checkType);
		var checkType = scheckType == "radio"?"r":(scheckType == "checkbox"?"c":"");
		var checked = source["ckd"]?"1":"0";
		this.nodes[nodeId] = T.extend(
		{//�ڵ�����Դ�����������в�������ͬ(��title��)
			"nodeId"    : nodeId,//������,��js�Զ�����
			"title"  : title ? title : name,//���tip��ʾ
			"sourcePath" : sourcePath,//����Ψһ��ʶ֮һ,�ڵ�����·��,�ɸ�������Դid���root_1_2_3_4
			"path"  : this.nodes[parentId].path + d + nodeId,//�ڵ�·���ɸ�������ΨһnodeId���root_1_2_3_4
			"isLoad": false,//��Ӧ�ӽڵ��Ƿ��Ѽ���
			"isExpand": false,//�ڵ��Ƿ���չ��
			"parentId": parentId,//���ڵ�ID������ΨһID��
			"parentNode": this.nodes[parentId],//���ڵ����
			"hasChild":   false,//�Ƿ����ӽڵ�
			"childNodes": null,//�ӽڵ����
			"relationIndex" : relationIndex,//���ӹ�ϵ,root_1
			"childPrepose" : "",//�ڵ�ǰ��ͼ�����͸�������
			"checktype" : checkType,//�ڵ�ѡ������,r(radio)/c(checkbox)
			"checked"   : checked//�ڵ�ѡ��״̬,0:δѡ��,1:��ѡ��,2:��ѡ��
		},source);
//		this.nodes[nodeId].nodeId = nodeId;
//		this.nodes[nodeId].title =  title ? title : name;
//		this.nodes[nodeId].path =  this.nodes[parentId].path + d + nodeId;
//		this.nodes[nodeId].isLoad =  false;
//		this.nodes[nodeId].isExpand =  false;
//		this.nodes[nodeId].parentId =  parentId;
//		this.nodes[nodeId].parentNode =  this.nodes[parentId];
//		this.nodes[nodeId].hasChild =  false;
//		this.nodes[nodeId].childNodes =  [];
//		this.nodes[nodeId].relationIndex =  relationIndex;
//		this.nodes[nodeId].childPrepose =  "";
//		this.nodes[nodeId].checktype =  checkType;
//		this.nodes[nodeId].checked =  checked;
		
		this.nodes[nodeId].hasChild = this.relation.indexOf(this._d + sid + d)>-1;
		if(this.nodes[nodeId].hasChild)this.nodes[nodeId].childNodes = [];
		return this.nodes[nodeId];
	},
	/**********************************
	���ݽڵ���������html
	@object node �ڵ����
	@boolean isLast  �Ƿ�Ϊ���ڵ��µ����һ��
	@boolean isSelf  �Ƿ�ֻ���ɱ��ڵ�HTML(�������ӽڵ�)
	**********************************/
	node2html : function(node, isLast,isSelf){
		var nodeId   = node.nodeId;
		node.icon = node.type?node.type:node.icon;//���Ӱ�type������ͼ��,����IVR�е�����,������ã��Ժ��Ż�
		var HasChild  = node.hasChild, isRoot = node.parentId=="0";
		if(isRoot && node.icon=="") node.icon = "root";
		if(node.icon=="" || typeof(this.icons[node.icon])=="undefined")
			node.icon = HasChild ? "folder" : "file";
		node.iconExpand  = isLast ? "��" : "��";
		
		var html = "";
		if(!isSelf){
			html = "<div nowrap='True' class='nodeWord' nodeId='"+ nodeId +"' title='"+ node.title +"' "
			if(this.tc.nodeExt){
				html += "onmouseover=\"T(\'#"+ this.tc.treeId +"_\'+this.getAttribute(\'nodeId\')+\'_exticon_span\').style.visibility = 'visible'\" " +
						"onmouseout=\"T(\'#"+ this.tc.treeId +"_\'+this.getAttribute(\'nodeId\')+\'_exticon_span\').style.visibility = 'hidden'\"" 
			}
			html += "><nobr>"
		};
		if(!isRoot){
			node.childPrepose = node.parentNode.childPrepose + (isLast ? "��" : "��");
			node.iconExpand  = HasChild ? isLast ? "PM2" : "PM1" : isLast ? "L2" : "L1";
			html += "<span>"+ this.symbol2image(node.parentNode.childPrepose) +"<img "+
			"align='absmiddle' id='"+ this.tc.treeId +"_expand_"+ nodeId +"' "+
			"src='"+ this.icons[node.iconExpand].src +"' style='cursor: "+ (!node.hasChild ? "":
			(T.iev<7? "hand" : "pointer")) +"'></span>";
		};
		html += "<img "+
			"align='absMiddle' "+
			"id='"+ this.tc.treeId +"_icon_"+ nodeId +"' "+
			"src='"+ this.icons[node.icon].src +"' />";
		if (this.tc.isCheck&&node.checktype){
			var ckicon = (node.checktype+node.checked).toUpperCase();
			html += "<img border='0' style='cursor:pointer' ";
			switch(node.checktype){
				case "c" :
				html += "id='" + this.tc.treeId + "_checkbox_" + nodeId + "' "+
				"src='" + this.icons[ckicon].src + "' />";
				break;
				case "r" :
				html += "id='" + this.tc.treeId + "_radio_" + nodeId + "' "+
				"src='" + this.icons[ckicon].src + "' />";
				break
			};
		};

		html +=	"<a class='tqtreeview' hideFocus "+
			"id='"+ this.tc.treeId +"_link_"+ nodeId +"' ";
			
		html +=	T.iev<8?"href='#' ":"href='javascript:void(0)' ";
		html +=	"title='"+ node.title +"' ";
			node.hasChild?html +=	" style='font-weight:700' ":" ";
			html +=	
			//"onfocus=\""+ this.tc.treeId +".focusLink('"+ nodeId +"')\" "+
			//"onclick=\"return "+ this.tc.treeId +".nodeClick('"+ nodeId +"')\" "+ 
			" >"+(node.name.length>20?node.name.substring(0,20)+"..":node.name) +
			"</a></nobr>";
			
		//������ʾ��Ϣ
			
		html +=" <span id='"+ this.tc.treeId +"_tip_"+ nodeId +"' "+
			"style='color:#c00;font-weight:700 '>"+(node.tip?node.tip:"")+"</span>";//"+(node.tip?"display:block":"display:none")+"//<img border='0' align='absmiddle' src='"+this.icons["wait"].src+"'>
		
		//���Ӱ�ť
		if(this.tc.nodeExt){
			html += "<span id='"+ this.tc.treeId +"_"+nodeId+"_exticon_span' class='abs'  style='display:block;right:5px;top:0;visibility:hidden'>"
			var _nE = this.tc.nodeExt;
			T.each(this.tc.nodeExt,function(item,ii){
				if(item.condition){
					var _iC = item.condition;
					var kk =_iC.length;
					var resNum = 0;
					for(var jj=0;jj<kk;jj++){
						if(_iC[jj].value == node[_iC[jj].param]){
							resNum++
						}
					};
					if(resNum == kk){
						html += "<span class='button16_a hover1 border_blank fl' extfn='yes' nodeId='"+nodeId+"' type='"+item.type+"' title='"+(item.tit||item.name)+"'><span class='"+item.iconcls+" fl' extfn='yes' nodeId='"+nodeId+"' type='"+item.type+"' title='"+(item.tit||item.name)+"'></span>"+item.name+"</span>";
					}
				}else{
					html += "<span class='button16_a hover1 border_blank fl' extfn='yes' nodeId='"+nodeId+"' type='"+item.type+"' title='"+(item.tit||item.name)+"'><span class='"+item.iconcls+" fl' extfn='yes' nodeId='"+nodeId+"' type='"+item.type+"' title='"+(item.tit||item.name)+"'></span>"+item.name+"</span>";
				}
				item = null
			})
			html += "</span>"
		};
			
		isSelf?"":html += "</div>";
		if(isRoot && node.name=="") html = "";
		if(!isSelf){
			html = "\r\n<span id='"+ this.tc.treeId +"_tree_"+ nodeId +"' sourcepath='" + node.sourcePath + "'>"+ html 
			html +="<span style='display: none'></span></span>";
		};
		return html;
	},
	/**********************************
	���ýڵ�ǰ�ö�㼶ͼ��
	@string type ͼ������
	**********************************/
	symbol2image : function(type){
		var str = "";
		for(var i=0; i<type.length; i++){
			var img = "";
			switch (type.charAt(i))
			{
				case "��" : img = "L4"; break;
				case "��" : img = "L2"; break;
				case "��" : img = "empty"; break;
				case "��" : img = "L1"; break;
				case "��" : img = "L3"; break;
				case "��" : img = "L0"; break;
			}
			if(img!="")
				str += "<img align='absMiddle' src='"+ this.icons[img].src +"' height='20'>";
		}
		return str;
	},
	/**********************************
	�������ӽڵ�ת��html
	@string nodeId  �ڵ�Ψһ��ʶ
	**********************************/
	buildChild : function(nodeId){
		if(this.nodes[nodeId].hasChild){
			var tcn = this.nodes[nodeId].childNodes, str = "";
			for (var i=0,k=tcn.length; i<k; i++){
				if(T("#"+this.tc.treeId + "_tree_" + tcn[i].nodeId))continue;
				str += this.node2html(tcn[i], i==tcn.length-1);
			}
			var temp = T("#"+this.tc.treeId +"_tree_"+ nodeId).childNodes;
			temp[temp.length-1].innerHTML = str;
		}
	},
	/**********************************
	��λ�ڵ���ʽ
	@string nodeId  �ڵ�Ψһ��ʶ
	**********************************/
	focusStyle : function(nodeId){
		if(!this.currentNode){
			this.currentNode = this.nodes["0"];
			this.currentPath = this.currentNode.sourcePath
		};
		if(!nodeId){return};
		//getNodeObj
		var a = T("#"+this.tc.treeId +"_link_"+ nodeId);
		//T.gpos(a).top)
		if(a){
			a.focus();
			var link = T("#"+this.tc.treeId +"_link_"+ this.currentNode.nodeId);
			if(link)with(link.style){color="";backgroundColor="";border="";}
			with(a.style){
				color = this.colors.highLightText;
				backgroundColor = this.colors.highLight;
				border = this.colors.border;
			};
			this.currentNode = this.nodes[nodeId];
			this.currentPath = this.currentNode.sourcePath;
		};

//		if(T("#"+this.tc.treeId + "_treelist").style.display == "none")return;
//		var _curNodeTop = T.gpos(T("#"+this.tc.treeId +"_tree_"+ nodeId)).top + T.gpos(T("#"+this.tc.treeId + "_treelist")).top;
//		var _treeObjHeight = T.gpos(T("#"+this.tc.treeId + "_treelist")).height;
//		if(_curNodeTop > _treeObjHeight){
//			T("#"+this.tc.treeId + "_treelist").scrollTop = _curNodeTop - _treeObjHeight;
//		};
	},
	/**********************************
	�ڵ��ý���
	@string nodeId  �ڵ�Ψһ��ʶ
	**********************************/
	focusLink : function(nodeId){
		if(this.currentNode && this.currentNode.nodeId==nodeId) return;
		this.focusStyle(nodeId);
	},
	/**********************************
	չ���ڵ�
	@string nodeId  �ڵ�Ψһ��ʶ
	@boolean onlyExpand  ��չ��
	@boolean onlyShrink  ������
	**********************************/
	expand : function(nodeId, onlyExpand,onlyShrink){
		var node  = this.nodes[nodeId];
		if (onlyExpand && node.isExpand) return;
		if (onlyShrink && !node.isExpand) return;

		if (!node.hasChild) return;
		var area  = T("#"+this.tc.treeId +"_tree_"+ nodeId);
		if (area) area = area.childNodes[area.childNodes.length-1];
		if (area){
			var icon  = this.icons[node.icon];
			var iconE = this.iconsExpand[node.icon];
			var Bool  = node.isExpand = onlyExpand || area.style.display == "none";
			var img   = T("#"+this.tc.treeId +"_icon_"+ nodeId);
			if (img)  img.src = !Bool ? icon.src :typeof(iconE)=="undefined" ? icon.src : iconE.src;
			var exp   = this.icons[node.iconExpand];
			var expE  = this.iconsExpand[node.iconExpand];
			var expand;
			if (expand = T("#"+this.tc.treeId +"_expand_"+ nodeId)){
				expand.src = !Bool ? exp.src : typeof(expE) =="undefined" ? exp.src  : expE.src;
			}
			/*
			//�ڵ�����ʱ,��λ�����ڵ�(������)
			if(!Bool && this.currentNode.path.indexOf(node.path)==0 && this.currentNode.nodeId!=nodeId){
				try{T("#"+this.tc.treeId +"_link_"+ nodeId).click();}
				catch(e){this.focusStyle(nodeId);}
			}
			*/
			area.style.display = !Bool ? "none" : "block";
			if(!node.isLoad){
				this.loadChildItem(nodeId);
				if(node.nodeId=="0") return;
				//�ӽڵ����ʱ, ��ʾ���ڼ���
				if(node.hasChild && node.childNodes.length>200){
					setTimeout(this.tc.treeId +".buildChild('"+ nodeId +"')", 1);
					var temp = T("#"+this.tc.treeId +"_tree_"+ nodeId).childNodes;
					temp[temp.length-1].innerHTML = "<div nowrap><nobr><span>"+ 
					this.symbol2image(node.childPrepose +"��") +"</span>"+
					"<img border='0' align='absmiddle' src='"+this.icons["wait"].src+"'>"+
					"<A style='font-size: 9pt'>������,���Ժ�...</A></nobr></div>";
				}else{
					this.buildChild(nodeId);
				}
			};
			this.setChildCheck(node,this.tc.expandExeChkF);//����ѡ��״̬
			if(this.tc.expandFun){this.tc.expandFun(node)};
		}
	},
	/**********************************
	�����Զ������nodeFnArgs
	@Object node  �ڵ����
	**********************************/
	nodeFnArgs : function(node){
		if(!this.tc.nodeFnArgs){return false};
		var nP = this.tc.nodeFnArgs.split(",");
		var nPvalue = [];
		if(nP){
			T.each(nP,function(o,j){
				nPvalue.push(node[o]);
			});
		};
		return nPvalue;
	},
	/**********************************
	�ڵ㵥���¼�,�¼��������Զ���(�Զ��������������ϵͳ��������ͬ[��title��],���nodeInit����)
	@string nodeId  �ڵ�Ψһ��ʶ
	**********************************/
	nodeClick : function(nodeId){
		if(!nodeId)return false;
		var node = this.nodes[nodeId];
		var fn = node.fn;
		var nC = this.tc.nodeClick;
		if(!(!fn&&!nC)){
			var nPvalue = this.nodeFnArgs(node);
			if(fn){
				fn.apply(this,nPvalue);
			}else if(nC){
				nC.apply(this,nPvalue);
			};
		};
		//this.focusStyle(node.relationIndex);
		return false;
	}
	,
	/**********************************
	��ȡĳ�ڵ�����·��(��ѭ���ڵ�ʱ����ȷ��Ψһ)
	@string sourceId ����Դ�ڵ�id
	**********************************/
	getPath: function(sourceId){
		var _d = this._d, d = this.divider;
		var A = new Array(), sidItem=sourceId; A[0] = sidItem;
		while(sidItem!="root" && sidItem!=""){
			var str = "(^|"+_d+")([^"+_d+d+"]+"+d+ sidItem +")("+_d+"|$)";
			if (new RegExp(str).test(this.relation)){
				sidItem = RegExp.$2.substring(0, RegExp.$2.indexOf(d));
				if(T.AindexOf(A,sidItem)>-1) break;
				A[A.length] = sidItem;
			}else break;
		}
		return A.reverse();
	},
	/**********************************
	��ȡĳ�ڵ�����Ψһ·��(ȷ��Ψһ)
	@string relationIndex ����Դ�ڵ�����root_1
	@string parentId ����Դ�ڵ��Ӧ���и��ڵ�ΨһnodeId
	**********************************/
//	setPath : function(relationIndex, parentId){
//		var path=[],d=this.divider;
//		while(parentId!="0"/*&&typeof(parentId)!="undefined"*/){
//			path.push(relationIndex.split(d)[1])
//			relationIndex = this.nodes[parentId].relationIndex
//			parentId = this.nodes[parentId].parentId
//			this.setPath(relationIndex, parentId)
//		};
//		if(parentId=="0"){
//			path.push(relationIndex.split(d)[1])
//			path.push(relationIndex.split(d)[0])
//		};
//		return path.reverse().join("_")
//	},
	/**********************************
	��ȡ�ڵ����
	@string sourceFlag  ����ԴsourcePath����sourceId
	**********************************/
	getNode : function(sourceFlag){
		var nodes = this.nodes,node = false,d = this.divider;
		if(sourceFlag.toString().indexOf("_")==-1&&sourceFlag!="root"){
			for(var i in nodes){
				if(nodes[i].relationIndex.split(d)[1] == sourceFlag){
					node = nodes[i];
					break
				};
			};
		}else{
			for(var i in nodes){
				if(nodes[i].sourcePath == sourceFlag){
					node = nodes[i];
					break
				};
			};
		}
		return node
	},
	/**********************************
	����sourcePath��ȡrelationIndex
	@string path �ڵ�sourcePath
	**********************************/
	getRelationByPath : function(path){
		var d = this.divider;
		path = path.split(d);
		path1= path[path.length-2]
		path2= path[path.length-1]
		return path1 + d + path2
	},
	/**********************************
	����relationIndex��ȡ�Ѽ��صĽڵ�·���б�
	@string relationIndex �ڵ�����relationIndex(root_1)
	**********************************/
	getPathList : function(relationIndex){
		var allNode = this.nodes,rL = relationIndex.length;ret=[];
		for ( var i in allNode){
			var indexof = allNode[i].sourcePath.indexOf(relationIndex);
			if(indexof>-1&&allNode[i].sourcePath.length == indexof+rL ){
				ret.push(allNode[i].sourcePath)
			}
		};
		return ret
	},
	/**********************************
	ѡ�нڵ�
	@string sourceId ����Դ�ڵ�id(��Ӧ���������ص�Id),pathMode����Ϊ(root_1_2)
	@boolean onlyExpand  �Ƿ�չ����λ�ڵ�
	@boolean onlyShrink  �Ƿ�������λ�ڵ�
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��sourceId����ڵ��Ӧ·��(root_1_2),���ڵ�pathΪ"0"
	**********************************/
	focus : function(sourceId, defer, onlyExpand, onlyShrink ,pathMode){
		if (!defer){
			setTimeout(this.tc.treeId +".focus('"+ sourceId +"', true ,"+ onlyExpand +", "+ onlyShrink +" ,"+ pathMode +")", 100);
			return;
		}
		var path;
		if(pathMode){
			path = sourceId.split("_");
		}else{
			path = this.getPath(sourceId);
		};
		if(path[0]!="root"){
			T.loadTip(2,"<div style=\"width:100%;text-align:left\">��ʼ����λ�ڵ�ʧ�ܡ�<br />ԭ��1������Դid "+ sourceId +" �����ڡ�<br />ԭ��2������idû����ȷ���ù���·��<br />"+
			"id"+sourceId+"��·��Ϊ = "+ path.join(this.divider)+"<br />��ȷ·���׽ڵ�idӦΪroot,��:root_1_2</div>",10,this.tc.treeObj);
			return false;
		};
		var root = this.nodes["0"], len = path.length,focusExec = this.tc.focusExec;
		for(var i=1; i<len; i++){
			if(root.hasChild){
				var relationIndex = path[i-1] + this.divider + path[i];
				for (var k=0; k<root.childNodes.length; k++){
					if (root.childNodes[k].relationIndex == relationIndex){
						root = root.childNodes[k];
						if(i<len - 1){
							this.expand(root.nodeId, true);
						}else{
							focusExec?this.nodeClick(root.nodeId):"";//��������¼�
							onlyExpand?this.expand(root.nodeId,true):"";
							onlyShrink?this.expand(root.nodeId,"", true):"";
							this.focusStyle(root.nodeId);
						};
						break;
					}
				}
			}
		};
		return true
	},
	/**********************************
	�ڵ㵥���¼�(ȫ�ֶ���)
	**********************************/
	clickFun : function(e){
		e = window.event || e; e = e.srcElement || e.target;
		switch(e.tagName.toUpperCase()){
			case "IMG" :
			if(e.id){
			//Сͼ���ݲ���Ӧ�¼�
			//        if(e.id.indexOf(this.tc.treeId +"_icon_")==0)
			//          this.focusStyle(e.id.substr(e.id.lastIndexOf("_") + 1));
				if (e.id.indexOf(this.tc.treeId +"_expand_")==0){
					this.expand(e.id.substr(e.id.lastIndexOf("_") + 1));
				}else if (e.id.indexOf(this.tc.treeId + "_checkbox_") == 0) {
					var _node = this.nodes[e.id.substr(e.id.lastIndexOf("_") + 1)];
					this.setCheck(_node);
				}else if (e.id.indexOf(this.tc.treeId + "_radio_") == 0) {
					var _node = this.nodes[e.id.substr(e.id.lastIndexOf("_") + 1)];
					this.setRadioCheck(_node);
				}
			}
			break;
			case "A" :
				if(e.id){
					this.focusStyle(e.id.substr(e.id.lastIndexOf("_") + 1));
					this.nodeClick(e.id.substr(e.id.lastIndexOf("_") + 1))
				};
				break;
			case "SPAN" :
				if(e.className=="pm")
				this.expand(e.id.substr(e.id.lastIndexOf("_") + 1));
				else if(e.getAttribute("extfn")=="yes"){
					if(this.tc.nodeExtFn){
						var curNode = this.nodes[e.getAttribute("nodeId")];
						var _nPvalue = this.nodeFnArgs(curNode);
						_nPvalue.push(e.getAttribute("type"));//���һ�������Զ���type
						this.tc.nodeExtFn.apply(this,_nPvalue);
					};
					//this.tc.nodeExtFn(e.getAttribute("nodeId"),e.getAttribute("type"))
				}
				break;
			case "DIV" :
				if(e.className="nodeWord"){
					T.cancelBub();
					this.focusLink(e.getAttribute("nodeId"));
					this.nodeClick(e.getAttribute("nodeId"))
				};
				break;	
			default :
				if(this.navigator=="netscape") e = e.parentNode;
				if(e.tagName.toUpperCase()=="SPAN" && e.className=="pm")
					this.expand(e.id.substr(e.id.lastIndexOf("_") + 1));
				break;
		}
	},
	/**********************************
	�ڵ�˫���¼�
	**********************************/
	dblClickFun : function(e){
		e = window.event || e; e = e.srcElement || e.target;
		var tg = e.tagName.toUpperCase();
		if((tg=="A" || tg=="IMG")&& e.id){
			var id = e.id.substr(e.id.lastIndexOf("_") + 1);
			if(this.nodes[id].hasChild) this.expand(id);
		}
	},
	/**********************************
	ת����ǰ�ڵ�ĸ��ڵ�
	**********************************/
	upperNode : function(){
		if(!this.currentNode) return;
		if(this.currentNode.nodeId=="0" || this.currentNode.parentId=="0") return;
		if (this.currentNode.hasChild && this.currentNode.isExpand)
			this.expand(this.currentNode.nodeId, false);
		else
			this.focusStyle(this.currentNode.parentId);
	},
	/**********************************
	ת����һ���ӽڵ�
	**********************************/
	lowerNode : function(){
		if (!this.currentNode){
			this.currentNode = this.nodes["0"];
			this.currentPath = this.currentNode.sourcePath;
		};
		if (this.currentNode.hasChild){
			if (this.currentNode.isExpand)
				this.focusStyle(this.currentNode.childNodes[0].nodeId);
			else
				this.expand(this.currentNode.nodeId, true);
		}
	},
	/**********************************
	ת����һ�ڵ�
	**********************************/
	pervNode : function(){
		if (!this.currentNode) return;
		var e = this.currentNode;
		if (e.nodeId == "0") return;
		var a = this.nodes[e.parentId].childNodes;
		for (var i = 0; i < a.length; i++) {
			if (a[i].nodeId == e.nodeId) {
				if (i > 0) {
					e = a[i - 1];
					while (e.hasChild&&e.isExpand) {
//						this.expand(e.nodeId, true);
						e = e.childNodes[e.childNodes.length - 1];
					}
					this.focusStyle(e.nodeId);
					return;
				} else {
					this.focusStyle(e.parentId);
					return;
				}
			}
		}
	},
	/**********************************
	ת����һ�ڵ�
	**********************************/
	nextNode : function(){
		var e = this.currentNode;
		if (!e) e = this.nodes["0"];
		if (e.hasChild&&e.isExpand) {
//			this.expand(e.id, true);
			this.focusStyle(e.childNodes[0].nodeId);
			return;
		}
		while (typeof(e.parentId) != "undefined") {
			var a = this.nodes[e.parentId].childNodes;
			for (var i = 0; i < a.length; i++) {
				if (a[i].nodeId == e.nodeId) {
					if (i < a.length - 1) {
						this.focusStyle(a[i + 1].nodeId);
						return;
					}
					else e = this.nodes[e.parentId];
				}
			}
		}
	},
	/**********************************
	����ͼ��
	@string path ͼƬ��ŵ�·����,Ĭ��Ϊthis.tc.Path
	**********************************/
	setIconPath  : function(path){
		for(var i in this._icons){
			var tmp = this._icons[i];
			this.icons[i] = new Image();
			this.icons[i].src = path + tmp;
		}
		for(var i in this._iconsExpand){
			var tmp = this._iconsExpand[i];
			this.iconsExpand[i]=new Image();
			this.iconsExpand[i].src = path + tmp;
		}
	},
	/**********************************
	����node�ڵ�radio״̬
	**********************************/
	setRadioCheck : function(node){
		if(!node){return};
		var ckt = node.checktype;
		if(!ckt){return};
		var chk,nodechk,chklist = this.checkedNodes;
		nodechk = node.checked = node.checked != "1" ? "1": "0";
		if (chk = T("#"+ this.tc.treeId + "_radio_" + node.nodeId)) {
			chk.src = this.icons[(ckt + (nodechk!="1" ? 0 : 1)).toUpperCase()].src;
		};
		var chknode = this.checkedNode;
		if(nodechk!="1"){
			chknode = "";
			T.Aremove(chklist,node.nodeId);
		}else{
			T.Apush(chklist,node.nodeId);
			if(!(chknode == node.nodeId)){
				if(chknode){
					T.Aremove(chklist,chknode);
					if (chk = T("#"+ this.tc.treeId + "_radio_" + chknode)) {
						this.nodes[chknode].checked = "0";
						chk.src = this.icons["R0"].src;
					}
				}
				chknode = node.nodeId
			}
		};
		this.checkedNode = chknode;
	},
	/**********************************
	����node�ڵ�checkbox״̬
	@object node �ڵ����
	@boolean ExeCheckFun �Ƿ�ִ���Զ���check����,Ϊ��Ĭ��ִ��
	**********************************/
	setCheck : function(node,ExeCheckFun){
		if(!node){return};
		var ckt = node.checktype;
		if(!ckt){return};
		var ExeCheckFun = typeof(ExeCheckFun)=="boolean"?ExeCheckFun:true;
		var chk,nodechk,chklist = this.checkedNodes;
		nodechk = node.checked = node.checked != "1" ? "1": "0";
		nodechk == "1" ? T.Apush(chklist,node.nodeId) : T.Aremove(chklist,node.nodeId);
		if (chk = T("#"+ this.tc.treeId + "_checkbox_" + node.nodeId)) {
			chk.src = this.icons[(ckt + (nodechk!="1" ? 0 : 1)).toUpperCase()].src;
		};
		if(ExeCheckFun&&this.tc.checkFun){
			var nPvalue = this.nodeFnArgs(node);
			this.tc.checkFun.apply(this,nPvalue);
		};
		this.tc.checkParent?this.setParentCheck(node,ExeCheckFun):"";//��
		this.tc.checkChild?this.setChildCheck(node,ExeCheckFun):"";//��
	},
	/**********************************
	����node�ӽڵ�checkbox״̬
	**********************************/
	setChildCheck : function(node,ExeCheckFun){
		if(!node.hasChild||node.checked=="2"){return};
		var ExeCheckFun = typeof(ExeCheckFun)=="boolean"?ExeCheckFun:true;
		var childs = node.childNodes,nodechk = node.checked,chk,chklist = this.checkedNodes;
		for (var i = 0, j = childs.length; i < j; i++){
			var ckt = childs[i].checktype;
			if(ckt){
				nodechk == "1" ? T.Apush(chklist,childs[i].nodeId) : T.Aremove(chklist,childs[i].nodeId);
			};
			var cktype = ckt=="r"?"radio":"checkbox";
			childs[i].checked = nodechk;
			if (chk = T("#"+ this.tc.treeId + "_"+ cktype +"_" + childs[i].nodeId)) {
				chk.src = this.icons[ckt.toUpperCase()+nodechk].src;
			};
			if(ExeCheckFun&&this.tc.checkFun){
				var nPvalue = this.nodeFnArgs(childs[i]);
				this.tc.checkFun.apply(this,nPvalue);
			};
			this.setChildCheck(childs[i],ExeCheckFun)
		}
	},
	/**********************************
	����node���ڵ�checkbox״̬
	**********************************/
	setParentCheck : function(node,ExeCheckFun){
		if(!node.parentNode){return};
		var ExeCheckFun = typeof(ExeCheckFun)=="boolean"?ExeCheckFun:true;
		var num=1,chk,parentnode = node.parentNode,chklist = this.checkedNodes;
		var ckt = parentnode.checktype;
		var cktype = ckt=="r"?"radio":"checkbox";
		if (node.relationIndex!="root") {
			for (var i = 0,j = parentnode.childNodes.length; i < j; i++){
				if (parentnode.childNodes[i].checked != node.checked){
					parentnode.checked = "2";
					num=0;
					if (chk = T("#"+ this.tc.treeId + "_"+ cktype +"_" + parentnode.nodeId)){
						chk.src = this.icons[ckt.toUpperCase()+"2"].src;
						break;
					}
				}
			};
			if(num==1){
				parentnode.checked = node.checked;
				if (chk = T("#"+ this.tc.treeId + "_"+ cktype +"_" + parentnode.nodeId))
				chk.src = this.icons[ckt.toUpperCase()+node.checked].src;
			}
			if(ckt){
				parentnode.checked == "1" ? T.Apush(chklist,parentnode.nodeId) : T.Aremove(chklist,parentnode.nodeId);
			};
			if(ExeCheckFun&&this.tc.checkFun){
				var nPvalue = this.nodeFnArgs(parentnode);
				this.tc.checkFun.apply(this,nPvalue);
			};
			this.setParentCheck(parentnode,ExeCheckFun);
		}
	},
	/**********************************
	���½ڵ�
	@string sourceIndex �ڵ�����relationIndex(root_1)����sourcePath,���pathMode
	@object sourceData ��sourceId��Ӧ��ֵ{"id":936,"type":"trunk","name":"11_36��ӵĽڵ�","hasChild":true}
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��sourceIndex����ڵ��Ӧ·��sourcePath(root_1_2),���ڵ�pathΪ"0"
	**********************************/
	updateNode : function(sourceIndex,sourceData,pathMode){
		if(!sourceData){T.loadTip(1,"�޸������ݻ����ݸ�ʽ����ȷ",2,this.tc.treeObj);return};
		var relationIndex = pathMode?this.getRelationByPath(sourceIndex):sourceIndex,node;
		if(this.relation.indexOf(relationIndex)==-1){T.loadTip(1,"�ڵ㲻����",2,this.tc.treeObj);return};
		T.extend(this.treeData[relationIndex],sourceData);//��������Դ
		if(pathMode){
			node = this.getNode(sourceIndex);
			if(node){
				T.extend(node,sourceData);
				this._updateNode(node)
			};
		}else{
			var pathList = this.getPathList(sourceIndex);
			for (var i = 0,j=pathList.length;i<j;i++){
				node = this.getNode(pathList[i]);
				T.extend(node,sourceData);
				this._updateNode(node)
			}
		}
	},
	/**********************************
	���½ڵ�������
	@object node �ڵ����
	**********************************/
	_updateNode : function(node){
		var relationIndex = node.relationIndex,sid = relationIndex.split("_")[1];
		if(!node.isLoad){return};//��δ������ֻ��������Դ
		var nodeId = node.nodeId,nodeChild = node.childNodes;
		var pnode = this.nodes[node.parentId];
		_isLast = pnode.childNodes[pnode.childNodes.length-1].nodeId == nodeId;//�Ƿ������һ��
		//����ͼ���
		node.icon = "";
		node.hasChild = this.relation.indexOf(this._d + sid + this.divider)>-1
		var Obj = T("#"+this.tc.treeId+"_tree_"+nodeId);
		if(!Obj||!Obj.childNodes[0]){return};
		var nodeObj = Obj.childNodes[0];
		nodeObj.innerHTML = this.node2html(node,_isLast,true);
		!node.hasChild?Obj.childNodes[1].style.display = "none":""
	},
	/**********************************
	�滻�ӽڵ�����
	@string parentIndex �ڵ㸸������relationIndex(root_1)����sourcePath
	@object childData {"11_36":{"id":936,"type":"trunk","name":"11_36��ӵĽڵ�","pid":11},"11_37":{"id":937,"type":"trunk","name":"11_37��ӵĸ��ڵ�2","pid":11}}
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��parentIndex����ڵ��Ӧ·��sourcePath(root_1_2),���ڵ�pathΪ"0"
	**********************************/
	replaceChild : function(parentIndex,childData,pathMode){
		if(!childData){T.loadTip(1,"���ݸ�ʽ����ȷ",2,this.tc.treeObj);return};
		var relationIndex,d=this.divider,_d=this._d,node;
		relationIndex = pathMode?this.getRelationByPath(parentIndex):parentIndex;
		//����ڵ�������ԭ�е��ӽڵ�����
		var sid = relationIndex.substr(relationIndex.indexOf(d) + d.length);
		var reg = new RegExp("(^|"+_d+")"+ sid +d+"[^"+_d+d +"]+("+_d+"|$)", "g");
		var cns = this.relation.match(reg);
		if (cns){
			reg = new RegExp(_d, "g"); 
			for (var i=0; i<cns.length; i++){
				this.relation = this.relation.replace(cns[i].replace(reg, ""),"");
				this.relation = this.relation.replace(_d+_d+_d+_d,_d+_d);
			};
			if(this.relation.length-2==this.relation.lastIndexOf(_d+_d)){
				this.relation = this.relation.substring(0,this.relation.lastIndexOf(_d+_d));
			};
		};
		//��childData��������ʼ��������
		for (var id in childData){
			this.treeData[id] = childData[id];
			this.relation += _d + _d + id;
			this.totalNode += 1;
		};
		//����
		if(pathMode){
			node = this.getNode(parentIndex)
			node?this._updateChild(node):""
		}else{
			var pathList = this.getPathList(parentIndex);
			for (var i = 0,j=pathList.length;i<j;i++){
				node = this.getNode(pathList[i])
				this._updateChild(node)
			}
		}
	},
	/**********************************
	�����ӽڵ�������
	@object node �ڵ����
	**********************************/
	_updateChild : function(node){
		//��ԭ�ӽڵ�δ����,�򲻼���
		if(node.hasChild&&!node.isLoad){return};
		var nodeId = node.nodeId;
		//��������child����
		node.childNodes = [];
		this.loadChildItem(nodeId,true);
		var childNode = node.childNodes;
		//��������child HTML
		var str = "";
		if(childNode.length>0){
			node.hasChild = true;
			for(var i=0; i<childNode.length; i++){
				str += this.node2html(childNode[i], i==childNode.length-1);
			}
		};
		T("#"+this.tc.treeId+"_tree_"+nodeId).childNodes[1].innerHTML  = str;
		this.tc.isCheck?this.setChildCheck(node):"";//���ڵ��ѡ��
		//node.isExpand?setTimeout(this.tc.treeId +".expand('"+ nodeId +"',true)",1):"";
	},
	/**********************************
	��ӽڵ�
	@string parentIndex �ڵ㸸������relationIndex(root_1)����sourcePath
	@object childData {"11_36":{"id":936,"type":"trunk","name":"11_36��ӵĽڵ�","pid":11},"11_37":{"id":937,"type":"trunk","name":"11_37��ӵĸ��ڵ�2","pid":11}}
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��parentIndex����ڵ��Ӧ·��sourcePath(root_1_2),���ڵ�pathΪ"0"
	**********************************/
	addNode : function(parentIndex,childData,pathMode){
		if(!childData){T.loadTip(1,"��ӽڵ����ݸ�ʽ����ȷ",2,this.tc.treeObj);return};
		var Pnode,d = this._d;
		if(!pathMode){
			if(this.relation.indexOf(parentIndex)==-1){T.loadTip(1,"���ڵ㲻����",2,this.tc.treeObj);return};
			Pnode = this.getNode(parentIndex.split("_")[1]);
		}else{
			Pnode = this.getNode(parentIndex);
			if(!Pnode){T.loadTip(1,"���ڵ㲻����",2,this.tc.treeObj);return}
		};
		for (var id in childData){
			if(T.AindexOf(this.relation.split(d+d),id)>-1){
				T.extend(this.treeData[id],childData[id]);
				continue;
			};
			this.treeData[id] = childData[id];
			this.relation += d + d + id;
			this.totalNode += 1;
		};
		
		this._updateChild(Pnode);
		this._updateNode(Pnode);
	},
	/**********************************
	ɾ���ڵ�
	@string sourceIndex �ڵ�����relationIndex(root_1)����sourcePath
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��sourceIndex����ڵ��Ӧ·��sourcePath(root_1_2),���ڵ�pathΪ"0"
	**********************************/
	delNode : function(sourceIndex,pathMode){
		var relationIndex = pathMode?this.getRelationByPath(sourceIndex):sourceIndex,d = this._d;
		var indexof = this.relation.indexOf(relationIndex);
		if(indexof > -1){
			var _relation = this.relation.split(d+d);
			T.Aremove(_relation,relationIndex)
			this.relation = _relation.join(d+d)
		}else{
			T.loadTip(1,"�ڵ㲻���ڻ��ѱ�ɾ��",2,this.tc.treeObj);
			return;
		};
		if(pathMode){
			this._delNode(sourceIndex)
		}else{
			var pathList = this.getPathList(sourceIndex);
			for (var i = 0,j=pathList.length;i<j;i++){
				this._delNode(pathList[i])
			}
		}
	},
	/**********************************
	ɾ���ڵ㸨������
	@string sourcePath �ڵ�·��
	**********************************/
	_delNode : function(sourcePath){
		var ParentPath = sourcePath.substring(0,sourcePath.lastIndexOf("_")),PnodeChild = this.getNode(ParentPath);
		if(PnodeChild){
			this._updateChild(PnodeChild)
			this._updateNode(PnodeChild)
		};
	},
	/**********************************
	��չ�����
	@number level չ�����ֵ,>=2(Ĭ����չ����1��)
	**********************************/
	expandLevel : function(level)
	{
		if (!/\d+/.test(level) || level < 1) return;
		var r;
		if ((r = this.nodes["0"]).hasChild){
			for (var i = 0, n = r.childNodes.length; i < n; i++)
				this.ExpandChildLevel(r.childNodes[i],level);
		}
	},
	/**********************************
	�ڵ�չ�����
	@object node �ѳ�ʼ���Ľڵ����
	@number level չ�����ֵ,>=2(Ĭ����չ��1��)
	**********************************/
	ExpandChildLevel : function(node,level){
		if (level < 1) return;
		level--;
		var me = node;
		if (me.hasChild && !me.isExpand) this.expand(me.nodeId);
		if(!me.childNodes){return};
		for (var i = 0, n = me.childNodes.length; i < n; i++){
			var childNode = me.childNodes[i],
			d = childNode.nodeId;
			if (childNode.hasChild)
			this.ExpandChildLevel(this.nodes[d],level)
		}
	},
	/**********************************
	չ�����нڵ�,����λ��ָ���ڵ�
	@string sourceId  ����Դid Ϊ����չ��������,������Ӧ�ӽڵ�
	**********************************/
	expandAll : function(sourceId){
		var t = this;
		var sourceId = sourceId?sourceId:"";
		if (sourceId == ""&&this.totalNode > 5000){
			Tconfirm({
				Title:"������Ϣ!",
				Ttype:"alert",
				Mask:false,
				Content:"���ݽڵ���࣡չ���ܺ�ʱ!<br /><b>ȷ��Ҫ����չ����?</b>",
				OKFn:function(){
					t.ExpandShrinkAll("", true);
					return false;
				}
			});
		}else if(sourceId == ""){
			t.ExpandShrinkAll("", true);
		}else{
			this.focus(sourceId);
			setTimeout(function(){
				var node = t.getNode(sourceId),nodeId = node.nodeId;
				if(!node.isLoad){
					t.loadChildItem(nodeId);
					t.buildChild(nodeId);
				};
				t.ExpandShrinkAll(nodeId,true);
			}, 200);
		};
	},
	/**********************************
	�������нڵ㲢��λ��ָ���ڵ�
	@string sourceId  ����Դid Ϊ��������������,������Ӧ�ӽڵ�
	**********************************/
	shrinkAll : function(sourceId){
		var t = this;
		var sourceId = sourceId?sourceId:"";
		if(sourceId){
			this.focus(sourceId);
			setTimeout(function(){
				var node = t.getNode(sourceId),nodeId = node.nodeId;
				if(!node.isLoad){
					t.loadChildItem(nodeId);
					t.buildChild(nodeId);
				};
				t.ExpandShrinkAll(nodeId,"",true);
				t = null
			}, 200);
		}else{
			this.ExpandShrinkAll("","",true);	
		};
	},
	/**********************************
	���expandAll/shrinkAll
	**********************************/
	ExpandShrinkAll : function(nodeId, onlyExpand, onlyShrink){
		var nodeId = nodeId?nodeId:"0";
		var e = this.nodes[nodeId].childNodes;
		if((!e)||(!e[0])){T.loadTip(1,"û���ӽڵ�",2,this.tc.treeObj);return};
		e = e[0];
		var isdo = t = false;
		while (e.nodeId != nodeId){
			var p = this.nodes[e.parentId].childNodes,
			pn = p.length;
			if (pn > 0 &&(p[pn - 1].nodeId == e.nodeId && (isdo || !e.hasChild))) {
				e = this.nodes[e.parentId];
				isdo = true;
			}else{
				if (e.hasChild && !isdo){
					this.expand(e.nodeId, onlyExpand, onlyShrink),
					t = false;
					for (var i = 0; i < e.childNodes.length; i++){
						if (e.childNodes[i].hasChild) {
							e = e.childNodes[i];
							t = true;
							break;
						}
					}
					if (!t) isdo = true;
				}else{
					isdo = false;
					for (var i = 0; i < pn; i++){
						if (p[i].nodeId == e.nodeId){
							e = p[i + 1];
							break;
						}
					}
				}
			}
		};
		if(nodeId!="0"&&(e.nodeId == nodeId)){
			this.expand(nodeId, onlyExpand, onlyShrink);
		};
		this.isAllLoad = true;
	},
	/**********************************
	չ������λ�����ڵ�
	@string sourceId ����Դ�е�id չ����Ӧ�ڵ�,��������Ӧ�ӽڵ�
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��sourceId����ڵ��Ӧ·��(root_1_2),���ڵ�pathΪ"root"
	**********************************/
	expandNode : function(sourceId,pathMode){
		this.focus(sourceId,false,true,false,pathMode);
	},
	/**********************************
	��������λ�����ڵ�
	@string sourceId ����Դ�е�id ������Ӧ�ڵ�,��������Ӧ�ӽڵ�
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��sourceId����ڵ��Ӧ·��(root_1_2),���ڵ�pathΪ"root"
	**********************************/
	shrinkNode : function(sourceId,pathMode){
		this.focus(sourceId,false,false,true,pathMode);
	},
	/**********************************
	����λ�����ڵ�
	@string sourceId ����Դ�е�id ������Ӧ�ڵ�,��������Ӧ�ӽڵ�
	@boolean pathMode  �Ƿ񰴽ڵ�·�����ж�λ,��true,��sourceId����ڵ��Ӧ·��(root_1_2),���ڵ�pathΪ"root"
	**********************************/
	focusNode : function(sourceId,pathMode){
		this.focus(sourceId,false,false,false,pathMode);
	},
	/**********************************
	��ȡѡ�����
	@string key ����ѡ����Ĳ���Ϊkey���ַ�������(1,2,3),Ϊ���򷵻�����nodeId�ַ�������(1,2,3)
	**********************************/
	getChecked : function(key){
		var chkd = this.checkedNodes;
		if(chkd.length==0){return ""};
		if(key){
			var _chkd = [];
			for(var i=0,len = chkd.length;i<len;i++){
				_chkd.push(this.nodes[chkd[i]][key])
			}
			return _chkd.join(",");
		}
		return chkd.join(",");
	},
	/**********************************
	ѡ��/ȡ��ѡ��ĳ��
	@string nodeORsourceId node����,Ҳ������node��Ӧ������ԴID(sourceId)����Ψһ·��sourcePath(����root_1_2)�������","�ָ�,��:1��2��3 �� root_1,root_2
	@boolean ExeCheckFun �Ƿ�ִ���Զ���check����,Ϊ��Ĭ��ִ��
	**********************************/
	setCheckByNode : function(nodeORsourceId,ExeCheckFun){
		if(!nodeORsourceId){return};
		if(typeof(nodeORsourceId)=="object"){
			this.setCheck(nodeORsourceId,ExeCheckFun)
		}else{
			var _nodes = nodeORsourceId.split(","),_nodesL = _nodes.length,node=null;
			for(var i=0;i<_nodesL;i++){
				node = this.getNode(_nodes[i]);
				this.setCheck(node,ExeCheckFun);
			}
		}
	},
	/**********************************
	��ȡ��ǰ��λ�ڵ����
	@string key ��ȡ������Ϊkey��ֵ,Ϊ�����ȡ��������{}
	**********************************/
	getFocus : function(key){
		var value;
		if(key){
			value = this.currentNode[key]?this.currentNode[key]:false
		}else{
			value = this.currentNode?this.currentNode:false
		};
		return value
	},
	/**********************************
	��ȡָ���ڵ�html����
	@string sourceId ����ԴsourcePath����sourceId
	**********************************/
	getNodeObj : function(sourceId){
		var node;
		node = this.getNode(sourceId);
		if(!node){return};
		return T("#"+ this.tc.treeId +"_link_"+ node.nodeId +"")
	},
	/**********************************
	��ȡָ���ڵ㸽����ʾ����
	@string sourceId ����ԴsourcePath����sourceId
	**********************************/
	getTipObj : function(sourceId){
		var node;
		node = this.getNode(sourceId);
		if(!node){return};
		return T("#"+ this.tc.treeId +"_tip_"+ node.nodeId +"")
	},
	/**********************************
	���ݽڵ�name����ģ�������ڵ���treeData�еĶ���
	@string key �ڵ�name����ֵ
	@boolenn isParent �Ƿ�������ӽڵ�Ľڵ�
	**********************************/
	searchByName : function(key,isParent){
		(this.tc.searchLoadAll&&!this.isAllLoad)?this.expandAll():"";
		var _ret = {},count=0;
		var _d = this.nodes;
		for(var i in _d ){
			if(_d[i].name&&_d[i].name.indexOf(key) != -1){
				if(!isParent&&_d[i].childNodes)continue;
				_ret[i] = _d[i];
				count += 1
			}
		};
		count == 0 ? _ret = false:"";
		return _ret
	},
	/**********************************
	���ݽڵ������ȷƥ��ڵ���nodes�еĶ���
	@string attrKey �ڵ���������
	@string attrValue �ڵ��������Ӧֵ
	**********************************/
	searchByAttr : function(attrKey,attrValue){
		if(!attrKey){return;};
		var _ret = false;
		var _d = this.nodes;
		for(var i in _d ){
			if(_d[i][attrKey] && (_d[i][attrKey] == attrValue)){
				_ret = _d[i];
				break;
			}
		};
		return _ret
	}
}
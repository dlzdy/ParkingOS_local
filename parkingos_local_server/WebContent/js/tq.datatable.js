/*TQtable 2012-06-25
 version1.1:2012-07-07
 Latest:2012-08-08
 Latest:2012-10-26 ���Ӷ�̬���ɾ����/���༭ģʽ BY FT
 Latest:2012-12-18 �м����ɰ汾/���ӱ༭ģʽ/���Ӷ��ͷ/���ݲ�ѯģ������˳�� BY FT
 Ĭ��ҳ����ÿҳ��ʾ������������Ϊpage��rp���ֶβ�����Ӧ���������ͻ
 20130930 ����N������������ �����Զ���Ӧ��Ԫ�в����˵����
*/
var Ttable = function(o){new TQTable(o).C()};
TQTable = function(o){
/*�������*/
	this.tc = T.extend({
			Path:"css/images/form/",
			tableFunId:"",//������,��:var tableFunId = new TQTable();
			tablename:"TQtable",//Ψһ��ʶ
			tabletitle:false,//����
			tableitems:false,//ϵͳ�ֶμ���
			tableFields:false,//��ͷ��
			addtionitem:false,//�����ͷ��y
			remainadditem:false,//���������ͷ��
			checktype:"checkbox",//ѡ������:checkbox/radio
			toolespower:true,//�Ƿ���ʾ������
			headrows:false,//���ͷ
			dbuttons:[true,true],//Ĭ�Ϲ���
			buttons:[],//�Զ��幤��
			searchitem:null,//�Զ�������
			allowpage:true,//�Ƿ���ʾ��ҳ
			pagetype:[5,10,20,30,50,100,200,300],//��ҳҳ��ѡ����
			dataUrl:"",//���������ַ
			method:"POST",//����ʽGET or POST
			param:"1=1",//���ݲ�ѯ����,methodΪPOSTʱ�ύ������Ĭ�ϲ���Ϊ��1=1&2=2
			extparam:false,//�������ݲ�ѯ����,��ʽͬparam
			fit:[false],//�Ƿ��洰�ڴ�С�ı�����Ӧ�������С
			autoH:false,//�Ƿ���������Զ��߶�
			rpage:20,//Ĭ��ÿҳ��ʾ��
			cpage:1,//��ǰҳ��
			isodbyserver:true,//�����ͷʱ,�Ƿ�ӷ���������
			sortTip:"�������",
			quikcsearch:false,
			isidentifier:true,//�Ƿ���ʾ����
			ischeck:true,//�Ƿ�����ѡ��
			isDargcol:true,//�Ƿ������϶���
			isResize:false,//�Ƿ������ֶ�������С
			isoperate:false,//�Ƿ������в���
			operatewidth:false,//���������ȣ�Ĭ���Զ�
			iscookcol:false,//�Ƿ����������ò�cookies����
			trclickfun:false,//�Ƿ񿪷ŵ�����ѡ���¼�
			trfun:false,//tr�Զ��嵥���¼�
			beginfun:false,
			fieldorder:null,//���ݲ�ѯģ������˳��
			loadfun:true,//��������Ϻ���Զ����¼�
			checkfun:false,//�Զ���ѡ����¼�
			editmode:false,//�ɱ༭���ģʽ
			nodatatip:"��������ָ���ѯ���ˣ���ʱû�����ݡ�",
			dataorign:0,//������Դ.0�ӷ�����,1�Զ��塣Ĭ����0,���
			hotdata:null,//{"page":1,"total":45,"rows": [{"id":"1","cell":["ͨ����","ҵ����ѯ","����","15210208937","�������ƶ�","2012-09-23 08:54","1022||����","1"]},{"id":"2","cell":["������","�ۺ����","����","15210208937","�������ƶ�","2012-09-23 08:54","1022||������","1"]},{"id":"3","cell":["�ȴ���","ҵ����ѯ","����","15210208937","�������ƶ�","2012-09-23 08:54","","1"]},{"id":"4","cell":["ͨ����","","����","15210208937","�������ƶ�","2012-09-23 08:54","1022||����","0"]},{"id":"5","cell":["δ����","","����","15210208937","�������ƶ�","2012-09-23 08:54","1022||����","0"]}]}
			orderfield:false,//Ĭ�������ֶ�
			orderby:"desc",//Ĭ������ʽ
			countitem:false,//�ϼ���
			toolsMode:1,//���ݹ�����ʾģʽ 0���̶�(��̬) 1�̶� Ĭ��Ϊ1
			hoverin:false//toolsModeΪ0ʱ,�����ͣ����Ԫ�����ڵ�Ԫ���ֶ���
		},o);
};

TQTable.prototype = {
	/**********************************
	
	 һЩ��������(BaseAttr)
	 	 
	**********************************/
	exhH:0,
	contentWidth:0,//��������ͷ/���ݿ�
	B : {
		thisT:this,
		newP : function(p,t){//������Բ���
			var l = t.tc;
			t.tc = null;
			t.tc = T.extend(l,p);
			l = null;
		},
		frozW : function(t){//�̶��еĿ��(ѡ����к�������)
			var fw = 0;
//			if(t.tc.isoperate&&(t.tc.toolsMode == 1||!t.tc.hoverin)){
//				var _w = T.iev<9?55:44;
//				(t.tc.operatewidth)?fw +=t.tc.operatewidth:fw +=_w*t.tc.isoperate.length;
//			};
			(t.tc.ischeck)?fw += 23:"";
			(t.tc.isidentifier)?fw += 32:"";
			return fw
		},
		extH : function(t,xH){//��ȥ�������Ĺ̶��߶�
			var extheight = 27;//�����ͷ�߶�
			(t.tc.tabletitle)? extheight += 29:"";
			(t.tc.searchitem)? extheight += 26:"";
			(t.tc.toolespower)? extheight += 36:"";
			(t.tc.allowpage)? extheight += 34:"";
			(t.tc.headrows)? extheight += 26:"";
			(t.tc.countitem)? extheight += 28:"";
			//!isNaN(parseInt(t.tc.tableObj.style.borderTopWidth))?extheight += 1:"";
			//!isNaN(parseInt(t.tc.tableObj.style.borderBottomWidth))?extheight += 1:"";
			extheight += t.exhH;
			return extheight
		},
		CheckSave:function(t){//ȫ��ѡ�е�ID��������
			return document.getElementById(t.tc.tablename+"_checklist")
		},
		Childboxs:function(t){//��ǰҳ������checkbox�����ж���/tr�ж���
			return document.getElementById(t.tc.tablename+"_froze_body").tBodies[0].rows
		},
		Allbox:function(t){//��ǰҳȫѡchecbox����
			return document.getElementById(t.tc.tablename+"_checkall")
			//return document.getElementById(t.tc.tablename+"_froze_header").tBodies[0].rows[0].cells[0].firstChild
		},
		headerObj:function(t){
			return document.getElementById(t.tc.tablename + "_header_div")	
		},
		tbodyObj:function(t){
			return document.getElementById(t.tc.tablename + "_body_div")	
		},
		tbodyObjR:function(t){
			return document.getElementById(t.tc.tablename + "_body_div_r")	
		},
		footerObj:function(t){
			return document.getElementById(t.tc.tablename + "_footer_div")	
		},
		countObj:function(t){
			return document.getElementById(t.tc.tablename + "_count_div")	
		},
		titleObj:function(t){
			return document.getElementById(t.tc.tablename + "_title_div")	
		},
		toolObj:function(t){
			return document.getElementById(t.tc.tablename + "_tooles_div")	
		},
		frozeObj:function(t){
			return document.getElementById(t.tc.tablename + "_froze_div")	
		},
		frozehObj:function(t){
			return document.getElementById(t.tc.tablename + "_froze_header")	
		},
		frozehdObj:function(t){
			return document.getElementById(t.tc.tablename + "_froze_header_div")	
		},
		tabledivObj:function(t){
			return document.getElementById(t.tc.tablename + "alldiv")	
		},
		tablechkSpan:function(t){
			if(t.tc.tabletitle){
				return document.getElementById(t.tc.tablename + "_checknum_span")
			}else{return false}
		}
	},
	/**********************************
	
	 ҳ�滺��������(GridData)
	 ���޸Ĺ�������(ModifyData)
	 ԭʼ�������(oGridData)
	 	 
	**********************************/
	GridData   : null,
	oGridData  : null,
	isOrigin   : true,
	ModifyData : {total:0,rows:[]},
	/*  {
			total:3,rows:{
				{"type","add","id":"2","cell":["2","80121632","����2"]},
				{"type","mod","id":"3","cell":["3","80121632","����2"]},
				{"type","del","id":"4","cell":["4","80121632","����2"]}
			}
		}
	*/

	/**********************************
	
	 �������������(Createtable)
	 p:�Զ��������ע���ʽ,Ĭ��Ϊ��
	 	 
	**********************************/
	C : function(p){
		if(this.tc.addtionitem){
			!this.tc.remainadditem?T.Aremove(this.tc.tableFields,this.tc.addtionitem):""
		};
		if(p){
			this.B.newP(p,this)
		};
		if(!this.tc.tableObj)return;
		this.GridData = null;
		this.oGridData = null;
		this.isOrigin = true;
		this.ModifyData = {total:0,rows:[]};
		
		if(T.gcok("tqgridmode")){
			this.tc.toolsMode = T.gcok("tqgridmode");
		};
		
		this.tc.tableObj.innerHTML="";
		var tableObj = this.tc.tableObj;//�����������
		var t = this;
		var tc = this.tc;
		var TNM = tc.tablename;

		var tablediv = document.createElement("div");//�������
		tableObj.appendChild(tablediv);
		var tabletit = document.createElement("div");//����������
		var tablebt = document.createElement("div");//�������߰�ť
		var tableheader = document.createElement("div");//��������ͷ
		var tablesearch = document.createElement("div");//�����������
		var tablebody = document.createElement("div");//�����������
		var tablebodyL = document.createElement("div");//��������������
		var tablebodyR = document.createElement("div");//������������Ҳ�
		var tableCount = document.createElement("div");//�����ϼƽ���г�
		var tablebottom = document.createElement("div");//�������ײ�
		var tableresize = document.createElement("div");//������������С�϶�
		var tablefrozehead = document.createElement("div");//�̶���ͷ
		var tablefrozediv = document.createElement("div");//�̶���
		
		tablediv.className = "t-grid t-datagrid";
		//tablediv.id = TNM + "alldiv";
		tablediv.id = TNM;
		
		//�������ʼ
		if(!tc.tableitems){return};
		this.headOS();//���ñ�ͷ˳��
		if(tc.addtionitem){
			//tc.tableFields.push(tc.addtionitem);
			tc.tableFields.unshift(tc.addtionitem);
		};
		//����������=======================================
		if(tc.tabletitle)
		{
			tabletit.id = TNM + "_title_div";
			tabletit.className = "tabletitle";
			tabletit.innerHTML = "";
			tablediv.appendChild(tabletit);
			this.Ti(null,tabletit);//������
		};
		
		//�����������=======================================
		if(tc.searchitem)
		{
			tablesearch.id = TNM + "_search_div";
			tablesearch.className = "tablesearch";
			tablesearch.innerHTML = "";
			tablediv.appendChild(tablesearch);
			this.Sh(null,tablesearch);//�������
		};
		
		
		//�������߰�ť=======================================
		if(tc.toolespower){
			tablebt.id = TNM + "_tooles_div";
			tablebt.className = "tablebutton";
			tablediv.appendChild(tablebt);
			this.To(null,tablebt);//�����������ع�����
		};
		
		
		//�����̶���ͷ=======================================
		//�̶��б�ͷ
		tablefrozehead.id = TNM + "_froze_header_div"; 
		tablefrozehead.className = "t-grid-froze-headercell";
		//tablefrozehead.style.zIndex = T.iev&&T.iev<8?"1":"0";
		
		tablebodyL.id = TNM + "_grid-body-l";
		tablebodyL.className = "t-grid-body-l";
		tablebodyL.style.width = "auto";
		tablebodyL.appendChild(tablefrozehead);
		tablediv.appendChild(tablebodyL);
		this.Fh(null,tablefrozehead);//���̶��б�ͷ



		//����ͷ
		tableheader.id = TNM + "_header_div";
		tableheader.className = "t-grid-header";
		//var tableheaderinner = document.createElement("div");
		//tableheaderinner.id = TNM + "_header_innerdiv";
		//tableheaderinner.className = "t-grid-header-innerdiv";
		//tableheader.appendChild(tableheaderinner);
		tablebodyR.id =TNM + "_body_div_r";
		tablebodyR.className = "t-grid-body-r";
		//tablebodyR.setAttribute("class","t-grid-body-r");
		
		tablediv.appendChild(tablebodyR);
		tablebodyR.appendChild(tableheader);
		this.Th();
		
		//�����������=======================================
		//�̶��п��
		tablefrozediv.id = TNM + "_froze_div";
		tablefrozediv.className = "t-grid-froze-header";
		//tablefrozediv.style.cssFloat = "left"; 
		var tablefrozecol = [];
		tablefrozecol.push("<div style=\"float:left;margin:0px;padding:0px;position:relative;overflow:auto;\">");
		tablefrozecol.push("</div>");
		tablefrozediv.innerHTML = tablefrozecol.join("");
		//tablediv.appendChild(tablefrozediv);
		
		tablebodyL.appendChild(tablefrozediv);
		
		//������ݿ��
		//tablebody.style.cssFloat = "left";
		tablebody.className = "t-grid-body";
		tablebody.id = TNM + "_body_div";
		
		var tablebodyinner = document.createElement("div");
		tablebodyinner.id = TNM + "_body_innerdiv";
		//tablebodyinner.style.float =T.iev&&T.iev==7?"":"left";
		tablebodyinner.className = "t-grid-body-innerdiv";
		tablebody.appendChild(tablebodyinner);
		
		//var tablecontent = [];
		//tablecontent.push("<table cellSpacing=\"0\" cellPadding=\"0\" class=\"t-grid-table\"><tbody>");
		//tablecontent.push("</tbody></table>");
		//tablebody.innerHTML = tablecontent.join("");
		
		//tablediv.appendChild(tablebody);
		
		tablebodyR.appendChild(tablebody);
		//��ͷ/�̶���������һ�����
		tablebody.onscroll = function(){
			t.B.headerObj(t).style.right = t.B.tbodyObj(t).scrollLeft + "px";
			t.B.frozeObj(t).firstChild.style.bottom = t.B.tbodyObj(t).scrollTop + "px";
		};
		
		//����/�������������
		var extheight = this.B.extH(this);
		var fObjW = tableObj.offsetWidth;
		var fObjH = tableObj.offsetHeight;
		var frozW = this.B.frozW(this);
		if(this.tc.isoperate&&(this.tc.toolsMode == 1||!this.tc.hoverin)){
			frozW += 205;
		};
		try{
			tableheader.style.width = this.contentWidth + "px";
			tablebodyinner.style.width = this.contentWidth + "px";
			tablebodyL.style.width = frozW + (T.iev&&T.iev<8?0:1) + "px";
			tablebody.style.width = tableObj.offsetWidth - frozW - 3 + "px";
			tablebodyR.style.width = tableObj.offsetWidth - frozW - 4 + "px";
			tablebody.style.height = tc.autoH?"auto":fObjH - extheight  + "px";
			tablefrozediv.style.height = tc.autoH?"auto":fObjH - extheight + "px"
		}catch(e){};
		this.bindFO();
		
		//�ϼƽ���г�
		if(this.tc.countitem){
			tableCount.id = TNM + "_count_div";
			tableCount.className = "t-grid-count";
			//tableCount.style.width = tableObj.offsetWidth - 1 + "px"
			tableCount.innerHTML = "<span class=\"counttitle\" title=\"��ǰ������\">�ϼ���Ŀ&nbsp;&nbsp;<font style=\"color:#c00\">0</font></span>"
			tablediv.appendChild(tableCount);
		};
		
		//���ײ�=======================================
		if(tc.allowpage){
		tablebottom.id = TNM + "_footer_div";
		tablebottom.className = "t-grid-footer";
		//tablebottom.style.width = tableObj.offsetWidth - 1 + "px"
			var tablebottomc = [];
				tablebottomc.push("<TABLE style=\"border:0px;width:100%\" id=\""+TNM+"_footer\" class=\"t-pager\" cellSpacing=\"0\" cellPadding=\"0\">");
					tablebottomc.push("<TBODY>");
						tablebottomc.push("<TR>");
							tablebottomc.push("<TD style='width:100%'>");
								tablebottomc.push("<div class=\"t-pager-buttons\">");
									tablebottomc.push("<SPAN  id=\""+TNM+"_pbutton_first\" class=\"button24_a  bg_green_hover border_green fl\" style='width:40px;'>");
										tablebottomc.push("��ҳ");
									tablebottomc.push("<\/SPAN>");
									tablebottomc.push("<SPAN  id=\""+TNM+"_pbutton_prev\" class=\"button24_a  bg_green_hover border_green fl\" style='width:40px;'>");
										tablebottomc.push("��һҳ");
									tablebottomc.push("<\/SPAN>");
									tablebottomc.push("<SPAN id=\""+TNM+"_pinput_next\" class=\"button24_a  bg_green_hover border_green fl\" style='width:40px;'>");
										tablebottomc.push("��һҳ");
									tablebottomc.push("<\/SPAN>");
									tablebottomc.push("<SPAN id=\""+TNM+"_pinput_last\" class=\"button24_a  bg_green_hover border_green fl\" style='width:40px;'>");
										tablebottomc.push("βҳ");
									tablebottomc.push("<\/SPAN>");
									tablebottomc.push("<SPAN class=\"t-pager-index\">");
										tablebottomc.push("<INPUT id=\""+TNM+"_pinput_curr\" class=\"t-pager-num\" value=\"0\" type=\"text\" title=\"����ҳ��,���س�����ת\">");
										tablebottomc.push("<SPAN id=\""+TNM+"_pinput_pages\" class=\"t-pager-pages\">\/0<\/SPAN>");
									tablebottomc.push("<\/SPAN>");
								tablebottomc.push("<\/div>");
							tablebottomc.push("<div style=\"float:right;padding:2px 5px 0 0\">");
							tablebottomc.push("��<span id=\""+TNM+"_pages_total\">0</span>��&nbsp;&nbsp;ÿҳ");
								tablebottomc.push("<select id=\""+TNM+"_pages_select\">");
								for(var p=0;p<tc.pagetype.length;p++){
									tablebottomc.push("<option value="+tc.pagetype[p]+"");
									tc.pagetype[p] == tc.rpage?tablebottomc.push(" selected=\"selected\""):"";
									tablebottomc.push(">"+tc.pagetype[p]+"<\/option>");
								};
								tablebottomc.push("<\/select>");
							tablebottomc.push("��");
							tablebottomc.push("<\/div>");
							tablebottomc.push("<\/TD>");
						tablebottomc.push("<\/TR>");
					tablebottomc.push("<\/TBODY>");
				tablebottomc.push("<\/TABLE>");
			tablebottom.innerHTML = tablebottomc.join("");
			tablediv.appendChild(tablebottom);
			tablebottomc = null
		};
		
		//�ı����С(��δʵ��)=======================================
		if(this.tc.isResize){
			tableresize.id = TNM + "_resize_div";
			tableresize.className = "t-grid-resizegrid";
			tableresize.innerHTML = "";
			tablediv.appendChild(tableresize)
		};
		
		//�����������,����������֮�����������=======================================
		this.M(null,tablebodyinner,0,true);

		//this.GridData = null
		//����������,���ҳ�滺��GridData
		//����=======================================
		tablediv = null;
		tabletit = null;
		tablebt = null;
		tableheader = null;
		tablebody = null;
		tablebottom = null;
		tableresize = null;
		tablefrozehead = null;
		tablefrozediv = null;
		hdiv = null;
		
	},
	/**********************************
	
	 headOrderSet��ͷ˳���趨
	 
	**********************************/
	headOS:function(){
		var tc = this.tc;
		if(tc.fieldorder){
			var fieldorder = tc.fieldorder.split(",");
			var colItems = tc.tableitems.concat();
			var newItems = [];
			for(var i=0;i<fieldorder.length;i++){
				for(var k=0;k<colItems.length;k++){
					if(fieldorder[i]==colItems[k].fieldname){
						newItems.push(colItems[k]);
						colItems.splice(k,1);
					}
				}
			};
			for(var j=0;j<colItems.length;j++){
				newItems.push(colItems[j]);
			};
			tc.tableFields = newItems;
			colItems = null
		}else{
			tc.tableFields = tc.tableitems;
		};
	},
	/**********************************
	
	 ��resize
	 
	**********************************/
	bindFO:function(){
		var t = this;
		var BindAsEventListener = function(object, fun, args) {
			return function() {    
				return fun.apply(object,args||[]);    
			}  
		};
		if(this.tc.fit[0]==true){
			var tableFitObj = T.iev&&T.iev<9?this.tc.tableObj:window;
			//var tableFitObj = window;
			//tableFitObj.onresize = BindAsEventListener(this,t.FO);
			T.bind(window,"resize",function(){t.FO()});	
			//T.bind(window,"resize",ResizeLayout)
		};
	},
	/**********************************
	
	 �����resize
	 
	**********************************/
	unbindFO:function(){
		var t = this;
		if(t.tc.fit[0]==true){
			var tableFitObj = T.iev&&T.iev<9?t.tc.tableObj:window;
			//var tableFitObj = window;
			tableFitObj.onresize = null;
		};
	},
	/**********************************
	
	 �ʺϸ��Ӷ����С(FitOutOb)
	 
	**********************************/
	FO:function(t){
		var t = t||this;
		var tc = t.tc;
		var TNM = tc.tablename;
		var _time = T.iev&&T.iev<9?300:100;
		setTimeout(function(){
			if(!T("#"+TNM))return;
			T("#"+TNM + "_grid-body-l").style.width = "auto";//���³�ʼ����ȣ�����
			
			var identifierNode = T("#"+TNM + "_identifier_header");
			if(identifierNode != null) {
				identifierNode.style.width = T.iev&&T.iev<8? 32 + "px":33 + "px";//���³�ʼ����ȣ�����
				identifierNode.style.width = 32 + "px";
			}
			
			var tableObj = tc.tableObj;
			var frozW = T.gow(T("#"+TNM + "_froze_div"));//t.B.frozW(t);
			var operateW = frozW - t.B.frozW(t) - 3;
			var extheight = t.B.extH(t);
			T("#"+TNM + "_grid-body-l").style.width = frozW + (T.iev&&T.iev<8?0:1) + "px";
			T("#"+TNM + "_operate")&&operateW>0?T("#"+TNM + "_operate").style.width = operateW + "px":"";
		
			if(tc.fit[1]||"undefined" == typeof(tc.fit[1])){
				try{
					if(tableObj.offsetWidth!==0){
						t.B.tbodyObj(t).style.width = tableObj.offsetWidth - frozW - 3 + "px"
						t.B.tbodyObjR(t).style.width = tableObj.offsetWidth - frozW - 4 + "px"
					}else{ 
					
						t.B.tbodyObj(t).style.width = tableObj.parentNode.offsetWidth - frozW - 3 + "px";
						t.B.tbodyObjR(t).style.width = tableObj.parentNode.offsetWidth - frozW - 4 + "px";
					}
				}catch(e){};
			};
			if(tc.fit[2]||"undefined" == typeof(tc.fit[2])){
				try{
					if(tableObj.offsetHeight!==0){
						t.B.tbodyObj(t).style.height = tableObj.offsetHeight - extheight + "px";
						t.B.frozeObj(t).style.height = tableObj.offsetHeight - extheight + "px";
					}else{
						t.B.tbodyObj(t).style.height = tableObj.parentNode.offsetHeight - extheight + "px";
						t.B.frozeObj(t).style.height = tableObj.parentNode.offsetHeight - extheight + "px";
					}
				}catch(e){};
			}else{
				try{
				t.B.tbodyObj(t).style.height = "auto";
				t.B.frozeObj(t).style.height = "auto";
				}catch(e){};
			};
		},_time)
		
	},
	/**********************************
	
	 ������(Title)
	 
	**********************************/
	Ti:function(p,t){
		if(p){
			this.B.newP(p,this)
		};
		var Tit = t||document.getElementById(this.tc.tablename + "_title_div");
		Tit.innerHTML = "<span class=\"t_grid_tabletitle\" >"+this.tc.tabletitle+"</span><span id=\""+this.tc.tablename + "_checknum_span\" class=\"t_grid_checknum\" ></span>";
		
	},
	/**********************************
	
	 �������(Search)
	 
	**********************************/
	Sh:function(p,t){
		if(p){
			this.B.newP(p,this)
		};
		var thisT = this;
		var Srh = t||document.getElementById(this.tc.tablename + "_search_div");
		var searchname = this.tc.tabletitle || "��ǰ�б�";
			
		var spon = document.createElement("span");
		var sptw = document.createElement("span");
		var fr = document.createElement("form");
		var divon = document.createElement("div");
		var divtw = document.createElement("div");
		var divth = document.createElement("div");
		var divfo = document.createElement("div");
		
//		spon.innerHTML = "<span style=\"float:left;padding-left:5px;\">��<"+searchname+">��ɸѡ:</span>";
		sptw.className = "grid_searchblock";
		
		fr.setAttribute("name",""+thisT.tc.tablename+"_filter_form");
		fr.id = thisT.tc.tablename+"_filter_form";
		fr.setAttribute("onkeydown","if(event.keyCode==13){return false;}");
		fr.action = "";
		
		divon.id = ""+thisT.tc.tablename+"_filter_t";
		divon.className = "grid_ssearch_t";
		divon.onclick = function(){thisT.Sselect(""+thisT.tc.tablename+"_filter_t",""+thisT.tc.tablename+"_filter_t_but",""+thisT.tc.tablename+"_filter_items",""+thisT.tc.tablename+"_filter_type_value",""+thisT.tc.tablename+"_filter_form")}
			
		divtw.id = ""+thisT.tc.tablename+"_filter_t_but";
		divtw.className = "grid_ssearch_t_but";
		divtw.onclick = function(){thisT.Sselect(""+thisT.tc.tablename+"_filter_t",""+thisT.tc.tablename+"_filter_t_but",""+thisT.tc.tablename+"_filter_items",""+thisT.tc.tablename+"_filter_type_value",""+thisT.tc.tablename+"_filter_form")}
		
		divfo.innerHTML = "��ѯ";
		divfo.onclick = function(){
			var strings = Serializ(thisT.tc.tablename+"_filter_form");
			if(strings.indexOf("value=&")!=-1){
				thisT.M({extparam:false});
				return
			};
			thisT.M({
				extparam:Serializ(thisT.tc.tablename+"_filter_form")
			})
		};
		divfo.className = "grid_searchbt";
		
		sptw.appendChild(fr);
		fr.appendChild(divon);
		fr.appendChild(divtw);
		fr.appendChild(divth);
		fr.appendChild(divfo);

		Srh.appendChild(spon);
		Srh.appendChild(sptw);
			
		
		var ssHtml = "";
		var divthHtml = "<input type=\"hidden\" class=\"txt\" name=\"action\" value=\"simplequery\"><input type=\"text\" style=\"width:90px;height:21px;padding:0px;margin:0px;border:0px;float:left\" name=\"value\" autocomplete=\"off\">";
		ssHtml += "  <div class=\"clear\"><\/div>";
		ssHtml += "  <div id=\""+thisT.tc.tablename+"_filter_items\" class=\"t_items\" style=\"display:none\">";
		var sI = thisT.tc.searchitem;
		for(var m=0;m<sI.length;m++){
			if(sI[m].isdefault == true){
				divon.innerHTML = sI[m].name;
				divthHtml += "<input type=\"hidden\" id=\""+thisT.tc.tablename+"_filter_type_value\" name=\"colname\" value=\""+sI[m].field+"\">";
			};
			ssHtml += "<div class=\'t_items_out\' tid=\""+sI[m].field+"\">"+sI[m].name+"<\/div>";
		};
		divth.innerHTML = divthHtml;
		var mmmm = document.createElement("div");
		mmmm.className = "grid_ssearch_select";
		mmmm.style.display = "none";
		mmmm.innerHTML = ssHtml;
		document.body.appendChild(mmmm)
		//extparam
	},
	/**********************************
	
	 ��ʾ������(ShowSelect)
	 
	**********************************/
	Sselect : function(input, btn, option, value,formid) {
		inputobj = document.getElementById(input);
		btnobj = document.getElementById(btn);
		optionobj = document.getElementById(option);
		valueobj = document.getElementById(value);
		optionobj.parentNode.style.display = "block";
		optionobj.style.display = optionobj.style.display == "" ? "none": "";
		optionobj.style.left = T.gpos(inputobj).left - 1 +"px";
		optionobj.style.top =T.gpos(inputobj).top + T.gpos(inputobj).height +"px";
		optionobj.onblur = function() {
			optionobj.parentNode.style.display = "none";
			optionobj.style.display = "none";
		}
		for (var i = 0; i < optionobj.childNodes.length; i++) {
			optionobj.focus();
			optionobj.childNodes[i].onmouseover = function() {
				this.className = "t_items_over"
			}
			optionobj.childNodes[i].onmouseout = function() {
				this.className = "t_items_out"
			}
			optionobj.childNodes[i].onclick = function() {
				optionobj.style.display = "none";
				inputobj.innerHTML = this.innerHTML;
				valueobj.value = this.tid||this.getAttribute("tid");
				document.forms[formid]["value"].focus();
				optionobj.blur();
			}
		}
},
	/**********************************
	
	 ��񹤾���(Tooles)
	 
	**********************************/
	To:function(p,t){
		if(p){
			this.B.newP(p,this)
		};
		var thisT = this;
		var Too = t||document.getElementById(this.tc.tablename + "_tooles_div");
		Too.innerHTML = "";
		if(this.tc.quikcsearch){
			var a = document.createElement("span");
			a.style.marginLeft = "5px";
			a.style.marginTop = "2px";
			a.style.float = "left";
			a.innerHTML =this.tc.quikcsearch;
			Too.appendChild(a);
			a = null
		}else if(this.tc.buttons){
			for(var n=0;n<this.tc.buttons.length;n++)
			{
				var tbtn = this.tc.buttons[n];
				if(tbtn.rule){
					if(!tbtn.rule()){continue}
				};
				var a = document.createElement("span");
				a.id = thisT.tc.tablename+"_bt_"+this.tc.buttons[n].name;
				a.className = this.tc.buttons[n].cls?this.tc.buttons[n].cls:"button24_a bg_gray_hover border_gray fl";
				a.style.marginLeft = "5px";
				a.style.marginTop = "2px";
				var bhtml = "";
				bhtml = "<span";
				bhtml += this.tc.buttons[n].tit?" title=\""+this.tc.buttons[n].tit+"\"":" title=\""+this.tc.buttons[n].dname+"\"";
				bhtml += ">";
				//<img src=\""+this.tc.Path+""+this.tc.buttons[n].icon+"\">
				this.tc.buttons[n].iconcls?bhtml += "<span class=\""+this.tc.buttons[n].iconcls+"\"><\/span>":"";
				bhtml += ""+this.tc.buttons[n].dname+"<\/span>";
				a.innerHTML = bhtml;
				a.name = tbtn.name;
				a.onpress = tbtn.onpress;
				a.onclick = (function(){
					this.onpress(this.name,thisT.tc.tablename);
				});
				Too.appendChild(a);
				a = null
			};
		};
		if(this.tc.dbuttons){//Ĭ�Ϲ�������ˢ�¡�������
			if(this.tc.iscookcol&&this.tc.dbuttons[0]){
				var a = document.createElement("span");
				a.id = this.tc.tablename +"_sub";
				a.style.marginTop = "2px";
				a.className = "button24_a border_blank hover1 fr";
				a.innerHTML = "<span title=\"���ñ�����Ƿ���ʾ\" class=\"icon16 icon16table1 fl\"><\/span>������";
				a.onclick = function(){thisT.VH(thisT.tc.tablename)};
				Too.appendChild(a);
				a = null
			};
			if(this.tc.dbuttons[1]){
				var b = document.createElement("span");
				b.style.marginTop = "2px";
				b.className = "button24_a border_blank hover1 fr";
				b.innerHTML = "<span title=\"�������뵱ǰ��&#10���±������\" class=\"icon16 icon16fresh fl\"><\/span>ˢ��";
				if(thisT.tc.ischeck){
					b.onclick = function(){thisT.B.Allbox(thisT).checked = false;thisT.B.CheckSave(thisT).value = "";thisT.M({cpage:1})}
				}else{
					b.onclick = function(){thisT.M({cpage:1});try{thisT.B.CheckSave(thisT).value = "";}catch(e){}}
				};
				Too.appendChild(b);
				b = null
			}
		};
		if(this.tc.isoperate&&this.tc.hoverin){
			var _mode = this.tc.toolsMode;
			var _class = _mode==0?"icon16 icon16uncheck fl":"icon16 icon16check fl";
			var c = document.createElement("span");
			c.style.marginTop = "2px";
			c.title = "�Ƿ�̶����ݲ�����\n���̶���̬��ʾ";
			c.className = "button24_a border_blank hover1 fr";
			c.innerHTML = "<span class=\""+_class+"\"><\/span>�̶�";
			c.onclick = function(){
				thisT.tc.toolsMode == 1?thisT.tc.toolsMode = 0:thisT.tc.toolsMode = 1;
				T.scok("tqgridmode",thisT.tc.toolsMode)
				thisT.C();
			};
			Too.appendChild(c);
			c = null
		}
	},
	/**********************************
	
	 �̶��б�ͷ(FrozeHead)
	 
	**********************************/
	Fh:function(p,t){
		if(p){
			this.B.newP(p,this)
		};
		var checktype = this.tc.checktype;
		var TNM = this.tc.tablename;
		var frozH = this.tc.headrows?"height:54px;":"";
		var Frh = t||document.getElementById(this.tc.tablename + "_froze_header_div");
		var tablefrozeheadt = [];
		tablefrozeheadt.push("<table id=\""+TNM+"_froze_header\" cellSpacing=\"0\" cellPadding=\"0\" class=\"t-grid-table\" style=\"width:auto;display:table;"+frozH+"\"><tbody><tr>");
		if(this.tc.ischeck){
			tablefrozeheadt.push("<td class=\"t-grid-headercell t-grid-cell-chx\" id=\""+TNM+"_check\" style=\"width:22px\">");
			checktype == "checkbox"?tablefrozeheadt.push("<input title=\"ȫѡ��ǰҳ���м�¼\" class=\"chx\" id=\""+TNM+"_checkall\" type=\""+checktype+"\">"):tablefrozeheadt.push("<input class=\"chx\" id=\""+TNM+"_checkall\" type=\""+checktype+"\" disabled>");
			tablefrozeheadt.push("<input type=\"hidden\" value=\"\" id=\""+TNM+"_checklist\">");
			tablefrozeheadt.push("</td>")
		};
		if(this.tc.isoperate&&(this.tc.toolsMode == 1||!this.tc.hoverin)){
			tablefrozeheadt.push("<td class=\"t-grid-headercell\" style=\"width:200px\" id=\""+TNM+"_operate\"><div class=\"tddiv\">����</div></td>");
		};
		tablefrozeheadt.push("</tr></tbody></table>");
		
		if(this.tc.isidentifier){
			tablefrozeheadt.push("<table id=\""+TNM+"_identifier_header\" cellSpacing=\"0\" cellPadding=\"0\" class=\"t-grid-table\" style=\"width:auto;display:table;"+frozH+"\"><tbody><tr>");
			tablefrozeheadt.push("<td class=\"t-grid-identifier\" style=\"width:32px;\"><div class=\"tddiv\" title=\"��ǰҳ��¼�������\">����</div></td>");
			tablefrozeheadt.push("</tr></tbody></table>");
		};
		if(this.tc.ischeck||(this.tc.isoperate&&(this.tc.toolsMode == 1||!this.tc.hoverin))||this.tc.isidentifier){Frh.innerHTML = tablefrozeheadt.join("")};
		
	},
	/**********************************
	
	 ���ݱ���ͷ(TableHead)
	 
	**********************************/
	Th:function(p,t){
	if(p){
		this.B.newP(p,this)
	};
	this.contentWidth = 0;
	if(this.tc.headrows){this.Ths(p,t);return};
	var TNM = this.tc.tablename;
	var items = this.tc.tableFields;
	var Thead = t||document.getElementById(this.tc.tablename + "_header_div");
	if(!Thead)return;
	var TableMain = TNM+"_body_div";
	Thead.innerHTML="";
	
	var thisT = this;
	var tb = document.createElement("table");
	var tbbody = document.createElement("tbody");
	var tbtr = document.createElement("tr");
	tb.cellPadding = "0";
	tb.cellSpacing = "0";
	tb.className = "t-grid-table";
	T.iev&&T.iev<8?tb.style.display = "":"table";//IE67��֧��,�����������ĸ��������Ҫ������֧��
	var ckey = TNM;
	var cvalues = "";
	if(this.tc.iscookcol){
		var gcok = T.gcok(ckey);
		if(gcok==null||gcok==""){var isscok = 1}else{var isscok = 0;};
	};

	for(var i=0;i<items.length;i++)
	{
		var tbtd = document.createElement("td");
		var m = parseInt(i);
		var Fenm = items[i].fieldname;
		var Fcnm = items[i].fieldcnname;
		var hd = items[i].shide||items[i].fhide;
		var fhide = items[i].fhide;
		var dataT = items[i].inputtype;
		
		T.dcok(TNM+ "_"+Fenm);//���ԭ����cookies���Ժ���ɾ����һ�д���
		
		var iW ;
		items[i].twidth !=""&&items[i].twidth?iW = items[i].twidth:iW = 130;
		if(this.tc.iscookcol){
		//�ж�cookies
			if(isscok == 0){
				for(var z=0;z<gcok.split("||").length;z++){
					if(gcok.split("||")[z].split(",")[0]== Fenm){
						gcok.split("||")[z].split(",")[1]=="1"?hd = false:hd = true;
						gcok.split("||")[z].split(",")[2]!=""?iW = gcok.split("||")[z].split(",")[2]:"";
						break
					}
				}
			};
			if(isscok == 1){
				var val = [];
				if(items[i].shide){
					if(!items[i].fhide){
						val = Fenm +",0,"+iW+"||"
					}
				}else{
					if(!items[i].fhide){
						val = Fenm +",1,"+iW+"||"
					}
				};
				cvalues+=val;
			};
		};
		if(!fhide){this.contentWidth += parseInt(iW)};
		tbtd.id = TNM+"_"+Fenm;
		tbtd.headid = m;
		tbtd.setAttribute("headid",m);
		items[i].noquery?tbtd.setAttribute("noquery","true"):"";
		tbtd.process = items[i].process;
		tbtd.className = "t-grid-headercell";
		tbtd.style.width = iW+"px";
		tbtd.style.display = fhide?"none":"";
		var outdiv = document.createElement("div");
		outdiv.style.overflow = "hidden";
		outdiv.style.position = "relative";
		outdiv.style.width = "100%";
		outdiv.style.cssFloat = "left";
		var indiv = document.createElement("div");
		indiv.cid = m;
		indiv.setAttribute("cid",m)
		indiv.style.position = "relative";
		if(items[i].issort=="undefined"||items[i].issort != false){
			indiv.className = "tddiv sort";
			indiv.title = thisT.tc.sortTip;
			indiv.innerHTML = "<span class=\"o\">&nbsp;</span>"+Fcnm+"";
			indiv.dataT = dataT;
			indiv.fid = Fenm;
			indiv.setAttribute("fid",Fenm);
			indiv.onclick = function(){thisT.So(TableMain,0,this.cid,this.dataT,this)};
		}else{
			indiv.className = "tddiv";
			indiv.innerHTML = ""+Fcnm+"";
		};
		var dragdiv = document.createElement("div");
		dragdiv.id = m;
		dragdiv.className = "t-grid-splitter";
		dragdiv.onmouseover  = function(){thisT.Rc(TNM,this)};
		
		outdiv.appendChild(indiv);
		thisT.tc.isDargcol?outdiv.appendChild(dragdiv):"";
		tbtd.appendChild(outdiv);
		tbtr.appendChild(tbtd);
		
		tbtd = null;
		outdiv = null;
		indiv = null;
		dragdiv = null
	};

	this.tc.iscookcol&&isscok == 1?T.scok(ckey,cvalues.substring(0,cvalues.length-2)):"";//дcookie
	tbbody.appendChild(tbtr);
	tb.appendChild(tbbody);
	Thead.appendChild(tb);
	
	tbtr = null;
	tbbody = null;
	tb = null
	},
	/**********************************
	
	 ���ͷ���ݱ���ͷ(TableHeads)
	 
	**********************************/
	_M:0,
	Ths:function(p,t){
	if(p){
		this.B.newP(p,this)
	};
	
	this._M = 0;
	this.contentWidth = 0;
	var TNM = this.tc.tablename;
	var tableFields = this.tc.tableFields;
	var Thead = t||document.getElementById(this.tc.tablename + "_header_div");
	
	var TableMain = TNM+"_body_div";
	Thead.innerHTML="";
	
	var thisT = this;
	var tb = document.createElement("table");
	var tbbody = document.createElement("tbody");
	var tbtr = document.createElement("tr");
	var _tbtr = document.createElement("tr");
	tb.cellPadding = "0";
	tb.cellSpacing = "0";
	tb.className = "t-grid-table";
	T.iev>7||!T.iev?tb.style.display = "table":"";//IE67��֧��,�����������ĸ��������Ҫ������֧��
	var ckey = TNM;
	var cvalues = "";
	if(this.tc.iscookcol){
		var gcok = T.gcok(ckey);
		if(gcok==null||gcok==""){var isscok = 1}else{var isscok = 0;};
	};
	var _nohides = false;
	for(var l=0;l<tableFields.length;l++){
		var items = tableFields[l].kinditemts;
		if(!items){alert("��������п������ô���");break;}
 		var itemname = tableFields[l].kindname;
		if(itemname==""){
			var _m = this._M;
			for(var i=0;i<items.length;i++)
			{
				this._M+=1;
				var tbtd = document.createElement("td");
				var m = parseInt(i)+_m;
				var Fenm = items[i].fieldname;
				var Fcnm = items[i].fieldcnname;
				var hd = items[i].shide||items[i].fhide;
				var dataT = items[i].inputtype;
				T.dcok(TNM+ "_"+Fenm);//���ԭ����cookies���Ժ���ɾ����һ�д���

				var iW ;
				items[i].twidth !=""&&items[i].twidth?iW = items[i].twidth:iW = 130;
				
				if(this.tc.iscookcol){
				//�ж�cookies
					if(isscok == 0){
						for(var z=0;z<gcok.split("||").length;z++){
							if(gcok.split("||")[z].split(",")[0]== Fenm){
								gcok.split("||")[z].split(",")[1]=="1"?hd = false:hd = true;
								gcok.split("||")[z].split(",")[2]!=""?iW = gcok.split("||")[z].split(",")[2]:"";
								break
							}
						}
					};
					if(isscok == 1){
						var val = [];
						if(items[i].shide){
							if(!items[i].fhide){
								val = Fenm +",0,"+iW+"||"
							}
						}else{
							if(!items[i].fhide){
								val = Fenm +",1,"+iW+"||"
							}
						};
						cvalues+=val;
					};
				};
				if(!hd){this.contentWidth += parseInt(iW)};
				tbtd.id = TNM+"_"+Fenm;
				tbtd.headid = m;
				tbtd.setAttribute("headid",m);
				items[i].noquery?tbtd.setAttribute("noquery","true"):"";
				tbtd.rowSpan = 2;
				tbtd.setAttribute("rowSpan",2)
				tbtd.process = items[i].process;
				tbtd.className = "t-grid-headercell";
				tbtd.style.width = iW+"px";
				tbtd.style.display = hd?"none":"";
				var outdiv = document.createElement("div");
				outdiv.style.overflow = "hidden";
				outdiv.style.position = "relative";
				outdiv.style.width = "100%";
				outdiv.style.cssFloat = "left";
				var indiv = document.createElement("div");
				indiv.cid = m;
				indiv.setAttribute("cid",m)
				indiv.style.position = "relative";
				
				if(items[i].issort=="undefined"||items[i].issort != false){
					indiv.className = "tddiv sort";
					indiv.title = thisT.tc.sortTip;
					indiv.innerHTML = "<span class=\"o\">&nbsp;</span>"+Fcnm+"";
					indiv.fid = Fenm;
					indiv.setAttribute("fid",Fenm);
					indiv.dataT = dataT;
					indiv.onclick = function(){thisT.So(TableMain,0,this.cid,this.dataT,this)};
				}else{
					indiv.className = "tddiv";
					indiv.innerHTML = ""+Fcnm+"";
				};
				var dragdiv = document.createElement("div");
				dragdiv.id = m;
				dragdiv.className = "t-grid-splitter";
				dragdiv.onmouseover  = function(){thisT.Rc(TNM,this)};
				
				outdiv.appendChild(indiv);
				thisT.tc.isDargcol?outdiv.appendChild(dragdiv):"";
				tbtd.appendChild(outdiv);
				tbtr.appendChild(tbtd);

				tbtd = null;
				outdiv = null;
				indiv = null;
				dragdiv = null
			}
		}else{
			var _tbtd = document.createElement("td");
			_tbtd.colSpan = items.length;
			_tbtd.className = "t-grid-headercell";
			_tbtd.innerHTML = "<div class=\"tddiv\" style=\"text-align:center;float:none;\">"+itemname+"</div>";
			_tbtd.setAttribute("colSpan",items.length);
			
			var _m = this._M;
			var _nohide = 0;
			for(var i=0;i<items.length;i++)
			{
				this._M+=1;
				var tbtd = document.createElement("td");
				var m = parseInt(i)+ _m;
				var Fenm = items[i].fieldname;
				var Fcnm = items[i].fieldcnname;
				var hd = items[i].shide||items[i].fhide;
				var dataT = items[i].inputtype;
		
				T.dcok(TNM+ "_"+Fenm);//���ԭ����cookies���Ժ���ɾ����һ�д���
				
				var iW ;
				items[i].twidth&&items[i].twidth !=""?iW = items[i].twidth:iW = 130;
				
				if(this.tc.iscookcol){
				//�ж�cookies
					if(isscok == 0){
						for(var z=0;z<gcok.split("||").length;z++){
							if(gcok.split("||")[z].split(",")[0]== Fenm){
								gcok.split("||")[z].split(",")[1]=="1"?hd = false:hd = true;
								gcok.split("||")[z].split(",")[2]!=""?iW = gcok.split("||")[z].split(",")[2]:"";
								break
							}
						}
					};
					if(isscok == 1){
						var val = [];
						if(items[i].shide){
							if(!items[i].fhide){
								val = Fenm +",0,"+iW+"||"
							}
						}else{
							if(!items[i].fhide){
								val = Fenm +",1,"+iW+"||"
							}
						};
						cvalues+=val;
					};
				};
				
				if(!hd){this.contentWidth += parseInt(iW);_nohide+=1};
				tbtd.id = TNM+"_"+Fenm;
				tbtd.headid = m;
				tbtd.setAttribute("headid",m);
				items[i].noquery?tbtd.setAttribute("noquery","true"):"";
				tbtd.process = items[i].process;
				tbtd.className = "t-grid-headercell";
				tbtd.style.width = iW+"px";
				tbtd.style.display = hd?"none":"";
				var outdiv = document.createElement("div");
				outdiv.style.overflow = "hidden";
				outdiv.style.position = "relative";
				outdiv.style.width = "100%";
				outdiv.style.cssFloat = "left";
				var indiv = document.createElement("div");
				indiv.cid = m;
				indiv.setAttribute("cid",m)
				indiv.style.position = "relative";
				if(items[i].issort=="undefined"||items[i].issort != false){
					indiv.className = "tddiv sort";
					indiv.title = thisT.tc.sortTip;
					indiv.innerHTML = "<span class=\"o\">&nbsp;</span>"+Fcnm+"";
					indiv.fid = Fenm;
					indiv.setAttribute("fid",Fenm);
					indiv.dataT = dataT;
					indiv.onclick = function(){thisT.So(TableMain,0,this.cid,this.dataT,this)};
				}else{
					indiv.className = "tddiv";
					indiv.innerHTML = ""+Fcnm+"";
				};
				var dragdiv = document.createElement("div");
				dragdiv.id = m;
				dragdiv.className = "t-grid-splitter";
				dragdiv.onmouseover = function(){thisT.Rc(TNM,this)};
				
				outdiv.appendChild(indiv);
				thisT.tc.isDargcol?outdiv.appendChild(dragdiv):"";
				tbtd.appendChild(outdiv);
				_tbtr.appendChild(tbtd);
				tbtr.appendChild(_tbtd);
				
				tbtd = null;
				outdiv = null;
				indiv = null;
				dragdiv = null
			};
			//alert( _nohide)
			//_nohide!=0?_tbtd.colSpan = _nohide:"";
			//_tbtd.style.display =_nohide==0?"none":"";
			if(_nohide==0){
				_tbtd.style.display = "none";
				//this.B.frozehObj(this).style.height = "54px";
			}else{
				_nohides = true;
				_tbtd.colSpan = _nohide;
				_tbtd.style.display = "";
				//this.B.frozehObj(this).style.height = "";
			};
			//_nohide = 0;
		};
	};
	if(_nohides){
		this.exhH = 0;
		this.B.frozehObj(this)?this.B.frozehObj(this).style.height = "54px":"";
	}else{
		this.exhH = -27;
		this.B.frozehObj(this)?this.B.frozehObj(this).style.height = "":"";
	};
	this.tc.iscookcol&&isscok == 1?T.scok(ckey,cvalues.substring(0,cvalues.length-2)):"";//дcookie
	tbbody.appendChild(tbtr);
	tbbody.appendChild(_tbtr);
	
	tb.appendChild(tbbody);
	Thead.appendChild(tb);
	tbtr = null;
	tbbody = null;
	tb = null
	
	},
	/**********************************
	
	 ���������(MakeContent)
	 p:�Զ��������ע���ʽ,Ĭ��Ϊ��
	 t:����������,�ⲿ���ô˺���ʱĬ��Ϊ��
	 cp:��ǰҳ��,Ĭ����1
	 isinit:�Ƿ��ʼ������
	 
	**********************************/
	M:function(p,t,cp,isinit){
		
		if(p){
			this.B.newP(p,this)
		};
		var cp = parseInt(cp)?cp:this.tc.cpage;//��ǰҳ��
		var thisT = this;
		this.LastSort = null;
		
		//��������ǰִ�еĺ���=======================================
		if(thisT.tc.beginfun){
			thisT.tc.beginfun(thisT.tc.tablename);//���Զ��庯����������������/�������
		};
		
		//this.B.tablechkSpan(this)?this.B.tablechkSpan(this).innerHTML = "":"";
		//this.B.CheckSave(this)?this.B.CheckSave(this).value="":"";
		
		var tc = this.tc;
		var TNM = tc.tablename;
		var checktype = tc.checktype;
		var TableDiv = t||document.getElementById(TNM+"_body_innerdiv");
		if(!document.getElementById(TNM+"_froze_div"))return;
		var TableFDiv = document.getElementById(TNM+"_froze_div").firstChild;

		
		var callback = function(data){
			thisT.GridData = data;//�洢�������
			thisT.isOrigin?thisT.oGridData = T.CloneObj(data):"";
			//�������غ�ִ�еĺ���=======================================
//			if(thisT.tc.loadfun){
//				thisT.tc.loadfun(thisT.tc.tablename,data);//���Զ��庯����������������/�������
//			};
//			if(data==null||typeof(data)!="object"){T.loadTip(1,"���ݸ�ʽ����",2,"");return};
			if(data&&typeof(data)=="object"&&data.total&&parseInt(data.total)>0){
				TableDiv.innerHTML="";
				TableFDiv.innerHTML = "";
				if(data.money){
					if(!T("#total_money")){
						var paatool = document.getElementById(TNM+"_tooles_div");
						var  a = document.createElement("div");
						a.setAttribute('id','total_money');
						a.style.marginLeft = "5px";
						a.style.marginTop = "7px";
						a.style.float = "left";
						paatool.appendChild(a);
					}
					T("#total_money").innerHTML="�ϼƣ�<font color='red'>"+data.money+"</font>";
				}
				if(!document.getElementById(TNM+"_header_div"))return;
				var Thead = document.getElementById(TNM+"_header_div").firstChild;
				var TheadBody = Thead.tBodies[0];
				var localindex=0;//add
				var uinindex=0;//add
				var THash =new TQHash();
				var tcell = TheadBody.rows[0].cells;
				for (var i=0;i<tcell.length;i++){
					if(tcell[i].id!="undefined"&&tcell[i].id!=null&&tcell[i].id!=""){
						if(tcell[i].id.indexOf('client_region')!=-1)//�������//add
						localindex=i;//add
						if(tcell[i].id.indexOf('uin')!=-1)//����������ϯ//add
						uinindex=i;//add
						var headid = tcell[i].getAttribute("headid");
						THash.setItem("tid"+headid,tcell[i].id);
						THash.setItem("twh"+headid,tcell[i].style.width);
						THash.setItem("hd"+headid,tcell[i].style.display);
						THash.setItem("process"+headid,tcell[i].process||false);
					}else{
						if(!TheadBody.rows[1]){return};
						var _tcell = TheadBody.rows[1].cells;
						for(var m=0;m<_tcell.length;m++){
							var headid = _tcell[m].getAttribute("headid");
							THash.setItem("tid"+headid,_tcell[m].id);
							THash.setItem("twh"+headid,_tcell[m].style.width);
							THash.setItem("hd"+headid,_tcell[m].style.display);
							THash.setItem("process"+headid,_tcell[m].process||false);
						}
					}
				};
				
				var tablecontent = [];
				tablecontent.push("<table id=\""+TNM+"_body\"  cellSpacing=\"0\" cellPadding=\"0\" class=\"t-grid-table\"><tbody>");
				//�̶���tablefrozecol
				var tablefrozecol = [];
				var tableidentifier = [];//����
				tablefrozecol.push("<table id=\""+TNM+"_froze_body\" cellSpacing=\"0\" cellPadding=\"0\" style=\"float:left;width:auto;display:table\"><tbody>");
				tableidentifier.push("<table id=\""+TNM+"_identifier_body\" cellSpacing=\"0\" cellPadding=\"0\" style=\"float:left;width:32px;display:table\"><tbody>");
				var tds = data.rows;
				for (var i=0;i<tds.length;i++)
				{
					
					//���ɹ̶���
					tablefrozecol.push("<tr id=\""+TNM+"_"+tds[i].id+"_ftr\" rid=\""+tds[i].id+"\">");
					tc.ischeck?tablefrozecol.push("<td class=\"t-grid-cell t_grid_frozecell t-grid-cell-chx\" style=\"width:22px\"><input class=\"chx\" id=\""+TNM+"_"+tds[i].id+"_ck\" name=\""+TNM+"_checkinput\" type=\""+checktype+"\" value = \""+tds[i].id+"\"></td>"):"";
					if(tc.isoperate&&(tc.toolsMode == 1||!tc.hoverin)){
						tablefrozecol.push("<td class=\"t-grid-cell t_grid_frozecell t_grid_operation\"><div class=\"tddiv\">");
						tablefrozecol.push("</div></td>")
					};
					tableidentifier.push("<td class=\"t-grid-cell t_grid_frozecell\" style=\"width:32px\"><div class=\"tddiv\">"+parseInt(i+1)+"</div></td>");//�������
					tablefrozecol.push("</tr>");
					tableidentifier.push("</tr>");
					
					//��ͨ��
					tablecontent.push("<tr id=\""+TNM+"_"+tds[i].id+"_tr\" rid=\""+tds[i].id+"\" class=\"t-grid-row\"");
					T.iev==6?tablecontent.push(" onmouseover=\"this.className='t-grid-cell-hover'\" onmouseout=\"this.className='t-grid-row'\""):"";
					tablecontent.push(">");
					for(var j=0;j<tds[i].cell.length;j++){
						var value=tds[i].cell[j]; //add
						if(localindex!=0&&localindex==j&&value.indexOf('|')!=-1){//add
							value=value.split('|')[1]//add
						};//add
						if(uinindex!=0&&uinindex==j&&value.indexOf('||')!=-1){//add
							value=value.split('||')[0]//add
						};//add
						//����������չ���Ժ��ٸ�
						
						var _tdW =THash.getItem("twh"+j);
						if(!_tdW){break};
						var _fieldid = THash.getItem("tid"+j);
						var _hoverIn = "";
						var _ishide = THash.getItem("hd"+j);
						if(thisT.tc.toolsMode == 0 && thisT.tc.hoverin && (TNM + "_"+thisT.tc.hoverin == _fieldid)){
							parseInt(_tdW)<180?(_tdW = "180px",T("#"+_fieldid).style.width = _tdW):"";
							_hoverIn = "<span class=\"opspan\" id=\""+TNM+"_opspan_"+tds[i].id+"\" rid=\""+tds[i].id+"\"></span>";
							_ishide != "none"?"":(_ishide="",T("#"+_fieldid).style.display = "block");
						};
						
						tablecontent.push("<td class=\"t-grid-cell\" id=\""+_fieldid+"_"+tds[i].id+"_td\"");
						_ishide!="none"?tablecontent.push(" style=\"width:"+_tdW+"\""):tablecontent.push(" style=\"display:none;width:"+_tdW+"\"");
						tablecontent.push(">");
						if(tc.editmode){
							value = thisT.EMTS(""+_fieldid,value,tds[i].id);
							tablecontent.push("<div class=\"tddiv\" ov=\""+tds[i].cell[j]+"\">"+value+"</div>");
						}else{
							if(THash.getItem("process"+j)){//add
								tablecontent.push("<div class=\"tddiv\">"+THash.getItem("process"+j)(value,tds[i].id,_fieldid)+"</div>");//����:value,valueid,fieldid
							}else{//add
								//�����ֶ�����ת����ʾ��ʽ
								value = thisT.TS(""+_fieldid,value,tds[i].id);
								typeof(value)=="object"?tablecontent.push("<div class=\"tddiv\"><font style=\"color:#c00\">����ֵ���󣬲�ӦΪ����</font>"+_hoverIn+"</div>"):tablecontent.push("<div class=\"tddiv\">"+value+""+_hoverIn+"</div>");//add
							};
						};
						tablecontent.push("</td>");
					};
					tablecontent.push("</tr>");
		
				};
				tablefrozecol.push("</tbody></table>");
				tableidentifier.push("</tbody></table>");
				tablecontent.push("</tbody></table>");
				
				tc.isidentifier?tablefrozecol.push(tableidentifier.join("")):"";
				
				TableDiv.innerHTML = tablecontent.join("");
				TableFDiv.innerHTML = tablefrozecol.join("");
				
				THash.clear();
				tablecontent = null;
				tablefrozecol = null;
				
				//Thead.parentNode.parentNode.style.right = document.getElementById(TNM+"_body_div_r").scrollLeft + "px";
				//TableFDiv.style.bottom = document.getElementById(TNM+"_body_div").scrollTop + "px";
				
				//�����ѡ���¼�=======================================
				if(thisT.tc.ischeck){
					thisT.CF();
					thisT.RC()//����ѡ����״̬
				};
				//����в����¼�=======================================
				if(thisT.tc.isoperate&&(thisT.tc.toolsMode == 1||!tc.hoverin)){
					thisT.MT();
				};
				//�����TR�¼�=======================================
				if(thisT.tc.trfun!=false||thisT.tc.trclickfun!=false){
					thisT.MTr();
				};
				//�ϼƽ���г�=======================================
				if(thisT.tc.countitem){
					var _countitem = thisT.tc.countitem;
					var countDiv = document.getElementById(thisT.tc.tablename + "_count_div");
					var cDHtml = "<span class=\"counttitle\" title=\"��ǰ������\">�ϼ���Ŀ����ǰҳ/ȫ����</span>";
					
					for(var _c=0,_cl=_countitem.length;_c<_cl;_c++){
						//ģ��
						data.countlist = data.countlist?data.countlist:{client_name:[560,1000]};
						//ģ��
						cDHtml += "<span class=\"countname\">"+_countitem[_c].fieldcnname+":</span><span class=\"countvalue\">"+data.countlist[_countitem[_c].fieldname][0]+"/"+data.countlist[_countitem[_c].fieldname][1]+"</span>"
					}
					countDiv.innerHTML = cDHtml
				}
				//���õײ���ҳ�Ȳ���=======================================
				if(thisT.tc.allowpage){
					var totpag = Math.ceil(parseInt(data.total)/parseInt(thisT.tc.rpage));
					thisT.MF(data.page,totpag,parseInt(data.total));
					document.getElementById(TNM+"_pinput_curr").onkeydown = function(e){
						var e = e ||event;
						if(e.keyCode == 13){
							var rpg = parseInt(this.value)?parseInt(this.value):0;
							if(isNaN(this.value)||parseInt(this.value)<1){rpg=thisT.tc.cpage};
							if(!isNaN(this.value)&&parseInt(this.value)>totpag){rpg=totpag};
							thisT.M("","",parseInt(rpg));
						}
					}
				};

			}else if(parseInt(data.total)==0){
				TableDiv.innerHTML="";
				TableFDiv.innerHTML = "";
				thisT.GridData = null;
				thisT.oGridData = null;
				document.getElementById(thisT.tc.tablename+"_body_innerdiv").innerHTML ="<span style=\"color:#666;padding-left:5px\">"+thisT.tc.nodatatip+"</span>";	//���޸�<span>
				//T.loadTip(1,"��������",2,thisT.tc.tableObj);
			}else if(data=="gotologin"){
				T.maskTip(1,"���ѳ�ʱ��δ���в���,Ϊ��֤���ݰ�ȫ,�����µ�¼��",3,thisT.tc.tableObj);
				data = false;
				//return
			}else{
				T.maskTip(2,"�����������ݸ�ʽ!�������[<font style=\"color:#c00\">ˢ��</font>]���ԣ�����ϵ����Ա��",3,thisT.tc.tableObj);
				data = false;
				//return
			};
			//�������غ�ִ�еĺ���=======================================
			if(thisT.tc.loadfun && thisT.tc.ischeck){
				thisT.RS(thisT,thisT.tc.tablename,data);//���Զ��庯����������������/�������
			};
			
			if(data&&thisT.tc.isoperate&&thisT.tc.toolsMode == 0&&thisT.tc.hoverin){
				thisT.TRHF();
			};
			
			thisT.FO();//��ʼ��ʱ���������ٵ���һ�δ�С
			//isinit?thisT.FO():"";
						
		};
		if(tc.dataorign==0){
			if(!this.tc.dataUrl){alert("�����ñ�����ݵ�ַ");return}
			//�ɷ�������ȡ����
			var params = this.tc.param;
			var sortdefineStr = "";
			if(this.tc.orderfield&&this.tc.orderby){
				sortdefineStr = "&orderfield="+this.tc.orderfield+"&orderby="+this.tc.orderby+""
			};
			var countlistStr = [];
			if(this.tc.countitem){
				for(var _co=0,_col=this.tc.countitem.length;_co<_col;_co++){
					countlistStr.push(this.tc.countitem[_co].fieldname); 
				}
				countlistStr = "&countfieldsstr="+countlistStr.join("__");
			};
			if(this.tc.extparam&&this.tc.extparam!=""){
				params = this.tc.extparam;
			};
			params = params+sortdefineStr+countlistStr;
			if(this.tc.method.toUpperCase()=="POST"){
				var tableFields = this.tc.tableFields;
				var field_names= this.GF();
				T.A.sendData(this.tc.dataUrl,"POST",params+"&page="+cp+"&rp="+thisT.tc.rpage+"&fieldsstr="+field_names,callback,2,this.tc.tableObj);
			}else{
				var tableFields = this.tc.tableFields;
				var field_names = this.GF();
				var lurl = this.tc.dataUrl;
				lurl = lurl.indexOf("?")!=-1?lurl+"&":lurl+"?";
				T.A.sendData(lurl+params+"&page="+cp+"&rp="+thisT.tc.rpage+"&fieldsstr="+field_names,"GET","",callback,2,this.tc.tableObj);
			};
			//this.tc.extparam=false;
		}else{
			callback(tc.hotdata||{"page":1,"total":0,"rows": []})
		};
	},
	
	/**********************************
	
	 �ָ�ÿһ�е�ѡ��״̬(ResumeSelected)
	 	 
	**********************************/
	RS : function(thisT,tablename,data){
		var Allbox = this.B.Allbox(this);//ȫѡchecbox����
		var Savebox = this.B.CheckSave(this);//ѡ�е�ID��������
		var rows = data.rows;
		for(var i=0;i<rows.length;i++){
			var cell = rows[i].cell;
			var checked = cell[0];
			if(checked == "ischecked"){
				var d = T("#"+tablename+"_"+rows[i].id+"_ck");
				d.checked = true;
				thisT.SC(Allbox,d,Savebox);
			}
		}
	},
	
	/**********************************
	
	 ��ȡ�ֶ�(GetField)
	 	 
	**********************************/
	GF : function(){
		var field_names= "";
		var fieldPr = this.tc.tablename.toString().length+1;
		var Thead = this.B.headerObj(this).firstChild;
		var TheadBody = Thead.tBodies[0];
		var tcell = TheadBody.rows;//[0].cells
		for(var i=0;i<tcell.length;i++){
			var _tcell = tcell[i].cells;
			for(var j=0;j<_tcell.length;j++){
				if(_tcell[j].getAttribute("headid")==null||_tcell[j].getAttribute("noquery")=="true"){continue};
				if(field_names==""){
					field_names=_tcell[j].id.substring(fieldPr);
				}else{
					field_names +="__"+_tcell[j].id.substring(fieldPr);
				}
			}
		};
		
//		var tableFields = this.tc.tableFields;
//		var field_names= "";
//		for(var i=0;i<tableFields.length;i++){
//			if(field_names==""){
//				field_names=tableFields[i].fieldname;
//			}else{
//				field_names +="__"+tableFields[i].fieldname;
//			}
//		};
		return field_names
	},
	/**********************************
	
	 ��ȡ�ֶ����Զ���(GetFieldObj)
	 	 
	**********************************/
	GFO : function(fieldname){
		var ret = null;
		var _items = this.tc.tableFields;
		if(this.tc.headrows){
			for(var m=0,n=_items.length;m<n;m++){
			var items = _items[m].kinditemts;
				for (var i=0;i<items.length;i++){
					if(items[i].fieldname == fieldname){
						ret = items[i]
					}
				}
			};
		}else{
			for (var i=0;i<_items.length;i++){
				if(_items[i].fieldname == fieldname){
						ret = _items[i]
					}
			}
		}
		return ret
	},
	/**********************************
	
	 �����е���¼�(MakeTrOperation)
	 	 
	**********************************/
	MTr : function(){
		var thisT = this;
		var Allbox = this.B.Allbox(this);//ȫѡchecbox����
		var Savebox = this.B.CheckSave(this);//ѡ�е�ID��������
		var Childboxs = this.B.Childboxs(this);//������checkbox����
		var tbtr = document.getElementById(this.tc.tablename+"_body").tBodies[0].rows;
		T.each(tbtr,function(tt,j){
			tt.onclick = function(){
				if(thisT.tc.trfun!=false){
					thisT.tc.trfun(this.rid||this.getAttribute("rid"))
				};
				if(thisT.tc.trclickfun!=false){
					T("#"+this.id.substring(0,this.id.length-3)+"_ck").checked = T("#"+this.id.substring(0,this.id.length-3)+"_ck").checked == true?false:true;
					thisT.SC(Allbox,T("#"+this.id.substring(0,this.id.length-3)+"_ck"),Savebox)
				}
			};
			tt = null
		})
	},
	TRHF : function(){
		//fttableopdiv opfield
		if(!document.getElementById(this.tc.tablename+"_body"))return;
		var thisT = this;
		var TNM = thisT.tc.tablename;
		var FArray = thisT.tc.isoperate;
		var opDoms = T.gbycls("opspan");
		T.each(opDoms,function(_tt){
			for(var it=0;it<FArray.length;it++){
				var modiparam = null;
				if(FArray[it].rule){
					modiparam = FArray[it].rule(_tt.getA_ttribute("rid")||_tt.rid);
					if(!modiparam){continue}
					//if(!FArray[it].rule(_tt.getAttribute("rid")||_tt.rid)){continue}
				}
				n = FArray[it];
				a = document.createElement("span");
				a.className = n.iconcls||"button16_a border_blank hover1 fl";
				a.title = n.tit?n.tit:n.name;
				a.fun = n.fun;
				a.modiparam = modiparam;
				a.setAttribute("type",n.type||"");
				//a.rid = _tt.getAttribute("rid")||_tt.rid;
				a.setAttribute("rid",_tt.getAttribute("rid")||_tt.rid);
				a.innerHTML = n.name;
				//a.onclick = function(){this.fun(this.rid,this.modiparam);this.className=="rtool"?this.className = "rtooled":"";};
				a.onclick = function(){this.fun(this.getAttribute("rid"),this.getAttribute("type"),this.modiparam);this.className += " rtooled";};
				_tt.appendChild(a)
			};
			_tt = null
		});
		var tbtr = document.getElementById(this.tc.tablename+"_body").tBodies[0].rows;
		T.each(tbtr,function(tt,j){
			tt.onmouseover = function(){
					var id = (this.rid||this.getAttribute("rid"));
					var opdiv = T("#"+TNM+"_opspan_"+id);
					opdiv.style.visibility = "visible";
			};
			tt.onmouseout = function(){
					var id = (this.rid||this.getAttribute("rid"));
					var opdiv = T("#"+TNM+"_opspan_"+id);
					opdiv.style.visibility = "hidden";
			};
			tt = null
		})
	},
	/**********************************
	
	 �����м�¼��������(MakeopDoms),�༭/ɾ����
	 	 
	**********************************/
	MT : function(){
		var thisT = this;
		var tb = document.getElementById(this.tc.tablename+"_froze_body");
		var trTool = this.B.Childboxs(this);
		var n;
		var a;
		T.each(trTool,function(tt){
			var toolobj = thisT.tc.ischeck!="undefined"&&thisT.tc.ischeck!=false?tt.cells[1].firstChild:tt.cells[0].firstChild;
			for(var it=0;it<thisT.tc.isoperate.length;it++){
				var modiparam = null;
				if(thisT.tc.isoperate[it].rule){
					modiparam = thisT.tc.isoperate[it].rule(tt.getAttribute("rid")||tt.rid);
					if(!modiparam){continue}
					//if(!thisT.tc.isoperate[it].rule(tt.getAttribute("rid")||tt.rid)){continue}
				}
				n = thisT.tc.isoperate[it];
				a = document.createElement("span");
				a.className = n.iconcls||"button16_a border_blank hover1 fl";
				a.title = n.tit?n.tit:n.name;
				a.fun = n.fun;
				a.setAttribute("type",n.type||"");
				a.modiparam = modiparam;
				a.setAttribute("rid",tt.getAttribute("rid")||tt.rid);
				//a.rid = tt.getAttribute("rid")||tt.rid;
				a.innerHTML = n.name;
				//alert(n.name);
				a.onclick = function(){this.fun(this.getAttribute("rid"),this.getAttribute("type"),this.modiparam);this.className += " rtooled";};
				toolobj.appendChild(a)
			};
			tt = null
		});
		n = null;
		a = null
	},
	/**********************************
	
	 ���õײ���ҳ�Ȳ���(MakeFooter)
	 cp:��ǰҳ��
	 tp:��ҳ��
	 dt:�ܼ�¼��
	 	 
	**********************************/
	MF : function(cp,tp,dt){
		var thisT = this;
		var TNM = this.tc.tablename;
		var btnFirs = document.getElementById(TNM+"_pbutton_first");//��ҳ
		var btnPrev = document.getElementById(TNM+"_pbutton_prev");//��һҳ
		var inpCurr = document.getElementById(TNM+"_pinput_curr");//��ǰҳ��
		var totPage = document.getElementById(TNM+"_pinput_pages");//��ҳ��
		var btnNext = document.getElementById(TNM+"_pinput_next");//��һҳ
		var btnLast = document.getElementById(TNM+"_pinput_last");//βҳ
		var dataTot = document.getElementById(TNM+"_pages_total");//������
		var selPage = document.getElementById(TNM+"_pages_select");//ҳ��ѡ���
		
		
		//��ҳ��ť�¼�
		btnFirs.onclick = function(){
			if(cp<2){return};
			//thisT.M("","",1)
			var plength = thisT.tc.param.length; 
			thisT.M({
				param:thisT.tc.param+"&tqpagetotal="+dt
			},"",1);
			thisT.tc.param = thisT.tc.param.substring(0,plength)
			
		};
		if(cp>1){
			btnFirs.title = "�Ϸ�����һҳ";
			btnFirs.className = "button24_a bg_green_hover border_green fl";
		}else{
			btnFirs.title = "�ѵ���ǰ";
			btnFirs.className = "button24_a button_disable fl"
		};
		//��һҳ��ť�¼�
		btnPrev.onclick = function(){
			if(cp<2){return};
			//thisT.M("","",cp-1)
			var plength = thisT.tc.param.length;
			thisT.M({
				param:thisT.tc.param+"&tqpagetotal="+dt
			},"",cp-1);
			thisT.tc.param = thisT.tc.param.substring(0,plength)
			
		};
		if(cp>1){
			btnPrev.title = "�Ϸ�һҳ";
			btnPrev.className = "button24_a bg_green_hover border_green fl";
		}else{
			btnPrev.title = "�ѵ���ǰ";
			btnPrev.className = "button24_a button_disable fl"
		};
		//��ǰҳ�������
		inpCurr.value = cp;
		//��ҳ����ʾ
		totPage.innerHTML = "\/"+tp;
		//��һҳ��ť�¼�
		btnNext.onclick = function(){
			if(cp>tp-1){return};
			//thisT.M("","",cp+1)
			var plength = thisT.tc.param.length;
			thisT.M({
				param:thisT.tc.param+"&tqpagetotal="+dt
			},"",cp+1);
			thisT.tc.param = thisT.tc.param.substring(0,plength)
		};
		if(cp<tp){
			btnNext.title = "�·�һҳ";
			btnNext.className = "button24_a bg_green_hover border_green fl";
		}else{
			btnNext.title = "�ѵ����";
			btnNext.className = "button24_a button_disable fl"
		};
		//���һҳ��ť�¼�
		btnLast.onclick = function(){
			if(cp>tp-1){return};
			//thisT.M("","",tp)
			var plength = thisT.tc.param.length;
			thisT.M({
				param:thisT.tc.param+"&tqpagetotal="+dt
			},"",tp);
			thisT.tc.param = thisT.tc.param.substring(0,plength)
		};
		if(cp<tp){
			btnLast.title = "�·������һҳ";
			btnLast.className = "button24_a bg_green_hover border_green fl"
		}else{
			btnLast.title = "�ѵ����";
			btnLast.className = "button24_a button_disable fl"
		};
		//������������ʾ
		dataTot.innerHTML = dt;
		//��ҳ������ѡ���¼�
		selPage.onchange = function(){
			thisT.tc.rpage = this.value;//����ÿҳ��ʾ��
			//thisT.B.CheckSave(thisT).value = "";//�л�ʱ���ѡ��ļ�¼ID
			thisT.M("","",1)
		};
		this.tc.cpage = cp
		//����
		btnFirs = null;
		btnPrev = null;
		inpCurr = null;
		totPage = null;
		btnNext = null;
		btnLast = null;
		dataTot = null;
		selPage = null;
	},
	/**********************************
	
	 �洢���ǰ������(LastSort)
	 	 
	**********************************/
	LastSort :null,
	/**********************************
	
	 �������(SortGrid),Ŀǰ֧���������ͣ�number,float,date,String
	 TableMain,0,this.cid,this.dataT,this

	**********************************/
	So:function(sTableID, bTR, sortCol, sDataType, sTd){
		//�ӷ���������
		if(this.tc.isodbyserver){
			//�������һ��������
			var LastSort = this.LastSort;
			if(LastSort!=null&&LastSort!=sTd){
				LastSort.firstChild.className = "o";
			};
			
			var fid = sTd.fid||sTd.getAttribute("fid");
			var orderby = "asc";
			if(sTd.firstChild.className == "o asc"){
				sTd.firstChild.className = "o desc";
				orderby = "desc"
			}else{
				sTd.firstChild.className = "o asc"
			};
			this.M({orderfield:""+fid+"",orderby:""+orderby+""});
			
			//��¼���һ��������
			this.LastSort = sTd;
			
			//this.tc.extparam = false;
			return
		};
		//��ǰҳ����
		//�������
		var Stable = document.getElementById(sTableID).firstChild.firstChild;
		if (!Stable||!this.GridData){T.loadTip(1,"��ǰ�����ݣ���������",2,this.tc.tableObj);return;}
		var sTBody = Stable.tBodies[0];
		var sTR = [];
		var Stablef = document.getElementById(sTableID.substr(0,sTableID.length-9)+"_froze_div").firstChild.firstChild;//�̶���
		var sTBodyf = Stablef.tBodies[0];
		var sTRf = [];
		
		//�������һ��������
		var LastSort = this.LastSort;
		if(LastSort!=null&&LastSort!=sTd){
			LastSort.firstChild.className = "o";
			T.each(sTBody.rows,function(eR){
				eR.cells[LastSort.cid].className = "t-grid-cell";
			});
		};
		//�ѵ�ǰ�з�������
		for (var i = bTR; i < sTBody.rows.length; i++) {
			sTR[i - bTR] = sTBody.rows[i];
			sTRf[i - bTR] = sTBodyf.rows[i];//�̶���
		};
		//�����һ���������뵱ǰ��������ͬ������reverse()����,���ı��ͷ��־
		if (LastSort == sTd){
			sTd.firstChild.className = sTd.firstChild.className == "o asc"?"o desc":"o asc";
			sTR.reverse();
			sTRf.reverse();//�̶���
		} else {
			sTd.firstChild.className = "o asc";
			//ð������
			var rTemp;
			var rTempf;
			for (var i = 0; i < sTR.length; i++) {
				for (var j = i + 1; j < sTR.length; j++) {
					if (Convert(sTR[i].cells[sortCol].firstChild.innerHTML, sDataType) > Convert(sTR[j].cells[sortCol].firstChild.innerHTML, sDataType)) {
						rTemp = sTR[i];
						sTR[i] = sTR[j];
						sTR[j] = rTemp;
						//�̶���
						rTempf = sTRf[i];
						sTRf[i] = sTRf[j];
						sTRf[j] = rTempf;
					}
				}
			};
		};
		var frag=document.createDocumentFragment();
		var fragf=document.createDocumentFragment();//�̶���
		for(var i=0,l=sTR.length;i<l;i++)
		{
			frag.appendChild(sTR[i]);
			sTBody.appendChild(frag);
			//�̶���
			fragf.appendChild(sTRf[i]);
			sTBodyf.appendChild(fragf);
		};
		frag = null;
		fragf = null
		T.each(sTBody.rows,function(o){//������ǰ������
			o.cells[sortCol].className = "t-grid-cell t-grid-cell-hover";
			o = null
		});
		
		//����IE6����ʱinputֵ����յ�bug
		this.tc.ischeck?this.RC(1):"";	
		
		//��¼���һ��������
		this.LastSort = sTd;
		
		function Convert(sValue, sDataType) {//��������ת����number,float,date,String
			sValue = sValue.replace(/<[^>].*?>/g,"");
			switch (sDataType) {
				case "number"://����
					return parseInt(sValue);
				case "float"://����
					return parseFloat(sValue);
				case "date"://����
					var dtime = sValue.replace(/[^\d]+/g, "-");
					var eTime = [];
					var nTime;
					eTime = dtime.split('-');
					if (T.iev) {
						nTime = new Date(eTime[1] + "-" + eTime[2] + "-" + eTime[0]);
					} else {
						nTime = new Date(eTime[0] + "-" + eTime[1] + "-" + eTime[2])
					}
					return nTime;
				default://�ַ���
					return sValue.toString();
			}
		}
	},
	/**********************************
	
	 �����п�(ResizeColm)
	 
	**********************************/
	Rc : function(tbn,o){
		var thisT = this;
		var tdcontainerX = T("#"+tbn+"_header_div");
		var tdcontainerY = T("#"+tbn+"_body_innerdiv");
		
		var mObj;//�϶�����
		if(!document.getElementById("tablecoldragdiv"))
		{
			mObj = document.createElement("div");
			mObj.id = "tablecoldragdiv";
			mObj.style.cssText="border-left:dotted 1px #000;z-index:9999;position:absolute;left:-30px;top:-1px;width:20px;height:1px;cursor:e-resize";
			document.body.appendChild(mObj);
		}else{
			mObj = document.getElementById("tablecoldragdiv")
		};
		o.onmousedown = function(evt){//��ʼ
			//��ֹ�϶�ʱ����
			if(!T.iev||(T.iev>8)){
				if(typeof userSelect === "string"){
					return document.documentElement.style[userSelect] = "none";
				}
				document.unselectable  = "on";
				document.onselectstart = function(){
					return false;
				}
			};
			if(!thisT.GridData){T.loadTip(1,"��ǰ��������ݣ����ɵ����п�",1,thisT.tc.tableObj);return};
			var oldpos = this.offsetLeft;
			var evt = evt || window.event;
			var preX = evt.clientX;
			var pos = T.gpos(this);
			var preLeft = preX + this.offsetWidth - 5;
			mObj.style.left = preLeft + "px";
			mObj.style.top = T.gpos(T("#"+tbn+"_body_div_r")).y  + "px";
			//mObj.style.top = T.gpos(T("#"+tbn+"_body_div_r")).y + T.scrollFix().y + "px";
			mObj.style.height=T("#"+tbn+"_body_div_r").offsetHeight + 2 + "px";
			if ((!window.captureEvents)&&(!evt.preventDefault)) { //��IE
				mObj.setCapture(); 
				mObj.onmousemove = function(evt){//�϶�
					var evt = evt || window.event; 
					var newX = evt.clientX;
					mObj.style.left=preLeft + newX - preX;
				};
				mObj.onmouseup = IeChangCol;
				//���㶪ʧʱ����
				//T.bind(mObj, "losecapture",IeChangCol);
			}else { //��IE��IE9.0
				//document.addEventListener("mouseup",NotIeChangCol,"")
				//document.addEventListener("mousemove",NotIeDragCol,"")
				T("doc").aevt("mousemove",NotIeDragCol,"");
				T("doc").aevt("mouseup",NotIeChangCol,"");
				//���㶪ʧʱ��ֹĬ�϶���
				//T.bind(window, "blur", NotIeChangCol);
				evt.preventDefault()
			};
			function IeChangCol(evt){ //IE�ı��п�
				mObj.releaseCapture(); 
				mObj.onmousemove = null;
				mObj.onmouseup = null;
				mObj.style.left="-30px";
				//var evt = arguments.length==0 ? event : arguments[0];
				var evt = event;
				var newX = evt.clientX;
				var newWidth =  newX - preX + oldpos + 8;
				var tdobj = o.parentNode.parentNode;
				if(newWidth<50) newWidth = 50;
				tdobj.style.width = newWidth + "px";
				thisT.contentWidth = thisT.contentWidth + parseInt(newWidth) - parseInt(oldpos)-6;
				tdcontainerX.style.width = thisT.contentWidth + "px";
				tdcontainerY.style.width = thisT.contentWidth + "px";
				
				if(thisT.tc.iscookcol&&T.gcok(thisT.tc.tablename)!=""){
					var tcoks = T.gcok(thisT.tc.tablename);
					var tcoksp = tcoks.split("||");
					var cvalues = "";
					for(var k=0;k<tcoksp.length;k++){
						if(tcoksp[k].split(",")[0]!=tdobj.id.replace(thisT.tc.tablename+"_","")){
							cvalues += tcoksp[k]+"||"
						};
					};
					cvalues += tdobj.id.replace(thisT.tc.tablename+"_","")+",1,"+newWidth+"||";
					T.scok(thisT.tc.tablename,cvalues.substring(0,cvalues.length-2));
				};
				
				//thisT.tc.iscookcol?T.scok(tdobj.id,["1",newWidth]):"";//����cookie
				try{
					var obj = document.getElementById(tbn+"_body").childNodes.item(0).childNodes;
					for(var i=0;i<obj.length;i++){
						obj.item(i).childNodes.item(o.id).style.width = newWidth + "px"	
					};
					//var tdobjDiv = o.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
					//tdobjDiv.style.right = document.getElementById(tbn+"_body").parentNode.scrollLeft + "px";//���¶���
					thisT.B.headerObj(thisT).style.right = thisT.B.tbodyObj(thisT).scrollLeft + "px";//���¶���

					
					
					tdobjDiv = null;
				}catch(e){};
				tdobj = null;
				if(typeof userSelect === "string"){
					return document.documentElement.style[userSelect] = "text";
				}
				document.unselectable  = "off";
				document.onselectstart = null
			};
			function NotIeDragCol(evt){//��IE�϶�
				//window.getSelection ? window.getSelection().removeAllRanges():document.selection.empty();
				var newX = evt.clientX;
				mObj.style.left=preLeft+newX-preX + "px"
			};
			function NotIeChangCol(evt){//��IE�ı��п�
				T("doc").revt("mouseup",NotIeChangCol,"");
				T("doc").revt("mousemove",NotIeDragCol,"");
				//document.removeEventListener("mouseup",NotIeChangCol,"")
				//document.removeEventListener("mousemove",NotIeDragCol,"")
				document.getElementById("tablecoldragdiv").style.left= "-30px";
				var newX = evt.clientX;
				var newWidth =  newX - preX + oldpos + 8;
				if(newWidth<50) newWidth = 50;
				var tdobj = o.parentNode.parentNode;
				tdobj.style.width = newWidth + "px";
				thisT.contentWidth = thisT.contentWidth + parseInt(newWidth) - parseInt(oldpos)-6;
				tdcontainerX.style.width = thisT.contentWidth + "px";
				tdcontainerY.style.width = thisT.contentWidth + "px";
				
				if(thisT.tc.iscookcol&&T.gcok(thisT.tc.tablename)!=""){
					var tcoks = T.gcok(thisT.tc.tablename);
					var tcoksp = tcoks.split("||");
					var cvalues = "";
					for(var k=0;k<tcoksp.length;k++){
						if(tcoksp[k].split(",")[0]!=tdobj.id.replace(thisT.tc.tablename+"_","")){
							cvalues += tcoksp[k]+"||"
						};
					};
					cvalues += tdobj.id.replace(thisT.tc.tablename+"_","")+",1,"+newWidth+"||";
					T.scok(thisT.tc.tablename,cvalues.substring(0,cvalues.length-2))
				}

				//thisT.tc.iscookcol?T.scok(tdobj.id,["1",newWidth]):"";//����cookie
				var obj = document.getElementById(tbn+"_body").childNodes.item(0).childNodes;
				for(var i=0;i<obj.length;i++){
					obj.item(i).childNodes.item(o.id).style.width = newWidth + "px"	
				};
				//var tdobjDiv = o.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
				//tdobjDiv.style.right = document.getElementById(tbn+"_body").parentNode.scrollLeft + "px";//���¶���
				thisT.B.headerObj(thisT).style.right = thisT.B.tbodyObj(thisT).scrollLeft + "px";//���¶���
				
				tdobjDiv = null;
				tdobj = null;
				if(typeof userSelect === "string"){
					return document.documentElement.style[userSelect] = "text";
				}
				document.unselectable  = "off";
				document.onselectstart = null
			}
		}
	},
	/**********************************
	
	 ��ʾ������(Visible Or Hide),Ŀǰͨ��cookies��������
	 
	**********************************/
	VH : function(t){
		var thisT = this;
		var colItems = this.tc.tableFields;
		var _collist = function(colItem){
			var colArray=[];
			for(var m=0;m<colItem.length;m++){
				var n = colItem[m].fieldcnname;
				var f = colItem[m].fieldname;
				var h = colItem[m].fhide;
				var hd = colItem[m].shide||colItem[m].fhide;
				var cookiename = t +"_"+ f;
				//var v = T.gcok(cookiename)!=null&&T.gcok(cookiename)!=""?T.gcok(cookiename).split(",")[0]:(hd?"0":"1");
				var v = null;
					
				if(thisT.tc.iscookcol){
					var gcoksp = T.gcok(t).split("||");
					for(var nn=0;nn<gcoksp.length;nn++){
						if(gcoksp[nn].split(",")[0]== f){
							v = gcoksp[nn].split(",")[1];
							break
						}
					}
				};
				if(v==null||v==""){
					v = hd?"0":"1"
				};
				!h?colArray.push({"fieldcnname":n,"fieldname":f,"fieldvalue":[v],"noList":[{value_name:"��ʾ",value_no:"1"}],"inputtype":"checkbox"}):"";
				n = null,f=null,h=null,hd=null,cookiename=null,v=null
			};
			return colArray
		};
		var collist = function(){
			var _colArray = [];
			if(thisT.tc.headrows){
				for(var k=0;k<colItems.length;k++){
					var coli = {};
					coli.kindname = colItems[k].kindname;
					coli.kinditemts = _collist(colItems[k].kinditemts);
					_colArray.push(coli);
				}
				
			}else{
				var coli = {};
				coli.kindname = "";
				coli.kinditemts = _collist(colItems);
				_colArray.push(coli);
			};
			return _colArray
		};
		Twin({Id:t+"_set_win",Title:"�����(��ʾ/����)����",Width:"390",Height:"auto",sysfun:
			function(tObj){
				Tform({
					formname: t + "_ColSetForm",
					dbuttons:false,
					fit:[false],
					formObj:tObj,
					formpower:false,
					formtipbt:"<div class=\"formtip\" style=\"width:88%\">��ʾ����ǰ����е���ʾ�������ñ����������ص��Ե�cookies�У�������ʹ�ô˵���ʱ���������÷�����Ч�����ң�����Ҫȷ����ʹ�õ����������������ܵ�����cookies��</div>",
					method:"POST",
					formAttr:[{
						formitems:collist()
					}],
					/*buttons : [//����
						{name: "ok", dname: "ȷ��",tit:"ȷ�����ò������������ص���", icon: "tbtn_save.gif",onpress:function(){
							 var selItem = Serializ(t + "_ColSetForm");
							 selItem = selItem.substring(0,selItem.length-1).split("&");
							 var cvalues = "";
							 for(var i=0;i<selItem.length;i++)
							 {
								 var key = t +"_"+ selItem[i].split("=")[0];
								 var keystyle = document.getElementById(key).style.width;
								 var kwidth = keystyle.substring(0,keystyle.length-2);
									var val = [];
									if(selItem[i].split("=")[1]!=""){
										val = selItem[i].split("=")[0] +",1,"+kwidth+"||"
									}else{
										val = selItem[i].split("=")[0] +",0,"+kwidth+"||"
									};
								cvalues+=val;
							 };
							 T.scok(t,cvalues.substring(0,cvalues.length-2));
							 thisT.Th();
							 thisT.C();
							 TwinC(t+"_set_win")
							}
						},
						{name: "cancel", dname: "ȡ��", tit:"ȡ����������",icon:"cancel.gif", onpress:function(){TwinC(t+"_set_win")} }
					],*/
					buttons:false
				});
			},	
		buttons:[{ name: "ok", dname: "ȷ��", icon: "ok.gif", tit:"ȷ�����ò������������ص���",onpress:function(){
				 var selItem = Serializ(t + "_ColSetForm");
				 selItem = selItem.substring(0,selItem.length-1).split("&");
				 var cvalues = "";
				 for(var i=0;i<selItem.length;i++)
				 {
					var key = t +"_"+ selItem[i].split("=")[0];
					var keystyle = document.getElementById(key).style.width;
					var kwidth = keystyle.substring(0,keystyle.length-2);
					var val = [];
					if(selItem[i].split("=")[1]!=""){
						val = selItem[i].split("=")[0] +",1,"+kwidth+"||"
					}else{
						val = selItem[i].split("=")[0] +",0,"+kwidth+"||"
					};
					cvalues+=val;
				 };
				 T.scok(t,cvalues.substring(0,cvalues.length-2));
				 thisT.Th();
				 thisT.C();
				 TwinC(t+"_set_win")
				}
			},
			{ name: "cancel",dname: "ȡ��",tit:"ȡ����������",onpress:function(){TwinC(t+"_set_win")}}]
				
		})
	},
	/**********************************
	
	 Checkbox�¼�(CheckFunction)
	 
	**********************************/
	CF : function(){
		var thisT = this;
		var tbn = this.tc.tablename;//�����
		var Allbox = this.B.Allbox(this);//ȫѡchecbox����
		var Savebox = this.B.CheckSave(this);//ѡ�е�ID��������
		var Childboxs = this.B.Childboxs(this);//������checkbox����
		var checktype =this.tc.checktype;
		
		if(checktype=="checkbox"){
			//��ǰҳȫѡ����
			//T.bind(Allbox,"click",function(){
				//thisT.CA(Allbox,Childboxs,Savebox)
			//});
			Allbox.onclick = function(){
				thisT.CA(Allbox,Childboxs,Savebox)
			}
		};
		//����ѡ����
		T.each(Childboxs,function(it){
			T.bind(it.cells[0].firstChild,"click",function(){
				thisT.SC(Allbox,it.cells[0].firstChild,Savebox)
			});
		})
	},
	/**********************************
	
	 ����ѡ���¼�(SingCheck)
	 
	**********************************/
	SC : function(parent,child,saveobj){
		var thisT = this;
		var parent = parent || thisT.B.Allbox(thisT);
		var saveobj = saveobj || thisT.B.CheckSave(thisT);
		var cval = saveobj.value;//��ѡIDֵ����
		var chxvalues = cval==""?[]:cval.split(",");
		var checktype =this.tc.checktype;
		var Childboxs = this.B.Childboxs(this);//������checkbox����
		var trobj = document.getElementById(this.tc.tablename+"_"+child.value+"_tr");
		
		if(checktype=="checkbox"){
			if(child.checked == true){
				if(T.AindexOf(chxvalues,child.value)<0){
					chxvalues.push(child.value)	
				}
			}else{
				if(T.AindexOf(chxvalues,child.value)>-1){
					T.Aremove(chxvalues,child.value)
				}
			};
			thisT.St(child);//���ö�Ӧ�е���ɫ
		}else{
			T.each(Childboxs,function(rd){
				var chd = rd.cells[0].firstChild;
				if(chd.checked==true){
					if(T.AindexOf(chxvalues,chd.value)<0){
						chxvalues.push(chd.value)	
					};
					thisT.St(chd,1);//���ö�Ӧ�е���ɫ
				}else{
					if(T.AindexOf(chxvalues,chd.value)>-1){
						T.Aremove(chxvalues,chd.value)
					};
					thisT.St(chd,0);//���ö�Ӧ�е���ɫ
				};
			})
		};
		saveobj.value = chxvalues.join(",");
		if(this.tc.checktype=="checkbox"){
			var clength = 0;
			T.each(Childboxs,function(Ci){
				clength += T.AindexOf(chxvalues,Ci.cells[0].firstChild.value)<0?0:1
			});
			parent.checked = (clength == Childboxs.length)?true:false
		};
		this.B.tablechkSpan(this)?this.B.tablechkSpan(this).innerHTML = chxvalues.length!=0?"��ѡ��"+chxvalues.length+"����¼":"":""
		//alert(chxvalues.length)
	},

	/**********************************
	
	 ȫѡ�¼�(CheckAll)
	 parentΪȫѡcheckbox;childΪ��checkbox�����м���,saveobjΪ�洢ѡ��ֵ��input����
	 
	**********************************/
	CA : function(parent,child,saveobj){
		var thisT = this;
		var cval = saveobj.value;//��ѡIDֵ����
		var chxvalues = cval==""?[]:cval.split(",");
		
		if(parent.checked == true){
			T.each(child,function(it){
				var c = it.cells[0].firstChild;
				c.checked = true;
				thisT.St(c);//���ö�Ӧ�е���ɫ
				if(T.AindexOf(chxvalues,c.value)<0){
					chxvalues.push(c.value)	 
				};
				it = null
			})
		}else{
			T.each(child,function(it){
				var c = it.cells[0].firstChild;
				c.checked = false;
				thisT.St(c);//���ö�Ӧ�е���ɫ
				if(T.AindexOf(chxvalues,c.value)>-1){
					T.Aremove(chxvalues,c.value)
				};
				it = null
			})
		};
	saveobj.value = chxvalues.join(",");
	this.B.tablechkSpan(this)?this.B.tablechkSpan(this).innerHTML = chxvalues.length!=0?"��ѡ��"+chxvalues.length+"����¼":"":""
	//alert(this.GS(false).split(",").length)
	},
	/**********************************
	
	 ���ݱ���ѡ��ֵ������checkox״̬IDs(ReCheckStatus)
	 
	**********************************/
	RC : function(Sort){//Sort=1,����ʱ����Ӧ�Զ���ѡ����¼�
		var thisT = this;
		var SaveVal = this.B.CheckSave(this).value;//ת��ѡ�е�ID���������ֵΪ����
		var Childboxs = this.B.Childboxs(this);//������checkbox����
		var clength = 0;
		var ic;
		if(SaveVal == ""){
			if(Sort!=1&&this.tc.checkfun){//��Ӧ�Զ�����checkbox����
				T.each(Childboxs,function(i){
					ic = i.cells[0].firstChild;
					thisT.St(ic)
				});
			};
			return
		}else{
			SaveVal = SaveVal.split(",");
			T.each(Childboxs,function(i){
				ic = i.cells[0].firstChild;
				T.AindexOf(SaveVal,ic.value)> -1 ? (ic.checked = true,clength = clength+1) :"";
				//ic.checked==true?thisT.St(ic):"";//���ö�Ӧ�е���ɫ
				thisT.St(ic)
			});
			if(this.tc.checktype=="checkbox"){
				this.B.Allbox(this).checked = (clength == Childboxs.length)?true:false
			};
		};
		ic = null
		SaveVal = null;
		Childboxs = null
	},
	/**********************************
	
	 ������ѡ��/ȡ��ѡ���е���ʽ(SetTrStyle)�Լ���Ӧ�Զ�����checkbox����
	 child:ѡ�����
	 r:radioר��,1Ϊѡ��,0Ϊδѡ��
	 
	**********************************/
	St : function(child,r){
		var thisT = this;
		var trobj = document.getElementById(this.tc.tablename+"_"+child.value+"_tr");
		if(child.checked == true||(r&&r==1)){
			trobj.className = "t-grid-row-sel";
			T.iev == 6?(trobj.onmouseout = null,trobj.onmouseout = function(){this.className = "t-grid-row-sel"}):"";
		}else{
			trobj.className = "t-grid-row";
			T.iev == 6?(trobj.onmouseout = null,trobj.onmouseout = function(){this.className = "t-grid-row"}):"";
		};
		if(this.tc.checkfun){//��Ӧ�Զ�����checkbox����
			this.tc.checkfun(child)
		}
	},
	/**********************************
	
	 ��ȡѡ����IDs(GetSelected)
	 
	**********************************/
	GS : function(tip){
		var SaveVal = this.B.CheckSave(this).value;//ѡ�е�ID���������ֵ
		if(SaveVal!=""){
			return SaveVal
		}else{
			tip==null||tip=="undefined"||tip==true?T.loadTip(1,"��δѡ���κ����ݣ�����ѡ��<b style=\"color:#c00\">1</b>��",2,this.tc.tableObj):"";
			return false
		}
	},
	/**********************************
	
	 ����ѡ����IDs��ȡĳ�ֶ�ֵ(GetSelectedByFieldName)
	 
	**********************************/
	GSByField : function(fieldname,tip){
		var SaveVal = this.B.CheckSave(this).value;//ѡ�е�ID���������ֵ
		var ret = [];
		if(SaveVal!=""){
			SaveVal = SaveVal.split(",")
			for(var i=0;i<SaveVal.length;i++){
				if(this.GD(SaveVal[i],fieldname)==''){
					ret.push('null');
				}else{
					ret.push(this.GD(SaveVal[i],fieldname))
				}
			}
			return ret.join(",")
		}else{
			tip==null||tip=="undefined"||tip==true?T.loadTip(1,"��δѡ���κ����ݣ�����ѡ��<b style=\"color:#c00\">1</b>��",2,this.tc.tableObj):"";
			return false
		}
	},
	/**********************************
	
	��ȡ��ǰҳ������IDs(GetCurrentId)
	
	**********************************/
	GCI : function(symbol){
		var symbol = symbol?symbol:",";
		if(this.GridData){
			data = this.GridData.rows
		}else{
			return false
		};
		var allids = [];
		for(var j = 0;j<data.length;j++)
		{
			allids.push(data[j].id)
		};
		allids = allids.length>0?allids.join(symbol):"";
		return allids
	},	
	/**********************************
	
	 ��ȡ���ĳ�ֶ�ĳ�е�ֵ(_GetGridData),���ɱ��ʱ��
	 tid:��¼ID
	 col:�ֶ���,Ϊ�����ȡ��������{�ֶ�1:value1,�ֶ�2:value2}��
	 type:�����е�ԭ���������ݸ�ʽtrue��ʾ��,fasle����Ϊ�ձ�ʾ��
	 origin:�༭ģʽ�»�ȡ�ֶ�ԭʼֵ(true/false)Ĭ��false
	 
	**********************************/
	GD : function(tid,col,type,origin){
		var data;
		data = origin?this.oGridData:this.GridData;
		if(!data){return false};
		var tds = data.rows;
		if(col){
			var j = this.GFI(col);
			for (var i=0;i<tds.length;i++)
			{
				if(tid == tds[i].id){
					return tds[i].cell[j];
					break;
				}
			}
		}else{
			for (var i=0;i<tds.length;i++)
			{
				if(tid == tds[i].id){
					if(type){
						return tds[i]
					}else{
						return tds[i].cell
					};
					break;
				}
			}
		};
		return false
	},
	/**********************************
	
	 GetRow��ȡѡ����,������rows����rows:[{id:,cell:[{}]}]
	 ids:ѡ���id����(id,id,id)
	 
	**********************************/
	GROW : function(ids){
		if(!ids){return};
		var ids = ids.split(",");
		var result = [];
		for (var i=0;i<ids.length;i++)
		{
			result.push(this.GD(ids[i],"",true))
		};
		return result
	},
	/**********************************
	
	 ����
	 
	**********************************/
	Destroy : function(){
		var t = this;
		/*
		purge(this.B.CheckSave(this));
		purge(this.B.footerObj(this));
		purge(this.B.headerObj(this));
		purge(this.B.tbodyObj(this));
		purge(this.B.frozeObj(this));
		purge(this.B.titleObj(this));
		purge(this.B.toolObj(this));
		purge(this.B.frozehObj(this));
		purge(this.B.tabledivObj(this));
		
		this.B.CheckSave(this).value = "";
		this.B.footerObj(this).innerHTML = "";
		this.B.headerObj(this).innerHTML = "";
		this.B.tbodyObj(this).innerHTML = "";
		this.B.frozeObj(this).innerHTML = "";
		this.B.titleObj(this).innerHTML = "";
		this.B.toolObj(this).innerHTML = "";
		this.B.frozehdObj(this).innerHTML = "";
		this.B.tabledivObj(this).innerHTML = "";
		*/
		//this.unbindFO();
		
		this.B.Allbox(this)?this.B.Allbox(this).onclick = null:"";
		this.tc.tableObj?(this.unbindFO(),this.tc.tableObj.innerHTML = ""):"";
	},
	/**********************************
	
	 ת����ʾ��ʽ
	 TranslateStyle
	 
	**********************************/
	TS : function(fname,value,id){
		value = typeof(value)=="object"?T.Obj2Str(value):value;//�����ʽ����textarea
		var fname = fname.substring(this.tc.tablename.length+1)
		var t = this;
		var tc = this.tc;
		if(fname==""){return};
		var inputhtml = [];
		var _items = this.GFO(fname);
		var FInputtype = _items.inputtype;
		switch (FInputtype){
			case "select":
			for(var j=0;j<_items.noList.length;j++){
				(value!="��ѡ��"&&(value == _items.noList[j].value_no||value == _items.noList[j].value_name))?inputhtml.push(_items.noList[j].value_name):"";
			}
			break;
			case "cselect":
				if(_items.noList&&_items.noList.length>0){
					for(var j=0;j<_items.noList.length;j++){
						(value!="��ѡ��"&&value!="-1"&&(value == _items.noList[j].value_no||value == _items.noList[j].value_name))?inputhtml.push(_items.noList[j].value_name):"";
					}
				}else{
					/*var act = _items.action;
					T.A.sendData("getdata.do?action=getvalue&type="+act+"&id="+value,"GET","",function(ret){
						//alert(ret);
						//inputhtml.push(ret);
						this.SV(id,fname,ret);
					});*/
					inputhtml.push(value);
				}
				break;
			/*case "mobile":
			case "telphone":
			var telphoneFvalue = value;
			
			if(telphoneFvalue.indexOf("||")!="-1"){
				var ftelphoneFvalue = telphoneFvalue.split("||")[0];
				var stelphoneFvalue =  telphoneFvalue.split("||")[1];
			}else{
				var ftelphoneFvalue = telphoneFvalue;
				var stelphoneFvalue = telphoneFvalue;
			};
			if(/^(1[4358].{9})|(01[4358].{9})$/.test(telphoneFvalue)){
				inputhtml.push( ftelphoneFvalue+"&nbsp;<img title=\"���Ͷ���\" class=\"ordericon2\" style='cursor:pointer' src=\""+tc.Path+"sendsms.gif\" onclick=\"javascript:messageout('"+stelphoneFvalue+ "','"+tc.tableObj.id+"');\">");
			}else
				inputhtml.push(ftelphoneFvalue);
			if(value!=''&&("undefined"!=typeof(iskehuduan)&&iskehuduan))
				inputhtml.push("&nbsp;<img title=\"�������\" class=\"ordericon\" style='cursor:pointer'  src=\""+tc.Path+"phone.gif\" onclick=\"javascript:tq_call_out('"+stelphoneFvalue+ "');\">");
			break;*/
			default:
				inputhtml.push(value);
			break;
		};
		_items = null;
		return inputhtml.join("")
	},
	/**********************************
	
	 �༭ģʽ��ת����ʾ��ʽ
	 EditModelTranslateStyle
	 
	**********************************/
	EMTS : function(fname,value,id){
		value = typeof(value)=="object"?T.Obj2Str(value):value;//�����ʽ����textarea
		var fname = fname.substring(this.tc.tablename.length+1)
		var t = this;
		var tc = this.tc;
		var FNM= tc.tablename;
		
		if(fname==""){return};

		var inputhtml = [];
			var items = tc.tableFields;
				for (var i=0;i<items.length;i++)
				{

					var FInputtype = items[i].inputtype;
					var Fnm = items[i].fieldname;
					if(Fnm == fname){
						var Fnm = items[i].fieldname;
						var Edi = items[i].edit;
						var iW = items[i].width;
						var iH = items[i].height;
						var hd = items[i].shide;
						var nosub = items[i].nosub?"nosub=\"true\"":"";
						var _fid = FNM+"_" + Fnm +"_"+id+"";
						var colSpan=1;
						if(items[i].inputtype == "multi"&&"undefined" == typeof(items[i].height)){iH = 60};
						var Fst;
						if(iW||iH){
							Fst = (Edi==false)?""+nosub+" class=\"txt\" style=\"width:" + iW + "px;height:" + iH + "px;margin-left:0px;background:#DDE4E6;color:#000\" readonly ":""+nosub+" class=\"txt\" style=\"width:" + iW + "px;height:" + iH + "px;margin-left:0px;\" ";
						}else{
							Fst = (Edi==false)?""+nosub+" class=\"txt\" style=\"margin-left:0px;background:#DDE4E6;color:#000\" readonly ":""+nosub+" class=\"txt\" style=\"margin-left:0px;\" ";
						}
						var Dfn = "onfocus=\"T.addcls(this,'h')\"  onblur=\"T.remcls(this,'h')\" ";
						if(items[i].fn){
							var eF = items[i].fn[0];
							Dfn = "onfocus=\"T.addcls(this,'h')\" onblur=\"T.remcls(this,'h')\" "+eF.type+"="+eF.fun+"('"+FNM+"','"+id+"')";
						};
						var _fvalue = value//items[i].fieldvalue;
						if(items[i].Fn){
							var eF = items[i].Fn[0];
							Dfn += " "+eF.type+"=javascript:"+eF.fun+"('"+FNM+"',this.value,'"+id+"')";
						};
						var extrahtml;
						if(items[i].trefn){
							extrahtml = items[i].trefn(FNM,Fnm,_fvalue,id)
							inputhtml.push(extrahtml);
						}else{
							switch (FInputtype){
								case "text":
								case "number":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<input "+Dfn+" type=\"text\" "+Fst+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\">");
								//inputhtml.push(""+fname+","+value+","+id+"")
								break;
								case "multi":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<textarea id=\""+_fid+"\" name=\"" + Fnm + "\" "+Dfn+" "+Fst+"");
								inputhtml.push(">" + _fvalue + "</textarea>");
								//inputhtml.push( "<img title=\"��ӱ�ע\" class=\"ordericon2\" src=\""+tc.Path+"sendsms.gif\" onclick=\"javascript:messageout('"+_fid+"');\">");
								break;
								case "checkbox":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								for(var j=0;j<items[i].noList.length;j++){
									inputhtml.push( "<input class=\"chk\" "+nosub+" type=\"checkbox\" name=\"" + Fnm + "\" value=\"" + items[i].noList[j].value_no + "\" id=\"_fid_" + items[i].noList[j].value_no + "\"");
									T.ie?inputhtml.push(" style=\"margin-left:5px;\""):inputhtml.push(" style=\"margin:0px;\"");
									(Edi==false)?inputhtml.push(" disabled "):"";
									var fvalues = _fvalue;
									typeof(fvalues)!="object"?fvalues = [fvalues]:"";
									for(var n=0;n<fvalues.length;n++){
										var fvalue = fvalues[n];
										if(fvalue == items[i].noList[j].value_no||fvalue == items[i].noList[j].value_name){inputhtml.push(" checked");}
									}
									inputhtml.push( ">");
									inputhtml.push( "<label class=\"lbl\" for=\"_fid_" + items[i].noList[j].value_no + "\"");
									T.ie?"":inputhtml.push(" style=\"padding-right:3px;padding-top:3px\"");
									inputhtml.push( ">" + items[i].noList[j].value_name + "</label>");
								}
								break;
								case "radio":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								for(var j=0;j<items[i].noList.length;j++){
									inputhtml.push( "<input class=\"chk\" "+nosub+" type=\"radio\" name=\"" + Fnm + "\" value=\"" + items[i].noList[j].value_no + "\" id=\"_fid_" + items[i].noList[j].value_no + "\"");
									T.ie?inputhtml.push(" style=\"margin-left:5px;\""):inputhtml.push(" style=\"margin:0px;\"");
									(Edi==false)?inputhtml.push(" disabled "):"";
									var fvalues = fvalue;
									typeof(fvalues)!="object"?fvalues = [fvalues]:"";
									for(var n=0;n<fvalues.length;n++){
										var fvalue = fvalues[n];
										if(fvalue == items[i].noList[j].value_no||fvalue == items[i].noList[j].value_name){inputhtml.push(" checked");}
									}
									inputhtml.push( ">");
									inputhtml.push( "<label class=\"lbl\" for=\"_fid_" + items[i].noList[j].value_no + "\"");
									T.ie?"":inputhtml.push(" style=\"padding-right:3px;padding-top:3px\"");
									inputhtml.push( ">" + items[i].noList[j].value_name + "</label>");
								}
								break;
								case "select":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<select "+Dfn+" class=\"slct\" "+nosub+" name=\"" + Fnm + "\" id=\""+_fid+"\"");
								if(Edi==false){inputhtml.push(" disabled style=\"background:#DDE4E6;color:#000\" ")};
								T.ie?inputhtml.push(" style=\"margin-left:5px;\""):"";
								inputhtml.push(">");
								for(var j=0;j<items[i].noList.length;j++){
									inputhtml.push( "<option value=\"" + items[i].noList[j].value_no + "\" ");
									(_fvalue == items[i].noList[j].value_no||_fvalue == items[i].noList[j].value_name)?inputhtml.push( " selected"):"";
									inputhtml.push( ">" + items[i].noList[j].value_name + "");
									inputhtml.push( "</option>");
								}
								inputhtml.push( "</select>");
								break;
								
								case "ivrlist":
								items[i].ubox_id = items[i].ubox_id||1000;
								items[i].nodeId = items[i].nodeId||0;
								inputhtml.push( "<input "+Dfn+" type=\"text\" class = \"txt\" style=\"float:left;width:150px\" uboxid = \""+items[i].ubox_id+"\" value=\"" + getTreeNodeName(_fvalue,items[i].ubox_id) + "\" id=\""+_fid+ "_text\" name=\"" + Fnm + "_text\" nosub=\"true\" onclick=\"ivrNodeSelect('"+tc.formFunId+"',this)\" title=\"���ѡ��\" style=\"cursor:pointer;\"/>");
								inputhtml.push( "<input type=\"hidden\" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\" />");
								inputhtml.push( "&nbsp;<span class=\"button2\" style=\"width:80px\" title=\"�����������̽ڵ�\" onclick=\"AddIvrNode('"+FNM+"_" + Fnm + "','"+items[i].ubox_id+"','"+items[i].nodeId+"')\"/>+�����ڵ�</span>");
								//&nbsp;<span class=\"button2\" style=\"width:80px\" title=\"ɾ����ǰ��ʾ�ڵ�\" onclick=\"DelIvrNode('"+FNM+"_" + Fnm + "')\">-ɾ���ڵ�</span>
								break;
								
								case "localselect":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								if(_fvalue!=""){
									tc.areaData = ""+_fid+"||"+_fvalue+""
								}else{
									tc.areaData = "";
								};
								inputhtml.push("<input type='hidden' id=\""+_fid+"\" "+nosub+" name=\"client_region\" value=\"\"/>");
								inputhtml.push( "<select "+nosub+" style=\"float:left\" name=\"f_s_" + Fnm + "\" id=\"_fidinput_sheng\" onchange='setshi(this.value,\""+_fid+"\")'");
								inputhtml.push(">");
								for(var j=0;j<items[i].noList.length;j++){
									inputhtml.push( "<option value=\"" + items[i].noList[j].value_no + "\" ");
									(_fvalue == items[i].noList[j].value_no)?inputhtml.push( " selected"):"";
									inputhtml.push( ">" + items[i].noList[j].value_name + "");
									inputhtml.push( "</option>");
								};
								inputhtml.push( "</select>");
								inputhtml.push("<span id=\"_fidspan_shi\"><select "+nosub+" id=\"_fidinput_shi\"  onchange=\"setquxian(this.value,'"+_fid+"')\"><option >��ѡ��</option></select></span>");
								inputhtml.push("<span id=\"_fidspan_quxian\"><select "+nosub+" id=\"_fidinput_quxian\"  onchange=\"setquxian(this.value,'"+_fid+"')\"><option >��ѡ��</option></select></span>");
								break;
								case "telphone":
								var telphoneFvalue = _fvalue;
								if(telphoneFvalue.indexOf("||")!="-1"){
									var ftelphoneFvalue = telphoneFvalue.split("||")[0];
									var stelphoneFvalue =  telphoneFvalue.split("||")[1];
								}else{
									var ftelphoneFvalue = telphoneFvalue;
									var stelphoneFvalue =  items[i].valueencry&&items[i].valueencry!=""?items[i].valueencry:telphoneFvalue;
								};
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + ftelphoneFvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<input type=\"hidden\" "+nosub+" value=\"" + stelphoneFvalue + "\" id=\""+_fid+"_encry\" name=\"" + Fnm + "_encry\">");	
								inputhtml.push( "<input "+Dfn+" type=\"text\" "+Fst+" value=\"" + ftelphoneFvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"");
								if(Edi==false){inputhtml.push(" readonly style=\"background:#DDE4E6;color:#000\">")}else{
								inputhtml.push( ">");
								inputhtml.push( "<img title=\"�������\" class=\"ordericon\" src=\""+tc.Path+"phone.gif\" onclick=\"javascript:callout('"+_fid+"','"+_fid+"_encry');\">");};
								break;
								case "mobile":
								var mobileFvalue = _fvalue;
								if(mobileFvalue.indexOf("||")!="-1"){
									var fmobileFvalue = mobileFvalue.split("||")[0];
									var smobileFvalue =  mobileFvalue.split("||")[1];
								}else{
									var fmobileFvalue = mobileFvalue;
									var smobileFvalue =  items[i].valueencry&&items[i].valueencry!=""?items[i].valueencry:mobileFvalue;
								};
								if(hd==true){
									inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + fmobileFvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break;
								};
								inputhtml.push( "<input type=\"hidden\" "+nosub+" value=\"" + smobileFvalue + "\" id=\""+_fid+"_encry\" name=\"" + Fnm + "_encry\">");	
								inputhtml.push( "<input "+Dfn+" type=\"text\" "+Fst+" value=\"" + fmobileFvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"");
								if(Edi==false){inputhtml.push(" readonly style=\"background:#DDE4E6;color:#000\">")}else{
								inputhtml.push( ">");
								inputhtml.push( "<img title=\"�������\" class=\"ordericon\" src=\""+tc.Path+"phone.gif\" onclick=\"javascript:callout('"+_fid+"','"+_fid+"_encry');\" />");
								smobileFvalue!=""?inputhtml.push( "<img title=\"���Ͷ���1\" class=\"ordericon2\" src=\""+tc.Path+"sendsms.gif\" onclick=\"javascript:messageout('"+_fid+"_encry','"+tc.tableObj.id+"');\" />"):inputhtml.push( "<img title=\"���Ͷ���\" class=\"ordericon2\" src=\""+tc.Path+"sendsms.gif\" onclick=\"javascript:messageout('"+_fid+"','"+tc.tableObj.id+"');\" />");
								};
								break;
								case "email":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<input "+Dfn+" type=\"text\" "+Fst+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"");
								if(Edi==false){inputhtml.push(" readonly style=\"background:#DDE4E6;color:#000\">")}else{
								inputhtml.push( ">");
								inputhtml.push( "<img title=\"�����ʼ�\" class=\"ordericon\" src=\""+tc.Path+"email.gif\" onclick=\"javascript:mailout('"+_fid+"');\">");
								};
								break;
								case "wwwnet":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<input "+Dfn+" type=\"text\" "+Fst+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"");
								if(Edi==false){inputhtml.push(" readonly style=\"background:#DDE4E6;color:#000\">")}else{
								inputhtml.push( ">");
								inputhtml.push( "<img title=\"����ַ\" class=\"ordericon\" src=\""+tc.Path+"openurl.png\" onclick=\"javascript:openurl('"+_fid+"');\">");
								};
								break;
								case "wwwsearch":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<input "+Dfn+" type=\"text\" "+Fst+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"");
								if(Edi==false){inputhtml.push(" readonly style=\"background:#DDE4E6;color:#000\">")}else{
								inputhtml.push( ">");
								inputhtml.push( "<img title=\"�ٶ�����\" class=\"ordericon\" src=\""+tc.Path+"baidu.gif\" onclick=\"javascript:wwwsearch('"+_fid+"');\">");
								};
								break;
								case "uploadfile":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<input readonly "+Dfn+" type=\"text\" "+Fst+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"");
								if(Edi==false){inputhtml.push(" readonly style=\"background:#DDE4E6;color:#000\">")}else{
								inputhtml.push( ">");
								inputhtml.push( "<img title=\"�ϴ��ļ�\" class=\"ordericon\" src=\""+tc.Path+"upload.gif\" onclick=\"javascript:upload('"+_fid+"');\">");
								};
								break;
								case "seluser":
								inputhtml.push( "<input "+Dfn+" readonly "+Fst+" value=\"" + _fvalue.split('||')[0] + "\" id=\"_fid_text\" name=\"" + Fnm + "_text\"  onclick=\"selectuser(this.id);\" style=\"cursor:pointer;_cursor:hand\"");
								(hd==true)?inputhtml.push(" type=\"hidden\""):inputhtml.push(" type=\"text\"");
								inputhtml.push(" title='���ѡ��'>");
								inputhtml.push( "<input "+Dfn+" type=\"hidden\" "+nosub+"  value=\"" + _fvalue.split('||')[1] + "\" id=\""+_fid+"\" name=\"" + Fnm + "\">");
								break;
								case "selalluser":
								inputhtml.push( "<input "+Dfn+" readonly "+Fst+" value=\"" + _fvalue.split('||')[0] + "\" id=\"_fid_text\" name=\"" + Fnm + "_text\"  onclick=\"selectuser(this.id,'1');\" style=\"cursor:pointer;_cursor:hand\"");
								(hd==true)?inputhtml.push(" type=\"hidden\""):inputhtml.push(" type=\"text\"");
								inputhtml.push(" title='���ѡ��'>");
								inputhtml.push( "<input "+Dfn+" type=\"hidden\" "+nosub+"  value=\"" + _fvalue.split('||')[1] + "\" id=\""+_fid+"\" name=\"" + Fnm + "\">");
								break;
								case "date":
								if(hd==true){inputhtml.push(" <input type=\"hidden\" "+nosub+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"> ");break};
								inputhtml.push( "<input "+Dfn+" type=\"text\" "+Fst+" value=\"" + _fvalue + "\" id=\""+_fid+"\" name=\"" + Fnm + "\"  onClick=\"WdatePicker({startDate:'%y-%M-01 00:00:00',alwaysUseStartDate:true});\"");
								if(Edi==false){inputhtml.push(" disabled style=\"background:#DDE4E6;color:#000\">")}else{
								inputhtml.push( " title=\"���ѡ��\" style=\"cursor:pointer;_cursor:hand\">");
								//inputhtml.push( "<img title=\"���ѡ��\" class=\"ordericon\" src=\""+tc.Path+"date.png\" onClick=\"WdatePicker({el:'_fid_"+i+"'})\">");
								};
								break;
							}
						};
						continue
					};
				}
		return inputhtml.join("")
	},
	/**********************************
	
	 ��ȡ�ֶ�index
	 GetFieldIndex
	 
	**********************************/
	GFI : function(fname){
		var Thead = this.B.headerObj(this).firstChild;
		var TheadBody = Thead.tBodies[0];
		var tcell = TheadBody.rows;//[0].cells
		for(var i=0;i<tcell.length;i++){
			var _tcell = tcell[i].cells;
			for(var j=0;j<_tcell.length;j++){
				if (_tcell[j].id == this.tc.tablename+"_"+fname){
					return _tcell[j].getAttribute("headid");
					break
				}
			}
		};
		
/*		var fitem = this.tc.tableFields;
		for(var i=0;i<fitem.length;i++){
			if (fitem[i].fieldname == fname){
				return i;
				break
			}
		};
*/		return false
	},/**********************************
	
	 �����
	 AddRow
	 data:[{id:,cell:[{}]}]
	 limitfield:�������ظ�ֵ���ֶΣ����ظ������ӣ���Ϊ�վ������ظ�
	 
	**********************************/
	AR : function(data,limitfield){
		var t = this;
		var oData = this.GridData||{"page":1,"total":0,"rows": []};
		var _oData = oData.rows;
		if(typeof(data)!="object"){alert("�����ݸ�ʽ����");return};
		var compare = function(limitValue){
			if(limitValue==false){return true};
			var flag = true;
			for (var m = 0;m<_oData.length;m++){
				if(limitValue==t.GD(_oData[m].id,limitfield)){
					flag = false;
					break
				};
			};
			return flag
		};
		if(oData.rows.length > 0){
			for(var i=0;i<data.length;i++){
				if(!limitfield||compare(data[i].cell[t.GFI(limitfield)],limitfield)){
					this.SM(data[i],"add");
					oData.rows.unshift(data[i]);
					oData.total += 1;
					t.isOrigin = false;//ԭʼ��������ѱ�����
				}
			};
		}else{
			for(var i=0;i<data.length;i++){
				this.SM(data[i],"add");
				oData.rows.unshift(data[i]);
				oData.total += 1;
				t.isOrigin = false;//ԭʼ��������ѱ�����
			};
		};
		var dorign = this.tc.dataorign;
		this.M({hotdata:oData,dataorign:1});
		this.tc.dataorign=dorign;
	},
	
	/**********************************
	
	 ɾ����
	 DeleteRow
	 
	**********************************/
	DR : function(ids){
		var oData = this.GridData;
		if(typeof(oData)!="object"){alert("������");return};
		var data = oData.rows;
		var id = ids.split(",");
		for (var m = 0;m<id.length;m++){
			for(var i=0;i<data.length;i++){
				if(data[i].id==id[m]){
					this.SM(data[i],"del",data[i].type=="add");
					data.splice(i,1);	
					oData.total -= 1;
					this.isOrigin = false;//ԭʼ��������ѱ�����
					break;
				};
			};
		};
		var dorign = this.tc.dataorign;
		this.M({hotdata:oData,dataorign:1},"",this.tc.cpage);
		this.tc.dataorign=dorign;
	},
	/**********************************
	
	 ��ȡ�޸�ֵ������json�����༭ģʽ�¡�
	 GetModify
	 tid:��¼id����id��,Ϊ������±��ǰҳ��������,�Ѿ��䶯����¼��type���
	 
	**********************************/
	GM : function(tid){
		if(!this.tc.editmode){alert("�Ǳ༭ģʽ����޴˹���");return};
		var cols = this.tc.tableFields;
		if(tid){
			for(var n=0;n<cols.length;n++){
				this.SD(tid,cols[n].fieldname)
			};
		}else{
			var data;
			if(this.GridData){
				tds = this.GridData.rows
			}else{
				return false
			};
			
			for(var m=0;m<tds.length;m++){
				for(var n=0;n<cols.length;n++){
					this.SD(tds[m].id,cols[n].fieldname)
				};
			};
		}
	},
	/**********************************
	
	 �༭ģʽ�¸��¸��ĵ�ֵ
	 SetData
	 tid:��¼ID
	 col:�ֶ���
	 
	**********************************/
	SD : function(tid,col){
		//if(!this.tc.editmode){alert("�Ǳ༭ģʽ����޴˹���");return};
		var data;
		if(this.GridData){
			data = this.GridData
		}else{
			return false
		};
		var tds = data.rows;
		var tinput = T("#"+this.tc.tablename+"_"+col+"_"+tid+"");
		if(col){
			var cols = this.tc.tableFields;
			for (var j=0;j<cols.length;j++)
			{
				if(col == cols[j].fieldname){break;}
			};
			for (var i=0;i<tds.length;i++)
			{
				if(tid == tds[i].id){
					tds[i].cell[j] = tinput.value;
					if(tds[i].type=="add"){
						this.SM(tds[i],"add")
					}else if(this.GD(tid,col,"",true)!=tinput.value){
						this.SM(tds[i],tds[i].type||"mod")
					}else{
						this.SM(tds[i],tds[i].type||"mod",true)
					};
					break;
				}
			}
		}else{
			return false
		};
	},
	
	/**********************************
	
	 ����ID����tableitems��fieldvalueֵ(�༭ĳ����¼��ʱ������)
	 id:��¼ID
	 
	**********************************/
	SDBID : function(id){
		var t = this;
		if(this.tc.headrows){
			var ti = t.tc.tableitems;
			T.each(ti,function(p,i){
				T.each(p.kinditemts,function(o,j){
					o.fieldvalue = t.GD(id,o.fieldname)
				})
			})
		}else{
			T.each(t.tc.tableitems,function(o,j){
				o.fieldvalue = t.GD(id,o.fieldname)
			});
		};
	},
	/**********************************
	
	 ���tableitems��fieldvalueֵ(�༭ĳ����¼��ʱ������)
	 id:��¼ID
	 
	**********************************/
	ClearFV : function(){
		var t = this;
		if(this.tc.headrows){
			var ti = t.tc.tableitems;
			T.each(ti,function(p,i){
				T.each(p.kinditemts,function(o,j){
					o.fieldvalue = ""
				})
			})
		}else{
			T.each(t.tc.tableitems,function(o,j){
				o.fieldvalue = ""
			});
		};
	},
	/**********************************
	 ����У���ˢ���������
	 NewAddRow
	 data:[{id:,cell:[{}]}]
	 limitfield:�������ظ�ֵ���ֶΣ����ظ������ӣ���Ϊ�վ������ظ�
	 
	**********************************/
	NAR : function(data,limitfield){
		var t = this;
		var oData = this.GridData||{"page":1,"total":0,"rows": []};
		var _oData = oData.rows;
		if(typeof(data)!="object"){alert("�����ݸ�ʽ����");return};
		var compare = function(limitValue){
			if(limitValue==false){return true};
			var flag = true;
			for (var m = 0;m<_oData.length;m++){
				if(limitValue==t.GD(_oData[m].id,limitfield)){
					flag = false;
					break
				};
			};
			return flag
		};
		if(oData.rows!=""){
			for(var i=0;i<data.length;i++){
				if(!limitfield||compare(data[i].cell[t.GFI(limitfield)],limitfield)){
					oData.rows.unshift(data[i]);
					oData.total += 1;
				}
			};
		}else{
			for(var i=0;i<data.length;i++){
				oData.rows.unshift(data[i]);
				oData.total += 1;
			};
		};
		var dorign = this.tc.dataorign;
		this.M({hotdata:oData,dataorign:1},"",this.tc.cpage);
		this.tc.dataorign=dorign;
	},
	/**********************************
	
	 ���ñ��޸����ݼ���(SetModifyData)
	 row ���޸ĵĵ������ݶ���{"id":"2","cell":["2","80121632","����2"]}
	 type ��������(add/mod/del)
	 recover true/false �Ƿ��Ǹ�ԭ
	 	 
	**********************************/
	SM : function(row,type,recover){
		if(typeof(row)!="object" || typeof(type)!= "string")return;
		var recover = recover||false;
		var tM = this.ModifyData;
		var tMrowType = "";
		for(var i=0;i<tM.rows.length;i++){
			if(tM.rows[i].id == row.id){
				tMrowType = tM.rows[i].type;
				tM.rows.splice(i,1);
				tM.total -= 1;
				break;
			}
		};
		if(!recover&&tMrowType!="del"){
			row.type = type;
			tM.rows.push(row);
			tM.total += 1;
		}
	},
	/**********************************
	
	 ���µ�Ԫ��ֵ(updateCellData)
	 	 
	**********************************/
	UCD: function(rid,fieldname,value) {
		var value = value?value:"";
		var cellObj = T("#"+this.tc.tablename+"_"+fieldname+"_"+rid+"_td")?T("#"+this.tc.tablename+"_"+fieldname+"_"+rid+"_td"):null;
		if(cellObj==null)return;
		cellObj.getElementsByTagName("div")[0].innerHTML = value;
    },
	/**********************************
	
	 ����rid��ȡ��Ԫ�����ʾֵ(GetCellValue)�������ݿ��е�ֵ
	 	 
	**********************************/
	GCV: function(rid,fieldname) {
		if(!rid)return;
		var cellObj = T("#"+this.tc.tablename+"_"+fieldname+"_"+rid+"_td")?T("#"+this.tc.tablename+"_"+fieldname+"_"+rid+"_td"):null;
		if(cellObj==null)return;
		return cellObj.getElementsByTagName("div")[0].innerHTML;
    }
};

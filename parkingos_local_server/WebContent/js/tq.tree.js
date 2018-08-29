/*TQtree
  LatestVersion 2012-10-31 by FT
*/
var Ttree = function(o){new TQTree(o).C()};
TQTree = function(o){
/*������*/
	this.tc = T.extend({
		Path:"images/tree/",//��Դ�ļ�·��
		treeid:"TQtree",//Ψһ��ʶ�������ظ�
		treename:"���ڵ�",//���ڵ�����
		treeObj:null,//����������
		dataUrl:"../tree/demodata.txt",//���������ַ
		method:"get",//��������ʽ
		params:"",//�������
		datatype:1,//1��ʾԶ�̶�ȡ,0��ʾ��������
		treedata:null,
		treeitems:null,
		nodeAddUrl:null,
		nodeEdiUrl:null,
		nodeRemUrl:null,
		rootClick:null,
		allopen:false,//Ĭ���Ƿ�չ��
		nodeClick:null,//�ڵ����¼�
		addnode:false,//�Ƿ���ʾ��ӽڵ㰴ť
		editnode:false,//�Ƿ���ʾ�༭�ڵ㰴ť
		removenode:false,//�Ƿ���ʾɾ���ڵ㰴ť
		actions:null,//[{}],�Զ���ڵ����
		icon:true,//�Ƿ���ʾͼ��
		check:false,//�Ƿ�ѡ��
		checkchild:false,//�Ƿ����ѡ������Ŀ
		checkparent:false,//�Ƿ����ѡ����Ŀ
		loadfun:false,
		repeatname:false
	},o);
};

TQTree.prototype = {
	selectedId:"",//��ѡ��id
	/**********************************
	
	 һЩ��������(BaseAttr)
	 	 
	**********************************/
	B : {
		thisT:this,
		newP : function(p,t){//������Բ���
			var l = t.tc;
			t.tc = null;
			t.tc = T.extend(l,p);
			l = null;
		}
	},
	TreeData:null,
	/**********************************
	
	 ������(Createtree)
	 
	**********************************/
	C:function(p,t){
		if(p){
			this.B.newP(p,this)
		};
		if(!this.tc.treeObj){T.loadTip(1,"TREEȱ�ٲ���",2);return}
		var t = this;
		var tc = this.tc;
		var treeObj = tc.treeObj;
		
		var callback = function(data){
			if(tc.loadfun){tc.loadfun()};
			t.TreeData = data;
			//var date1=new Date();
			t.M(data,treeObj);
			//var testdate = new Date()-date1;
			//alert("��ʱ"+testdate+"����")
		};
		if(tc.datatype==1){
			if(this.tc.method.toUpperCase()=="POST"){
				T.A.sendData(this.tc.dataUrl,"POST",params+"&page="+cp+"&rp="+thisT.tc.rpage+"&fieldsstr="+field_names+"&r="+Math.random(),callback,2,this.tc.treeObj);
			}else{
				var lurl = this.tc.dataUrl;
				var params = this.tc.params;
				lurl = lurl.indexOf("?")!=-1?lurl+"&":lurl+"?";
				T.A.sendData(lurl+params+"&r="+Math.random(),"GET","",callback,2,this.tc.treeObj);
			}
		};
		if(tc.datatype==0){
			callback(tc.treedata)
		};
	},
	
	M: function(data, pObj ,id ,isp,isopn) {
		var t = this;
		var id = id||0;
		var _isp = false;
		var isopn = id==0?true:isopn;
		isopn = this.tc.allopen?true:isopn;
		var ul = document.createElement("ul");
		uclassName = id==0?"":"line";
		ul.style.display = isopn?"block":"none";
		ul.className = uclassName;
		ul.id = this.tc.treeid + "_" + id + "_ul";
		if(id==0){
			var rootul = document.createElement("ul");
			rootul.className = "tqtree";
			rootul.id = this.tc.treeid + "_treeroot_ul";
			var rootli = document.createElement("li");
			rootli.id = this.tc.treeid + "_0_li";
			rootul.appendChild(rootli);
			rootli.appendChild(ul);
			t.MnodeSwitch(rootli,0,true,true,rootli);//�ڵ�״̬
			t.tc.check?t.MnodeCheck(rootli,0,false):"";//ѡ��״̬
			t.MnodeMainActions(rootli,0,this.tc.treename,"","");
			pObj.appendChild(rootul);
			pObj = rootli;
			//t.SetSelClass(root.id,true);
		};
		for (var i = 0;i<data.length;i++){
			if(data[i].pid == id){
				_isp = true;
				var li = document.createElement("li");
				li.id = this.tc.treeid +"_"+data[i].id+"_li";
				li.setAttribute("treepid",id);
				
				this.MnodeSwitch(li,data[i].id,isp,data[i].open,pObj);//�ڵ�״̬
				this.tc.check?this.MnodeCheck(li,data[i].id,data[i].checked):"";//ѡ��״̬
				this.MnodeMainActions(li,data[i].id,data[i].name,data[i].icon,data[i].fn);//�ڵ����Ʋ�����
				ul.appendChild(li);
				
				this.M(data,li,data[i].id,_isp,data[i].open)
			};
		};
		
		if(_isp){
			pObj.appendChild(ul);
			//�����ڵ�λ��״̬���ǲ������һ����
			if(ul.childNodes[ul.childNodes.length-1].firstChild.getAttribute("swhstat")==null){
				ul.childNodes[ul.childNodes.length-1].firstChild.className = "treebutton switch bottom_docu";
			}else{
				ul.childNodes[ul.childNodes.length-1].firstChild.className = "treebutton switch bottom_open"
				//ul.className = ul.className=="tqtree"?"tqtree":""
			};
		}
		
	},
	MnodeSwitch:function(obj,_id,isp,opn,pObj){
		var t = this;
		var sclass = _id==0?"treebutton switch center_open":"treebutton switch center_docu";
		//sclass += isp?(opn?" root_open":" center_close"):" center_docu";
		
		var id = this.tc.treeid +"_"+_id+"_switch";
		var span = document.createElement("span");
		span.id = id;
		span.className = sclass;
		obj.appendChild(span);
		
		//���ڵ�
		if(_id==0){
			span.className = "treebutton switch root_open";
			span.onclick = function(){
				if(T(this.parentNode).gtag("ul")[0].style.display=="none"){
					T(this.parentNode).gtag("ul")[0].style.display = "block";
					this.className = "treebutton switch root_open";
					this.setAttribute("opnstat",true);
				}else{
					T(this.parentNode).gtag("ul")[0].style.display = "none";
					this.className = "treebutton switch root_close";
					this.setAttribute("opnstat",false);
				};
			};
			span.setAttribute("swhstat",isp||false);
			span.setAttribute("opnstat",opn||false);
			return
		};
		
		//���ø��ڵ�
		opn = this.tc.allopen?true:opn;
		if(isp){
			pObj.firstChild.className = "treebutton switch center_open";
			pObj.firstChild.onclick = function(){
				if(T(this.parentNode).gtag("ul")[0].style.display=="none"){
					T(this.parentNode).gtag("ul")[0].style.display = "block";
					this.className = "treebutton switch center_open";
					this.setAttribute("opnstat",true);
				}else{
					T(this.parentNode).gtag("ul")[0].style.display = "none";
					this.className = "treebutton switch center_close";
					this.setAttribute("opnstat",false);
				};
			};
			pObj.firstChild.setAttribute("swhstat",isp||false);
			pObj.firstChild.setAttribute("opnstat",opn||false);
		}else{
			//pObj.firstChild.className = "treebutton switch bottom_docu";
		};
	},
	MnodeCheck:function(obj,id,chkd){
		var t = this;
		var cclass = "treebutton chk";
		cclass += chkd?" checkbox_true_full":" checkbox_false_full";
		//id = id=="treeroot"?0:id;
		var id = this.tc.treeid +"_"+id+"_check";
		var span = document.createElement("span");
		span.id = id;
		span.className = cclass;
		span.setAttribute("chkstat",chkd||false);
		span.onclick = function(){t.SetCheck(this.id)}
		obj.appendChild(span)
	},
	MnodeMainActions:function(obj,oid,name,icon,fn){
		var t = this;
		var id = this.tc.treeid +"_"+oid+"_a";
		var ahtml = [];
		var iclass = this.tc.icon?"treebutton":""
		var istyle = icon?"background:url("+icon+")":"";
		iclass += icon?"":" ico_open";
		var a = document.createElement("a");
		a.id = id;
		
		ahtml.push("<span id=\""+this.tc.treeid+"_"+oid+"_ico\" class=\""+iclass+"\" style=\""+istyle+"\"><\/span>");
		ahtml.push("<span id=\""+this.tc.treeid+"_"+oid+"_name\">"+name+"<\/span>");
		a.innerHTML = ahtml.join("");
		obj.appendChild(a);
		
		if(oid!=0){
			var addspan = document.createElement("span");
			addspan.className = "treebutton add";
			addspan.setAttribute("title","��ӷ���");
			addspan.onclick = function(){T.cancelBub();t.AddNode(this.id)};
			
			var edispan = document.createElement("span");
			edispan.className = "treebutton edit";
			edispan.setAttribute("title","�༭");
			edispan.onclick = function(){T.cancelBub();t.EdiNode(this.id)};
			
			var remspan = document.createElement("span");
			remspan.className = "treebutton remove";
			remspan.setAttribute("title","ɾ��");
			remspan.onclick = function(){T.cancelBub();t.RemNode(this.id)};
			
			T.bind(a,"click",function(){
				t.SetSelClass(a.id,true);
				if(t.tc.addnode){
					addspan.id = t.tc.treeid +"_"+oid+"_add";
					t.SetNodeAct(a.id,addspan)
				};
				if(t.tc.editnode){
					edispan.id = t.tc.treeid +"_"+oid+"_edi";
					t.SetNodeAct(a.id,edispan)
				};
				if(t.tc.removenode){
					remspan.id = t.tc.treeid +"_"+oid+"_rem";
					t.SetNodeAct(a.id,remspan)
				};
			});		
			if(fn){
				T.bind(a,"click",function(){
					fn(oid,name);
				})
			};
			if(t.tc.nodeClick){
				T.bind(a,"click",function(){
					t.selectedId = oid;
					t.tc.nodeClick(oid,name);
				})
			};
		}else{
			
			if(t.tc.addnode){
				var addspan = document.createElement("span");
				addspan.className = "treebutton add";
				addspan.setAttribute("title","��ӷ���");
				addspan.onclick = function(){T.cancelBub();t.AddNode(this.id)};
				
				var _addspan = document.createElement("span");
				_addspan.setAttribute("title","��ӷ���");
				_addspan.style.fontWeight = "normal";
				_addspan.style.color = "#009";
				_addspan.innerHTML = "��ӷ���"
				_addspan.onclick = function(){T.cancelBub();t.AddNode(this.id)};
				
				addspan.id = t.tc.treeid +"_"+oid+"_add";
				_addspan.id = t.tc.treeid +"_"+oid+"_addtip";
				
				a.appendChild(addspan);
				a.appendChild(_addspan)

			};
			T.bind(a,"click",function(){
				t.SetSelClass(a.id,true);
			});	
			if(t.tc.rootClick){
				T.bind(a,"click",function(){
					t.selectedId = oid;
					t.tc.rootClick(oid,name);
				})
			};
		}
	},
	SetCheck:function(id){
		var t = this;
		var data = this.TreeData;
		var rid =id.split("_")[id.split("_").length-2];
		//rid = rid=="treeroot"?0:rid;
		var cclass = "treebutton chk";
		var chkd = T(id).attr("chkstat");
		cclass += chkd=="true"?" checkbox_false_full":" checkbox_true_full";
		T(id).acls(cclass);
		_chkd = chkd=="true"?"false":"true";
		T(id).attr("chkstat",_chkd);
		t.tc.checkchild?t.SetChildCheck(rid,chkd):"";
		t.tc.checkparent?t.SetParentCheck(T("#"+id).parentNode.parentNode):"";
	},
	SetChildCheck:function(rid,chkd){
		var t = this;
		var data = this.TreeData;
		for(var i = 0;i<data.length;i++){
			if(data[i].pid == rid){
				T(t.tc.treeid +"_"+data[i].id+"_check").attr("chkstat",chkd);
				t.SetCheck(t.tc.treeid +"_"+data[i].id+"_check");
			};
		};
	},
	SetParentCheck:function(pulobj){
		var t = this;
		var pid =pulobj.id.split("_")[pulobj.id.split("_").length-2];
		//pid = pid=="treeroot"?0:pid;
		var pobj = pid!="treeroot"?T("#"+this.tc.treeid+"_"+pid+"_check"):null;
		var pobj = T("#"+this.tc.treeid+"_"+pid+"_check");
		var data = this.TreeData;
		var flag = 0;
		var tflag = 0;
		var tpart = 0;
		for(var i = 0;i<data.length;i++){
			if(data[i].pid == pid){
				if(T(t.tc.treeid +"_"+data[i].id+"_check").attr("chkstat")=="false"){
					flag +=1;
				};
				if(T(t.tc.treeid +"_"+data[i].id+"_check").attr("chkstat")=="part"){
					tpart +=1;
				};
				tflag += 1;
			};
		};
		if(pobj!=null){
			var nclass;
			if(flag==tflag){
				nclass = "treebutton chk checkbox_false_full";
				T(pobj.id).attr("chkstat","false");
			};
			if(tflag>flag){
				nclass = "treebutton chk checkbox_true_part";
				T(pobj.id).attr("chkstat","part");
			};
			if(flag==0){
				nclass = "treebutton chk checkbox_true_full";
				T(pobj.id).attr("chkstat","true");
			};
			if(tpart>0){
				nclass = "treebutton chk checkbox_true_part";
				T(pobj.id).attr("chkstat","part");
			};
			pobj.className = nclass;
			this.SetParentCheck(pobj.parentNode.parentNode)
		}
		
	},
	SetSelClass:function(id,sel){
		var cclass = "";
		cclass += sel?"curSelectedNode":"";
		if(!T(this.tc.treeid + "_treeroot_ul")){return;}
		var doms = T(this.tc.treeid + "_treeroot_ul").gtag("a");
		for(var m = 0 ;m<doms.length;m++){
			doms[m].id == id ?T(doms[m].id).acls(cclass):T(doms[m].id).acls("");
			if(doms[m].id != id){
				if(doms[m].id!=this.tc.treeid+"_0_a"){
					var _doms = T("#"+doms[m].id).childNodes;
					for(var n = 0 ;n<_doms.length;n++){
						if(n>1){
							_doms[n].parentNode.removeChild(_doms[n]); 
							n = n-1;
						}
					}
				};
			};
		};
	},
	SetNodeAct:function(objid,aobj){
		T("#"+objid).appendChild(aobj)
	},
	AddNode:function(id){
		var t = this;
		var id = id.split("_")[id.split("_").length-2];
		var url = this.tc.nodeAddUrl;
		T.each(t.tc.treeitems,function(o,j){
			o.fieldvalue = o.fieldname=="pid"?(id!=0?id:""):""
		});
		Twin({Id:"add_cnode_win",Title:"��ӷ���", Width: 500,Height: "auto",sysfunI:id,sysfun:function(id,tObj){
			Tform({
				formname: "tree_node_form",
				formObj:tObj,
				dbuttons:true,
				suburl:url,
				formtip:"<div class=\"formtip\" style=\"width:471px\">���±�<b><�����></b>Ϊ��ʱ,�򱣴�Ϊһ�����ࡣ</div>",
				method:"POST",
				Callback:function(f,rcd,ret,o){
					if(ret=='1'||ret.indexOf('success')!=-1){
						T.loadTip(1,"��ӳɹ���","2",t.tc.treeObj);
						//t.AddNodes(id,Serializ("tree_node_form"));
						TwinC("add_cnode_win");
						var thistree = T("#"+t.tc.treeid+"_treeroot_ul")
						t.tc.treeObj.removeChild(thistree);
						t.C();
					}
				},
				subFun:function(f){
					var name = T("#"+f+"_name")?T("#"+f+"_name").value:false;
					
					if(name){
						var hasname = t.GFieldByName(name);
						if(hasname){T.loadTip(1,"�����Ѵ���!��������д",2)}
						return !hasname;
					};
					return true
				},
				formAttr:[{
					formitems:[{kindname:"",kinditemts:t.tc.treeitems}],
					rules:[{name:'name',type:'',url:'',requir:true,warn:'',okmsg:''}]
				}]
				});	
			 }
		})
	},
	AddNodes:function(id,data){
		alert(id)
		var pobj = T("#"+id)
		
	},
	EdiNode:function(id){
		var t = this;
		var id = id.split("_")[ id.split("_").length-2];
		var url = this.tc.nodeEdiUrl;
		T.each(t.tc.treeitems,function(o,j){
			o.fieldvalue = t.GFieldsById(id,o.fieldname);
		});
		Twin({Id:"edit_cnode_win",Title:"�༭", Width: 500,Height: "auto",sysfunI:id,sysfun:function(id,tObj){
			Tform({
				formname: "tree_node_form",
				formObj:tObj,
				dbuttons:true,
				suburl:url,
				method:"POST",
				Callback:function(f,rcd,ret,o){
					if(ret=='1'||ret.indexOf('success')!=-1){
						T.loadTip(1,"�༭�ɹ���","2",t.tc.treeObj);
						TwinC("edit_cnode_win");
						var thistree = T("#"+t.tc.treeid+"_treeroot_ul")
						t.tc.treeObj.removeChild(thistree);
						t.C();
					}
				},
				subFun:function(f){
					var name = T("#"+f+"_name")?T("#"+f+"_name").value:false;
					
					if(name){
						var hasname = t.GFieldByName(name);
						if(hasname){T.loadTip(1,"�����Ѵ���!��������д",2)}
						return !hasname;
					};
					return true
				},
				formAttr:[{
					formitems:[{kindname:"",kinditemts:t.tc.treeitems}],
					rules:[{name:'name',type:'',url:'',requir:true,warn:'',okmsg:''}]
				}]
				});	
			 }
		})
	},
	RemNode:function(id){
		var t = this;
		var id = id.split("_")[ id.split("_").length-2];
		var url = this.tc.nodeRemUrl;
		var treeId = this.tc.treeid;
		if(treeId == "productTree"){
			deleteProductTreeNode(t, id, url);
		}else{
			Tconfirm({
				Title:"������Ϣ!",
				Ttype:"alert",
				Content:"ȷ��Ҫɾ����?",
				OKFn:function(){
				T.A.sendData(url+id+"&r="+Math.random(),"GET","",
					function(ret){
						if(ret=="1"){
							T.loadTip(1,"ɾ���ɹ���",2,t.tc.treeObj);
							var thistree = T("#"+t.tc.treeid+"_treeroot_ul")
							t.tc.treeObj.removeChild(thistree);
							t.C();
						}else if(ret=="-1"){//����������ã�����ɾ��
							T.loadTip(1,"ɾ��ʧ�ܣ�����������������ɾ�������",2,t.tc.treeObj);
						}else{
							T.loadTip(1,"����ʧ�ܣ������ԣ�",2,t.tc.treeObj)
						}
					},0,t.tc.treeObj)
				}})
		}
	},
	GetChilds:function(pid){
		var data = this.TreeData;
		var ids = "";
		for(var i=0;i<data.length;i++){
			if(data[i].pid == pid){
				ids += data[i].id+","+this.GetChilds(data[i].id);
			}
		};
		return ids
	},
	GetChild:function(pid){
		var ids = this.GetChilds(pid);
		ids = ids.substring(0,ids.length-1)
		return ids
	},
	GFieldsById : function(tid,col){
		var data;
		if(this.TreeData){
			data = this.TreeData
		}else{
			return false
		};
		for (var i=0;i<data.length;i++)
		{
			if(tid == data[i].id){
				if(col){
					return data[i][col]
				}else{
					return data[i]
				};
				break;
			}
		}
	},
	GFieldByName:function(name){
		var _item = this.TreeData;
		var result=false; 
		for (var i = 0,j=_item.length;i<j;i++){
			if(name ==_item[i].name){
				result = _item[i];
				break
			};
		};
		return result
	}
}
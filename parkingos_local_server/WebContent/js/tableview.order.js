/*Block Fucntion 2012-05-25 By Ft
*/
var _clientF = new TQForm({
	formname:"tableview_edit_f",
	fit:[true,true,true],
	dbuttons:true,
	suburl:"taleview.do?action=edit",
	method:"POST",
	Callback:
	function(f,rcd,ret,o){
		if(ret=="1"){
			T.loadTip(1,"����ɹ���",2,"")
			_clientT.M()
		}else{
			T.loadTip(1,"����ʧ�ܣ������ԣ�",2,o)
		}
	}
});	

/*==============================

  �ͻ��б�

==============================*/
var _clientT = new TQTable({
	tabletitle:"�ҵ�ģ��",
	tablename:"tableview_tables",
	dataUrl:"tableviewOrder.do",
	iscookcol:false,
	operatewidth:160,
	param:"action=quickquery&type=myclient",
	fit:[true,true,true],
	beginfun:function(){
		T.pageCover(1,layoutL_M,"#fff");
		T.pageCover(1,layoutL_B_B,"#fff")
	},
	loadfun:function(t,d){
		T.pageCover(0,layoutL_M);
		T.pageCover(0,layoutL_B_B);
		if(!d||d=="gotologin"||typeof(d)!="object"){return};
		if(parseInt(d.total)<1){return};
		T.each(_clientT.tc.tableitems,function(o,j){
			o.fieldvalue = _clientT.GD(d.rows[0].id,o.fieldname);
		});
	},isoperate:getAuthOperator(),
	tableitems:getCleintFields[0].kinditemts,
	buttons :eval(getAuthButtons())
});

function getAuthOperator() {
	var o = [];
	if(auth_edit) {
		o.push({name:"�༭",fun:function(id){
					T.each(_clientT.tc.tableitems,function(o,j){
						o.fieldvalue = _clientT.GD(id,o.fieldname)
					});
					Twin({Id:"bill_page_edit_w"+id,Title:"�༭",Width:750,sysfunI:id,sysfun:function(id,tObj){
							Tform({
								formname: "billpage_edit_f",
								formObj:tObj,
								recordid:"id",
								suburl:"tableviewOrder.do?action=edit&id="+id+"&tud_id="+tud_id,
								method:"POST",
								formAttr:[{
									formitems:[{kindname:"",kinditemts:_clientT.tc.tableitems}]
								}],
								buttons : [//����
									{name: "cancel", dname: "ȡ��", tit:"ȡ����Ӹ�����ע",icon:"cancel.gif", onpress:function(){TwinC("bill_page_edit_w"+id);} }
								],
								Callback:
								function(f,rcd,ret,o){
									if(ret=="1"){
										T.loadTip(1,"����ɹ���",2,"");
										TwinC("bill_page_edit_w"+id);
										_clientT.M("","",_clientT.tc.cpage);
										
									}else{
										T.loadTip(1,"����ʧ�ܣ������ԣ�",2,o)
									}
								}
							});	
						}
					})
				}});
				
		o.push({name:"�ֶ�����",fun:function(id){
					T.each(_clientT.tc.tableitems,function(o,j){
						o.fieldvalue = _clientT.GD(id,o.fieldname)
					});
					Twin({
						Id:"bill_colnum_edit_w"+id,
						Title:"�ֶ�����",
						Width:T.gww()-20,
						Height:T.gwh()-20,
						Drag:false,
						CloseFn:function(){T("#alllayout").style.display = "block";},
						Content:"<iframe src=\"tableUiSet.do?action=preupdate&id="+id+"&tud_id="+tud_id+"&tudidname=&rand="+Math.random()+"\" style=\"width:100%;height:100%\" frameborder=\"0\"></iframe>"
					})
				}});
	}
	return o;
}

function toolbarItem(name){
	dataTypeSelect(name)
};
function dataTypeSelect(name){
	if(_clientT.GridData==null||_clientT.GridData=='err'){T.loadTip(1,"û������,���ɽ��д˲�����",2,_clientT.tc.tableObj);return};
	var v = "0";
	var isedit = true;
	var sysfunI = "0";
	var h= 165;
	_clientT.GS(0)?sysfunI = _clientT.GS():(v="1",isedit=false);
	Twin({Id:"export_win",Title:"ɾ������ģ��",Width:350,Height:h,sysfunI:sysfunI,sysfun:function(ids,tObj){
			Tform({
				formname: "opconfirm",
				formObj:tObj,
				dbuttons:false,
				suburl:"tableviewOrder.do?action=export",
				method:"POST",
				formAttr:[{
					formitems:[{kindname:"",kinditemts:getSelectItems(name,v,isedit,_clientT.GS(0),_clientT.GCI())}]
				}],
				buttons : [//����
					{name: "daochu", dname: "ȷ��Ҫɾ��", tit:"���ȷ��ɾ������",icon:"delete.png", onpress:function(n,fn,fobj,url){
							T.each(document.forms["opconfirm"]["seldatattype"],function(o,j){
								if(o.checked==true){
									infotype = o.value;
									return
								}
							});
							var info;
							if(infotype=="0"){
								info = "���\"<b>"+_clientT.GS()+"</b>\"��ģ��";
							}else if(infotype=="1"){
								info = "<b>��ҳ����</b>"
							}else{
								info = "<b>ȫ������(��ǰ������)</b>"
							};
							Tconfirm({
								Title:function(){return "������Ϣ!"}(),
								Ttype:function(){return "alert"}(),
								Content:"ȷ��Ҫɾ��"+info+"��?<br><b style=\"color:#c00\">"+function(){return "����ɾ�����޷��ָ�!"}()+"</b>",
								OKFn:function(){
								T.A.sendData("tableviewOrder.do?action=delete","POST",Serializ(fn).substring(0,Serializ(fn).length-1),
									function(ret){
										if(ret=="1"){
											T.loadTip(1,"ɾ���ɹ���",2,"");
											_clientT.B.CheckSave(_clientT).value = "";
											_clientT.B.Allbox(_clientT).checked = false;
											_clientT.M("","",_clientT.tc.cpage);
											TwinC("export_win");
										}else{
											T.loadTip(1,"����ʧ�ܣ������ԣ�",2,tObj)
										}
									},0,tObj)
								},
								Coverobj:tObj.parentNode
							});
						}
					},
					{name: "cancel", dname: "ȡ��", icon:"cancel.gif", onpress:function(){TwinC("export_win")} }
				]
			});	
		}
	})
}
function getSelectItems(name,v,isedit,ids,allids){
	return [{fieldname:"seldatattype",fieldcnname:"",inputtype:"radio",fieldvalue:[v],noList:[{value_name:"ɾ��ѡ������",value_no:"0"}],width:"210",height:"90",colSpan:2,edit:isedit},
		{fieldname:"seldatattype",fieldcnname:"",inputtype:"radio",fieldvalue:[v],noList:[{value_name:"ɾ����ҳ����",value_no:"1"}],width:"210",height:"90",colSpan:2},
		//{fieldname:"seldatattype",fieldcnname:"",inputtype:"radio",fieldvalue:[v],noList:[{value_name:"ɾ��ȫ������(��ǰ������)",value_no:"2"}],width:"210",height:"90",colSpan:2},
		{fieldname:"selids",fieldcnname:"��ѡID",inputtype:"text",fieldvalue:ids,width:"210",height:"",colSpan:2,hide:true},
		{fieldname:"pageids",fieldcnname:"��ǰҳ����ID",inputtype:"text",fieldvalue:allids,width:"210",height:"",colSpan:2,hide:true}];
}
function clientT(obj){
	//CclientM();//�����������˵�
	CclientS();//��������
	//CclientD();//�������ݷ���
	CTableViewD();
};

function CclientS(){//��������
	var auth_ct =(auth_add)?"":" disabled=true title='��û��Ȩ��'";
	var Cevent = (auth_add)?"CreateBillModel('tableviewOrder.do?action=create')": "return false;";
	var mHtml = "";
	mHtml += "<form name=\"ssform\" action=\"\">";
	mHtml += "<div style=\"width:100%;height:29px;float:left;margin-top:7px;*margin-top:14px;_margin-top:7px;overflow:hidden;\">";
	mHtml += "<div style=\"margin-left:5px;height:35px;padding:0px;overflow:hidden;width:100%;white-space:nowrap\" title=\"��ѡ�����ʱ,����������Ȩ�޷�Χ�ڵ����й���,�����ͻ��������վ��\" >";
	//mHtml += " ����ģ��";
	mHtml += "<div onclick=\""+Cevent+"\" style='margin:5 auto;' onmouseover=\"T('#add_tableview_bt').className='button_lh';T('#add_tableview_btr').className='button_rh'\" onmouseout=\"T('#add_tableview_bt').className='button_l';T('#add_tableview_btr').className='button_r'\">";
	mHtml += "<div class=\"button_l\" style=\"width:88px;height:50px;margin-left:60px;\" title=\"�½�����ģ��\" id=\"add_tableview_bt\">";
	mHtml += "<span class=\"icon_add_c\" style=\"padding-left:10px\" "+auth_ct+">�½�����ģ��</span></div>";
	mHtml += "<div class=\"button_r\" id=\"add_tableview_btr\" style=\"width:5px\"></div></div>";
	mHtml += "</div>";
	mHtml +="</div>";
	mHtml += "</div>";
	mHtml += "<div style=\"width:100%;float:left;top:25px;margin-top:15px;\">";
	mHtml += "<div class=\"searchbt\" style=\"margin-left:5px;height:21px;border:1px solid #bbb;padding:0px;width:205px;overflow:hidden;\">";	
	mHtml += "<div id=\"ssearch_t\" class=\"ssearch_t\" onClick=\"show_select(\'ssearch_t\',\'ssearch_t_but\',\'t_items\',\'ssearch_type_value\',\'ssform\')\">ģ������<\/div>";
	mHtml += "<div id=\"ssearch_t_but\" class=\"ssearch_t_but\" onClick=\"show_select(\'ssearch_t\',\'ssearch_t_but\',\'t_items\',\'ssearch_type_value\',\'ssform\')\"><\/div>";
	mHtml += "<input type=\"hidden\" id=\"ssearch_type_value\" name=\"colname\" value=\"name\">";
	mHtml += "<input type=\"hidden\" class=\"txt\" name=\"action\" value=\"simplequery\">";
	mHtml += "<div><input type=\"text\" title=\"˫�����\" style=\"width:90px;height:21px;padding:0px;margin:0px;border:0px;float:left\" name=\"value\" autocomplete=\"off\" ondblclick=\"this.value=''\"></div>";
	mHtml += "<div onclick=\"SimpleSearch()\" class=\"searchbt\"  style=\"float:left;vertical-align:top;margin:0px;padding:0px;padding-left:5px;border-left:1px solid #bbb;height:24px;line-height:23px;cursor:pointer;_cursor:hand;\">����</div>";
	mHtml += "</div>";	
	mHtml += "</div>";
	mHtml += "<div class=\"ssearch_div\" id=\"ssearch_button_div\">";
	mHtml += "</div>";
	mHtml += "</form>";
	layoutL_M.innerHTML = mHtml;
	var ssHtml = "";
		ssHtml += "  <div class=\"clear\"><\/div>";
		ssHtml += "  <div id=\"t_items\" class=\"t_items\" style=\"display:none\">";
		ssHtml += "    <div class=\'t_items_out\' tid=\"name\">ģ������<\/div>";
		ssHtml += "  <\/div>";
	var mmmm = document.createElement("div");
	mmmm.className = "ssearch_select";
	mmmm.innerHTML = ssHtml;
	document.body.appendChild(mmmm)
};
function SimpleSearch(title){
	var title = title?title:"";
	if(document.forms["ssform"]["value"].value == ""){
		T.loadTip(1,"����д��ѯ����",1,T("#ssearch_button_div"));
		document.forms["ssform"]["value"].focus();
		return
	};
	var range = "&tud_id="+tud_id;
	_clientT.C({
		extparam:Serializ("ssform")+range,
		tabletitle:title+">>�������"
	})
};

function CTableViewD(){//
	layoutL_B_T.innerHTML = "<span style=\"clear:both;padding-left:10px;float:left;\">��ͼ����</span>";
	layoutL_B_B.innerHTML = ""
	var menucount = T.A.sendData("tableviewOrder.do?action=loadcount&tud_id="+tud_id+"&rand="+Math.random());
	var mc = menucount.split(',')
	var bLD  ={
			"root_10":{"id":1,"type":"root","name":"���÷���",cktp:false,ckd:false,"pid":0,icon:"root"}, 
			"10_55":{"id":55,"type":"trunk","name":"ȫ��ģ��","pid":10,cktp:false,ckd:false,"mtype":"all","tud_id":tud_id,"tip":mc[0]}, 
			"55_552":{"id":552,"name":"�༭ģ��","pid":55,"mtype":"edit","tud_id":tud_id,"tip":mc[1]},
			"55_553":{"id":553,"name":"��ѯģ��","pid":55,"mtype":"search","tud_id":tud_id,"tip":mc[2]}
		};
	
	tableViewTree = new tqTree({ treeId:"tableViewTree", dataType:0, 
		localData:bLD,
		treeObj:layoutL_B_B,
		focusExec:true, 
		nodeFnArgs:"id,name,mtype,tud_id,tip", 
		nodeClick:function(){
			var args = arguments;
			if(args[0]==1){return}
			_clientT.C({tableObj:layoutR_M,extparam:"action=query&type="+args[2]+"&tud_id="+args[3]+"&total="+args[4]})
		},
		
		isCheck:false, 
		loadfun:function(v){
			tableViewTree.focusNode(55);
			tableViewTree.expandLevel(3);
		}})
	tableViewTree.C();
};

function CreateBillModel(url){
	if(tud_id==''){
		T.loadTip(1,"���ȴ����������Զ����ֶΣ�ϵͳ�Զ���->�������Զ���->�������Զ����ֶΣ���",10,"");
		return;
	}
		
	Twin({Id:"Createbillmodel_win",Title:"�½�ģ��",Width:"750",Height:"auto",sysfun:function(tObj){
			Tform({
				formname: "bill_add_f",
				formObj:tObj,
				recordid:"id",
				suburl:url,
				method:"POST",
				formAttr:[{
					formitems:function(){
						var a = getCleintFields;
						var items = a[0].kinditemts;
						for(var i=0;i<items.length;i++){
							items[i].fieldvalue='';
							if(items[i].fieldname=='create_time')
								items[i].fieldvalue=T.curt();
							else if(items[i].fieldname=='creator')
								items[i].fieldvalue=nickname;
							else if(items[i].fieldname=='tud_id')
								items[i].fieldvalue=tud_id;
						}
						return a;
					}()
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ��",icon:"cancel.gif", onpress:function(){TwinC("Createbillmodel_win");} }
				],
				Callback:
				function(f,rcd,ret,o){
					if(ret=="1"||ret.indexOf('success')!=-1){
						T.loadTip(1,"�½��ɹ���",2,"");
						TwinC("Createbillmodel_win");
						if(typeof(_clientT)==="object"){
							CTableViewD();
						}
					}else{
						T.loadTip(1,"�½�ʧ�ܣ������ԣ�",2,o)
					}
				}
			});	
		}
	})

};
 function selectResModel(id){
 	var fielditems = getCleintFields;
    Twin({
		//Coverobj:cobj,
        Id:"sel_R_M_w",
        Width:800,
        Height:400,
        Top:100,
        Mask:true,
		Title:"ѡ��ģ��",
		//sysfunI:cid,
    	sysfun:function(tObj){
            var _SclientT = new TQTable({
            	tableObj:tObj,
				//fieldorder:fielditems.searchSort[0].sort.toString(),
    			checktype:"radio",
            	tablename:"_R_M_search_t",
				trclickfun:true,
				dataUrl:"tableviewOrder.do",
            	param:"action=query4select&tud_id="+tud_id+"&id="+id+"&rand="+Math.random(),
    			buttons:[{
    				name: "ok",
    				dname: "ȷ��ѡ��",
    				icon: "ok.gif",
    				tit:"ȷ��ѡ��",
    				onpress:function(){
        				if(_SclientT.GS()){
        					//alert(_SclientT.GS(1));
    						var res =T.A.sendData("tableviewOrder.do?action=setresmodel&id="+id+"&resid="+_SclientT.GS(1)+"&rand="+Math.random());
    						if(res=='1'){
    							T.loadTip(1,"�󶨳ɹ���",2,"");
    							TwinC("sel_R_M_w");
    							_clientT.M();
    						}
        				};
    				
    				}
    			},{
    				name: "cancel",
    				dname: "ȡ��",
    				icon: "cancel.gif",
    				tit:"ȡ��ѡ��",
    				onpress:function(){
    					TwinC("sel_R_M_w");
    				}
    			}
				],
			tableitems:fielditems[0].kinditemts
        	});
			_SclientT.C()
   		}
 	})
 }


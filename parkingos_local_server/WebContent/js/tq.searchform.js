/*TQform 2012-04-05
 Latest:2012-07-07
*/
var userCode;
var TSform = function(o){new TQSForm(o)};
TQSForm = function(o){
/*������*/
	this.tc = T.extend({
			Path:"images/form/",
			formtitle:false,
			formFunId:null,
			formWinId:"tq_supper_search_win",
			formpower:true,
			showCon:false,//��ʾ����
			colSpan:2,//�ֶ�ռ������
			url:"",
			fieldorder:null,
			fit:[false],
			suburl:"",
			updataurl:"",
			dbuttons:true,
			dbuttonname:["����","����"],
			method:"POST",
			action:"",
			recordid:null,
			formAttr:[{}],
			formtip:"",
			formtipbt:"",
			Callback:false,
			Css:false,
			C50Pct:"half",
			C100Pct:"whole",
			nmCls:"l",
			cnCls:"r",
	        isEscape:true,
			isArray:true,
			islisten:1,
			SubAction:false
		},o);
	
	if(this.tc.url){T.extend(this.tc.formAttr[0],{formitems:eval("["+T.A.sendData(this.tc.url)+"]")})};
	this.C();
};

TQSForm.prototype = {
/*������C*/
	C : function(){
		var t = this;
		var tc = this.tc;
		var FNM= tc.formname;
		var formObj = tc.formObj;
		formObj.innerHTML = "";
		if(T("#"+FNM)){tc.islisten=0};
	
		var formdiv = document.createElement("form");//������
		var formtit = document.createElement("div");//����������
		var formbt = document.createElement("div");//�������߰�ť
		var inputdiv = document.createElement("div");//����������
		
		inputdiv.className = "tqForm";
		inputdiv.id = FNM + "_input_div";
		formbt.className = "formbutton";
		
		//try{formObj.style.visibility = "hidden";}catch(e){};

		if(tc.formAttr[0].formitems){
			if(tc.fieldorder){
				var fieldorder = tc.fieldorder.split(",");
				var colItems = tc.formAttr[0].formitems[0].kinditemts.concat();
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
				tc.formAttr[0].formitems[0].kinditemts = newItems;
				colItems = null
			};
			
			if(tc.otherformAttr){
				//var formattrLength = tc.formAttr[0].formitems.length;
				var kinditemtsLength = tc.formAttr[0].formitems[0].kinditemts.length;
				for(var of=0;of<tc.otherformAttr[0].kinditemts.length;of++){
					++kinditemtsLength;
					tc.formAttr[0].formitems[0].kinditemts[kinditemtsLength-1]=tc.otherformAttr[0].kinditemts[of];
				}
				//T.extend(tc.formAttr[0].formitems,tc.otherformAttr)
			}
			//������
			formdiv.name = FNM;
			formdiv.setAttribute("name",FNM);
			formdiv.id = FNM;
			formdiv.action = tc.action;
			//����������
			if(tc.formtitle)
			{
			formtit.className = "formtitle";
			formtit.innerHTML = "<span style='padding-left:5px;'>"+tc.formtitle+"</span>";
			formdiv.appendChild(formtit);
			};
			
			if(tc.formpower){//��Ȩ��
				//�������߰�ť
				if(tc.dbuttons){
					if(tc.dbuttonname[0]){
						var a = document.createElement("span");
						a.id = FNM+"_sub";
						a.className = "button24_a bg_gray_hover border_gray fl";
						a.style.marginLeft = "5px";
						a.href = "javascript:void(0)";
						a.innerHTML = "<span class=\"icon16 icon16search1 fl\"><\/span>"+tc.dbuttonname[0]+"";
						a.onclick = (tc.Callback)?function(){t.TCSubimtForm(tc.Callback,FNM,tc.suburl,tc.method,tc.recordid)}:function(){t.TCSubimtForm(t.TCFormBack,FNM,tc.suburl,tc.method,tc.recordid);};
						formbt.appendChild(a);
					};
					if(tc.dbuttonname[1]){
						var b = document.createElement("span");
						b.className = "button24_a bg_gray_hover border_gray fl";
						b.style.marginLeft = "5px";
						b.href = "javascript:void(0)";
						b.innerHTML = "<span class=\"icon16 icon16cancel1 fl\"><\/span>"+tc.dbuttonname[1]+"";
						b.onclick = function(){Tconfirm({Title:"��ʾ��Ϣ",Id:"formresetid",Content:"ȷ��������<br><font style='color:#c00'>�����޸ĵ����ݽ�����ԭ</font>",Catch:false,Coverobj:function(){if(formObj.id.substring(0,7) == "winbody"){return formObj.parentNode}else{return null}}(),OKFn:function(){if(tc.recordid){var hid = T(FNM+"_"+tc.recordid).val();t.C();T(FNM+"_"+tc.recordid).val(hid)}else{t.C()}}})};
						formbt.appendChild(b);
					};
				}
		
				if(tc.buttons){
					for(var n=0;n<tc.buttons.length;n++)
					{
						var a = document.createElement("a");
						a.id = "a_"+tc.buttons[n].name;
						a.href = "javascript:void(0)";
						
						a.className = tc.buttons[n].cls?tc.buttons[n].cls:"button24_a bg_gray_hover border_gray fl";
						a.style.marginLeft = "5px";
						var iconspan = tc.buttons[n].iconcls?"<span class=\""+tc.buttons[n].iconcls+"\"></span>":"";
						a.title = tc.buttons[n].tit||tc.buttons[n].dname;
						a.innerHTML = ""+iconspan+""+tc.buttons[n].dname+"";
						
						
						var tbtn = tc.buttons[n];
						a.name = tbtn.name;
						a.onpress = tbtn.onpress;
						a.onclick = (function(){
							this.onpress(this.name,tc.formname,tc.suburl,tc.updataurl,tc.method);
						});
						formbt.appendChild(a)
					};
				}
			};
			var curversion = document.createElement("div");
			curversion.id = FNM + "_curversion";
			curversion.className = "button24_a  fl hand";
			curversion.style.marginLeft = "5px";
			curversion.style.display = "none";
			//�ͻ���ѯҳ��
			if(typeof(pagetype)!='undefined'&&pagetype=='client'){
				//curversion.innerHTML = "<input id=\""+FNM+"_range\" name=\"range\" type='checkbox' value='1' /><label class=\"lbl\" for=\""+FNM+"_range\">�ڵ�ҳ��ǰ�б���ͼ������(����ѡ����Ȩ�޷�Χ��ȫ������������)</label>";
				curversion.innerHTML = "<input id=\""+FNM+"_range_0\" name=\"range\" type='radio' value='0' checked /><label class=\"lbl\" for=\""+FNM+"_range_0\">�������ͻ��غͻ���վ</label>&nbsp;" + 
				"<input id=\""+FNM+"_range_1\" name=\"range\" type='radio' value='' /><label class=\"lbl\" for=\""+FNM+"_range_1\">�����ͻ��غͻ���վ</label>&nbsp;" + 
				"<input id=\""+FNM+"_range_2\" name=\"range\" type='radio' value='1' checked='true' /><label class=\"lbl\"  for=\""+FNM+"_range_2\">ֻ�ڵ�ǰ��ͼ������</label>&nbsp;";
			}else{
				curversion.innerHTML ="<input id=\""+FNM+"_range_1\" name=\"range\" type='radio' value='' /><label class=\"lbl\" for=\""+FNM+"_range_1\">��ȫ������������</label>&nbsp;" + 
				"<input id=\""+FNM+"_range_2\" name=\"range\" type='radio' value='1' checked='true'/><label class=\"lbl\" for=\""+FNM+"_range_2\">ֻ�ڵ�ǰ��ͼ������</label>";
			}
			formbt.appendChild(curversion);
			formdiv.appendChild(formbt);
			//����չʾ��(ֻ֧��IE)
			if(T.iev&&tc.showCon){
				var conditionDiv = document.createElement("div");
				conditionDiv.id = FNM + "_conditiondiv";
				with(conditionDiv.style){
					height = "29px";
					lineHeight = "29px";
					borderBottom = "1px solid #ccc";
					background = "#f5f5f5";
					overflow = "hidden";
					float = "left";
					width = "100%";
					margin = "0";
					padding = "0";
				};
				conditionDiv.innerHTML = "<span class='fl' style='margin:0 0 0 5px;font-weight:700'>��ѯ����:</span><span class='fl' style='margin:0 0 0 5px;overflow:hidden;'>�����·�����</span>";
				formdiv.appendChild(conditionDiv);
			}
			//����ʾ
			if(tc.formtip){
				var tiptp = document.createElement("div");
				tiptp.innerHTML = tc.formtip;
				inputdiv.appendChild(tiptp);
			};
			
			for(var m=0;m<tc.formAttr[0].formitems.length;m++){
				var items = tc.formAttr[0].formitems[m].kinditemts;
					var kinddiv = document.createElement("div");
					if(tc.formAttr[0].formitems[m].kindname){
						with(kinddiv.style){
							borderBottom = "1px solid #ddd";
							marginBottom = "20px";
							paddingTop = "20px";
							fontSize = "12px";
							fontWeight = "700";
						};
						kinddiv.className = "whole";
						kinddiv.innerHTML = "&nbsp;"+tc.formAttr[0].formitems[m].kindname;
					}else{
						with(kinddiv.style){
							marginTop = "10px";
							clear = "both";
						};
						kinddiv.innerHTML = "";
					};
					inputdiv.appendChild(kinddiv);
					
					for (var i=0;i<items.length;i++)
					{
						if(items[i].shhide) continue;
						var Fnm = items[i].fieldname;
						if(Fnm == "range"){curversion.style.display = "block";continue};
						var colSpan = tc.colSpan||items[i].colSpan||1;//items[i].colSpan||1;
						var hd = items[i].shide;
						if(hd)
							continue;
						
						var CPct = tc.C50Pct;
						if( colSpan == 2){
							CPct = tc.C100Pct;
						};
						
						var _colDiv = document.createElement("div");
						_colDiv.id = "div_" + Fnm;
						_colDiv.className = CPct;
						
						var _colName = document.createElement("div");
						_colName.className = tc.nmCls;
						_colName.innerHTML = items[i].fieldcnname;
						_colDiv.appendChild(_colName);
						
						var _colContent = document.createElement("div");
						_colContent.className = tc.cnCls;
						_colContent.style.paddingLeft = "5px";
						
						
						//��������
						this.FType(_colDiv,items[i]);
						//�����ֶ�����UI
						this.MakeList(items[i],_colContent);
						
						_colDiv.appendChild(_colContent);
						inputdiv.appendChild(_colDiv);
					}
			};
			//���ײ���ʾ
			if(tc.formtipbt){
				var tipbt = document.createElement("div");
				tipbt.innerHTML = tc.formtipbt;
				inputdiv.appendChild(tipbt);
			};
			
			var linebt = document.createElement("div");
			linebt.className = "clear";
			linebt.innerHTML = "";
			with(linebt.style){
				width = "100%";
				height = "9px";
				overflow = "hidden";
			};
			inputdiv.appendChild(linebt);
			
			//�������������
			var extheight = T.iev&&tc.showCon?30:0;
			var linshiH = 0;
			var fObjW = tc.formObj.offsetWidth||200;
			var fObjH = tc.formObj.offsetHeight||100;
			linshiH =(fObjH<30)?30:0;
			(tc.formtitle)? extheight += 30:"";
			(tc.formpower)? extheight += 35:extheight -= 1;
			extheight += linshiH;
			inputdiv.style.width = tc.fit[0]?fObjW - 5 + "px":"100%";
			inputdiv.style.height = linshiH==0?fObjH - extheight + "px":"auto";
			tc.fit[2]?"":inputdiv.style.height = "auto";
			if(tc.islisten == 1 && tc.fit[0]==true){
				var formFitObj = T.iev&&T.iev<9?tc.formObj:window;
				T.bind(formFitObj,"resize",function(){
					setTimeout(function(){
						try{
							if(tc.fit[1]||"undefined" == typeof(tc.fit[1]))T("#"+tc.formname+"_input_div").style.width = formObj.offsetWidth!==0? formObj.offsetWidth - 5 + "px":formObj.parentNode.offsetWidth - 5 + "px";
							if(tc.fit[2]||"undefined" == typeof(tc.fit[2]))T("#"+tc.formname+"_input_div").style.height = (formObj.offsetHeight!==0) ? formObj.offsetHeight - extheight + linshiH + "px":formObj.parentNode.offsetHeight - extheight + linshiH + "px"
						}catch(e){}
					},100)
				});	
			};
			formdiv.appendChild(inputdiv);
		};
	
		//���ñ�CSS��ʽ
		if(tc.Css){T.LJC("/css/"+tc.Css+"","c")}
		
		//�����
		formObj.appendChild(formdiv);
		//formObj.style.visibility = "visible";
		
		//�Ƿ���֤
		if(tc.formAttr[0].rules){
			setTimeout(function(){Tcheck(FNM,tc.formAttr[0].rules,"",tc.formObj)},100);
		};
		
		//�߶�����
		setTimeout(function(){
			try{
				if(tc.height != "auto"){
					T("#"+tc.formname+"_input_div").style.height = (tc.formObj.offsetHeight!==0) ? tc.formObj.offsetHeight - extheight + linshiH + "px":tc.formObj.parentNode.offsetHeight - extheight + linshiH + "px";
				}
			}catch(e){}
		},500);
		
		if(tc.loadfun){
			tc.loadfun(FNM);	
		}
		
	},
	/*AddOption,���options
	  Pobj:������select
	  obj:�����������new Option(name,value)
	*/
	Ao: function(Pobj,obj){
		T.iev?Pobj.add(obj):Pobj.options.add(obj)
	},
	/*
	  MakeList,�����ֶ�����UI
	*/
	MakeList : function(item,obj){
		var colSpan = 2;
		var tc = this.tc;
		var formObj = tc.formObj;
		var FNM = tc.formname;
		var Fnm = item.fieldname;
		var cnname = item.fieldcnname;
		var Dvalue = item.fieldvalue||(item.defaultValue?item.defaultValue:"");
		var Fst;
		Fst = "class=\"txt\" style=\"margin-left:0px;\" ";
		var Dfn = (T.iev)?"onfocus=\"T.addcls(this,'h')\" onblur=\"T.remcls(this,'h');\"":" onfocus=\"T.addcls(this,'h')\" onblur=\"T.remcls(this,'h')\" ";
		if(item.fn){
			var eF = item.fn[0];
			Dfn = (T.iev)?"onfocus=\"T.addcls(this,'h')\" onblur=\"T.remcls(this,'h');\" on"+eF.type+"="+eF.fun+"(this.value)":"onfocus=\"T.addcls(this,'h')\" onblur=\"T.remcls(this,'h')\" "+eF.type+"="+eF.fun+"(this.value)";
		};
		
		//var _nosub = (T.iev)?" nosub=\"true\" autocomplete=\"off\" ":" autocomplete=\"off\" ";
		var _nosub = (T.iev)?" autocomplete=\"off\" ":" autocomplete=\"off\" ";
		//var _nosub = " autocomplete=\"off\" ";
		var selectListen = T.iev? "":"";
		
		var Id = FNM+"_" + Fnm;
		var Name = Fnm;
		var StartId = FNM+"_" + (item.startname||Fnm + "_start");
		var StartName = item.startname||Fnm + "_start";
		var EndId = FNM+"_" + (item.endname|| Fnm + "_end");
		var EndName = item.endname||Fnm + "_end";
		var ConditionName = item.conditionname||Fnm;
		
		var inputhtml = [];
		inputhtml.push("<span style=\"display:none\"></span>");
		var extrahtml;
		if(item.refn){
			extrahtml = item.refn(FNM,Fnm,item.fieldvale)
			inputhtml.push(extrahtml);
		}else{
			switch (item.inputtype){
				case "number":
				case "hour":
				case "minute":
					inputhtml.push( "<input class=\"txt\" "+Dfn+" "+_nosub+" type=\"text\" "+Fst+" value=\"\" id=\""+StartId+ "\" name=\""+StartName+ "\" startname=\""+StartName+ "\" endname=\""+EndName+ "\" conditionname=\""+ConditionName+ "\"  />");
					if(StartName==EndName){break;}//���ݼ��ݼ��ݼ���JAVA��̨
					inputhtml.push( "<span class=\"fl\" id=\""+StartId+ "_bridge\" ");
					item.defaultcon=="between"?inputhtml.push( "style=\"display:block\" "):inputhtml.push( "style=\"display:none\" ");
					inputhtml.push( ">��</span> ");
					
					inputhtml.push( "<input class=\"txt\" ");
					item.defaultcon=="between"?inputhtml.push( "style=\"display:block\" "):inputhtml.push( "style=\"display:none\" ");
					inputhtml.push( ""+Dfn+" "+_nosub+" type=\"text\" "+Fst+" value=\"\" id=\""+EndId+ "\" name=\""+EndName+ "\" startname=\""+StartName+ "\" endname=\""+EndName+ "\" conditionname=\""+ConditionName+ "\"/>");
					break;
				case "doub"://����չ
				case "text":
				case "multi":
				case "uploadfile":
				case "uploadtqfiles":
				case "qqnum":
				case "equal":
				case "like":
				case "showmap":
				case "nobetween":
					inputhtml.push( "<input class=\"txt\" "+Dfn+" "+_nosub+" type=\"text\" "+Fst+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\" />");
					break;
				case "checkbox":
				case "radio":
				case "select":
					if(tc.formFunId&&!item.noList&&!item.Fn&&!item.fn){
						inputhtml.push( "<input  class=\"iconinput sel bg_gray_hover border_gray\"  readonly=\"readonly\" type=\"text\" "+_nosub+" value=\"\" id=\""+FNM+"_" + Fnm + "_text\" name=\"" + Fnm + "_text\" onClick=\"treeSelect('"+tc.formFunId+"',this,'"+ item.dataurl+"',"+tc.formFunId+".treeCallbak);\"");
						inputhtml.push( " title=\"���ѡ��\" >");
						inputhtml.push( "<span title=\"���ѡ��\" id=\""+FNM+"_" + Fnm + "_text_clickspan\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onClick=\"treeSelect('"+tc.formFunId+"',this.previousSibling,'"+ item.dataurl+"',"+tc.formFunId+".treeCallbak);\"> ")
						inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickicon\" class='icon16 icon16arrowdown fl' ></span>");
						inputhtml.push( "</span>");
						inputhtml.push( "<input type=\"hidden\" "+_nosub+"  value=\"\" id=\""+Id+ "\" name=\""+Name+ "\" "+selectListen+">");
					}else{
						inputhtml.push( "<select "+Dfn+" "+selectListen+"  "+_nosub+" class=\"slct\" name=\""+StartName+ "\" startname=\""+StartName+ "\" endname=\""+EndName+ "\" conditionname=\""+ConditionName+ "\"  id=\""+StartId+ "\" style='width:242px'/>")
						for(var j=0;j<item.noList.length;j++){
							inputhtml.push( "<option value=\"" + item.noList[j].value_no + "\" ");
							inputhtml.push( ">" + item.noList[j].value_name + "");
							inputhtml.push( "</option>");
						}
						inputhtml.push( "</select>");
					}
					break;
				case "localselect":
					if(Dvalue!=""){
						tc.areaData = ""+FNM+"_" + Fnm + "||"+Dvalue+""
					}else{
						tc.areaData = "";
					};
					inputhtml.push("<input type='hidden' "+_nosub+"  id=\""+Id+ "\" name=\""+Name+ "\" value=\"\"/>");
					inputhtml.push( "<select class=\"slct\" style=\"float:left\"  name=\"f_s_" + Fnm + "\" id=\""+FNM+"_" + Fnm + "input_sheng\" onchange='setshi(this.value,\""+FNM+"_" + Fnm + "\")'");
					inputhtml.push(">");
					for(var j=0;j<item.noList.length;j++){
						inputhtml.push( "<option value=\"" + item.noList[j].value_no + "\" ");
						(Dvalue == item.noList[j].value_no)?inputhtml.push( " selected"):"";
						inputhtml.push( ">" + item.noList[j].value_name + "");
						inputhtml.push( "</option>");
					}
					inputhtml.push( "</select>");
					inputhtml.push("<span id=\""+FNM+"_" + Fnm + "span_shi\"><select class=\"slct\" id=\""+FNM+"_" + Fnm + "input_shi\"  onchange=\"setquxian(this.value,'"+FNM+"_" + Fnm + "')\"><option >��ѡ��</option></select></span>");
					inputhtml.push("<span id=\""+FNM+"_" + Fnm + "span_quxian\"><select class=\"slct\" id=\""+FNM+"_" + Fnm + "input_quxian\"  onchange=\"setquxian(this.value,'"+FNM+"_" + Fnm + "')\"><option >��ѡ��</option></select></span>");
				break;
				case "mobile":
				case "telphone":
					inputhtml.push( "<input "+Dfn+" "+_nosub+" type=\"text\" class=\"txt\" "+Fst+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\" />");
					if("undefined"!=typeof(iskehuduan)&&iskehuduan){
						inputhtml.push( "<span title=\"�������\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"javascript:callout('"+FNM+"_" + Fnm + "');\"> ")
						inputhtml.push( "<span class='icon16 icon16call fl'></span>");
						inputhtml.push( "</span>");
					};
					inputhtml.push( "<span title=\"���Ͷ���\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"javascript:messageout('"+FNM+"_" + Fnm + "','"+tc.formObj.id+"');\"> ")
					inputhtml.push( "<span class='icon16 icon16sms fl'></span>");
					inputhtml.push( "</span>")
					break;
				case "email":
					inputhtml.push( "<input "+Dfn+" "+_nosub+" type=\"text\" class=\"txt iconinput\" "+Fst+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\"");
					inputhtml.push( ">");
					inputhtml.push( "<span title=\"���͵����ʼ�\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"javascript:mailout('"+FNM+"_" + Fnm + "');\"> ")
					inputhtml.push( "<span class='icon16 icon16email fl'></span>");
					inputhtml.push( "</span>")
					break;
				case "wwwnet":
					inputhtml.push( "<input "+Dfn+" "+_nosub+" type=\"text\" class=\"txt iconinput\" "+Fst+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\"");
					inputhtml.push( ">");
					inputhtml.push( "<span title=\"����ַ\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"javascript:openurl('"+FNM+"_" + Fnm + "');\"> ")
					inputhtml.push( "<span class='icon16 icon16goto fl'></span>");
					inputhtml.push( "</span>")
					break;
				case "wwwsearch":
					inputhtml.push( "<input "+Dfn+" "+_nosub+" type=\"text\" class=\"txt iconinput\" "+Fst+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\"");
					inputhtml.push( ">");
					inputhtml.push( "<span title=\"�ٶ�����\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"javascript:wwwsearch('"+FNM+"_" + Fnm + "');\"> ")
					inputhtml.push( "<span class='icon16 icon16baidu fl'></span>");
					inputhtml.push( "</span>")
					break;
				case "selcustomer":
					var coverobj = formObj;
					if(formObj.id.substring(0,7) == "winbody"){coverobj = formObj.parentNode};
					inputhtml.push( "<input  "+selectListen+"  "+_nosub+" readonly=\"readonly\"  value=\"\" id=\""+Id+"\" name=\""+ Name+ "\"  class=\"iconinput sel bg_gray_hover border_gray\" type=\"text\" onclick=\"selcetClient('"+FNM+"_" + Fnm +"',T('#"+coverobj.id+"'));\">");
					
					inputhtml.push( "<span title=\"����ѡ��ͻ�\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"selcetClient('"+FNM+"_" + Fnm +"',T('#"+coverobj.id+"'));\"> ")
					inputhtml.push( "<span class='icon16 icon16search1 fl'></span>");
					inputhtml.push( "</span>")
					
					inputhtml.push( "<span title=\"�鿴�ͻ�����\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"javascript:show_visitor(T('#"+FNM+"_" + Fnm + "').value,'','',T('#"+coverobj.id+"'))\" > ")
					inputhtml.push( "<span class='icon16 icon16detail fl'></span>");
					inputhtml.push( "</span>")
					
					coverobj=null;
					break;
				case "selLinkMan":
					var coverobj = formObj;
					var parentObj = item.parent?FNM+"_"+item.parent:"";
					if(formObj.id.substring(0,7) == "winbody"){coverobj = formObj.parentNode};
					inputhtml.push( "<input  "+selectListen+"  "+_nosub+" readonly=\"readonly\" class=\"iconinput sel bg_gray_hover border_gray\" value=\"\" id=\""+Id+"\" name=\""+Name+ "\"   type=\"text\" onclick=\"selcetLinkMan('"+FNM+"_" + Fnm +"',T('#"+coverobj.id+"'));\">");
					
					inputhtml.push( "<span title=\"����ѡ����ϵ��\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"selcetLinkMan('"+FNM+"_" + Fnm +"',T('#"+coverobj.id+"'),'"+parentObj+"');\"> ")
					inputhtml.push( "<span class='icon16 icon16search1 fl'></span>");
					inputhtml.push( "</span>")
					
					inputhtml.push( "<span title=\"�鿴��ϵ������\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none'  onclick=\"javascript:show_linkman(T('#"+FNM+"_" + Fnm + "').value,'','',T('#"+coverobj.id+"'))\" > ")
					inputhtml.push( "<span class='icon16 icon16detail fl'></span>");
					inputhtml.push( "</span>")
					
					coverobj=null;
					break;
				case "seluser":
					inputhtml.push( "<input  readonly=\"readonly\"   value=\"\" id=\""+FNM+"_" + Fnm + "_text\" name=\"" + Fnm + "_text\"  ");
					inputhtml.push( " "+_nosub+" onclick=\"selectuser('"+FNM+"_" + Fnm + "_text','','yes');\" type=\"text\" class=\"iconinput sel bg_gray_hover border_gray\" />");
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickspan\" title=\"���ѡ��\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"selectuser('"+FNM+"_" + Fnm + "_text','','yes');\" > ")
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickicon\" class='icon16 icon16user1 fl'></span>");
					inputhtml.push( "</span>")
					inputhtml.push( "<input type=\"hidden\" "+_nosub+" "+selectListen+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\">");
					inputhtml.push( "<input type=\"hidden\" "+_nosub+" "+selectListen+" value=\"\" id=\""+Id+ "_department\" name=\"" + Fnm + "_department\">");
					break;
				case "selonlyuser":
					inputhtml.push( "<input readonly=\"readonly\"   value=\"\" id=\""+FNM+"_" + Fnm + "_text\" name=\"" + Fnm + "_text\"  ");
					inputhtml.push( " "+_nosub+" onclick=\"selectuser('"+FNM+"_" + Fnm + "_text','','no');\" type=\"text\" class=\"iconinput sel bg_gray_hover border_gray\" />");
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickspan\" title=\"���ѡ��\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"selectuser('"+FNM+"_" + Fnm + "_text','','no');\" > ")
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickicon\" class='icon16 icon16user1 fl'></span>");
					inputhtml.push( "</span>")
					inputhtml.push( "<input type=\"hidden\" "+_nosub+" "+selectListen+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\">");
					break;	
				case "selalluser":
					inputhtml.push( "<input  readonly=\"readonly\"   value=\"\" id=\""+FNM+"_" + Fnm + "_text\" name=\"" + Fnm + "_text\"  ");
					inputhtml.push( " "+_nosub+" onclick=\"selectuser(this.id,'1','yes');\" type=\"text\" class=\"iconinput sel bg_gray_hover border_gray\" />");
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickspan\" title=\"���ѡ��\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"selectuser(this.previousSibling.id,'1','yes');\"> ")
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickicon\" class='icon16 icon16user1 fl'></span>");
					inputhtml.push( "</span>")
					inputhtml.push( "<input type=\"hidden\" "+_nosub+" "+selectListen+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\">");
					inputhtml.push( "<input type=\"hidden\" "+_nosub+" "+selectListen+" value=\"\" id=\""+Id+ "_department\" name=\"" + Fnm + "_department\">");
					names = null;
					ids = null;
				break;
				case "selusers"://��ѡ
					inputhtml.push( "<input  readonly=\"readonly\" value=\"\" id=\""+FNM+"_" + Fnm + "_text\" name=\"" + Fnm + "_text\" ");
					inputhtml.push( ""+_nosub+" class=\"iconinput sel bg_gray_hover border_gray\" type=\"text\" onclick=\"selectusers('"+FNM+"_" + Fnm +"_text','1');\" />")
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickspan\" title=\"���ѡ����Ա\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onclick=\"selectusers('"+FNM+"_" + Fnm +"_text','1');\"> ")
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickicon\" class='icon16 icon16user1 fl'></span>");
					inputhtml.push( "</span>")
					inputhtml.push( "<input  type=\"hidden\" "+_nosub+" "+selectListen+"  value=\"\" id=\""+Id+ "\" name=\""+Name+ "\">");
					names = null;
					ids = null;
				break;
				case "date":
					inputhtml.push( "<input "+_nosub+" "+selectListen+" readonly=\"readonly\" type=\"text\"  value=\"\" id=\""+StartId+ "\" name=\""+StartName+ "\" startname=\""+StartName+ "\" endname=\""+EndName+ "\" conditionname=\""+ConditionName+ "\"   onClick=\"WdatePicker({startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false});\"");
					inputhtml.push( "class=\"iconinput sel bg_gray_hover border_gray\" title=\"���ѡ��\" >");
					inputhtml.push( "<span title=\"���ѡ��\" onClick=\"WdatePicker({startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false,el:'"+ StartId + "'});\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none'> ")
					inputhtml.push( "<span class='icon16 icon16calendar fl' ></span>");
					inputhtml.push( "</span>");
					inputhtml.push( "<span class= 'fl' id=\""+StartId+ "_bridge\">��</span>");
					inputhtml.push( "<input "+_nosub+" "+selectListen+" readonly=\"readonly\" type=\"text\"  value=\"\" id=\""+EndId+ "\" name=\""+EndName+ "\"  startname=\""+StartName+ "\" endname=\""+EndName+ "\" conditionname=\""+ConditionName+ "\" onClick=\"WdatePicker({startDate:'%y-%M-%d 23:59:59',alwaysUseStartDate:false});\"");
					inputhtml.push( "class=\"iconinput sel bg_gray_hover border_gray\" title=\"���ѡ��\" >");
					inputhtml.push( "<span title=\"���ѡ��\" onClick=\"WdatePicker({startDate:'%y-%M-%d 23:59:59',alwaysUseStartDate:false,el:'"+ EndId + "'});\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none'> ")
					inputhtml.push( "<span class='icon16 icon16calendar fl' ></span>");
					
					inputhtml.push( "</span>") 
					break;
				case "startdate":
					inputhtml.push( "<input "+_nosub+" "+selectListen+" readonly=\"readonly\" type=\"text\"  value=\"\" id=\""+StartId+ "\" name=\""+StartName+ "\" startname=\""+StartName+ "\" endname=\""+EndName+ "\" conditionname=\""+ConditionName+ "\"   onClick=\"WdatePicker({startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false});\"");
					inputhtml.push( "class=\"iconinput sel bg_gray_hover border_gray\" title=\"���ѡ��\" >");
					inputhtml.push( "<span title=\"���ѡ��\" onClick=\"WdatePicker({startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false,el:'"+ StartId + "'});\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none'> ")
					inputhtml.push( "<span class='icon16 icon16calendar fl' ></span>");
					inputhtml.push( "</span>");
					break;
				case "enddate":
					inputhtml.push( "<input "+_nosub+" "+selectListen+" readonly=\"readonly\" type=\"text\"  value=\"\" id=\""+StartId+ "\" name=\""+StartName+ "\" startname=\""+StartName+ "\" endname=\""+EndName+ "\" conditionname=\""+ConditionName+ "\"   onClick=\"WdatePicker({startDate:'%y-%M-%d 23:59:59',alwaysUseStartDate:false});\"");
					inputhtml.push( "class=\"iconinput sel bg_gray_hover border_gray\" title=\"���ѡ��\" >");
					inputhtml.push( "<span title=\"���ѡ��\" onClick=\"WdatePicker({startDate:'%y-%M-%d 00:00:00',alwaysUseStartDate:false,el:'"+ StartId + "'});\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none'> ")
					inputhtml.push( "<span class='icon16 icon16calendar fl' ></span>");
					inputhtml.push( "</span>");
					break;
				case "treeSelect":
					inputhtml.push( "<input readonly=\"readonly\" type=\"text\" "+_nosub+" class=\"iconinput sel bg_gray_hover border_gray\"  value=\"\" id=\""+FNM+"_" + Fnm + "_text\" name=\"" + Fnm + "_text\" onClick=\"treeSelect('"+tc.formFunId+"',this,'"+ item.dataurl+"',"+tc.formFunId+".treeCallbak);\" ");
					inputhtml.push( " title=\"���ѡ��\">");
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickspan\" title=\"���ѡ��\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none' onClick=\"treeSelect('"+tc.formFunId+"',this.previousSibling,'"+ item.dataurl+"',"+tc.formFunId+".treeCallbak);\"> ")
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickicon\" class='icon16 icon16arrowdown fl' ></span>");
					inputhtml.push( "</span>") 
					inputhtml.push( "<input type=\"hidden\" "+_nosub+" "+selectListen+"  value=\"\" id=\""+Id+ "\" name=\""+Name+ "\">");
					break;
				case"cactic":
					inputhtml.push( "<input "+_nosub+" readonly=\"readonly\"  value=\"\" id=\""+FNM+"_" + Fnm + "_text\" name=\"" + Fnm + "_text\"  onclick=\"selectCactic(this.id,'','"+ item.dataurl+"','win');\" style=\"cursor:pointer;_cursor:hand\"");
					inputhtml.push(" type=\"text\" class=\"iconinput sel bg_gray_hover border_gray\" ");
					inputhtml.push(" title='���ѡ��'>");
					inputhtml.push( "<span title=\"���ѡ��\" id=\""+FNM+"_" + Fnm + "_text_clickspan\" onClick=\"selectCactic('"+FNM+"_" + Fnm + "_text','','"+ item.dataurl+"','win');\" class='button24_a bg_gray_hover border_gray fl' style='border-left:none'> ")
					inputhtml.push( "<span id=\""+FNM+"_" + Fnm + "_text_clickicon\" class='icon16 icon16arrowdown fl' ></span>");
					inputhtml.push( "</span>") 
					inputhtml.push( "<input type=\"hidden\" "+_nosub+" "+selectListen+" value=\"\" id=\""+Id+ "\" name=\""+Name+ "\">");
					break;
				case "cselect":
					var targetid =FNM+"_" + item.target; 
					var action = item.action;
//					alert(targetid);
					inputhtml.push( "<select style=\"width:210px\" class=\"slct\" ");
					if(action)
						inputhtml.push( " onchange=\"cactic_Select(this.value,'"+targetid+"','"+action+"')\" ");
					inputhtml.push(" name=\"" + Fnm + "\" id=\""+FNM+"_" + Fnm + "\"")
					inputhtml.push(">");
					for(var j=0;j<item.noList.length;j++){
						inputhtml.push( "<option value=\"" + item.noList[j].value_no + "\" ");
						inputhtml.push( ">" + item.noList[j].value_name + "");
						inputhtml.push( "</option>");
					}
					inputhtml.push( "</select>");
					break;
			}
		}
		inputhtml.push( "<span style='width:80%;clear:both;line-height:14px;margin-left:75px;*margin-left:0px;display:none' id = '"+FNM+"_" + Fnm + "_t'></span>");
		obj.innerHTML = inputhtml.join("");				
	
	},
	/*FieldType,�����ֶ��������ö�Ӧ����
	*/
	FType : function(Obj,item){
		var t = this;
		var name = item.fieldname;
		var condition = item.condition;
		var type = item.inputtype;
		var cnname = item.fieldcnname;
		var conditionName = item.conditionname;
		var startname = item.startname||name + "_start";
		var endname = item.endname||name + "_end";
		
		var sObjD = document.createElement("div"); 
			sObjD.className = "fl";
		var sObj = T.iev&&T.iev<9?document.createElement("<select name="+(conditionName||name)+" />"):document.createElement("select"); 
			sObj.id = t.tc.formname + "_" + (conditionName||name);
			sObj.setAttribute("name",conditionName||name);
			sObj.setAttribute("cnname",cnname);
			sObj.setAttribute("startname",startname);
			sObj.setAttribute("endname",endname);
			T.iev?sObj.setAttribute("nosub","true"):"";
			sObj.className = "slct fl";
			sObj.style.width = "68px";
			sObj.style.border = "1px solid #ccc";
			sObj.onchange = function(){
				t.conditionChange(this,this.getAttribute("cnname"),this.getAttribute("startname"),this.getAttribute("endname"));
			}; 

		with(sObjD.style){
			width = "70px";
			margin = "0";
			padding = "0 0 0 5px";
			float = "left";
			textAlign = "right";
		};
		sObjD.appendChild(sObj);
		Obj.appendChild(sObjD);
		if(condition&&"object"==typeof(condition)){
			if(condition.length==1){
				t.Ao(sObj,new Option(condition[0].name,condition[0].value));
				sObj.style.display = "none";
				sObjD.setAttribute("ctype",condition[0].value);
				sObjD.innerHTML += condition[0].name;
				
			}else{
				T.each(condition,function(c,j){
					t.Ao(sObj,new Option(c.name,c.value));
				});
			}
			return;
		};
		switch (type){
			case "number":
				this.Ao(sObj,new Option("����","3"));//3
				this.Ao(sObj,new Option("����","between"));
				this.Ao(sObj,new Option("���ڵ���","1"));//1
				this.Ao(sObj,new Option("С�ڵ���","2"));//2
				this.Ao(sObj,new Option("Ϊ��","null"));
				break;
			case "date":
				this.Ao(sObj,new Option("���ڵ���","1"));
				this.Ao(sObj,new Option("����","between"));
				this.Ao(sObj,new Option("����","3"));
				this.Ao(sObj,new Option("С�ڵ���","2"));
				this.Ao(sObj,new Option("Ϊ��","null"));
				break;
			case "nobetween":
				this.Ao(sObj,new Option("����","3"));
				this.Ao(sObj,new Option("���ڵ���","1"));
				this.Ao(sObj,new Option("С�ڵ���","2"));
				break;
			case "startdate":
				sObjD.setAttribute("ctype","1")
				this.Ao(sObj,new Option("���ڵ���","1"));
				break;
			case "enddate":
				sObjD.setAttribute("ctype","2")
				this.Ao(sObj,new Option("С�ڵ���","2"));
				break;
			case "select":
			case "radio":
			case "checkbox":
			case "localselect":
			case "seluser":	
			case "selonlyuser":	
			case "treeSelect":
			case "selcustomer":
			case "selLinkMan":
				sObjD.setAttribute("ctype","3")
				sObjD.innerHTML = "����";
				break;
			case "text":
			case "multi":
			case "uploadfile":
			case "uploadtqfiles":
			case "telphone":
			case "mobile":
			case "email":
			case "wwwnet":
			case "wwwsearch":
			case "qqnum":
				sObjD.setAttribute("ctype","like")
				sObjD.innerHTML = "����";
				break;
			case "equal":
				sObjD.setAttribute("ctype","3")
				sObjD.innerHTML = "����";
			case "like":
				sObjD.setAttribute("ctype","like")
				sObjD.innerHTML = "����";
			default:
				sObjD.setAttribute("ctype","3")
				sObjD.innerHTML = "����";
		}
	},
	/**********************************
	
	 setCondition:����ֵ�ı�ʱ�������
	 
	**********************************/
	setCondition : function(obj,type){
		if(T.iev&&event.propertyName&&event.propertyName != 'value')return;
		var FNM = this.tc.formname;
		if(obj.value!=""&&obj.value==obj.parentNode.firstChild.innerHTML)return;
		T.trim(T.trim(obj.value))!=""?obj.setAttribute("nosub","false"):obj.setAttribute("nosub","true");
		
		obj.parentNode.firstChild.innerHTML = obj.value;//���浱ǰֵ
		var fname = obj.getAttribute("conditionname")||obj.getAttribute("name");
		var _id = FNM + "_" + fname;//��������ID
		var ctype = T("#" + _id).parentNode.previousSibling.getAttribute("ctype")||T("#" + _id).value;//��������
		if(!T.iev||!this.tc.showCon){
			T("#" + _id).setAttribute("nosub","false");
			return
		};
		
		var cnname = T("#"+_id).getAttribute("cnname")||T.filterHtml(T("#"+_id).parentNode.parentNode.firstChild.innerHTML);
		var conditionname = obj.getAttribute("conditionname")?obj.getAttribute("conditionname"):"";
		this.setExperess(fname,cnname,conditionname);
	},
	/**********************************
	
	 conditionChange:����ѡ����
	 
	**********************************/
	conditionChange : function(obj,cnname,startname,endname){
		var FNM = this.tc.formname;
		var id = obj.id;
		var value = obj.value;
		var name = obj.getAttribute("name");
		//����
		obj.setAttribute("nosub","false");
		if(startname==endname){
			var _startObj = T("#" + FNM + "_" + startname);
			if(_startObj.value!=""){
				_startObj.setAttribute("nosub","false");
			};
		}else{
			var _startObj = T("#" + FNM + "_" + startname);
			var _endObj = T("#" + FNM + "_" + endname);
			var _wordObj = T("#" + FNM + "_" + startname +"_bridge");
			
			switch(value){
				case "1"://���ڵ���
					_startObj.style.display = "block";
					_endObj.style.display = "none";
					_wordObj.style.display = "none";
					_startObj.setAttribute("nosub","false");
					_endObj.setAttribute("nosub","true");
					break;
				case "2"://С�ڵ���
					_startObj.style.display = "block";
					_endObj.style.display = "none";
					_wordObj.style.display = "none";
					_startObj.setAttribute("nosub","false");
					_endObj.setAttribute("nosub","true");
					break;
				case "3"://����
					_startObj.style.display = "block";
					_endObj.style.display = "none";
					_wordObj.style.display = "none";
					_startObj.setAttribute("nosub","false");
					_endObj.setAttribute("nosub","true");
					break;
				case "between"://����
					_startObj.style.display = "block";
					_endObj.style.display = "block";
					_wordObj.style.display = "block";
					_startObj.setAttribute("nosub","false");
					_endObj.setAttribute("nosub","false");
					break;
				case "null"://Ϊ��
					_startObj.style.display = "none";
					_endObj.style.display = "none";
					_wordObj.style.display = "none";
					_startObj.setAttribute("nosub","true");
					_endObj.setAttribute("nosub","true");
					break;
			};
		}
		T.iev&&this.tc.showCon?this.setExperess(name,cnname):"";
	},
	//�������е��ֶ�
	conditionField : [],
	/**********************************
	
	 setExperess:�����������ʽ
	 
	**********************************/
	setExperess : function(fname,cnname,conditionname){
		var _C = this.conditionField;
		var _W = _C.length?T("#"+this.tc.formname + "_conditiondiv").childNodes[1].innerHTML :"";
		var id = this.tc.formname + "_" + fname;
		var _startObj = T("#" + id + "_start")||T("#" + id);
		var _endObj = T("#" + id + "_end")||T("#" + id);
		var _conditionObj = T("#"+this.tc.formname+"_"+conditionname)||T("#" + id);

		var _startObjText = T("#"+_startObj.id+"_text")?T("#"+_startObj.id+"_text"):_startObj;
		
		if(id.indexOf("_department")!=-1){
			_startObjText = T("#"+id.substring(0,id.lastIndexOf("_department"))+"_text");
		}
		
		var value =  _conditionObj.parentNode.previousSibling.getAttribute("ctype")||_conditionObj.value;
		var seltext = _conditionObj.options?_conditionObj.options[_conditionObj.selectedIndex].text:T.filterHtml(_conditionObj.parentNode.previousSibling.innerHTML);
		
		var Ctips = [];
		switch(value){
			case "1"://���ڵ���
				if(T.trim(_startObj.value)==""){
					T.Aremove(_C,fname);
				}else{
					T.Apush(_C,fname);
					Ctips.push("<b>"+cnname+"</b>"+"<span class='red'>"+seltext+T.trim(_startObjText.value)+"</span>");
				}
				break;
			case "2"://С�ڵ���
				var _endObjText = T("#"+_endObj.id+"_text")?T("#"+_endObj.id+"_text"):_endObj;
				if(T.trim(_endObj.value)==""){
					T.Aremove(_C,fname);
				}else{
					T.Apush(_C,fname);
					Ctips.push("<b>"+cnname+"</b>"+"<span class='red'>"+seltext+T.trim(_startObjText.value)+"</span>");
				}
				break;
			case "3"://����
				if(T.trim(_startObj.value)==""||T.trim(_startObjText.value)==""){
					T.Aremove(_C,fname);
				}else{
					T.Apush(_C,fname);
					Ctips.push("<b>"+cnname+"</b>"+"<span class='red'>"+seltext+T.trim(_startObjText.value)+"</span>");
				}
				break;
			case "between"://����
				var _endObjText = T("#"+_endObj.id+"_text")?T("#"+_endObj.id+"_text"):_endObj;
				if(T.trim(_startObj.value)==""||T.trim(_endObj.value)==""){
					T.Aremove(_C,fname);
				}else{
					T.Apush(_C,fname);
					Ctips.push("<span class='red'>"+T.trim(_startObjText.value) + " &le; </span>" + "<b>"+cnname+"</b>" + "<span class='red'> &le; " + T.trim(_endObjText.value)+"</span>");
				}
				break;
			case "null"://Ϊ��
				T.Apush(_C,fname);
				Ctips.push("<b>"+cnname+"</b>"+"<span class='red'>Ϊ��"+"</span>");
				break;
			case "like"://����
				T.Apush(_C,fname);
				if(T.trim(_startObj.value)==""){
					T.Aremove(_C,fname);
				}else{
					T.Apush(_C,fname);
					Ctips.push("<b>"+cnname+"</b>"+"<span class='red'>"+seltext+T.trim(_startObjText.value)+"</span>");
				}
				break;
		};
		
 		if(!Ctips.length){
			_conditionObj.setAttribute("nosub","true");
			var re = new RegExp("(����)\\[[^\\[]*<b>"+cnname+"</b>.[^\\]]*\\]{1}","g");
			var _re = new RegExp("\\[[^\\[]*<b>"+cnname+"</b>.[^\\]]*\\]{1}","g");
			_W = _W.replace(re,"").replace(_re,"");
			if(_C.length==1){
				_W = _W.replace(/����/g,"");
			}else if(_C.length==0){
				_W = "�����·�����";
			};
			T("#"+this.tc.formname + "_conditiondiv").childNodes[1].innerHTML = _W;
			return;
		};
		_conditionObj.setAttribute("nosub","false");
		
		
		
		Ctips.unshift("[");
		Ctips.push("]");
		var _Ctips = "";		
		if(_W.indexOf(cnname)!=-1){
			var re = new RegExp("\\[[^\\[]*<b>"+cnname+"</b>.[^\\]]*\\]{1}","gi");
			_Ctips = _W.replace(re,Ctips.join(""));
		}else{
			_Ctips = _C.length>1?_W + "����" + Ctips.join(""):_W + Ctips.join("");
		};
		
		
		
		T("#"+this.tc.formname + "_conditiondiv").childNodes[1].innerHTML = _Ctips;
	},
	/*
		treeslectѡ��ɹ���ִ��
		�������(�ݲ�����)
	*/
//	treeCallbak : function(formid,obj){
//		formid.setCondition(obj,'treeSelect')
//	},
	treeCallbak:false,
	/**********************************
	
	 GetFieldAttribue:��ȡ�ֶ�ĳ������
	 
	**********************************/
	GFA : function(fieldname,fieldattr){
		var t = this;
		var ret = false;
		var ti = this.tc.formAttr[0].formitems;
		T.each(ti,function(p,i){
			T.each(p.kinditemts,function(o,j){
				if(o.fieldname == fieldname){
					ret = o[fieldattr];
				}
			})
		});
		return ret
	},
	//�ύ��
	TCSubimtForm : function(f,o,url){
		this.tc.subFun?this.tc.subFun(f):"";
		this.tc.SubAction?this.tc.SubAction(f,o,url):"";
		TwinC(this.tc.formWinId,true);
	},
	
	//Ĭ�ϻص�
	TCFormBack : function(f,rcd,r,o){
		alert("û�лص�����");
	}
	
}

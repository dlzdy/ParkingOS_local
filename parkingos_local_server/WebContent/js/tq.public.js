/*Public Fucntion 2012-06-22
 Latest: 2013-11-03 
*/
/*===���Ͷ���===*/
var smsrule = [
				{name:"mobile",type:"",requir:true,warn:"���պ��벻��Ϊ��",okmsg:""},
				{name:"content",type:"",requir:true,warn:"�������ݲ���Ϊ��",okmsg:""}
			];
function CsmsHtml(phonenumInfo,obj){
	var coverobj = phonenumInfo[2]? phonenumInfo[2]:null;
	Tform({
		//formtitle:"���Ͷ���",
		formid:"smsSendForm",
		formname:"smsSendForm",
		recordid:"id",
		dbuttons:false,
		formObj:obj,
		fit:[false],
		suburl:"shortmsginner.do",
		updataurl:"",
		formtipbt:"<div class=\"formtip\" style=\"width:312px\">��ʾ�����ŷ����ܵ���Ӫ������Ӱ�죬�����ܱ�֤100%���ͳɹ��ͼ�ʱ���գ�����ö������ݶ����Ŀͻ��ǳ���Ҫ�������ͨ�����ż�¼�����ŷ���״̬��</div>",
		//Callback:function(f,r,c,o){T.loadTip(1,c,2,o)},
		method:"POST",
		formAttr:[{
			formitems:[{kindname:"",kinditemts:[
						{fieldcnname:"����ԱID",fieldname:"admin_uin",fieldvalue:phonenumInfo[0],inputtype:"text",colSpan:2,width:"215",hide:true},
						{fieldcnname:"���պ���",fieldname:"mobile",fieldvalue:phonenumInfo[1],inputtype:"text",colSpan:2,width:"215",edit:false},
						{fieldcnname:"��������<br>(�������330��)",fieldname:"content",fieldvalue:"",inputtype:"multi",colSpan:2,width:"215",height:60}
					]}],
			rules:smsrule
		}],
		buttons : [//����
			{name: "send", dname: "ȷ������", iconcls: "icon16 icon16sms fl",
			onpress:function(btname,formname,formObj,suburl,updataurl,method){
						Tcheck(formname,smsrule,"sub",formObj);//��֤
						if(TFormCheckSign==1){
							function smsformSub(ret){smsSendSub(formname,ret)};
							T.A.sendData(suburl,"POST",Serializ(formname),smsformSub,0,formObj);
						}
					}
},
			{name: "cancel", dname: "ȡ��", iconcls:"icon16 icon16cancel fl", onpress: function(){TwinC("sms_w","","",coverobj)} }
		]
	});
};
function smsSendSub(f,r){
	if(r=="0"){
		T.loadTip(1,"���ŷ��ͳɹ���",2);
		TwinC("sms_w")
	}else if(r=="11"){
		T.loadTip(2,"��������,���ֵ��<br>���ղŵķ��Ͷ��Ų����ѱ�����Ϊ<br><font style='color:#c00'>&lt;δ���Ͷ��ż�¼&gt;</font><br>��ֵ��ɺ������ԶԴ˼�¼����<font style='color:#c00'>�ط�</font>")
	}else if(r=='1001'){
		T.loadTip(2,"���������ͣ��뵽��Ӧ�����̺�̨��ѯ���ͽ����");
	}else{
		T.loadTip(2,"����ʧ�ܣ�<br>���ղŵķ��Ͷ��Ų����ѱ�����Ϊ<br><font style='color:#c00'>&lt;δ���Ͷ��ż�¼&gt;</font><br>���Ź��ָܻ������������ԶԴ˼�¼����<font style='color:#c00'>�ط�</font>")
	}
};
function messageout(o,coverobj){
	T.cancelBub();
	if(typeof(coverobj)=="string"){
		coverobj = coverobj&&T("#"+coverobj).id.substring(0,7) == "winbody"?T("#"+coverobj).parentNode:null;
	};
	var smsc = T(o)?T(o).val():o;
	if(!admin_uin||admin_uin==""){T.loadTip(1,"�޷����Ͷ��ţ�����Ա�ʺŴ���!",2);return}
	if("undefined"==typeof(sendpower)||sendpower!="true"){T.loadTip(1,"��δ��ͨ���Ź��ܻ�û�з��Ͷ��ŵ�Ȩ�ޣ�����ϵ����Ա!",2);return}
	if(smsc==""){
		T.loadTip(1,"���벻��Ϊ��!",1,coverobj);
//	}else if(/^(1[4358].{9})|(01[4358].{9})$/.test(smsc)==false){
//		T.loadTip(1,"�����ֻ�����,���ܷ��Ͷ���",1,coverobj);
	}else{
		Twin({Id:"sms_w",Title:"���Ͷ���",Content:"",sysfun:CsmsHtml,sysfunI:[admin_uin,smsc,coverobj],Width:360,Height:275,Coverobj:coverobj})
	}
};
//var mongourl = "http://127.0.0.1/mj";//���ز���
var mongourl = "http://211.157.150.98:8080/mj/";//���ϲ���
//var mongourl = "http://mdb.tq.cn/mj";//����
/*===�ϴ��ļ�===*/
var uploadresult="";//�ϴ���mongojava�󣬷���IFRAME������vip���񣬴������������������ֵ
function uploadfiles(o,oldfile){
	var adminId = admin_uin;
	var uin = uin;
	var file=oldfile||"";
	var type=typeof(uploadtype)=='undefined'?'bills':uploadtype;
	var uploadurl = "mogoupload.do?file="+file+"&type="+type;
	var fileurl = o+"_fileurl";
	Twin({
		Id:o+"_win",
		Title:"�ϴ�",
		Mask:false,
		Width:400,
		Content:"<iframe name='"+o+"' id='"+o+"_f' src='"+uploadurl+"' width='100%' height='150' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>",
		//Content:"�ϴ���URL",
		buttons:[
			{dname:"ȷ��",name:"ok",icon:"ok.gif",onpress:function(){
				if(uploadresult==""){
					T.loadTip(1,"�����ϴ��ļ�!",1);
					return;
				};
				var getresult = uploadresult[0].name;
				var getresulturl = uploadresult[0].name;
				if(!getresult){
					T.loadTip(1,"�ϴ�ʧ�ܣ��������ϴ�!",1);
				};
				var ov = T("#"+o).value;
				ov = ov==''?getresult:ov+"|"+getresult;
				try{
					while(ov.indexOf('||')!=-1){
						ov = ov.replace('||','|');
					}
				}catch(e){}
				T("#"+o).value = ov;
				var newuplist = document.createElement("div");
				newuplist.style.width = "90%";
				newuplist.style.float = "left";
				newuplist.style.cssFloat = "left";
				newuplist.innerHTML = "<ul class='fl' style='overflow:hidden;width:70%;line-height:18px;border-bottom:1px solid #ddd' title='"+getresult+"'>"+getresult+"</ul><ul class='fl' onclick=\"openmongofiles('"+getresult+"')\" style='padding-left:1px;cursor:pointer' title='�鿴/����'><img src='/vip/tqccresource/tq_images/form/grid_look.gif' /></ul><ul class='fl' onclick=\"delmongofiles('"+getresult+"',this,'"+o+"')\" style='padding-left:1px;cursor:pointer' title='ɾ��'><img src='/vip/tqccresource/tq_images/form/delete.png' /></ul>"
				T(o).apch(newuplist,"be");
				var select_id = o.substring(0,o.length-8); //������ƶ�Ӧid��input��ID
				if(T("#"+select_id+"fileurl")){
					//alert(T("#"+select_id+"fileurl").name);
					T("#"+select_id+"fileurl").value = getresulturl;
				};
				uploadresult="";
				TwinC(o+"_win","","","",2);
				}
			},
			{dname:"ȡ ��",name:"cancel",icon:"",onpress:function(){TwinC(o+"_win","","","",2)}}
		]
	})
};
function uploadfile(o){
var adminId = admin_uin;
	var uin = uin;
	var file="";
	var type=typeof(uploadtype)=='undefined'?'bills':uploadtype;
	var uploadurl = "mogoupload.do?file="+file+"&type="+type;
	var fileurl = o+"_fileurl";
	Twin({
		Id:o+"_win",
		Title:"�ϴ�",
		Mask:false,
		Width:400,
		Content:"<iframe name='"+o+"' id='"+o+"_f' src='"+uploadurl+"' width='100%' height='150' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>",
		//Content:"�ϴ���URL",
		buttons:[
			{dname:"ȷ��",name:"ok",icon:"ok.gif",onpress:function(){
				if(uploadresult==""){
					T.loadTip(1,"�����ϴ��ļ�!",1);
					return;
				};
				var getresult = uploadresult[0].name;
				var getresulturl = uploadresult[0].name;
				if(!getresult){
					T.loadTip(1,"�ϴ�ʧ�ܣ��������ϴ�!",1);
				};
				var ov = T("#"+o).value;
				ov = ov==''?getresult:ov+"|"+getresult;
				try{
					while(ov.indexOf('||')!=-1){
						ov = ov.replace('||','|');
					}
				}catch(e){}
				T("#"+o).value = ov;
				uploadresult="";
				TwinC(o+"_win","","","",2);
				}
			},
			{dname:"ȡ ��",name:"cancel",icon:"",onpress:function(){TwinC(o+"_win","","","",2)}}
		]
	})

}
/*===���ϴ��ļ�===*/
function openupfile(o){
	var url = T("#"+o).value;
	if(!url){
		T.loadTip(1,"�����ϴ��ļ�!",1);
	}else{
		window.open(mongourl+"filelist.do?adminid="+admin_uin+"&filename="+url+"&type=&token="+token);
	}
};
/*===��mongo�ϴ��ļ�===*/
function openmongofiles(f){
	window.open(mongourl+"filelist.do?adminid="+admin_uin+"&filename="+f+"&type="+uploadtype+"&token="+token);
};
/*===ɾ��mongo�ϴ��ļ�===*/
function delmongofiles(f,self,o){
	//T.A.sendData(mongourl+"/filelist.do?operate=deletefile&adminid="+admin_uin+"&filename="+f+"&type="+uploadtype+"&token="+token);
	//window.open(mongourl+"/filelist.do?adminid="+admin_uin+"&filename="+f+"&type="+uploadtype+"&token="+token);
	var url = mongourl+"filelist.do?operate=deletefile&adminid="+admin_uin+"&filename="+f+"&type="+uploadtype+"&token="+token;
	Twin({
		Id:"delfile_win",
		Title:"������Ϣ",
		Mask:false,
		Width:300,
		Height:130,
		Content:"<div class='win_confirm' style='margin-right:5px;'></div><div style='float:left;width:200px;font-weight:700;margin-top:2px;'>ȷ��Ҫɾ�����ļ���?<iframe name='delfile_iframe' id='delfile_iframe' src='' width='90%' height='40' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe></div>",
		//Content:"�ϴ���URL",
		buttons:[
			{dname:"ȷ��",name:"ok",icon:"ok.gif",onpress:function(){
				var ov = T("#"+o).value;
				if(ov.indexOf(f+"|")!=-1)
					ov = ov.replace(f+"|","");
				else
					ov = ov.replace(f,"");
				T("#"+o).value=ov;
				document.getElementById("delfile_iframe").src = url;
				T("#delfile_win_a_ok").style.display = "none";
				T("#delfile_win_a_cancel").innerHTML = "ɾ���С���";
				T("#delfile_win_a_cancel").onclick = null;
			 	self.parentNode.parentNode?self.parentNode.parentNode.removeChild(self.parentNode):"";
				setTimeout(function(){
					//T.loadTip(1,"ɾ���ɹ�!",1);
					TwinC("delfile_win","","","","0");
				},2000)
			}},
			{dname:"ȡ��",name:"cancel",icon:"cancel.gif",onpress:function(){
				TwinC("delfile_win","","","","0");
			}}
		]
	})
};
/*===���===*/
function tq_call_out(phone_num){
	//if(/^(1[4358]\d{9})|(01[4358]\d{9})$/.test(phone_num)){
	//	phone_num.substring(0,1)!="0"?phone_num = "0"+phone_num:""
	//}
	try{window.navigate("app:1234567@"+phone_num+""); } catch(e){};
};
/*function callout(o,hideo){
	alert(o+"_"+hideo)
};
*/
function callout(o,hideo){
	hideo = hideo?hideo:o;
	if(T(o).val()==""){
		T.loadTip(1,"���벻��Ϊ��!",1);
	}else{
		T(hideo).val()==""?T.tq_call_out(T(o).val()):T.tq_call_out(T(hideo).val())
	}
};

/*===���ʼ�===*/
function mailout(o){
	if(T(o).val()==""){
		T.loadTip(1,"�ʼ�����Ϊ��!",1);
	}else{
		window.open("mailto:"+ T(o).val())
		//window.location.href = "mailto:"+ T(o).val()
	}
};
/*===����ַ===*/
function checkeURL(URL){
	var strRegex = "^((https|http)?://)"  
         + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp��user@  
         + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP��ʽ��URL- 199.194.52.184  
         + "|" // ����IP��DOMAIN�������� 
         + "([0-9a-z_!~*'()-]+\.)*" // ����- www.  
         + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // ��������  
        + "[a-z]{2,6})" // first level domain- .com or .museum  
        + "(:[0-9]{1,4})?" // �˿�- :80  
        + "((/?)|" // a slash isn't required if there is no file name  
        + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";  
        var re=new RegExp(strRegex);  
  //re.test() 
        if (re.test(URL)){ 
            return (true);  
        }else{  
            return (false);  
        } 
};
function openurl(o){
	var oUrl = T(o).val();
	if(checkeURL(oUrl)){
		var urltype = oUrl.substr(0,4).toUpperCase();
		//alert(urltype);
		oUrl = (urltype!="HTTP"||urltype!="HTTPS")?"http://"+oUrl:oUrl;
		window.open(oUrl)
	}else{
		T.loadTip(1,"��ַ��ʽ����!",1)
	}
};
/*===������===*/
function wwwsearch(o){
	window.open("http://www.baidu.com/s?wd="+T(o).val()+"");
};
/*===��ѡԱ��===*/
function selectuser(o,isall,isdepartment,operate){//isall:1��ʾ����ȫ����Ա��Ϊ�ձ�ʾ����Ȩ������Ա
	var div = document.getElementById(o+"_w");
	if(!div){
			div = document.createElement("div");
			div.setAttribute('id',o+"_w");
			div.style.position = "absolute";
			div.style.border = "1px solid #889DAD";
			div.style.width = "353px";
			div.style.height = "200px";
			div.style.zIndex = "9999";
			div.innerHTML = "<iframe name='"+o+"' id='"+o+"_f' src='tqccresource/tq_js/danxuan.html?isall="+isall+"&operate="+operate+"&isdepartment="+isdepartment+"' width='100%' height='200' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>";
		};
		div.style.display = "block";
		var pos = T.gpos(o);
		div.style.left = pos.x  +"px";
		(T.gwh() + T.scrollFix().y - pos.y > 240)?div.style.top = pos.y + pos.height + "px":(div.style.top = "",div.style.bottom = T.gwh() - pos.y + "px");
		if(!document.getElementById(o+"_w")){
			document.body.appendChild(div);
		}else{		
			var iobj = document.getElementById(o+"_f"); 
			var ifobj = iobj.contentWindow.document.getElementById("querytext");
			if(ifobj){(ifobj.value!="")?ifobj.select():ifobj.focus()};
		};
		setTimeout(
			function(){document.body.onclick=function(e){
			 e=window.event?window.event:e;
			 var e_tar=e.srcElement?e.srcElement:e.target;
			 if(e_tar.id.indexOf(o)!=-1)
			 {
				  return;
			 }
			 else
			 {
				 T("#"+o+"_w")?document.body.removeChild(T("#"+o+"_w")):"";
			 };
			document.body.onclick=null;
		}},500)
};
/*===��ѡԱ��===*/
function selectusers(o,isall,isdepartment){//isall:1��ʾ����ȫ����Ա��Ϊ�ձ�ʾ����Ȩ������Ա
	//var pos = T.gpos(o);
	//var _left = pos.x;
	//var _top = pos.y + 21;
	//(T.gwh() - pos.y < 260)?_top = pos.y - 260:"";
/*	Twin({
		Id:o+"_seluser_win",
		Title:"ѡ��",
		//Left:_left,
		//Top:_top,
		Refer:o,
		Catch:false,
		zIndex:999,
		Width:353,
		Height:260,
		Mask:false,
		Content:"<iframe name='"+o+"' id='"+o+"_f' src='tqccresource/tq_js/duoxuan.html?isall="+isall+"&isdepartment="+isdepartment+"' width='100%' height='205' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>",
		buttons:[
			{dname:"ȷ��ѡ��",name:"ok",icon:"ok.gif",onpress:function(){
				var frameObj = document.getElementById(o+"_f").contentWindow;
				var ret = frameObj.getSels();
				var select_name = o; //������Ƶ�input��ID
				var select_id = o.substring(0,o.length-5); //������ƶ�Ӧid��input��ID
				if(T("#"+select_name)){
					T("#"+select_name).value = ret.select_names;
					T(select_name).acls("txt");
				};
				if(T("#"+select_id)){
					T("#"+select_id).value = ret.selids;
				};
				TwinC(o+"_seluser_win","","","",2);
				}
			},
			{dname:"�� ��",name:"deleteall",icon:"cancel.gif",onpress:function(){
				var select_name = o; //������Ƶ�input��ID
				var select_id = o.substring(0,o.length-5); //������ƶ�Ӧid��input��ID
				if(T("#"+select_name)){
					T("#"+select_name).value = "";
					T(select_name).acls("txt");
				};
				if(T("#"+select_id)){
					T("#"+select_id).value = "";
				};
				TwinC(o+"_seluser_win","","","",2);
				}
			},
			{dname:"ȡ ��",name:"cancel",icon:"",onpress:function(){TwinC(o+"_seluser_win","","","",2)}}
		]
	})
*/	
	var div = document.getElementById(o+"_w");
	if(!div){
			div = document.createElement("div");
			div.setAttribute('id',o+"_w");
			div.style.position = "absolute";
			div.style.border = "1px solid #889DAD";
			div.style.width = "353px";
			div.style.height = "235px";
			div.style.zIndex = "100";
			div.innerHTML = "<iframe name='"+o+"' id='"+o+"_f' src='tqccresource/tq_js/duoxuan.html?isall="+isall+"&isdepartment="+isdepartment+"' width='100%' height='235' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>";
		};
		div.style.display = "block";
		var pos = T.gpos(o);
		div.style.left = pos.x  +"px";
		(T.gwh() + T.scrollFix().y - pos.y > 240)?div.style.top = pos.y + pos.height + "px":(div.style.top = "",div.style.bottom = T.gwh() - pos.y + "px");
		if(!document.getElementById(o+"_w")){
			document.body.appendChild(div);
		}else{		
			var iobj = document.getElementById(o+"_f"); 
			var ifobj = iobj.contentWindow.document.getElementById("querytext");
			if(ifobj){(ifobj.value!="")?ifobj.select():ifobj.focus()};
		};
		setTimeout(
			function(){document.body.onclick=function(e){
				 e=window.event?window.event:e;
				 var e_tar=e.srcElement?e.srcElement:e.target;
				 if(e_tar.id.indexOf(o)!=-1)
				 {
					  return;
				 }
				 else
				 {
					T("#"+o+"_w")?document.body.removeChild(T("#"+o+"_w")):"";
					//T("#"+o+"_w").style.display="none";
				 };
				document.body.onclick=null;
			}
		},500)
};
/*===�½��ͻ�===*/
function CreateC(url,title){
	Twin({Id:"CreateClient_win",Title:title,Width:"800",Height:"auto",sysfun:function(tObj){
			CreateRecordF = new TQForm({
				formFunId:"CreateRecordF",
				formname: "client_add_f",
				formid:"CreateRecordF",
				formObj:tObj,
				recordid:"id",
				suburl:url,//"clientmanage.do?action=create",
				method:"POST",
				formAttr:[{
					formitems:getCleintFields(1),
					rules:function(){
						var l = CvalidateFields();
						for(var m=0;m<l.length;m++){
							if(!l[m].type){l[m].type=""};
							if(l[m].type.indexOf("ajax")!=-1){
								l[m].url = "visitorInfomation.do?oper=testValue&col="+l[m].name+"&operate=create&value="
							}
						};
						return l
					}()
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ ��", tit:"ȡ��"+title,iconcls:"", onpress:function(){TwinC("CreateClient_win");} }
				],
				Callback:
				function(f,rcd,ret,o){
					if(ret=="1"||ret.indexOf('success')!=-1){
						T.loadTip(1,"�½��ɹ���",2,"");
						TwinC("CreateClient_win");
						if(typeof(_clientT)==="object"){
							_clientT.M()
						}
					}else{
						T.loadTip(1,"�½�ʧ�ܣ������ԣ�",2,o)
					}
				}
			});	
			CreateRecordF.C();
		}
	})
};


	
/*===�½���Ʒ===*/
function Cproduct(url,title,callback){
	var fitems;
	var fvalue;
	if(typeof(getProductFields)=="function"&&typeof(ProvalidateFields)=="function"){
		fitems = getProductFields(1);
		fvalue = ProvalidateFields()
	}else{
		var ajaxfitem = eval(T.A.sendData("productmanage.do?action=getmodel&r="+Math.random()));
		fitems = ajaxfitem[0].fields[0];
		fvalue = ajaxfitem[0].validateFields;
		fvalue.push({name:'product_name',type:'',url:'',requir:true,warn:'',okmsg:''})
		fvalue.push({name:'product_type',type:'',url:'',requir:true,warn:'',okmsg:''})

	};
	Twin({Id:"CreateProductt_win",Title:title,Width:"750",Height:"auto",sysfun:function(tObj){
			Tform({
				formname: "product_add_f",
				formObj:tObj,
				recordid:"id",
				suburl:url,//"clientmanage.do?action=create",
				method:"POST",
				formAttr:[{
					formitems:fitems,
					rules:function(){
						var l = fvalue;
						return l
					}()
				}],
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ��"+title,icon:"cancel.gif", onpress:function(){TwinC("CreateProductt_win");} }
				],
				Callback:
				function(f,rcd,ret,o){
					if(ret=="1"||ret.indexOf('success')!=-1){
						T.loadTip(1,"�½��ɹ���",2,"");
						TwinC("CreateProductt_win");
						callback?callback():"";
					}else{
						T.loadTip(1,"�½�ʧ�ܣ������ԣ�",2,o)
					}
				}
			});	
		}
	})
};
/*===ѡ��ͻ�===*/
function selcetClient(cid,cobj){//cobj:��������
    Twin({
		Coverobj:cobj,
        Id:"selClient_w",
        Width:600,
        Height:350,
		Title:"ѡ��ͻ�",
		sysfunI:cid,
    	sysfun:function(cid,tObj){
    		T.A.sendData("clientmanage.do","POST","action=getmodel",
				function(r){
					var fielditems = r[0];
					var _SclientT = new TQTable({
		            	tableObj:tObj,
						fieldorder:fielditems.searchSort[0].sort.toString(),
		    			checktype:"radio",
		            	tablename:"client_search_t",
						trclickfun:true,
						dataUrl:"clientmanage.do",
		            	param:"action=quickquery&type=allclient",
						searchitem:[
							{name:"�ͻ�����",field:"client_name",type:"text",isdefault:true},
							{name:"�ͻ��ֻ�",field:"client_mobile",type:"text"},
							{name:"�̶��绰",field:"client_telephone",type:"text"},
							{name:"��˾����",field:"client_company",type:"text"},
							{name:"�ͻ���ַ",field:"client_adress",type:"text"}
						],
		    			buttons:[{
		    				name: "ok",
		    				dname: "ȷ��ѡ��",
		    				iconcls: "icon16 icon16ok fl",
		    				tit:"ȷ��ѡ��",
		    				onpress:function(){
		        				if(_SclientT.GS()){
		        					T("#"+cid).value = _SclientT.GS(1);
		    						TwinC("selClient_w","","",cobj)
		        				};
		    				
		    				}
		    			},{
		    				name: "cancel",
		    				dname: "ȡ��",
		    				iconcls: "icon16 icon16cancel fl",
		    				tit:"ȡ��ѡ��",
		    				onpress:function(){
		    					TwinC("selClient_w","","",cobj)
		    				}
		    			}
						],
					tableitems:fielditems.fields[0].kinditemts
		        	});
					_SclientT.C()	
				},2,tObj);
   		}
 	})
};
/*===���ݿͻ�idѡ����ϵ��===*/
function selcetLinkMan(cid,cobj,pid){//cobj:�������� pid ���ͻ�id
    Twin({
		Coverobj:cobj,
        Id:"selContact_w",
        Width:600,
        Height:350,
		Title:"ѡ����ϵ��",
		sysfunI:cid,
    	sysfun:function(cid,tObj){
    		T.A.sendData("contactmanage.do","POST","action=getmodel",
				function(r){
					var fielditems = r[0];
					var _ScontactT = new TQTable({
		            	tableObj:tObj,
						fieldorder:fielditems.searchSort[0].sort.toString(),
		    			checktype:"radio",
		            	tablename:"client_search_t",
						trclickfun:true,
						dataUrl:"contactmanage.do",
		            	param:"action=query&range=&visitor_id="+pid,
						searchitem:[
							{name:"��ϵ������",field:"client_name",type:"text",isdefault:true}
						],
		    			buttons:[{
		    				name: "ok",
		    				dname: "ȷ��ѡ��",
		    				iconcls: "icon16 icon16ok fl",
		    				tit:"ȷ��ѡ��",
		    				onpress:function(){
		        				if(_ScontactT.GS()){
		        					T("#"+cid).value = _ScontactT.GS(1);
		    						TwinC("selContact_w","","",cobj)
		        				};
		    				
		    				}
		    			},{
		    				name: "cancel",
		    				dname: "ȡ��",
		    				iconcls: "icon16 icon16cancel fl",
		    				tit:"ȡ��ѡ��",
		    				onpress:function(){
		    					TwinC("selContact_w","","",cobj)
		    				}
		    			}
						],
					tableitems:fielditems.fields[0].kinditemts
		        	});
					_ScontactT.C()	
				},2,tObj);
   		}
 	})
};
/*===����ͻ�===*/
function ImportC(){
	var content="<div align=center></br>"+
        	"<font color=RED size=3></font><form name='inportform' id='inportform' method='post'  onsubmit='return checkInput();'"+
        	" action='importVisitorInfo.do' encType='multipart/form-data'> "+
        	"<table>"+
        	"<tr height='40px'><td align='right'>�ļ�����</td><td align='left'>"+
			"<input type='file' name='upfile' id='upfile' size='35'/>&nbsp;&nbsp;<input type='hidden' name ='oper' value='preimport'/><input type='hidden' name ='type' value='importvisitors'/></td></tr>"+
            "<tr><td align='right'><font color='green'>˵����</font></td><td align='left'>"+
            "<font color='green'>����ǰ���������ļ���ͷ���Զ������Ƿ��Ӧ;</font><br/>"+
            "<font color='green'>·���в����������ַ�;</font><br/>"+
             "<font color='green'>֧��Excel2007�ļ���.xlsx������;</font><br/><span id='errroraaa'></span></td></tr>"+
             "<tr><td align='right'></td><td align='right'><button type='submit' class='button'>��ʼ����</button></td></tr>"+
			"</table></form>"+
			"</div>";
	Twin({Id:"CreateClient_win",Title:"����ͻ�",Width:"400",Height:"200",Content:content})
};
/*===�߼�����===*/
var tqsearchForm = null;
function supperSerach(formitems,SubAction,SubFun,LoadFun,fieldorder,isInView,tableViewTree){
	//�Ƿ���ʾ�ڵ�ǰ��ͼ��ѯ
	var _isInView = (isInView == "no")?false:true;
	tableViewTree = tableViewTree?tableViewTree:("undefined"!=typeof(Client_TREE)?Client_TREE:false);
	Twin({Catch:false,Id:"tq_supper_search_win",Title:"�߼�����",Width:"850",Height:"auto",sysfun:function(tObj){
			tqsearchForm = new TQSForm({
				formname: "tq_supper_search_f",
				formObj:tObj,
				formFunId:"tqsearchForm",//����
				suburl:"action=query",
				method:"POST",
				fieldorder:fieldorder,
				loadfun:LoadFun?LoadFun:null,
				subFun:SubFun?SubFun:null,
				SubAction:SubAction||function(f,o,url){
					var viewCondition = "|type|ownner|days|csqlid|";
					var extargs = "";
					if(tableViewTree&&T("#tq_supper_search_f_range")&&T("#tq_supper_search_f_range").checked == true){
						var nPvalue = tableViewTree.tc.nodeFnArgs;
						var FocusArgs = tableViewTree.getFocus();
						T.each(nPvalue.split(","),function(o,m){
							viewCondition.indexOf("|"+o+"|")!=-1?extargs += "&"+o+"="+T.utf8(FocusArgs[o]):""
						});
					};
					if(typeof(_workBillT)=='object'){
						_workBillT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:url+extargs+"&"+Serializ(o)
						},"","");
					}else{
						_clientT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:url+extargs+"&"+Serializ(o)
							//addtionitem:{fieldname:"client_flag",fieldcnname:"����״̬",inputtype:"text",hide:true,process:function(v){
							//	if(v==1){return "<font style=\"color:blue\">����վ</font>"}else if(v==2){return "<font style=\"color:#c00\">�ͻ���</font>"}
							//	else{return "<font style=\"color:green\">�и�����</font>"}}}
						})
					}
				},
				formAttr:[{
					formitems:formitems||getCleintFields()
				}],
				otherformAttr:
				function(){
					if(_isInView){
						return [{kindname:'',kinditemts:[{fieldcnname:"��ѯ��Χ",fieldname:"range",fieldvalue:'',inputtype:"checkbox",noList:[{value_name:"��ǰ��ͼ������",value_no:"1"}]}]	}]
					}else{
						return false
					}
				}(),
				buttons : [//����
					{name: "cancel", dname: "ȡ��", tit:"ȡ����ѯ",iconcls:"icon16 icon16cancel fl", onpress:function(){TwinC("tq_supper_search_win",true);} }
				]
			});	
			tqsearchForm.conditionField = [];
		}
	})
};
/*===�Զ�����ͼ===*/
function  defineSerach(){
	Twin({Id:"defineSerach_client_win",Title:"��ӿͻ��б�����ͼ",Width:"850",Height:"auto",sysfun:function(tObj){
			TSform({
				formname: "defineSerach_client__f",
				formObj:tObj,
				suburl:"action=query",
				method:"POST",
				dbuttons:false,
				formAttr:[{
					formitems:getCleintFields(),
					rules:[{name:'model_name',requir:true,warn:'��������ģ������',okmsg:''}]
				}],
				otherformAttr:[
					{
						kindname:'',
						kinditemts:
							[
								{fieldcnname:"ģ������",fieldname:"model_name",fieldvalue:'',inputtype:"text","hide":false}
							]
					}
				],
				buttons : [//����
					{name: "cancel", dname: "ȷ�����", tit:"���ȷ��",icon:"ok.gif", onpress:function(){
						TwinC("defineSerach_client_win");}
					},
					{name: "cancel", dname: "ȡ��", tit:"ȡ��",icon:"cancel.gif", onpress:function(){TwinC("defineSerach_client_win");} }
				],
				Callback:
					function(){
						TwinC("CreateClient_win");
					}
			});	
		}
	})
};
/*����ID��ѯ�������ͻ���Ϣ
  id:�ͻ�id
  isedit:�Ƿ�ɱ༭
  callback:�ɱ༭ʱ�ص�����
*/
var show_visitor_form = "";
function show_visitor(id,isedit,callback,coverobj){
	if(!id){T.loadTip(1,"ֵΪ��ʱ�����ɲ�ѯ�ͻ�����",2);return};
	var isedit = isedit||false;
	Twin({Id:"client_detail",Coverobj:coverobj,zIndex:10,Title:"�鿴�ͻ���Ϣ",Width:750,Height:500,sysfunI:id,sysfun:function(id,tObj){
			T.A.sendData("ajaxclient.do?action=getmodel","POST","visitor_id="+id,
				function(f){
					show_visitor_form = new TQForm({
						formname: "client_detail_f",
						formObj:tObj,
						formFunId:"show_visitor_form",
						suburl:"clientmanage.do?action=edit",
						method:"POST",
						formAttr:[{
							formitems:f[0].fields,
							rules:f[0].validateFields
						}],
						buttons : [//����
							{name: "cancel", dname: "�ر�", tit:"�ر�",icon:"cancel.gif", onpress:function(){TwinC("client_detail")} }
						],
						formpower:isedit,
						Callback:callback||function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"����ɹ���",2,"");
								TwinC("client_detail");
							}else{
								T.loadTip(1,"����ʧ�ܣ������ԣ�",2,o)
							}
						}
			    	});	
			    	show_visitor_form.C();
				},2,tObj);
    	}
    })
}
/*����ID��ѯ��������ϵ����Ϣ
  id:�ͻ�id
  isedit:�Ƿ�ɱ༭
  callback:�ɱ༭ʱ�ص�����
*/
var show_linkman_form = "";
function show_linkman(id,isedit,callback,coverobj){
	if(!id){T.loadTip(1,"ֵΪ��ʱ�����ɲ�ѯ��ϵ������",2);return};
	var isedit = isedit||false;
	Twin({Id:"contact_detail",Coverobj:coverobj,zIndex:10,Title:"�鿴��ϵ����Ϣ",Width:750,Height:400,sysfunI:id,sysfun:function(id,tObj){
			T.A.sendData("contactmanage.do?action=getmodel","POST","id="+id,
				function(f){
					show_visitor_form = new TQForm({
						formname: "client_detail_f",
						formObj:tObj,
						formFunId:"show_visitor_form",
						geturl:"contactmanage.do?action=simplequery&colname=id&value="+id,
						suburl:"clientmanage.do?action=edit",
						method:"POST",
						formAttr:[{
							formitems:f[0].fields,
							rules:f[0].validateFields
						}],
						buttons : [//����
							{name: "cancel", dname: "�ر�", tit:"�ر�",iconcls:"icon16 icon16cancel fl", onpress:function(){TwinC("contact_detail")} }
						],
						formpower:isedit,
						Callback:callback||function(f,rcd,ret,o){
							if(ret=="1"){
								T.loadTip(1,"����ɹ���",2,"");
								TwinC("contact_detail");
							}else{
								T.loadTip(1,"����ʧ�ܣ������ԣ�",2,o)
							}
						}
			    	});	
			    	show_visitor_form.C();
				},2,tObj);
    	}
    })
}


/*===������===*/
function QuickCreate(eo,o,w,h){//eo��괥������,oλ�ö���,w���(Ϊ��ʱΪλ�ö�����),h�߶�(Ϊ��ʱΪauto
	var c = document.createElement("div");
	var chtml = [];
	//chtml.push("<a href=\"#\" onclick=\"javascript:alert('d')\"><img src=\"FT_images/bg/d4.png\"></a>");
	var auth_cc =(auth_addclient)?"":" disabled=true ";
	chtml.push("<a class=\"qmenu\" href=\"javascript:void(0)\" "+auth_cc+" onclick=\"CreateC()\"><span class=\"icon_client\"></span>�½��ͻ�</a>");
	chtml.push("<a class=\"qmenu\" href=\"javascript:void(0)\" onclick=\"CreateC()\"><span class=\"icon_client\"></span>�½���ϵ��</a>");
	chtml.push("<a class=\"qmenu\" href=\"javascript:void(0)\" onclick=\"CreateC()\"><span class=\"icon_plan\"></span>�½��ճ�/����</a>");
	chtml.push("<a class=\"qmenu\" href=\"javascript:void(0)\" onclick=\"CreateC()\"><span class=\"icon_orders\"></span>�½���ͬ/����</a>");
	chtml.push("<a class=\"qmenu\" href=\"javascript:void(0)\" onclick=\"CreateC()\"><span class=\"icon_product\"></span>�½�����</a>");
	c.innerHTML = chtml.join("");	
	var w = w?w:T("#"+o).offsetWidth;
	var div = document.getElementById(eo+"_w");
	if(!div){
			div = document.createElement("div");
			div.setAttribute('id',eo+"_w");
			div.style.position = "absolute";
			div.style.border = "1px solid #98BFE2";
			div.style.background = "#fff";
			div.style.width = w + 1 + "px";
			div.style.overflow = "hidden";
			div.style.height = h?h+"px":"auto";
			div.style.zIndex = "100";
		};
		div.innerHTML = "";	
		div.appendChild(c);
		div.style.display = "block";
		var pos = T.gpos(o);
		div.style.left = pos.x +"px";
		(T.gwh() - pos.y > 40)?div.style.top = pos.y + T("#"+o).offsetHeight - 2 + "px":(div.style.top = "",div.style.bottom = T.gwh() - pos.y + "px");
		if(!document.getElementById(eo+"_w")){
			document.body.appendChild(div);
		};
		setTimeout(
			function(){document.body.onclick=function(e){
			 e=window.event?window.event:e;
			 var e_tar=e.srcElement?e.srcElement:e.target;
			 if(e_tar.id==eo)
			 {
				return;
			 }
			 else
			 {
				T("#"+eo+"_w").style.display="none";
			 }
		}},500)
};


function checkInput(){
	var value=document.getElementById('upfile').value;
	var errormsg = "";
	if(value=='')
		errormsg="��ѡ���ļ���";
	else{
		var fur = value.substring(value.length-4);
		if(fur.indexOf('xls')==-1&&fur.indexOf('xlsx')==-1)
			errormsg ='�ļ������Ϸ���';
	}
	if(value.length!=value.replace(/[^\x00-\xff]/g,"**").length)
		errormsg="�ļ������ܰ��������ַ���";
	if(errormsg!=''){
		document.getElementById('errroraaa').innerHTML ="<font color=red>"+errormsg+"</font>";
		return false;
	}else
		document.getElementById('errroraaa').innerHTML ="<font color=red>���ڵ��룬���Ժ�....</font>";
	return true;
};
String.prototype.gb=function(){
	return escape(this.toString());
};
String.prototype.utf8=function(){
	return  escape(encodeURIComponent(this.toString()));
};

//���л���
function Serializ(nodes,charset,updateFieldStr){//noFieldStr Ϊtureʱ�ύupdatefieldstr��������̨,Ϊ�ջ�δ����ʱ���ύ
		charset = charset?charset.toLowerCase():"utf-8";
		nodes = document.forms[nodes];
		var data="";
		var updatefieldstr = []; 
		for(var i=0;i<nodes.length;i++){
			if(nodes[i].getAttribute("nosub")=="true"){continue;}
			if(T.trim(nodes[i].name)==""){continue;}
			updatefieldstr.join(",").indexOf(nodes[i].name)==-1?updatefieldstr.push(nodes[i].name):"";
			if(nodes[i].type.toLowerCase()=="checkbox"){
				if(nodes[i].checked==true){
					if(charset=="utf-8"){
						data += nodes[i].name + "=" + (T.trim(nodes[i].value)=="" ? "": nodes[i].value.utf8()) + "&";
					}else{
						data += nodes[i].name + "=" + (T.trim(nodes[i].value)=="" ? "": nodes[i].value).gb() + "&";
					}
				}else{
					data += nodes[i].name + "=&";
				}
			}else if(nodes[i].type.toLowerCase()=="radio"){
				if(nodes[i].checked==true){
					if(charset=="utf-8"){
						data += nodes[i].name + "=" + (T.trim(nodes[i].value)=="" ? "": nodes[i].value.utf8()) + "&";
					}else{
						data += nodes[i].name + "=" + (T.trim(nodes[i].value)=="" ? "": nodes[i].value).gb() + "&";
					}
				}
			}
			else{
				if(charset=="utf-8"){
					data += nodes[i].name + "=" + T.trim(nodes[i].value).utf8() + "&";
				}else{
					data += nodes[i].name + "=" + T.trim(nodes[i].value).gb() + "&";	
				};
			}		
		};
		updateFieldStr?data += "updatefieldstr="+updatefieldstr.join("__")+"&":"";
		return data; 
	};
	
function DragFun(obj,t,fixfun){//0x,1y,fixfun�����¼�(��������С,����С��)
	obj.onmousedown = function(evt){//��ʼ
		var mObj;
		if(t==0){
			var xDrag = document.getElementById("Layout_xDrag");
			if(!xDrag){
				xDrag = document.createElement("div");
				xDrag.id = "Layout_xDrag";
				xDrag.style.cssText="display:block;border-left:dotted 1px #000;z-index:9999;position:absolute;width:5px;height:2000px;top:0px;left:-10px;cursor:e-resize";
				document.body.appendChild(xDrag)
			};
			mObj = xDrag;
		}else if(t==1){
			var yDrag = document.getElementById("Layout_yDrag");
			if(!yDrag){
				yDrag = document.createElement("div");
				yDrag.id = "Layout_yDrag";
				yDrag.style.cssText="display:block;border-top:dotted 1px #000;z-index:9999;position:absolute;width:2000px;height:5px;top:-10px;left:0px;cursor:s-resize;";
				document.body.appendChild(yDrag)
			};
			mObj = yDrag;
		}else{
			return	
		};
		
		var oldposX = this.offsetLeft;
		var oldposY = this.offsetTop;
		var evt = evt || window.event;
		var pos = T.gpos(this);
		mObj.style.display = "block";
		if(t==0){
			var preX = evt.clientX;
			mObj.style.left = preX + "px";
		}else{
			var preY = evt.clientY;
			mObj.style.left = pos.x + "px";
			mObj.style.top = preY + "px";
		};
		if ((!window.captureEvents)&&(!evt.preventDefault)) { //��IE
			mObj.setCapture(); 
			mObj.onmousemove = function(evt){//�϶�
				var evt = evt || window.event; 
				var newX = evt.clientX;
				var newY = evt.clientY;
				t==0?mObj.style.left=newX+"px":mObj.style.top=newY+"px";
			};
			mObj.onmouseup = IeDragX;
		}else { //��IE��IE9.0
			T("doc").aevt("mousemove",NotIeDragCol,"");
			T("doc").aevt("mouseup",NotIeDragX,"");
			evt.preventDefault()
		};
		function IeDragX(evt){ //IE�ı��п�
			mObj.releaseCapture(); 
			mObj.onmousemove = null;
			mObj.onmouseup = null;
			var evt = event;
			if(t==0){
				var newX = evt.clientX;
				var newWidth =  newX - preX + oldposX + 4;
				if(newWidth<50) newWidth = 50;
				if(newWidth>T.gww()-200) newWidth = T.gww() - 200;
				mObj.style.left = "-10px";
				layoutL.style.width = newWidth + "px";
				T.scok(layoutL.id,newWidth);//����cookie
			}else{
				var newY = evt.clientY;
				var newHeight =  T.gwh() - newY;
				if(newHeight<100) newHeight = 100;
				if(newHeight>T.gwh()-150) newHeight = T.gwh() - 150;
				//mObj.style.top = "-10px";
				mObj.style.display = "none";
				layoutR_B.style.height = newHeight - bheight + "px";
				T.scok(layoutR_B.id,newHeight - bheight);//����cookie
			};
			ResizeLayout();
			if(fixfun){
				T.each(fixfun,function(o,j){
					o.f(o.p)
				})
			};
			document.unselectable  = "off";
			document.onselectstart = null
		};
		function NotIeDragCol(evt){//��IE�϶�
			var newX = evt.clientX;
			var newY = evt.clientY;
			t==0?mObj.style.left=newX + "px":mObj.style.top=newY+"px";
		};
		function NotIeDragX(evt){//��IE�ı���
			T("doc").revt("mouseup",NotIeDragX,"");
			T("doc").revt("mousemove",NotIeDragCol,"");
			if(t==0){
				var newX = evt.clientX;
				var newWidth =  newX - preX + oldposX - 2;
				if(newWidth<50) newWidth = 50;
				if(newWidth>T.gww()-200) newWidth = T.gww() - 200;
				mObj.style.left = "-10px";
				layoutL.style.width = newWidth + "px";
				T.scok(layoutL.id,newWidth);//����cookie
			}else{
				var newY = evt.clientY;
				var newHeight =  T.gwh() - newY;
				if(newHeight<100) newHeight = 100;
				if(newHeight>T.gwh()-150) newHeight = T.gwh() - 150;
				//mObj.style.top = "-10px";
				mObj.style.display = "none";
				layoutR_B.style.height = newHeight - bheight + "px";
				T.scok(layoutR_B.id,newHeight - bheight);//����cookie
			};
			ResizeLayout();
			if(fixfun){
				T.each(fixfun,function(o,j){
					o.f()//o.f(o.p)
				})
			};
			if(typeof userSelect === "string"){
				return document.documentElement.style[userSelect] = "text";
			}
			document.unselectable  = "off";
			document.onselectstart = null
		}
	}
};
//�°�������ѡ��
//clickfun ��Ϊ��������,���������в�����˫����

function treeSelect(formid,inputobj,dataurl,clickfun){
		var _dataType = (dataurl!="undefined"&&dataurl!=""&&dataurl!="null"&&dataurl.indexOf('.do')!=-1)?"1":"0";
		var o = inputobj.id;
		var n = inputobj.name;
		n = n.substring(0,n.length-5);
		var select_name = o; //������Ƶ�input��ID
		var select_id = o.substring(0,o.length-5); //������ƶ�Ӧid��input��ID
		var expandLevel=2;
		if(dataurl.indexOf('localdata')!=-1)//�ͻ�������ֻչʾһ��
			expandLevel=1;
		var isTool = _dataType == 1?true:false;
		var isSearch=true;
		if(_dataType=='0'){
			isSearch=false;
			var formFunction = eval(formid);
			var treeData = {},dataObj = formFunction.GFA(n,"noList");
			var id,name,_i=0;
			for(var i=0,j=dataObj.length;i<j;i++){
				id = dataObj[i].value_no;
				name = dataObj[i].value_name;
				treeData["root_"+dataObj[i].value_no] = {id:id,name:name};
				_i += 1;
			};
			_i>15?isSearch=true:"";
		}
		//alert(isSearch);
		var _Twin = new Twindow({
			Id:o+"_win",
			Title:"ѡ��",
			TitleH:26,
			Refer:inputobj,
			Width:200,
			MaxH:280,
			MinH:false,
			//Coverobj:formFunction.tc.formObj,
			zIndex:100001,
			Mask:false,
			sysfun:function(tObj){
				tObj.style.overflow = "auto";
				tObj.style.background = "#EDF1F8";
				tObj.style.borderBottom = "1px solid #ccc";
				function selOK(selid,seltext){
					var sname = (selid!=""&&seltext!="��ѡ��")?seltext:"";
					T("#"+select_name)?T("#"+select_name).value = sname:"";
					T("#"+select_id)?T("#"+select_id).value = selid:"";
					if(clickfun)clickfun(selid,seltext);
					TwinC(o+"_win",false,"","",2);
				};
				eval(""+o+"_tree_select = new tqTree({"+
					"treeId:\""+o+"_tree_select\","+
					"treeObj:tObj,"+
					"isSearch:"+isSearch+","+
					"isTool:"+isTool+","+
					"dataType:"+_dataType+","+
					"dataUrl:dataurl,"+
					"ajaxTip:T('#"+o+"').parentNode,"+
					"MinH:200,"+
					"localData:treeData,"+
					"nodeFnArgs:\"id,name\","+
					"loadfun:function(id,name){"+
					"eval(o+'_tree_select').expandLevel("+expandLevel+");"+
					//"	T('#winbody_"+o+"_win').style.height='200px'"+
					"},"+
					"nodeClick:function(id,name){"+
					"	selOK(id,name)"+
					"}"+
				"});");
				eval(o+"_tree_select").C();
			},
			CloseFn : function(){
				eval(""+o+"_tree_select = null");
			},
			buttons:[
			{dname:"x ���",tit:"��յ�ǰ�������ֵ",iconcls:"",onpress:function(){
				T("#"+select_name)?T("#"+select_name).value = "":"";
				T("#"+select_id)?T("#"+select_id).value = "":"";
				if(clickfun)clickfun();
				TwinC(o+"_win",false,"","",2);
			}},
			{dname:"ȡ ��",iconcls:"",onpress:function(){
				eval(""+o+"_tree_select = null");
				TwinC(o+"_win",false,"","",2);
			}}
			]
		});
		_Twin.C();
		setTimeout(
			function(){document.body.onclick=function(e){
			 e=window.event?window.event:e;
			 var e_tar=e.srcElement?e.srcElement:e.target;
			 if(e_tar.id.indexOf(o)!=-1)
			 {
				  return;
			 }
			 else
			 {
			 	TwinC(o+"_win",false,"","",2);
			 };
			document.body.onclick=null;
		}},500)
};
/*===����ѡ���cactic===*/
function selectCactic(o,isall,dataurl,type){//isall:1��ʾ����ȫ�����ݣ�Ϊ�ձ�ʾ����Ȩ��������,tree��ֵ�����ַajax
	if(type=="win"&&dataurl!="undefined"){
		Twin({
			Id:o+"_cactic_win",
			Title:"ѡ��",
			TitleH:26,
			Refer:T("#"+o),
			Width:200,
			Height:200,
			Mask:false,
			sysfun:function(tObj){
				tObj.style.overflow = "auto";
				var select_name = o; //������Ƶ�input��ID
				var select_id = o.substring(0,o.length-5); //������ƶ�Ӧid��input��ID
				function selOK(selid,seltext){
					//var sname = selid!=""?seltext+"("+selid+")":"";
					var sname = selid!=""?seltext:"";
					T("#"+select_name)?T("#"+select_name).value = sname:"";
					T("#"+select_id)?T("#"+select_id).value = selid:"";
					TwinC(o+"_cactic_win",false,"","",2);
				};

				var treeDataUrl = dataurl||"demodata.txt";
				var t = new TQTree({
					treeid:o+"_tree",
					treename:"��ѡ��",
					allopen:true,
					treeObj:tObj,
					dataUrl:treeDataUrl,
					rootClick:function(id,name){
						selOK("","")
					},
					nodeClick:function(id,name){
						selOK(id,name)
					}
				});
				t.C();
			}
		})
	}else{
		var div = document.getElementById(o+"_w");
		if(!div){
				div = document.createElement("div");
				div.setAttribute('id',o+"_w");
				div.style.position = "absolute";
				div.style.border = "1px solid #889DAD";
				div.style.width = "180px";
				div.style.height = "200px";
				div.style.zIndex = "100";
				div.innerHTML = "<iframe name='"+o+"' id='"+o+"_f' src='/vip/tqccresource/tq_js/tqtree.html?isall="+isall+"' width='100%' height='200' frameborder='0' scrolling='no' style='overflow:hidden;' ></iframe>";
			};
			div.style.display = "block";
			var pos = T.gpos(o);
			div.style.left = pos.x  +"px";
			(T.gwh() + T.scrollFix().y - pos.y > 240)?div.style.top = pos.y + pos.height  + "px":(div.style.top  = pos.y - pos.height - 177 + "px");
			if(!document.getElementById(o+"_w")){
				document.body.appendChild(div);
			};
		setTimeout(
			function(){document.body.onclick=function(e){
				 e=window.event?window.event:e;
				 var e_tar=e.srcElement?e.srcElement:e.target;
				 if(e_tar.id.indexOf(o)!=-1)
				 {
					  return;
				 }
				 else
				 {
					 T("#"+o+"_w")?document.body.removeChild(T("#"+o+"_w")):"";
				 };
				document.body.onclick=null;
			}},500)
	}
};


function getParam(paramName)
{
        paramValue = "";
        isFound = false;
        if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=")>1)
        {
            arrSource = unescape(this.location.search).substring(1,this.location.search.length).split("&");
            i = 0;
            while (i < arrSource.length && !isFound)
            {
                if (arrSource[i].indexOf("=") > 0)
                {
                     if (arrSource[i].split("=")[0].toLowerCase()==paramName.toLowerCase())
                     {
                        paramValue = arrSource[i].split("=")[1];
                        isFound = true;
                     }
                }
                i++;
            }   
        }
   return paramValue;
};
function banKeySpace(e){   
    var ev = e || window.event;//��ȡevent����   
    var obj = ev.target || ev.srcElement;//��ȡ�¼�Դ   
    var t = obj.type || obj.getAttribute('type');//��ȡ�¼�Դ����  
    //��ȡ��Ϊ�ж��������¼�����
    var vReadOnly = obj.getAttribute('readonly');
    var vEnabled = obj.getAttribute('enabled');
    //����nullֵ���
    vReadOnly = (vReadOnly == null) ? false : vReadOnly;
    vEnabled = (vEnabled == null) ? true : vEnabled;
    //����Backspace��ʱ���¼�Դ����Ϊ������С������ı��ģ�
    //����readonly����Ϊtrue��enabled����Ϊfalse�ģ����˸��ʧЧ
    var flag1=(ev.keyCode == 8 && (t=="password" || t=="text" || t=="textarea") && (vReadOnly==true || vEnabled!=true))?true:false;
    //����Backspace��ʱ���¼�Դ���ͷ�������С������ı��ģ����˸��ʧЧ
    var flag2=(ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")?true:false;        
    //�ж�
    if(flag2){
		ev.keyCode=0;
        return false;
    }
    if(flag1){   
        ev.keyCode=0;
		return false;   
    };
	if((ev.keyCode==116)||//����F5  
		(ev.ctrlKey  &&  ev.keyCode==82)){//Ctrl+R  
		ev.keyCode=0;  
		return false;  
	};
	if(ev.keyCode==122){ev.keyCode=0;return false}; //����F11  
	if(ev.ctrlKey  &&  ev.keyCode==78){return false}; //����  Ctrl+n  
	if(ev.shiftKey  &&  ev.keyCode==121){return false}//����  shift+F10  
	
};
function show_select(input, btn, option, value,formid ,conditioninput) {
	conditioninput = conditioninput||"value";
    inputobj = document.getElementById(input);
    btnobj = document.getElementById(btn);
    optionobj = document.getElementById(option);
    valueobj = document.getElementById(value);
    optionobj.parentNode.style.display = "block";
    optionobj.style.display = optionobj.style.display == "" ? "none": "";
	optionobj.style.left =T.gpos(inputobj).left +"px";
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
			var conditionObj = document.forms[formid][conditioninput];
			var conditionParent = conditionObj.parentNode;
			var inputtype = this.getAttribute("inputtype")||"text";
			var nHtml = "";
			switch(inputtype){
				case "date":
					nHtml = "<input type=\"text\" title=\"˫�����\" style=\"width:90px;height:21px;padding:0px;margin:0px;border:0px;float:left\" name=\""+conditioninput+"\" id=\""+(formid+"_"+conditioninput)+"\" autocomplete=\"off\" ondblclick=\"this.value=''\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'{%y-1}-%M-%d',maxDate:'{%y+1}-%M-%d',readOnly:true});\">"
					break;
				default:
				nHtml = "<input type=\"text\" title=\"˫�����\" style=\"width:90px;height:21px;padding:0px;margin:0px;border:0px;float:left\" name=\""+conditioninput+"\" id=\""+(formid+"_"+conditioninput)+"\" autocomplete=\"off\" ondblclick=\"this.value=''\">"
			}
			conditionParent.innerHTML = nHtml;
			conditionParent.firstChild.focus();
			
            optionobj.blur();
        }
    }
};
//���ݿͻ�ID��ȡ�ͻ�����
function GetClientName(id){
	var clientInfo = eval(T.A.sendData("/vip/ajaxclient.do?action=getmodel&visitor_id="+id+"&r="+Math.random()+""));
	clientInfo = clientInfo[0].fields[0].kinditemts;
	var rvalue = "";
	for (var i = 0;i<clientInfo.length;i++){
		if(clientInfo[i].fieldname=="client_name"){
			rvalue += clientInfo[i].fieldvalue
		};
	};
	return rvalue
}
//IVR�ڵ�ѡ��
function ivrNodeSelect(formFunId,inputobj,ivrtype,seatId){
		var o = inputobj.id;
		var n = inputobj.name;
		var uboxid = inputobj.getAttribute("uboxid");
		n = n.substring(0,n.length-5);
		var select_name = o; //������Ƶ�input��ID
		var select_id = o.substring(0,o.length-5); //������ƶ�Ӧid��input��ID
		
		var formFunction = eval(formFunId);
		var treeData = {},dataObj = IvrNodeList[uboxid].nodeList;
		joinNode(dataObj);//ƴ�ӹҶ� ��Ч��ʶ
		if(typeof(ivrtype)=="undefined"){
			if(typeof(seatId)=="undefined"){//����ϯ����
				dataObj=dnisNodeList[uboxid].nodeList;
			}
		}else{
			if(ivrtype=="ivr_voice_avigation"){
				dataObj.unshift({"value_name":"��Ч����","value_no":-1});
			}else if(ivrtype=="dnis_number_tb"){
				
			}else{
				dataObj.unshift({"value_name":"�Ҷ�","value_no":-2});
			}
		}
		var id,name,isSearch=false,_i=0;
		for(var i=0,j=dataObj.length;i<j;i++){
			id = dataObj[i].value_no;
			name = dataObj[i].value_name;
			treeData["root_"+dataObj[i].value_no] = {id:id,name:name};
			_i += 1;
		};
		_i>15?isSearch=true:"";
		Twin({
			Id:o+"_win",
			Title:"ѡ��",
			TitleH:26,
			Refer:inputobj,
			Width:200,
			MaxH:280,
			//Coverobj:formFunction.tc.formObj,
			zIndex:100001,
			Mask:false,
			sysfun:function(tObj){
				tObj.style.overflow = "auto";
				tObj.style.background = "#EDF1F8";
				tObj.style.borderBottom = "1px solid #ccc";
				function selOK(selid,seltext){
					var sname = (selid!=""&&seltext!="��ѡ��")?seltext:"";
					//alert(sname)
					T("#"+select_name)?T("#"+select_name).value = sname:"";
					T("#"+select_id)?T("#"+select_id).value = selid:"";
					TwinC(o+"_win",false,"","",2);
				};
				eval(""+o+"_tree = new tqTree({"+
					"treeId:\""+o+"_tree\","+
					"treeObj:tObj,"+
					"isSearch:"+isSearch+","+
					"dataType:0,"+
					//"dataUrl:dataurl,"+
					"localData:treeData,"+
					"nodeFnArgs:\"id,name\","+
					"nodeClick:function(id,name){"+
					"	selOK(id,name)"+
					"}"+
				"});");
				eval(o+"_tree").C();
			},
			CloseFn : function(){
				eval(""+o+"_tree = null");
			},
			buttons:[{dname:"x ���",tit:"��յ�ǰ�������ֵ",iconcls:"",onpress:function(){
				T("#"+select_name)?T("#"+select_name).value = "":"";
				T("#"+select_id)?T("#"+select_id).value = "":"";
				TwinC(o+"_win",false,"","",2);
			}},
			{dname:"ȡ ��",iconcls:"",onpress:function(){
				TwinC(o+"_win",false,"","",2);
			}}]
		});
		setTimeout(
			function(){document.body.onclick=function(e){
			 e=window.event?window.event:e;
			 var e_tar=e.srcElement?e.srcElement:e.target;
			 if(e_tar.id.indexOf(o)!=-1)
			 {
				  return;
			 }
			 else
			 {
				TwinC(o+"_win",false,"","",2);
			 };
			document.body.onclick=null;
		}},500)
};
function getTreeNodeName(nodeid,uboxid){
	var _nodeList = IvrNodeList[uboxid].nodeList,ret="";
	for (var i=0,j=_nodeList.length;i<j;i++){
		if(nodeid == _nodeList[i].value_no){
			ret = _nodeList[i].value_name		
		}
	};
	return ret
};


function AddIvrNode(obj,uboxid,nodeId){
	var nodeid = T("#"+obj).value;
	Twin({
		Id:"addivrnode",
		Title:"�������нڵ�",
		Content:"",
		Width:390,
		Height:155,
		sysfunI:obj,
		sysfun:function(obj,Obj){
			Tform({
				formname:"addivrnodef",
				formtitle:"",
				formObj:Obj,
				method:"POST",
				suburl:"ivrmanage.do?action=addIvrNode&ubox_id="+uboxid+"&selfId="+nodeId,
				formAttr:[{
					formitems:[{kindname:"",kinditemts:[
						{fieldcnname:"�ڵ�����",fieldname:"node_name",fieldvalue:"",inputtype:"text",colSpan:2,remark:""},
						{fieldcnname:"�ڵ�����",fieldname:"node_type_id",fieldvalue:"",inputtype:"select",colSpan:2,noList:typeList,remark:""}
					]}],
					rules:[
						{name:"node_name",type:"",requir:true,warn:"",okmsg:""}
					]
				}],
				Callback:function(f,rcd,ret,o){
					if(ret=="0"){
						T.loadTip(1,"����ʧ��,������!",2);
					}else{
						T.loadTip(1,"����ɹ�",2);
						var data = ret.split("||");
						var array = eval("("+data[0]+")");
						if(data[1]!="2"){//did
							dnisNodeList[uboxid].nodeList.push(array);
						}						
						IvrNodeList[uboxid].nodeList.push(array);
						//ivrTree.refresh();
						TwinC("addivrnode");
						//����
					}
					
				}
			})
		}	
	})
};

function DelIvrNode(obj,ubox_id,ivrType,defaultnode){
	var objSelect = T("#"+obj);
	var nodeid = objSelect.value;
	if(nodeid==''){
		T.loadTip(1,"��ǰû��ѡ�нڵ�",2,"");
		return false;
	}
	if(defaultnode==nodeid){
		T.loadTip(1,"Ĭ�Ͻڵ��ʶ������ɾ��!",2,"");
		return false;
	}
	if(nodeid=='-1'||nodeid=="-2"){
		T.loadTip(1,"ϵͳ�ڵ�,�޷�ɾ��",2,"");
		return false;
	}
	Tconfirm({
		Title:"������Ϣ!",
		Ttype:"alert",
		Content:"ȷ��Ҫɾ���˽ڵ���?<br><b>ɾ�����޷��ָ���</b>",
		OKFn:function(){
			T.A.sendData("ivrmanage.do?action=del","POST","id="+nodeid+"&ubox_id="+ubox_id+"&ivrType="+ivrType,
				function(ret){
					if(ret=="1"){
						T.loadTip(1,"ɾ���ɹ���",2,"");
						ivrTree.refresh();
						//ɾ��select��Ӧ��
						for(var i in IvrNodeList[ubox_id].nodeList){
							if(IvrNodeList[ubox_id].nodeList[i].value_no==nodeid){
								IvrNodeList[ubox_id].nodeList.splice(i,1);
								break;
							}
						}
					}else{
						T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"");
					}
				},0,"");
		 				
		}
	});
};
function joinNode(dataObj){
	for(var i in dataObj){//������ʶ
		if(dataObj[i].value_no==-1){
			dataObj.splice(i,1);
		}
	};
	for(var i in dataObj){//�Ҷ�
		if(dataObj[i].value_no==-2){
			dataObj.splice(i,1);
		}
	};
}
//IVR��������
function tryIvrVoice(obj,ubox_id){
	var url= "ivrmanage.do?action=getUrl&ubox_id="+ubox_id;
	var strURL = obj.previousSibling.value;
	strURL = T.A.sendData(url)+strURL;
	var selText = obj.previousSibling.options[obj.previousSibling.selectedIndex].text
	if(strURL==""){
		strURL = obj.previousSibling.getAttribute("defaulturl");
	};
	strURL = encodeURI(strURL);
	if(obj.className == "icon16 icon16stop hover1"){
		obj.className = "icon16 icon16play hover1";
		obj.title = "����";
		obj.nextSibling.nextSibling.innerHTML = "";
		obj.nextSibling.innerHTML = "";
	}else{
		var xmlhttp = T.A.getXmlhttp();
	    xmlhttp.onreadystatechange = function(){
		    if(xmlhttp.readyState==4){  
			    if(xmlhttp.status==200 || xmlhttp.status==0){
			    	obj.nextSibling.innerHTML = "��"+selText+"��";
					obj.className = "icon16 icon16stop hover1";
					obj.title = "ֹͣ������"+selText+"��";
					obj.nextSibling.nextSibling.style.left = parseInt(obj.firstChild.offsetLeft) + "px";
					obj.nextSibling.nextSibling.style.top  = parseInt(obj.firstChild.offsetTop) + 20 + "px";
					obj.nextSibling.nextSibling.innerHTML = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab' width='80' height='20'><param name='movie' value='/vip/swf/singlemp3player/singlemp3player.swf?file="+strURL+"&amp;autoStart=true&amp;backColor=6BB15C&amp;frontColor=ffffff&amp;repeatPlay=no&amp;songVolume=100&amp;showDownload=true'><param name='wmode' value='transparent'><embed wmode='transparent' src=\"/vip/swf/singlemp3player/singlemp3player.swf?file="+strURL+"&amp;autoStart=true&amp;backColor=6BB15C&amp;frontColor=ffffff&amp;repeatPlay=no&amp;songVolume=100&amp;showDownload=true\" type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' width='130' height='130'></object>";
					//T.loadTip(1,"��ʼ����",1,obj);
			    }else{
			    	T.loadTip(1,"��"+selText+"����Ӧ�����ļ�������!",2,obj)
		       }  
			};
		}
	    xmlhttp.open("GET","proxy.do?per=tryIvrVoice&url="+strURL,true);   
	    xmlhttp.send(null); 
		//xmlhttp = null
	};
}
/*===ѡ��Dnis===*/
function seldnisNumber(FNM,Fnm,cobj,checktype){//cobj:��������
	var cid = FNM +"_" + Fnm;
	var phoneSeat_id = T("#"+FNM+"_id");
	var ubox_id = T("#"+FNM+"_ubox_id");
	var extparams = "";
	if(phoneSeat_id){
		extparams = "&phoneseat_id="+phoneSeat_id.value;
	};
	if(ubox_id){
		extparams += "&ubox_id="+ubox_id.value;
	};
	var fielditems = [
						{"fieldcnname":"�м̺ű��","fieldname":"id","fieldvalue":"","hide":false,"inputtype":"text"},
						{"fieldcnname":"�м̺���","fieldname":"dnis_number","fieldvalue":"","hide":false,"inputtype":"text",twidth:120},
						{"fhide":true,"fieldcnname":"�ڵ���Ϣ","fieldname":"ivr_node_id","fieldvalue":"","hide":true,"inputtype":"text",twidth:120},
						{"fhide":true,"fieldcnname":"��ϯ��Ϣ","fieldname":"phoneseat_id","fieldvalue":"","hide":true,"inputtype":"text",twidth:120},
						{"fieldcnname":"��ϯ����","fieldname":"seat_id","fieldvalue":"","hide":true,"inputtype":"text",twidth:120},
						{"fieldcnname":"�ڵ�����","fieldname":"node_name","fieldvalue":"","hide":true,"inputtype":"text",twidth:120}
					]
    Twin({
		Coverobj:cobj,
        Id:"selDnis_w",
        Width:600,
        Height:400,
		Title:"ѡ���м�",
		sysfunI:cid,
    	sysfun:function(cid,tObj){
            var _SclientT = new TQTable({
            	tableObj:tObj,
    			checktype:"checkbox",
            	tablename:"dnis_search_t",
				trclickfun:true,
				dataUrl:"ivrmanage.do?otherParams=2",
            	param:"action=showDis"+extparams,
				searchitem:[
					{name:"�м̺�",field:"dnis_number",type:"text",isdefault:true}
				],
    			buttons:[{
    				name: "ok",
    				dname: "ȷ��ѡ��",
    				icon: "ok.gif",
    				tit:"ȷ��ѡ��",
    				onpress:function(){
        				if(_SclientT.GS()){
        					var dnisNumber_value = _SclientT.GSByField("dnis_number");//Dnis_number
        					var regex = new RegExp(",", "g");
							var numS = dnisNumber_value.replace(regex,"_");
        					T("#"+cid).value =numS;
        					T("#"+cid+"_text").value =  _SclientT.GS(1);		//ID
        					T("#"+cid+"_node").value =_SclientT.GSByField("ivr_node_id");//ivr_node_id
    						TwinC("selDnis_w","","",cobj)
        				};
    				}
    			},{
    				name: "cancel",
    				dname: "ȡ��",
    				icon: "cancel.gif",
    				tit:"ȡ��ѡ��",
    				onpress:function(){
    					TwinC("selDnis_w","","",cobj)
    				}
    			}
				],
			tableitems:fielditems
        	});
			_SclientT.C()
   		}
 	})
};
function clearDnisNumber(cid,cobj){//cobj:�������� 
	T("#"+cid).value  = "";
	T("#"+cid+"_text").value =  "";
	T("#"+cid+"_node").value = "";
}

/*����ѡ��*/
function cactic_Select(value,target,action){
	if(value==-1)
		return;
	var childs =getChildById(action,value);
	var selectform = document.getElementById(target);
	selectform.options.length = 0;
	if(childs&&childs.length>0){
		for(var i=0;i<childs.length;i++){
			var varItem = new Option(childs[i].value_name, childs[i].value_no);      
			selectform.options.add(varItem);     
		}
	}
	//alert(document.getElementById(target).innerText);
}

function getChildById(action,id){
	var childs = eval(T.A.sendData("getdata.do?action="+action+"&id="+id));
	return childs;
}
function jslimit(){
    with(document.body) {
      oncontextmenu=function(){return false}
      ondragstart=function(){return false}
      onselectstart=function(){return false}
      onbeforecopy=function(){return false}
      onselect=function(){return false}
      oncopy=function(){return false}
	  onselectstart=function(){return false}
    }
}

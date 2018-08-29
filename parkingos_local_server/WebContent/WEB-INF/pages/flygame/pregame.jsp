<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<head>
<title>��һ���~~</title>
<style type="text/css">
		html,body {
		    padding: 0 !important;
			margin: 0 !important;
		    background-color:#ffffff;
		    width:100%;
		    height:100%;
		    font-family:"΢���ź�";
		    overflow-x:hidden !important;
		    background-size: 100% 100%;
			background-position:top center;
		    background-color:#F0F0F0;
		    background-image: url(images/flygame/b_g.png);
		    background-repeat:no-repeat;
		}
		.confirmbtn{
			background:#FFFFFF;
			border:1px solid #CFCFCF;
			border-radius: 5px;
			margin-top:18%;
			color:#000000;
			text-align:center;
		}
		.friendbg{
		    padding: 0 !important;
			margin: 0 !important;
		    font-family:"΢���ź�";
		    background-size: 100% 100%;
			background-position:top center;
		    background-image: url(images/flygame/border_green.png);
		    background-repeat:no-repeat;
		}
		</style>
</head>
<script src="js/tq.js?081744" type="text/javascript">//���</script>
<body id='body' >
	<img src='images/flygame/rule.png' id='rule' style='position:absolute' onclick='viewRule();'/>
	<img src='images/flygame/friend_bg.png' id='friend' style='position:absolute' onclick='getfriend();'/>
	<a href="#" onclick='myscore()' style='color:#000;text-decoration:none;'><img id="score"  style="position:absolute;border:0" src="images/flygame/score_bg.png" /></a>
	<img src='images/flygame/begin.png'  style='position:absolute' id ='cbtn' onclick='getmTickets();'/>
	<form action="flygame.do?action=play" method='post' id='togame'>
		<input type='hidden' name='tid' id='tid'/>
		<input type='hidden' name='uin' value='${uin}'/>
		<input type='hidden' name='s_width' id='s_width'/>
	</form>
</body>
<script>
var getobj=function(id){return document.getElementById(id)};
var h = getobj('body').offsetHeight;
var w = getobj('body').offsetWidth;
function setobjCss(obj,css){
	for(var c in css){
		obj.style[c]=css[c];
	}
}
setobjCss(getobj('rule'),{'width':parseInt(w*0.16)+'px','left':parseInt(w*0.42)+'px','top':parseInt(h*0.59)+'px'});
setobjCss(getobj('score'),{'width':parseInt(w*0.32)+'px','left':parseInt(w*0.15)+'px','top':parseInt(h*0.69)+'px'});
setobjCss(getobj('friend'),{'width':parseInt(w*0.32)+'px','left':parseInt(w*0.51)+'px','top':parseInt(h*0.69)+'px'});
setobjCss(getobj('cbtn'),{'width':parseInt(w*0.68)+'px','left':parseInt(w*0.16)+'px','top':parseInt(h*0.80)+'px'});
var mesgcount = parseInt('${mesgcount}');

if(mesgcount>0){
	var mesgsimg = document.createElement("img");
	mesgsimg.setAttribute('id','mesgsimg');
	setobjCss(mesgsimg,{'top':parseInt(h*0.69)+'px','left':parseInt(w*0.75)+'px','width':parseInt(w*0.07)+'px','position':'absolute'});
	mesgsimg.src='images/flygame/mesg_title.png';
	document.body.appendChild(mesgsimg);
}

/**��ȡ����*/
function getfriend(){
	//alert('friend');
	if(getobj('mesgsimg'))
		getobj('mesgsimg').style.display='none';
	var data = eval(T.A.sendData("flygame.do","POST","action=friend&uin=${uin}"));
	myfrieds(data);
}
//�����б�
function myfrieds(data){
	var cover = document.createElement("div");
	cover.setAttribute('id','cover');
	setobjCss(cover,{'display':'block','visibility':'visible','width':'100%','height':'100%','background':'#000','position':'absolute',
				'top':'0px','left':'0px','cursor':'not-allowed','filter':'alpha(opacity=40)','opacity':'0.6'});
	//�б��
	var dis = document.createElement("div");
	dis.setAttribute('id','dis');
	dis.className='friendbg';
	setobjCss(dis,{'top':parseInt(h*0.15)+'px','left':parseInt(w*0.1)+'px','width':parseInt(w*0.8)+'px',
				'height':parseInt(h*0.65)+'px','position':'absolute','align':'center','borderRadius':parseInt(w*0.053)+'px'});
	dis.zIndex = 1;
	var cdiv = document.createElement("div");
	//�Լ�ͷ��
	var owerimg = document.createElement("img");
	owerimg.src=data[0].wx_imgurl;
	setobjCss(owerimg,{'top':parseInt(h*0.028)+'px','left':parseInt(w*0.042)+'px','width':parseInt(w*0.1)+'px',
		'position':'absolute','borderRadius':parseInt(w*0.05)+'px'});
	cdiv.appendChild(owerimg);
	
	//�û���
	var frimg = document.createElement("img");
	frimg.src='images/flygame/friend.png';
	setobjCss(frimg,{'top':parseInt(h*0.038)+'px','left':parseInt(w*0.18)+'px','width':parseInt(w*0.4)+'px',
		'position':'absolute','borderRadius':parseInt(w*0.04)+'px'});
	cdiv.appendChild(frimg);
	
	//�û����б�
	var fsdiv = document.createElement("div");
	setobjCss(fsdiv,{'top':parseInt(h*0.5*0.2)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.76)+'px',
		'position':'absolute','height':parseInt(h*0.6*0.873)+'px','overflowY':'auto'});
	if(data.length>1){
		for(var i=1;i<data.length;i++){
			var fdiv = document.createElement("div");
			fdiv.setAttribute('id',data[i].euin);
			setobjCss(fdiv,{'top': parseInt((i-1)*h*0.5*0.19)+'px','backgroundColor':'#FFFFFF','width':'100%',
				'position':'absolute','height':parseInt(h*0.095*0.95)+'px'});
			fdiv.onclick=function(){getmessage(this,'')};
			//ÿһ���û���
			var eimg= document.createElement("img");
			setobjCss(eimg,{'top':parseInt(h*0.018)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.1)+'px',
				'position':'absolute'});
			eimg.src=data[i].wx_imgurl;
			fdiv.appendChild(eimg);
			//��Ϣ��ʾ
			var mc = data[i].mesgs;
			if(mc&&parseInt(mc)>0){
				var countspan = document.createElement("span");
				countspan.innerText=mc;
				setobjCss(countspan,{'top':parseInt(h*0.01)+'px','left':parseInt(w*0.1)+'px','width':parseInt(w*0.04)+'px',
					'position':'absolute','color':'#FFFFFF','height':parseInt(w*0.04)+'px','backgroundColor':'#FF0000',
					'fontSize':parseInt(w*0.03)+'px','borderRadius':parseInt(w*0.02)+'px','textAlign':'center','lineHeight':parseInt(w*0.04)+'px'});
				fdiv.appendChild(countspan);
			}
			
			var words = document.createElement("span");
			setobjCss(words,{'top':parseInt(h*0.020)+'px','left':parseInt(w*0.18)+'px','width':parseInt(w*0.5)+'px',
				'position':'absolute','fontWeight':'600','color':'#BBBBBB','fontSize':parseInt(w*0.06)+'px'});
			words.innerHTML=data[i].wx_name;
				
			fdiv.appendChild(words);
			fsdiv.appendChild(fdiv);
		}
	}else{
		//û�кû�����ʾ
		var noticketimg= document.createElement("img");
		noticketimg.setAttribute('id','seleimg_noticket');
		setobjCss(noticketimg,{'top':parseInt(h*0.07)+'px','left':parseInt(w*0.14)+'px','width':parseInt(w*0.5)+'px','position':'absolute'});
		noticketimg.src="images/flygame/no_friend.png";
		fsdiv.appendChild(noticketimg);
	}
	//�رհ���
	var img= document.createElement("img");
	img.setAttribute('id','aimg');
	setobjCss(img,{'top':parseInt(h*0.125)+'px','left':parseInt(w*0.82)+'px','width':parseInt(w*0.1)+'px',
		'position':'absolute'});
	img.src="images/flygame/close_green.png";
	img.onclick=function(){closeCover()};
	dis.appendChild(cdiv);
	dis.appendChild(fsdiv);
	
	document.body.appendChild(cover);
	document.body.appendChild(dis);
	document.body.appendChild(img);
	fsdiv.scrollTop =fsdiv.scrollHeight; 
}

var touin;//��Ϣ������
var mesgTiv=true;//ѭ����Ϣ��־
//��Ϣ�б�
function mymessages(data,tuin){
	touin=tuin;
	//������
	var cover = document.createElement("div");
	cover.setAttribute('id','cover');
	setobjCss(cover,{'display':'block','visibility':'visible','width':'100%','height':'100%','background':'#000','position':'absolute',
				'top':'0px','left':'0px','cursor':'not-allowed','filter':'alpha(opacity=40)','opacity':'0.6'});
	
	//�б��
	var dis = document.createElement("div");
	dis.setAttribute('id','dis');
	dis.className='friendbg';
	setobjCss(dis,{'top':parseInt(h*0.15)+'px','left':parseInt(w*0.1)+'px','width':parseInt(w*0.8)+'px',
		'position':'absolute','height':parseInt(h*0.65)+'px','align':'center','borderRadius':parseInt(w*0.05)+'px'});
	
	dis.zIndex = 1;
	var cdiv = document.createElement("div");
	setobjCss(cdiv,{'borderBottom':'2px solid #dddddd','position':'absolute','left':parseInt(w*0.02)+'px','width':parseInt(w*0.76)+'px','height':parseInt(h*0.5*0.19)+'px'});
	//�û���
	var frname = document.createElement("span");
	//����ͷ��
	var owerimg = document.createElement("img");
	var _oname='';//�Լ�����
	var _oimg='';//�Լ�ͷ��
	var _fname='';//��������
	var _fimg='';//����ͷ��
	for(var i=0;i<2;i++){
		var uin = data[i].id;
		if(uin==tuin){
			_fname=data[i].wx_name;
			_fimg=data[i].wx_imgurl;
			owerimg.src=data[i].wx_imgurl;
			frname.innerText=data[i].wx_name;
		}else{
			_oname=data[i].wx_name;
			_oimg=data[i].wx_imgurl;
		}
	}
	//owerimg.src=data[0].wx_imgurl;
	setobjCss(owerimg,{'top':parseInt(h*0.028)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.1)+'px',
		'position':'absolute','borderRadius':parseInt(w*0.05)+'px'});
	
	cdiv.appendChild(owerimg);
	
	//�û���
	setobjCss(frname,{'top':parseInt(h*0.038)+'px','left':parseInt(w*0.18)+'px','width':parseInt(w*0.5)+'px',
		'position':'absolute','fontSize':parseInt(w*0.06)+'px','fontWeight':'600','color':'#BBBBBB'});
	cdiv.appendChild(frname);
	
	//��Ϣ�б�
	var fsdiv = document.createElement("div");
	fsdiv.setAttribute('id','fsdiv');
	setobjCss(fsdiv,{'top':parseInt(h*0.5*0.2)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.76)+'px',
		'position':'absolute','height':parseInt(h*0.5*0.875)+'px','borderBottom':'2px solid #dddddd','overflowY':'auto'});
	
	var lasttop = 0;
	if(data.length>2){
		for(var i=2;i<data.length;i++){
			var line = 0;
			if(i>2)
				line=parseInt(data[i-1].leng);
			var fdiv = document.createElement("div");
			var dss = fdiv.style;
			fdiv.setAttribute('id',data[i].id);
			dss.position ='absolute';
			var ltop =0;
			if(i>2){
				if(line>2){
					ltop = lasttop+parseInt(line*h*0.5*0.095);
					//dss.height=parseInt(line*h*0.5*0.095)+'px';
				}else{
					//dss.height=parseInt(h*0.5*0.19)+'px';
					ltop = lasttop+parseInt(h*0.5*0.19);
				}
			}
			dss.top = ltop+"px";
			lasttop= ltop;
			//dss.backgroundColor='#dddddd';
			dss.width='100%';
			
			//dss.height=parseInt(h*0.095*0.95)+"px";
			
			var _fuin=data[i].fuin;
			var _tuin=data[i].tuin; 
			//ÿһ���û���
			var words = document.createElement("span");
			setobjCss(words,{'top':parseInt(h*0.020)+'px','left':parseInt(w*0.14)+'px','width':(parseInt(w*0.45)-16)+'px',
				'position':'absolute','paddingLeft':'8px','paddingRight':'8px','lineHeight':parseInt(h*0.5*0.08)+'px',
				'fontSize':parseInt(w*0.04)+'px','borderRadius':'8px'});
			var wss = words.style;
			//�Ựͷ��
			var eimg= document.createElement("img");
			//ͷ���ͷ
			var arrowimg=document.createElement("img");
			
			var arss = arrowimg.style;
			var lr = 'left';//��Ϣ�����/�ұߣ�
			
			if(_tuin==tuin){
				lr='right';
				eimg.src=_oimg;
			}else{
				eimg.src=_fimg;
			}
			var ess = eimg.style;
			ess.position ='absolute';
			ess.top = parseInt(h*0.018)+"px";
			ess.width = parseInt(w*0.1)+"px";
			
			arss.position ='absolute';
			arss.top = parseInt(h*0.03)+"px";
			arss.width = parseInt(w*0.020)+"px";
			
			var wlength =data[i].wleng;
			var ab=8;
			if(lr=='left'){
				words.innerHTML=data[i].message;
				wss.backgroundColor='#A7E54C';
				ess.left =parseInt(w*0.022)+"px";
				arss.left =parseInt(w*0.127)+"px";
				arrowimg.src='images/flygame/left_arrow.png';
				if(wlength<20){
					wss.width=wlength*ab+"px";
				}
			}else{
				words.innerHTML=data[i].message;
				arrowimg.src='images/flygame/right_arrow.png';
				if(parseInt(data[i].leng)<2){
					wss.textAlign='right';
				}
				wss.backgroundColor='#FFFFFF';
				if(wlength<20){
					wss.width=wlength*ab+"px";
					wss.left =  (parseInt(w*0.14)+((parseInt(w*0.45)-16)-wlength*ab))+"px";
				}
				arss.left =parseInt(w*0.585)+"px";
				ess.left =parseInt(w*0.62)+"px";
			}
			fdiv.appendChild(words);
			fdiv.appendChild(arrowimg);
			fdiv.appendChild(eimg);
			fsdiv.appendChild(fdiv);
		}
	}
	//�رհ���
	var img= document.createElement("img");
	img.setAttribute('id','aimg');
	setobjCss(img,{'top':parseInt(h*0.125)+'px','left':parseInt(w*0.82)+'px','width':parseInt(w*0.1)+'px','position':'absolute'});
	img.src="images/flygame/close_green.png";
	img.onclick=function(){closeCover();getfriend();}//closeTimeout();};
	
	//�ײ������
	var bdiv = document.createElement("div");
	setobjCss(bdiv,{'top':parseInt(h*0.55)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.76)+'px',
		'position':'absolute','height':parseInt(h*0.5*0.2)+'px'});
	bdiv.innerHTML="<input name='mesg' id='mesginput' value='��������' onclick='levemesg(this);'/>";
	//bss.backgroundColor="#FF0000";
	//�ײ��Ҳ�ͼƬ
	var brimg= document.createElement("img");
	setobjCss(brimg,{'top':parseInt(h*0.56)+'px','left':parseInt(w*0.66)+'px','width':parseInt(w*0.1)+'px','position':'absolute'});
	brimg.src="images/flygame/message_right.png";
	brimg.onclick=function sendmesg(){sendmessage();};
	
	
	dis.appendChild(cdiv);
	dis.appendChild(fsdiv);
	dis.appendChild(bdiv);
	dis.appendChild(brimg);
	
	document.body.appendChild(cover);
	document.body.appendChild(dis);
	document.body.appendChild(img);
	
	var mesginput = getobj('mesginput');
	setobjCss(mesginput,{'height':parseInt(h*0.07)+'px','width':parseInt(w*0.54)+'px','marginLeft':'10px',
		'border':'1px solid #BBBBBB','color':'#BBBBBB','fontSize':parseInt(w*0.04)+'px','borderRadius':'15px','paddingLeft':'10px'});
	fsdiv.scrollTop =fsdiv.scrollHeight;
	if(!mesgTiv)
		getNewMessage();
}
var select_ticket_id;
function checktikcets(obj,leng){
	var id = obj.id.split('_')[2];
	var sobj = getobj('seleimg_'+id);
	select_ticket_id=sobj.title;//��ѡ���ͣ��ȯ
	for(var i=0;i<leng;i++){
		getobj('seleimg_'+i).src="images/flygame/radio_fal.png";
	}
	//alert(select_ticket_id);
	sobj.src="images/flygame/radio_tru.png";
}
function togame(dlen){
	//location = 'flygame.do?action=play&uin=${uin}&tid='+select_ticket_id;
	var na =navigator.userAgent.toLowerCase();
	//alert(na);
	var exptype=0;// android;
	if(na.indexOf('iphone')!=-1&&na.indexOf('micromessenger')==-1)
		exptype=1;
	if(dlen>0){
		getobj('tid').value=select_ticket_id;
		getobj('s_width').value=exptype;
		getobj('togame').submit();
	}else{
		closeCover();
	}
}
//ѡ��ͣ��ȯ
function usetickets(data){
	var cover = document.createElement("div");
	cover.setAttribute('id','cover');
	setobjCss(cover,{'display':'block','visibility':'visible','width':'100%','height':'100%','background':'#000','position':'absolute',
				'top':'0px','left':'0px','cursor':'not-allowed','filter':'alpha(opacity=40)','opacity':'0.6'});
	//�б��
	var dis = document.createElement("div");
	dis.setAttribute('id','dis');
	dis.className='friendbg';
	setobjCss(dis,{'top':parseInt(h*0.15)+'px','left':parseInt(w*0.1)+'px','width':parseInt(w*0.8)+'px',
				'height':parseInt(h*0.7)+'px','position':'absolute','align':'center','borderRadius':parseInt(w*0.053)+'px'});
	dis.zIndex = 1;
	var cdiv = document.createElement("div");
	
	//����ͼ��
	var frimg = document.createElement("img");
	frimg.src='images/flygame/usetickets_title.png';
	setobjCss(frimg,{'top':parseInt(h*0.038)+'px','left':parseInt(w*0.038)+'px','width':parseInt(w*0.7)+'px','position':'absolute'});
	cdiv.appendChild(frimg);
	
	//��ʾ��
	var wspan = document.createElement("span");
	setobjCss(wspan,{'top':parseInt(h*0.092)+'px','color':'#BBBBBB','fontWeight':'700','left':parseInt(w*0.038)+'px',
		'textAlign':'center','width':parseInt(w*0.7)+'px','position':'absolute','fontSize':parseInt(w*0.045)+'px'});
	wspan.innerHTML='������һ����˽���Ϊ��ĺû���';
	cdiv.appendChild(wspan);
	
	//ͣ��ȯ�б�
	var fsdiv = document.createElement("div");
	setobjCss(fsdiv,{'top':parseInt(h*0.5*0.3)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.76)+'px',
		'position':'absolute','height':parseInt(h*0.7*0.61)+'px','overflowY':'auto'});
	var dlen = data.length;
	if(dlen>0){
		for(var i=0;i<dlen;i++){
			var tid = data[i].id;
			var fdiv = document.createElement("div");
			fdiv.setAttribute('id','ticket_'+tid+'_'+i);
			setobjCss(fdiv,{'top': parseInt(i*h*0.5*0.19)+'px','backgroundColor':'#FFFFFF','width':'100%',
				'position':'absolute','height':parseInt(h*0.095*0.95)+'px'});
			//ÿһ��ͣ��ȯ
			var eimg= document.createElement("img");
			setobjCss(eimg,{'top':parseInt(h*0.0058)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.2)+'px','position':'absolute'});
			var money= data[i].money;
			var bnum=money*4-1;
			if(money>6){
				eimg.src="images/flygame/ticket_reds.png";
			}else if(money>3){
				eimg.src="images/flygame/ticket_yellow.png";
			}else{
				eimg.src="images/flygame/ticket_green.png";
			}
			var monspan = document.createElement("span");
			var monleft=parseInt(w*0.075)+'px';
			if(money>9)
				monleft=parseInt(w*0.065)+'px'
			setobjCss(monspan,{'top':parseInt(h*0.02)+'px','left':monleft,'color':'#FFFFFF','fontSize':parseInt(w*0.077)+'px','position':'absolute'});
			monspan.innerHTML=money;
			
			fdiv.appendChild(eimg);
			
			var words = document.createElement("span");
			setobjCss(words,{'top':parseInt(h*0.028)+'px','left':parseInt(w*0.24)+'px','width':parseInt(w*0.5)+'px',
				'position':'absolute','fontWeight':'600','color':'#BBBBBB','fontSize':parseInt(w*0.04)+'px'});
			var res = data[i].resources;
			words.innerHTML='�ŷɺ�õ�'+bnum+'���ӵ� ';
			if(res==1)
				words.innerHTML='�ŷɺ�õ�'+bnum+'<font color="red">��2</font>���ӵ� ';
			
			//ѡ�񰴼�
			var seleimg= document.createElement("img");
			seleimg.setAttribute('id','seleimg_'+i);
			seleimg.setAttribute('title',tid);
			setobjCss(seleimg,{'top':parseInt(h*0.028)+'px','left':parseInt(w*0.66)+'px','width':parseInt(w*0.05)+'px','position':'absolute'});
			if(i==0){
				select_ticket_id=tid;//Ĭ��ѡ��һ��		
				seleimg.src="images/flygame/radio_tru.png";
			}else
				seleimg.src="images/flygame/radio_fal.png";
			
			
			//ѡ�񰴼�
			var ownticketimg= document.createElement("img");
			setobjCss(ownticketimg,{'top':parseInt(h*0.005)+'px','left':parseInt(w*0.154)+'px','width':parseInt(w*0.07)+'px','position':'absolute'});
			ownticketimg.src="images/flygame/own_ticket.png";
			if(res==1)
				fdiv.appendChild(ownticketimg);
			
			//seleimg.onclick=function(){checktikcets(this,dlen)};
			//alert(seleimg.onclick);
			
			fdiv.appendChild(monspan);
			fdiv.appendChild(words);
			fdiv.appendChild(seleimg);
			
			fdiv.onclick=function(){checktikcets(this,dlen)};
			
			fsdiv.appendChild(fdiv);
		}
	}else{
		cdiv.removeChild(frimg);
		cdiv.removeChild(wspan);
		//û��ͣ��ȯ��ʾ
		var noticketimg= document.createElement("img");
		noticketimg.setAttribute('id','seleimg_noticket');
		setobjCss(noticketimg,{'left':parseInt(w*0.087)+'px','width':parseInt(w*0.6)+'px','position':'absolute'});
		noticketimg.src="images/flygame/no_ticket.png";
		setobjCss(fsdiv,{'top':parseInt(h*0.5*0.1)+'px','height':parseInt(h*0.5*0.95)+'px'})
		fsdiv.style.height=parseInt(h*0.7*0.81)+'px';
		fsdiv.appendChild(noticketimg);
	}
	//�رհ���
	var img= document.createElement("img");
	img.setAttribute('id','aimg');
	setobjCss(img,{'top':parseInt(h*0.13)+'px','left':parseInt(w*0.82)+'px','width':parseInt(w*0.1)+'px','position':'absolute'});
	img.src="images/flygame/close_green.png";
	img.onclick=function(){closeCover()};
	
	//ȷ������
	var okimg= document.createElement("img");
	okimg.setAttribute('id','okimg');
	setobjCss(okimg,{'top':parseInt(h*0.59)+'px','left':parseInt(w*0.26)+'px','width':parseInt(w*0.3)+'px','position':'absolute'});
	if(dlen>0){
		okimg.src="images/flygame/ok.png";
		okimg.onclick=function(){togame(dlen)};
	}else{
		okimg.src="images/flygame/to_buy.png";
		okimg.onclick=function(){toBuy()};
	}
	
	dis.appendChild(cdiv);
	dis.appendChild(fsdiv);
	dis.appendChild(okimg);
	
	document.body.appendChild(cover);
	document.body.appendChild(dis);
	document.body.appendChild(img);
	
}

//�ҵ�ս��
function myscore(){
	var data = eval(T.A.sendData("flygame.do","POST","action=score&uin=${uin}"));
	var cover = document.createElement("div");
	cover.setAttribute('id','cover');
	setobjCss(cover,{'display':'block','visibility':'visible','width':'100%','height':'100%','background':'#000','position':'absolute',
				'top':'0px','left':'0px','cursor':'not-allowed','filter':'alpha(opacity=40)','opacity':'0.6'});
	//�б��
	var dis = document.createElement("div");
	dis.setAttribute('id','dis');
	dis.className='friendbg';
	setobjCss(dis,{'top':parseInt(h*0.15)+'px','left':parseInt(w*0.1)+'px','width':parseInt(w*0.8)+'px',
				'height':parseInt(h*0.65)+'px','position':'absolute','align':'center'});
	dis.zIndex = 1;
	
	var cdiv = document.createElement("div");
	
	//�ҵ�ͷ��ͼ��
	var myimg = document.createElement("img");
	myimg.src=data[0].wx_imgurl;
	setobjCss(myimg,{'top':parseInt(h*0.028)+'px','left':parseInt(w*0.038)+'px','width':parseInt(w*0.1)+'px',
		'position':'absolute','borderRadius':parseInt(w*0.05)+'px'});
	cdiv.appendChild(myimg);
	
	//����ͼ��
	var frimg = document.createElement("img");
	frimg.src="images/flygame/score.png";
	setobjCss(frimg,{'top':parseInt(h*0.038)+'px','left':parseInt(w*0.2)+'px','width':parseInt(w*0.3)+'px','position':'absolute'});
	cdiv.appendChild(frimg);
	
	//ͣ��ȯ�б�
	var fsdiv = document.createElement("div");
	setobjCss(fsdiv,{'top':parseInt(h*0.5*0.2)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.76)+'px',
		'position':'absolute','height':parseInt(h*0.8*0.65)+'px','overflowY':'auto'});
	
	var dlen = data.length;
	if(dlen>1){
		for(var i=1;i<dlen;i++){
			var fdiv = document.createElement("div");
			fdiv.setAttribute('id','score_'+i);
			setobjCss(fdiv,{'top': parseInt((i-1)*h*0.5*0.19)+'px','backgroundColor':'#FFFFFF','width':'100%',
				'position':'absolute','height':parseInt(h*0.095*0.95)+'px'});
			//ÿһ��ս��
			var eimg= document.createElement("img");
			setobjCss(eimg,{'top':parseInt(h*0.0258)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.07)+'px','position':'absolute'});
			eimg.src="images/flygame/score_title.png";
			
			fdiv.appendChild(eimg);
			
			var words = document.createElement("span");
			setobjCss(words,{'top':parseInt(h*0.02)+'px','left':parseInt(w*0.128)+'px','width':parseInt(w*0.4)+'px',
				'position':'absolute','fontWeight':'600','color':'#666666','fontSize':parseInt(w*0.043)+'px'});
			words.innerHTML='<b>'+data[i].remark+'</b>';
			
			var datetime = document.createElement("span");
			setobjCss(datetime,{'top':parseInt(h*0.058)+'px','left':parseInt(w*0.128)+'px','width':parseInt(w*0.2)+'px',
				'position':'absolute','fontWeight':'600','color':'#BBBBBB','fontSize':parseInt(w*0.033)+'px'});
			datetime.innerHTML='<b>'+data[i].ctime+'</b>';
			
			var is_operate = data[i].is_operate;
			var ptype =  data[i].ptype;
			var money = data[i].money;
			var addorshare = document.createElement("span");
			addorshare.setAttribute('id','addorshare_'+i);
			//if(ptype!=3){//δ����ɼ�Ϊ�û���
				var ptype =  data[i].ptype;
				var sid = data[i].id;
				setobjCss(addorshare,{'top':parseInt(h*0.02)+'px','left':parseInt(w*0.528)+'px','width':parseInt(w*0.2)+'px',
						'position':'absolute','fontWeight':'600','color':'#BBBBBB','fontSize':parseInt(w*0.04)+'px'});
				if(ptype==0||ptype==2||ptype==4||ptype==5){//û�з���
					if(ptype==0&&money>=4){//ͣ��ȯ���ڻ����4Ԫ
						if(is_operate==0)
							addorshare.innerHTML='<div onclick="toshare('+sid+','+i+')" style="background-color:#9AD243;width:60px;height:30px;border-radius:15px;color:#FFFFFF;line-height:30px;text-align:center;font-weight:700;box-shadow:0px 2px 1px #81B03A;" >ȥ����</div>';
						else
							addorshare.innerHTML='<b>&nbsp;&nbsp;�ѷ���</b>';	
					}
					if(ptype==2&&money>=1){//ͣ��ȯ���ڻ����4Ԫ
						if(is_operate==0)
							addorshare.innerHTML='<div onclick="toshare('+sid+','+i+')" style="background-color:#9AD243;width:60px;height:30px;border-radius:15px;color:#FFFFFF;line-height:30px;text-align:center;font-weight:700;box-shadow:0px 2px 1px #81B03A;" >ȥ����</div>';
						else
							addorshare.innerHTML='<b>&nbsp;&nbsp;�ѷ���</b>';	
					}
					if(ptype==4||ptype==5){
						if(is_operate==0)
							addorshare.innerHTML='<div onclick="toshare('+sid+','+i+')" style="background-color:#9AD243;width:60px;height:30px;border-radius:15px;color:#FFFFFF;line-height:30px;text-align:center;font-weight:700;box-shadow:0px 2px 1px #81B03A;" >ȥ����</div>';
						else
							addorshare.innerHTML='<b>&nbsp;&nbsp;�ѷ���</b>';	
					}
				}else if(ptype==1){
					if(is_operate==0)
						addorshare.innerHTML='<div onclick="toaddfriend('+sid+','+i+')" style="background-color:#9AD243;width:60px;height:30px;border-radius:15px;color:#FFFFFF;line-height:30px;text-align:center;font-weight:700;box-shadow:0px 2px 1px #81B03A;" >�Ӻ���</div>';
					else
						addorshare.innerHTML='<b>�ѼӺ���</b>';
				}else if(ptype==3){//ϴ��ȯv
					var aid = data[i].aid;
					var aname = "ȥʹ��";
					if(aid==2)
						aname="ȥ��ѯ";
					else if(aid==3)
						aname="ȥͶ��";
					addorshare.innerHTML='<div onclick="tousewcar('+aid+')" style="background-color:#9AD243;width:60px;height:30px;border-radius:15px;color:#FFFFFF;line-height:30px;text-align:center;font-weight:700;box-shadow:0px 2px 1px #81B03A;" >'+aname+'</div>';
				}else if(ptype==6){//�ڶ�����Ϸ���ȯ
					datetime.style.width=parseInt(w*0.6)+'px'
					datetime.innerHTML='<b>���ں��лظ����ڶ��ء��˽�����</b>';
				}
			//}
			
			fdiv.appendChild(datetime);
			fdiv.appendChild(words);
			fdiv.appendChild(addorshare);
			fsdiv.appendChild(fdiv);
		}
	}else{
		//û�кû�����ʾ
		var noticketimg= document.createElement("img");
		noticketimg.setAttribute('id','seleimg_noticket');
		setobjCss(noticketimg,{'top':parseInt(h*0.07)+'px','left':parseInt(w*0.14)+'px','width':parseInt(w*0.5)+'px','position':'absolute'});
		noticketimg.src="images/flygame/no_score.png";
		fsdiv.appendChild(noticketimg);
	}
	//�رհ���
	var img= document.createElement("img");
	img.setAttribute('id','aimg');
	setobjCss(img,{'top':parseInt(h*0.13)+'px','left':parseInt(w*0.82)+'px','width':parseInt(w*0.1)+'px','position':'absolute'});
	img.src="images/flygame/close_green.png";
	img.onclick=function(){closeCover()};
	
	dis.appendChild(cdiv);
	dis.appendChild(fsdiv);
	
	document.body.appendChild(cover);
	document.body.appendChild(dis);
	document.body.appendChild(img);
	fsdiv.scrollTop =fsdiv.scrollHeight; 
}


function tousewcar(type){
	var turl="http://a.app.qq.com/o/simple.jsp?pkgname=com.youlemobi.customer";
	if(type==2)
		turl="http://m.renrenche.com/liantong/";
	else if(type==3)
		turl="http://mp.weixin.qq.com/s?__biz=MjM5MjgxOTY4OA==&mid=208360229&idx=1&sn=df9c59a4d36233c65f5fef2baf373141&scene=0#rd";
	window.open(turl);//"http://a.app.qq.com/o/simple.jsp?pkgname=com.youlemobi.customer";
	//location=turl;
}

function toshare(sid,index){
	var sourcetag = navigator.userAgent;
	if(navigator.userAgent.indexOf("MicroMessenger")==-1){
		var ds = T.A.sendData("flygame.do","POST","action=getbid&uin=${uin}&sid="+sid,false,2);
		var linkurl="";
		var imgUrl = "";
		var desc='����˭�ŵĻһ����Ϳ��Գ�Ϊ˭�ĺû��ѣ�����ͣ��ȯ�����ȯ���������';
		var title ='����'+ds.carid+'���ڴ�һ������������ĺû���';
		var url  ='http://s.tingchebao.com/zld/';
		//var url  ='http://192.168.199.240/zld/';
		linkurl= url +'carowner.do?action=getobonus&id='+ds.bid;
		imgUrl = url+'images/flygame/share_b.png';
		getobj('addorshare_'+index).innerHTML='<b>&nbsp;&nbsp;�ѷ���</b>';
		//alert(linkurl);
		if(sourcetag.indexOf("Android")!=-1){//����android
			window.share.share(linkurl,title,desc,imgUrl)
		}else if(sourcetag.indexOf("iPhone")!=-1){//����iphone
			var u = 'http://s.tingchebao.com';
			//alert(u+'?desc='+desc+'&title='+title+'&imgurl='+imgUrl+'&url='+linkurl);
			location = u+'?desc='+desc+'&title='+title+'&imgurl='+imgUrl+'&url='+linkurl;
		}
	}else{
		getobj('addorshare_'+index).innerHTML='<b>&nbsp;&nbsp;�ѷ���</b>';
		location = "flygame.do?action=toshare&uin=${uin}&page=pregame&sid="+sid;
		//location = "flygame.do?action=toshare&uin=${uin}&tid=${tid}&bnums="+bnums+"&sid="+sid;
	}
	
}

//��Ϊ�û���
function toaddfriend(id,index){
	T.A.sendData("flygame.do","POST","action=addfriend&uin=${uin}&touin="+touin+"&sid="+id,function(ret){
		if(ret==1){
			T.loadTip(1,"��Ϊ�û��ѳɹ���",2,"");
			getobj('addorshare_'+index).innerHTML='<b>�ѼӺ���</b>';
		}else if(ret==2){
			T.loadTip(1,"��Ϊ�û��ѳɹ���",2,"");
			getobj('addorshare_'+index).innerHTML='<b>�ѼӺ���</b>';
		}else
			T.loadTip(1,"��Ǹ������û���ʧ�ܣ��´ΰ�~~",2,"");
	});
}
//����
function viewRule(){
	//var url="http://mp.weixin.qq.com/s?__biz=MzA4MTAxMzA2Mg==&mid=208930805&idx=1&sn=2196e63ca2ecedad4960bee99688f46a#rd";
	
	var cover = document.createElement("div");
	cover.setAttribute('id','cover');
	setobjCss(cover,{'display':'block','visibility':'visible','width':'100%','height':'100%','background':'#000','position':'absolute',
				'top':'0px','left':'0px','cursor':'not-allowed','filter':'alpha(opacity=40)','opacity':'0.6'});
	//�б��
	var dis = document.createElement("div");
	dis.setAttribute('id','dis');
	dis.className='friendbg';
	setobjCss(dis,{'top':parseInt(h*0.15)+'px','left':parseInt(w*0.1)+'px','width':parseInt(w*0.8)+'px',
				'height':parseInt(h*0.65)+'px','position':'absolute','align':'center'});
	dis.zIndex = 1;
	
	//����ͼ��
	var frimg = document.createElement("img");
	frimg.src="images/flygame/rule_title.png";
	setobjCss(frimg,{'top':parseInt(h*0.038)+'px','left':parseInt(w*0.25)+'px','width':parseInt(w*0.3)+'px','position':'absolute'});
	dis.appendChild(frimg);
	
	
	//ͣ��ȯ�б�
	var fsdiv = document.createElement("div");
	setobjCss(fsdiv,{'top':parseInt(h*0.5*0.2)+'px','left':parseInt(w*0.022)+'px','width':parseInt(w*0.76)+'px',
		'position':'absolute','height':parseInt(h*0.8*0.65)+'px','overflowY':'auto'});
	
	//����ͼ��
	var frimg = document.createElement("img");
	frimg.src="images/flygame/fly_rule.png";
	setobjCss(frimg,{'left':parseInt(w*0.01)+'px','width':parseInt(w*0.74)+'px','position':'absolute'});
	fsdiv.appendChild(frimg);
	
	dis.appendChild(fsdiv);
	
	//�رհ���
	var img= document.createElement("img");
	img.setAttribute('id','aimg');
	setobjCss(img,{'top':parseInt(h*0.13)+'px','left':parseInt(w*0.82)+'px','width':parseInt(w*0.1)+'px','position':'absolute'});
	img.src="images/flygame/close_green.png";
	img.onclick=function(){closeCover()};
	
	document.body.appendChild(cover);
	document.body.appendChild(dis);
	document.body.appendChild(img);
}

/**��ȡ��Ϣ*/
function getmessage(obj,touin){
	var tuin = touin;
	if(obj){
		tuin=obj.id;
		closeCover();
	}
	var data = eval(T.A.sendData("flygame.do","POST","action=message&fuin=${uin}&tuin="+tuin));
	
	mymessages(data,tuin);
}


/**ͣ��ȯ���ӵ� */
function getmTickets(obj){
	var data = eval(T.A.sendData("flygame.do","POST","action=usetickets&uin=${uin}"));
	usetickets(data);
}

/*��������*/
function levemesg(obj){
	//closeTimeout();
	obj.value='';
	setobjCss(obj,{'color':'#666666'});
}
/*������Ϣ*/
function sendmessage(){
	var message=getobj('mesginput').value;
	if(message=='��������'||message==''){
		return ;
	}
	//alert(message);
	if(message&&message.length>0){
		var data = eval(T.A.sendData("flygame.do","POST","action=sendmessge&fuin=${uin}&tuin="+touin+"&message="+encodeURI(encodeURI(message))));
		closeCover();
		mymessages(data,touin);
	}
}

function toBuy(){
	//location='http://mp.weixin.qq.com/s?__biz=MzA4MTAxMzA2Mg==&mid=205938292&idx=1&sn=76c6259270d762df187a187fac9e9a8d#rd';
	var sourcetag = navigator.userAgent;
	if(navigator.userAgent.indexOf("MicroMessenger")==-1){
		if(sourcetag.indexOf("Android")!=-1){//����android
			window.share.buyTicket();
		}else if(sourcetag.indexOf("iPhone")!=-1){//����iphone
			location = 'http://s.buyticket.com';
		}
	}else{
		location = "wxpaccount.do?action=tobuyticket&openid=${openid}";
	}
	closeCover();
}
/**ȥ������**/
function closeCover(){
	document.body.removeChild(getobj('aimg'));
	document.body.removeChild(getobj('dis'));
	document.body.removeChild(getobj('cover'));
}

var agin='${agin}';
if(agin!=''){
	//var touin = '${touin}';
	if(agin=='1')
		getmTickets();
	else if(agin=='friend')
		getfriend();
	else if(agin=='score')
		myscore();
	else if(agin=='leavemesg')
		getmessage(false,'${touin}')
}


function getNewMessage(){
	var data = eval(T.A.sendData("flygame.do","POST","action=message&mtype=1&fuin=${uin}&tuin="+touin));
	if(data&&data.length>0){
		closeCover();
		mymessages(data,touin);
		closeTimeout();
	}
	mesgTiv=setTimeout(getNewMessage,5000);
}

function closeTimeout(){
	if(mesgTiv){
		clearTimeout(mesgTiv);
		mesgTiv=false;
	}
}
</script>
</html>
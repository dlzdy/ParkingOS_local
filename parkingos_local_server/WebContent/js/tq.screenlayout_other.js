/*ScreenLayout Fucntion 2012-05-05
  LatestVersion 2012-06-19
 ÿ��һ�����������ڴ˱�ע��
*/
var lt = layouttype;//��������
var lt_h = 50;//�绰������Ϣ��
var l_w = 260;;//�绰��ע�ȿ��
var b_h = (lt==0)?170:230;//�ײ��߶�
b_h = T.gwh()>550?b_h+50:b_h;
var r_h = 0;//���������������
(function(){
var layoutContainer = document.getElementById("alllayout");
var layoutL = document.createElement("div");//��
var layoutR = document.createElement("div");//��
var layoutB = document.createElement("div");//��
var telinfo = document.createElement("div");//���������
var mesginfo = document.createElement("div");//���������
var relationsI = document.createElement("div");//�ͻ������Ϣ�б���
var relationsC = document.createElement("div");//�ͻ������Ϣչʾ
if(lt==2){
	var layoutRAll = document.createElement("div");
	layoutRAll.id = "layoutRAll";
	layoutRAll.style.width = T.gww() - l_w - 10  +"px";
	layoutRAll.style.height = T.gwh() - r_h - 2 + "px";
	layoutRAll.className = "layoutrall";
}
//��
layoutL.id = "screenleft";
layoutL.className = "layoutleft";
layoutL.style.width = l_w + 2+"px";
//��
layoutR.id = "screenright";
if(lt!=2){
	layoutR.className = "fieldlayout layoutright";
	layoutR.style.height = T.gwh() - b_h - r_h -  10  +"px";
	layoutR.style.width = T.gww() - l_w - 12  +"px";
}else{
	layoutR.className = "fieldlayout layoutright";
	layoutR.style.height ="auto";
	layoutR.style.width = T.gww() - l_w - 32 + "px";
	(T.iev =="6.0")?layoutR.style.marginLeft = "1px":"";
};
//��
layoutB.className = "fieldlayout layoutbottom";
layoutB.style.width = (lt==0)?T.gww() - 6 +"px":T.gww() - l_w - 12 +"px";
if(lt==2){
	layoutB.style.width = T.gww() - l_w - 32 +"px"
	layoutB.style.height ="auto"
}else{
	(T.iev =="6.0"&&lt==1)?layoutB.style.marginLeft = "2px":"";
	(b_h==0)?layoutB.style.display ="none":layoutB.style.height = b_h - 2 + "px";
}
//����
layoutContainer.appendChild(layoutL);
if(lt==2){
	layoutRAll.appendChild(layoutR);
	layoutContainer.appendChild(layoutRAll);
}else{
	layoutContainer.appendChild(layoutR);
	layoutContainer.appendChild(layoutB);
}
//��CONTENT
mesginfo.id="messagedetail";
mesginfo.className="fieldlayout telfollowup";
mesginfo.style.overflow = "auto";
mesginfo.innerHTML = getFieldsInfo('messageinfo').join("");
mesginfo.style.height = T.gwh() - b_h - r_h - lt_h - 3  +"px";
//�������TAB
telinfo.id = "telinfoid";
telinfo.className = "fieldlayout telinfo";
telinfo.style.height = (lt_h-10) +"px";
var tTab = document.createElement("div");
tTab.id = "teldealediv";
tTab.className ="teldeale";
telinfo.appendChild(tTab);
layoutL.appendChild(telinfo);
layoutL.appendChild(mesginfo);
Ttab({
	mName:"busi",
	items:telbuttons,
	menuI:tTab,
	menuC:layoutR,
	menuCw:T.gww() - l_w - 12,
	menuCh:T.gwh() - b_h - 10,
	mtype:"over",
	normalC:"nos",
	selectC:"s"
});

//��CONTENT
//���������ϢTAB
if(lt!=2){
	relationsI.className = "relationmenu";
	relationsC.className = "relationcontainer"
	relationsC.style.width = "100%";
	relationsC.style.height = b_h==0?"auto":b_h - 27 + "px";
	layoutB.appendChild(relationsI);
	layoutB.appendChild(relationsC);
	Ttab({
		mName:"rela",
		items:relationsbutton,
		menuI:relationsI,
		menuC:relationsC,
		mtype:"over",
		normalC:"nos",
		selectC:"s"
	});
}else{
	var layoutRAllb = document.createElement("div")
	layoutRAllb.style.width = (T.iev == "6.0")?T.gww() - l_w - 37 + "px":T.gww() - l_w - 32 + "px";
	var rlen = relationsbutton.length;
	for(var i = 0;i<rlen;i++)
	{
		var c = document.createElement("div")
		c.innerHTML = "<span style=\"float:left;width:100%;height:29px;line-height:29px;padding-left:5px;font-weight:700;border-bottom:1px solid #ccc\">"+relationsbutton[i].dname+"</span>";
		c.className = "layoutbottom";
		c.style.marginTop = "4px";
		c.style.border = "1px solid #889DAD";
		c.style.cssFloat = "left";
		c.style.width = "100%";
		c.style.height = "auto";

		var t = document.createElement("div");
		var cheight = relationsbutton[i].height?t.items[id].height+"px":"100%";
		t.style.height = cheight;
		t.style.width = "100%";
		t.style.background = "#fff";
		t.style.overflow = "hidden";
		t.style.display = "block";
		t.style.cssFloat = "left";
		if(relationsbutton[i].sysfuc){
			relationsbutton[i].sysfuc(t);
		}else{
			t.innerHTML = (relationsbutton[i].src)?"<iframe src=\""+relationsbutton[i].src+"\" frameborder=\"0\" width=\"100%\" height=\"100%\"></iframe>":""+relationsbutton[i].content+"";
		};
		c.appendChild(t);
		layoutRAllb.appendChild(c);
	};
	layoutRAll.appendChild(layoutRAllb);
	setTimeout(
		function()
		{
			for(var i=0;i<telbuttons.length;i++)
				{
					T("busi_a_"+i).aevt("click",function(){
						layoutRAll.scrollTop = "0"
					})
				}
		},100)
};
T.bind(window,"resize",function(){
	try{
		PL?PLorder.style.width = T.gww() - l_w - 12  +"px":"";
		if(lt!=2){
			layoutR.style.height = T.gwh() - b_h - r_h -  10  +"px";
			mesginfo.style.height = T.gwh() - b_h - r_h - lt_h - 3  +"px";
			layoutB.style.width = (lt==0)?T.gww() - 6 +"px":T.gww() - l_w - 12 +"px";
			layoutR.style.width = T.gww() - l_w - 12  +"px"};
		if(lt==2){
			//layoutR.style.height = "auto";
			layoutRAllb.style.width = (T.iev == "6.0")?T.gww() - l_w - 37 + "px":T.gww() - l_w - 32 + "px";
			layoutR.style.width = T.gww() - l_w - 32 + "px";
			layoutRAll.style.width = T.gww() - l_w - 10 +"px";
			layoutRAll.style.height = T.gwh() - r_h - 2 + "px";
		}else{
			(b_h==0)?layoutB.style.display ="none":layoutB.style.height = b_h - 2 + "px";
		}
	}catch(e){};
});
})();
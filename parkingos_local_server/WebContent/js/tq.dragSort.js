/*firefox���wind.event�¼�����*/
function __firefox(){
    HTMLElement.prototype.__defineGetter__("runtimeStyle", __element_style);
    window.constructor.prototype.__defineGetter__("event", __window_event);
    Event.prototype.__defineGetter__("srcElement", __event_srcElement);
}
function __element_style(){
    return this.style;
}
function __window_event(){
    return __window_event_constructor();
}
function __event_srcElement(){
    return this.target;
}
function __window_event_constructor(){
    if(document.all){
        return window.event;
    }
    var _caller = __window_event_constructor.caller;
    while(_caller!=null){
        var _argument = _caller.arguments[0];
        if(_argument){
            var _temp = _argument.constructor;
            if(_temp.toString().indexOf("Event")!=-1){
                return _argument;
            }
        }
        _caller = _caller.caller;
    }
    return null;
}
var _isIE = /msie/.test(navigator.userAgent.toLowerCase()) && !/opera/.test(navigator.userAgent.toLowerCase());
if(!_isIE){  
   __firefox();
}
/*end firefox���wind.event�¼�����*/
var Class = { 
      create:   function()   { 
          return   function()   { 
              this.initialize.apply(this, arguments); 
          } 
      } 
} 
function $A(iterable) {
	if (!iterable) return [];
	if (iterable.toArray) return iterable.toArray();
	var length = iterable.length, results = new Array(length);
	while (length--) results[length] = iterable[length];
	return results;
}
Function.prototype.bind=function(){
    if (arguments.length < 2 && arguments[0] === undefined) return this;
    var __method = this, args = $A(arguments), object = args.shift();
    return function() {
      return __method.apply(object, args.concat($A(arguments)));
    }
}
var Position = {
	positionedOffset:   function(element)   { 
          var valueT = 0,valueL  = 0,valueST = 0; 
          do{ 
              valueT   +=   element.offsetTop     ||   0; 
              valueL   +=   element.offsetLeft   ||   0; 
              valueST  +=   element.scrollTop || 0;
              element   =   element.offsetParent; 
              if(element){ 
                  p = element.style.position;
                  if(p == 'relative'||p == 'absolute')break; 
              } 
          }while(element); 
          return [valueL,valueT,valueST]; 
      }
};    


/*
	tq.dragSort.js
	�϶����� 2013-06-20
*/
var makeDragSort = function(initArg){
	var t = this;
	var initArg = initArg||{};
	t.uiObj = null;//�϶��ؼ�����Ķ���
	t.sortedIds = "";//��ʼ�г���ID����(id1,id2,id3) ��ʱû����
	t.valueObj = null;//����������������(������,��<input>)
	t.onlyFlag = "tqdragsort";//Ψһ��ʶ,�ַ���,�Է�ֹ���ͬ��ؼ���ͻ,���ܰ���"_",�����������뺯����������ͬ������
	t.isDrag = true;//�Ƿ��϶�
	t.startDragFun = null;//�϶���ʼʱִ�к���
	t.endDragFun = null;//�϶��ɹ�������ִ�к���
	t.stopDragFun = null;//�϶�ֹͣ��ִ�к���
	t.delFun = null;//ɾ�������г����,����ֵΪ�г���ID
	t.ajaxDelFun = null;//ɾ�����ٻص�ʱ,��ajaxɾ��
	t.clearFun = null;//����г���ִ�к���
	t.globleTip = "��ס�϶�����/�ϳ��б�����ɾ��&nbsp;";//�ײ���ʾ
	t.cellTip = "��ס�϶�����/�ϳ��б�����ɾ��";//��Ԫ��ʾ
	t.delArea = null;//�Ϸ��ͷ��¼���Ч����DOM ID
	t.minLimit = 0;//�����г�������
	t.maxLimit = false;//����г�������
	t.clearBt = true;//�Ƿ���ʾ��հ�ť
	t.buttons = null;//�Զ��尴ť
	
	t.customerArgList = "";//�Զ�������
	t.itembuttons = [{name:"�༭",tit:"�༭",type:"up",condition:[{valueIndex:0,value:"userdefine"}],iconcls:"",cls:""},{name:"ɾ��",tit:"ɾ��",type:"down",iconcls:"",cls:""}],//�ڵ���չ������ť(�ڵ������ұ���ʾ)
	//�����������ĸ�ʽ
	//ע��:conditonΪ�ջ�δ����ʱ,��ʾ���м�¼����Ӵ˲���
	//��itembuttonsFun���ʹ��
	t.itembuttonsFun = function(id,btType){alert(id)},//��չ��ť��Ӧ���¼�����,id ����ΨһID btType Ϊitembuttons�е�type����
	
	t.itembuttons = false;//��Ԫ��¼������ť
	t.itembuttonsFun = false;//��Ԫ��¼������ť����
	
	
	T.extend(t,initArg);
	t.minLimit = parseInt(t.minLimit);
	t.maxLimit = parseInt(t.maxLimit);
	if(!t.uiObj||!t.valueObj){return};
	var _Opos = T.gpos(t.uiObj);
	var _w = _Opos.width;
	var _h = _Opos.height;
	
	var _rTitle = document.createElement("div");
	var _rContent = document.createElement("div");
	
	_rTitle.className = "drag_sort_title";
	_rTitle.id = t.onlyFlag+"_drag_sort_title_obj";
	_rTitle.innerHTML = "<span style='float:left;'></span>";
	if(t.clearBt){
		_rTitle.innerHTML += "<span class='curhand fr' style='margin:3px 3px 0 0' onclick='"+t.onlyFlag.toString()+".clear()' title='���'><span class='icon16 icon16delete hover1 fl'></span></span>";
	};
	_rContent.style.height = _h - 54>0?_h - 54 + "px":"auto";
	_rContent.style.overflow = "auto";
	_rContent.id = t.onlyFlag+"_drag_sort_list_obj";
	
	t.uiObj.style.overflow = "hidden";
	t.uiObj.appendChild(_rTitle);
	t.uiObj.appendChild(_rContent);
	if(t.globleTip){
		var _rTip = document.createElement("div");
		_rTip.id = t.onlyFlag+"_drag_sort_tip_obj";
		_rTip.style.height = "23px";
		_rTip.style.color = "#999";
		_rTip.style.lineHeight = "24px";
		_rTip.style.textAlign = "right";
		_rTip.style.borderTop = "1px solid #ccc";
		_rTip.innerHTML = t.globleTip;
		_rTip.onmouseover = function(){this.style.color="#c00"};
		_rTip.onmouseout = function(){this.style.color="#999"};
		t.uiObj.appendChild(_rTip);
	};
	var _rContentH = "";
	_rContentH += "<div class='drag_sort_list'>"
	_rContentH += "<ul class='sort_div' id='"+t.onlyFlag+"_sort_div'>";
	_rContentH += "</ul>";
	_rContentH += "</div>";
	_rContent.innerHTML = _rContentH;

	t.sortResults = t.sortedIds!=""?t.sortedIds.split(","):[];
	t.total = 0;
	t.customerResults = [];
	
	/*�����ҵ�Drag����*/
	var Drag = {
	    // �����element�����ã�һ��ֻ����קһ��Element
	    obj: null , 
	    /**
	    * @param: elementHeader    used to drag..
	    * @param: element            used to follow..
	    */
	    init: function(elementHeader, element) {
	        // �� start �󶨵� onmousedown �¼���������괥�� start
	        elementHeader.onmousedown = Drag.start;
	        // �� element �浽 header �� obj ���棬���� header ��ק��ʱ������
	        elementHeader.obj = element;
	        // ��ʼ�����Ե����꣬��Ϊ���� position = absolute ���Բ�����ʲô���ã����Ƿ�ֹ���� onDrag ��ʱ�� parse ������
	        if(isNaN(parseInt(element.style.left))) {
	            element.style.left = "0px";
	        }
	        if(isNaN(parseInt(element.style.top))) {
	            element.style.top = "0px";
	        }
	        // ���Ͽ� Function����ʼ���⼸����Ա���� Drag.init �����ú�Űﶨ��ʵ�ʵĺ���
	        element.onDragStart = new Function();
	        element.onDragEnd = new Function();
	        element.onDrag = new Function();
	    },
	    // ��ʼ��ק�İ󶨣��󶨵������ƶ��� event ��
	    start: function(event) {
	        var element = Drag.obj = this.obj;
	        // �����ͬ������� event ģ�Ͳ�ͬ������
	        event = Drag.fixE(event);
	        // �����ǲ���������
	        if(event.which != 1){
	            // �����������������
	            return true ;
	        }
	        // ������������Ľ��ͣ����Ͽ�ʼ��ק�Ĺ���
	        element.onDragStart();
	        // ��¼�������
	        element.lastMouseX = event.clientX;
	        element.lastMouseY = event.clientY;
	        // ���¼�
	        document.onmouseup = Drag.end;
	        document.onmousemove = Drag.drag;
	        return false ;
	    }, 
	    // Element���ڱ��϶��ĺ���
	    drag: function(event) {
	        event = Drag.fixE(event);
//	        if(event.which == 0 ) {
//	             return Drag.end();
//	        }
	        // ���ڱ��϶���Element
	        var element = Drag.obj;
	        // �������
	        var _clientX = event.clientX;
	        var _clientY = event.clientY;
	        // ������û����ʲô������
	        if(element.lastMouseX == _clientX && element.lastMouseY == _clientY) {
	            return    false ;
	        }
	        // �ղ� Element ������
	        var _lastX = parseInt(element.style.left);
	        var _lastY = parseInt(element.style.top);
	        // �µ�����
	        var newX, newY;
	        // �����µ����꣺ԭ�ȵ�����+����ƶ���ֵ��
	        newX = _lastX + _clientX - element.lastMouseX;
	        newY = _lastY + _clientY - element.lastMouseY;
	        // �޸� element ����ʾ����
	        element.style.left = newX + "px";
	        element.style.top = newY + "px";
	        // ��¼ element ���ڵ����깩��һ���ƶ�ʹ��
	        element.lastMouseX = _clientX;
	        element.lastMouseY = _clientY;
	        // ������������Ľ��ͣ��ҽ��� Drag ʱ�Ĺ���
	        element.onDrag(newX, newY);
	        return false;
	    },
	    // Element ���ڱ��ͷŵĺ�����ֹͣ��ק
	    end: function(event) {
	        event = Drag.fixE(event);
	        // ����¼���
	        document.onmousemove = null;
	        document.onmouseup = null;
	        // �ȼ�¼�� onDragEnd �Ĺ��ӣ����Ƴ� obj
	        var _onDragEndFuc = Drag.obj.onDragEnd();
	        // ��ק��ϣ�obj ���
	        Drag.obj = null ;
	        return _onDragEndFuc;
	    },
	    // �����ͬ������� event ģ�Ͳ�ͬ������
	    fixE: function(ig_) {
	        if( typeof ig_ == "undefined" ) {
	            ig_ = window.event;
	        }
	        if( typeof ig_.layerX == "undefined" ) {
	            ig_.layerX = ig_.offsetX;
	        }
	        if( typeof ig_.layerY == "undefined" ) {
	            ig_.layerY = ig_.offsetY;
	        }
	        if( typeof ig_.which == "undefined" ) {
	            ig_.which = ig_.button;
	        }
	        return ig_;
	    }
	};

	var DragDrop = Class.create();
	DragDrop.prototype = {
	    initialize: function(elementHeader_id , element_id){
	        var element = document.getElementById(element_id);
	        var elementHeader = document.getElementById(elementHeader_id);
	        this.isDragging = false;
	        this.elm = element;
	        //this.hasIFrame = this.elm.getElementsByTagName("IFRAME").length > 0;
	        if(!t.isDrag)return;
	        if( elementHeader){
	            elementHeader.style.cursor = "move";
	            Drag.init(elementHeader, this.elm);
	            this.elm.onDragStart = this._dragStart.bind(this);
	            this.elm.onDrag = this._drag.bind(this);
	            this.elm.onDragEnd = this._dragEnd.bind(this);
	        }
	    },
	    // ��ʼ��ק
		_dragStart :function(event){
			if(t.startDragFun)t.startDragFun();
		    DragUtil.reCalculate(this);    // ���¼������п���קԪ�ص�λ��
		    this.origNextSibling = this.elm.nextSibling;
		    var _ghostElement = DragUtil.getGhostElement();
		    var offH = this.elm.offsetHeight;
		    var offW = this.elm.offsetWidth
			//if(DragUtil.isGecko){ // ���� Gecko
		        offH -= parseInt(_ghostElement.style.borderTopWidth) *  2 ;
		    	offW -= parseInt(_ghostElement.style.borderLeftWidth) * 2 ;
			//}
		    var position = Position.positionedOffset(this.elm);
		    var offLeft = position[0];
		    var offTop = position[1];
		    var scrollST = _rContent.scrollTop;
		    var scrollSL = _rContent.scrollLeft;
		    //��Ԫ�ص�ǰ�����ռλ���߿�
		    _ghostElement.style.width = offW  + "px";
		    _ghostElement.style.height = offH + "px";
		    this.elm.parentNode.insertBefore(_ghostElement, this.elm.nextSibling);
		    //����Ԫ����ʽ����
		    //this.elm.style.width = offW + "px";
		    this.elm.style.position = "absolute";
		    this.elm.style.zIndex = 100;
		   	var tmpMarginL = parseInt(T(this.elm).gtcs("marginLeft"));
		    var tmpMarginT = parseInt(T(this.elm).gtcs("marginTop"));
//		    this.elm.style.left = offLeft - tmpMarginL/2 + 'px';
			this.elm.style.left = t.uiObj.style.position ? offLeft -  tmpMarginL/2 - scrollSL   +'px': T.mousePos(event).x + "px";;
		    this.elm.style.top = t.uiObj.style.position ? offTop -  tmpMarginT/2 - scrollST   +'px': T.mousePos(event).y + "px";//offTop - tmpMarginT/2 - scrollST   +'px';
		    this.isDragging = false;
		    DragUtil.lastLeft = parseInt(this.elm.style.left);
		    DragUtil.lastTop = parseInt(this.elm.style.top);
		    //����ֵΪ��ˮƽ����Ԫ�صĿ�ȵ�һ�룬��ֱ����Ԫ�صĸ߶ȵ�һ��
		    DragUtil.rangeX = parseInt(offW / 2);
		    DragUtil.rangeY = parseInt(offH / 2);
		    return false;
		},
		// �϶�ʱ�������������ÿ���������仯ʱ��
		_drag: function(clientX , clientY){
		    if (!this.isDragging){    // ��һ���ƶ���꣬����������ʽ
		        this.elm.style.filter = "alpha(opacity=70)";
		        this.elm.style.opacity = 0.7;
		        this.isDragging = true;
		    }
		    // �����뵱ǰ���λ������Ŀ���ק��Ԫ�أ��Ѹ�Ԫ�طŵ� found ������
		    var found = null;
		    var max_distance = 100000000;
		    for(var i = 0 ; i < DragUtil.dragArray.length; i++) {
		        var ele = DragUtil.dragArray[i];
		        DragUtil.curLeft = parseInt(this.elm.style.left);
		        DragUtil.curTop = parseInt(this.elm.style.top);
		        var distance = Math.sqrt(Math.pow(clientX - ele.elm.pagePosLeft, 2 ) + Math.pow(clientY - ele.elm.pagePosTop, 2 ) ) ;//+ Math.pow(clientY  + _rContent.scrollTop, 2 )

		        if(isNaN(distance)){
		            continue;
		        }
		        if(distance < max_distance){
		            max_distance = distance;
		            found = ele;
		        }
		    }
		    if(DragUtil.curTop > (DragUtil.lastTop+DragUtil.rangeY) || DragUtil.curTop >= (DragUtil.lastTop-DragUtil.rangeY) && 
		
		DragUtil.curLeft > (DragUtil.lastLeft+DragUtil.rangeX)) {
		        direction = 1;
		    } else if(DragUtil.curTop < (DragUtil.lastTop-DragUtil.rangeY) || DragUtil.curTop >= (DragUtil.lastTop-DragUtil.rangeY) 
		
		&& DragUtil.curLeft < (DragUtil.lastLeft-DragUtil.rangeX)) {
		        direction = -1;
		    } else return;
		    // �����߿�嵽 found Ԫ�ص�ǰ��
		    var _ghostElement = DragUtil.getGhostElement();
			//if(found != null && _ghostElement.nextSibling != found.elm) {
		    if(found != null) {
		    	try{
			        if(direction == -1) {
			            found.elm.parentNode.insertBefore(_ghostElement, found.elm);
			        } else if(direction == 1) {
			            found.elm.parentNode.insertBefore(_ghostElement, found.elm.nextSibling);
			        }
		        }catch(e){};
		        direction = '';
		        if(DragUtil.isOpera){//����Opera
		            document.body.style.display = "none";
		            document.body.style.display = "";
		        }
		    }
		},
		// ������ק
		_dragEnd :function(e){
		    var curId = this.elm.getAttribute("rid");
		    var curName = this.elm.firstChild.innerHTML;
		    var clsName = this.elm.className;
			if(t.stopDragFun)t.stopDragFun(""+curId);//��קֹͣ�����
		    if(this._afterDrag()){// ��ק�ɹ���Ĳ���
			   if(t.endDragFun)t.endDragFun(""+curId);
		    };
		    var e = e||window.event;
			var e_tar = e.srcElement?e.srcElement:e.target;
			if(t.delArea){
				if(e_tar.id.indexOf(t.delArea)!=-1)
				{
					t._delFun(""+curId,""+curName,""+clsName,e_tar.id);
				};
			}else if(t.delArea!=false){
				if(e_tar.id.split("_")[0]!=t.onlyFlag)
				{
					t._delFun(""+curId,""+curName,""+clsName,e_tar.id);
				};
			};
			t.sortResults = [];
		    var tmpElements = document.getElementById(t.onlyFlag+"_sort_div").childNodes;
		    for(var i=0;i<tmpElements.length;i++){
				t.sortResults.push(tmpElements[i].getAttribute("rid"));
		    };
			t.save_sort();
		    return true;
		},
		// ������קʱ���õĺ���
		_afterDrag : function(){
		    var returnValue = false;
		    // ���϶���Ԫ�ص���ʽ�ظ���ԭ����״̬
		    DragUtil.curTop = 0;
		    DragUtil.curLeft = 0;
		    DragUtil.lastTop = 0;
		    DragUtil.lastLeft = 0;
		
		    this.elm.style.position = "";
		    this.elm.style.top = "";
		    this.elm.style.left = "";
		    this.elm.style.width = "";
		    this.elm.style.zIndex = "";
		    this.elm.style.filter = "";
		    this.elm.style.opacity = "";
		    // �����߿�ĵط������϶������Ԫ��
		    var ele = DragUtil.getGhostElement();
		    if(ele.nextSibling != this.origNextSibling) {
		        ele.parentNode.insertBefore(this.elm, ele.nextSibling);
		        //��Ҫ��dragArray��Ӧ����
		        returnValue = true;
		    }
		    //ɾ�����߿�
		    ele.parentNode.removeChild(ele);
		    if(DragUtil.isOpera) {
		        document.body.style.display = "none";
		        document.body.style.display = "" ;
		    }
		    return returnValue;
		}
	};
	
	var DragUtil = new Object();
	// ����������Ϣ
	DragUtil.getUserAgent = navigator.userAgent;
	DragUtil.isGecko = DragUtil.getUserAgent.indexOf("Gecko") != -1;
	DragUtil.isOpera = DragUtil.getUserAgent.indexOf("Opera") != -1;
	// ����ÿ������ק��Ԫ�ص�����
	DragUtil.reCalculate = function(el) {
	    for( var i = 0 ; i < DragUtil.dragArray.length; i++ ) {
	        var ele = DragUtil.dragArray[i];
	        var position = Position.positionedOffset(ele.elm);
	        ele.elm.pagePosLeft = position[0];
	        ele.elm.pagePosTop = position[1] - _rContent.scrollTop;
	    }
	};
	// �϶�Ԫ��ʱ��ʾ��ռλ��
	DragUtil.ghostElement = null ;
	DragUtil.getGhostElement = function(){
	    if(!DragUtil.ghostElement){
	        DragUtil.ghostElement = document.createElement("DIV");
	        DragUtil.ghostElement.className = "modbox";
	        DragUtil.ghostElement.id = t.onlyFlag+"_modbox";
	        DragUtil.ghostElement.style.border = "3px dashed #aaa";
	        DragUtil.ghostElement.innerHTML = "&nbsp;";
	    }
	    return DragUtil.ghostElement;
	};

	DragUtil.curTop = 0, DragUtil.curLeft = 0; // ��ǰ��קԪ�ص�λ��
	DragUtil.lastTop = 0, DragUtil.lastLeft = 0; // ��ʼ��ק��Ԫ�ص�λ��
	DragUtil.rangeX = 0, DragUtil.rangeY = 0; // �϶�����Ӧ��Χ������ֵ
	DragUtil.dragArray = new Array();
	// ��ʼ�����п���ק��Ԫ�أ����г�ֵ������ק�Ĳ��ֵ� id Ϊ��Ԫ�� id ���� _h
	t.initDrag = function(tmpHeaderElementId,tmpElementId) {
		DragUtil.dragArray[t.total] = new DragDrop(tmpHeaderElementId , tmpElementId);
		t.total+=1;
	};
	t.add_sort = function(name,id,cls,args,extArgValue){
		var args = args||{};
		if(t.maxLimit&&t.sortResults.length==t.maxLimit){
			T.loadTip(1,"�������"+t.maxLimit+"��",3,t.uiObj);
			return;
		};
		if(T.AindexOf(t.sortResults,id)==-1){t.sortResults.push(id);};
		if(document.getElementById(t.onlyFlag+"_"+id)){return};
		var obj = document.getElementById(t.onlyFlag+"_sort_div");
		var addDiv = document.createElement("li");
		addDiv.id = t.onlyFlag+"_"+id;
		addDiv.setAttribute("rid",id);
		
		var _extArgs = t.customerArgList?t.customerArgList.split(","):false;
		if(_extArgs&&extArgValue)
			T.each(_extArgs,function(p,q){
				addDiv.setAttribute(p,extArgValue[q]);//����Ҫ��Ӧ
			});
			
			
		addDiv.className = cls||"drag_li";
		addDiv.style.left = "0px";
		addDiv.style.top = "0px";
		
		var dragDiv = document.createElement("div");
		dragDiv.id = t.onlyFlag+"_"+id+"_h";
		t.cellTip?dragDiv.title = t.cellTip:"";
		dragDiv.className = "drag_div";
		dragDiv.innerHTML = name;
		addDiv.appendChild(dragDiv);
			
		if(t.itembuttons){
			var btDiv = document.createElement("div");
			btDiv.className = "drag_btdiv";
			
			var itembuttons = t.itembuttons;
			var _ibl = itembuttons.length;
			
			for(var i = 0;i<_ibl;i++){
				var item = itembuttons[i];
				if(item.condition){
					var _iC = item.condition;
					var kk =_iC.length;
					var resNum = 0;
					for(var jj=0;jj<kk;jj++){
						if(_iC[jj].value == args[_iC[jj].valueIndex]){
							resNum++
						}
					};
					if(resNum == kk){
						var _bs = document.createElement("span");
						var _cls = item.cls;
						_cls = _cls?_cls:"fl button16_a border_gray bg_gray_hover";
						var iconcls = item.iconcls||"";
						_bs.className = _cls;
						_bs.setAttribute("itembt","yes");
						_bs.setAttribute("rid",id);
						_bs.setAttribute("type",item.type);
						_bs.title = item.tit?item.tit:item.name;
						_bs.innerHTML = "<span class='"+iconcls+"'></span>"+item.name;
						_bs.onpress = item.onpress;
						_bs.onclick = function(){
							t.btClick()
						};
						btDiv.appendChild(_bs);
					}
				}else{
					var _bs = document.createElement("span");
					var _cls = item.cls;
					_cls = _cls?_cls:"fl button16_a border_gray bg_gray_hover";
					var iconcls = item.iconcls||"";
					_bs.className = _cls;
					_bs.setAttribute("itembt","yes");
					_bs.setAttribute("rid",id);
					_bs.setAttribute("type",item.type);
					_bs.title = item.tit?item.tit:item.name;
					_bs.innerHTML = "<span class='"+iconcls+"'></span>"+item.name;
					_bs.onpress = item.onpress;
					_bs.onclick = function(){
						t.btClick()
					};
					btDiv.appendChild(_bs);
				}
			};
			addDiv.appendChild(btDiv);
		};
		
		obj.appendChild(addDiv);
		t.initDrag(t.onlyFlag+"_"+id+"_h",t.onlyFlag+"_"+id);
		t.save_sort();
	}
	t._delFun = function(id,name,cls,e_tar){
		if(!isNaN(t.minLimit)&&t.sortResults.length<t.minLimit+1){
			T.loadTip(1,"���ٱ���"+t.minLimit+"��",3,t.uiObj);
			return;
		};
		if(t.ajaxDelFun){
			t.ajaxDelFun(id,name,cls,e_tar,t.del_sort);
		}else{
			t.del_sort(id);
			t.delFun?t.delFun(id,name,cls,e_tar):"";
		};
	};
	t.del_sort = function(id){
		if(T.AindexOf(t.sortResults,id)!=-1){T.Aremove(t.sortResults,id);};
		if(!document.getElementById(t.onlyFlag+"_"+id)){return};
		var obj = document.getElementById(t.onlyFlag+"_sort_div");
		var addDiv = document.getElementById(t.onlyFlag+"_"+id);
		if(!addDiv){return};
		obj.removeChild(addDiv);
		t.save_sort();
	}
	t.save_sort = function(jurl,jdiv,jfunc){
		this.valueObj.value = t.sortResults.join(",");
		T("#"+t.onlyFlag+"_drag_sort_title_obj").firstChild.innerHTML = "&nbsp;��&nbsp;<font style='color:#c00;font-weight:700'>"+t.sortResults.length+"</font>&nbsp;��";
	}
	t.clear = function(){
		var tmpElements = document.getElementById(t.onlyFlag+"_sort_div");
		var ids = t.sortResults.join(",");
		if(t.minLimit>0){
			T.loadTip(1,"���ٱ���"+t.minLimit+"��",3,t.uiObj);
			var _s = t.sortResults;
			var _sl = _s.length;
			for (var m=_sl-1;m>t.minLimit-1;m--){
				var _o = document.getElementById(t.onlyFlag+'_'+_s[m]+'_h');
				t._delFun(_s[m],_o.innerHTML,_o.parentNode.className)
			};
			ids = ids.replace(t.sortResults.join(","),"").replaceAll(",,",",");
			ids.lastIndexOf(",")==ids.length-1?ids=ids.substring(0,ids.length-1):"";
		}else{
			tmpElements.innerHTML = "";
			t.sortResults = [];
			t.save_sort();
			DragUtil.dragArray = null;
			DragUtil.dragArray = new Array();
			t.total = 0;
		};
		t.clearFun?t.clearFun(ids):"";	
		ids = null;
	},
	t.clearAll = function(){
		var tmpElements = document.getElementById(t.onlyFlag+"_sort_div");
		var ids = t.sortResults.join(",");
			tmpElements.innerHTML = "";
			t.sortResults = [];
			t.save_sort();
			DragUtil.dragArray = null;
			DragUtil.dragArray = new Array();
			t.total = 0;
		//t.clearFun?t.clearFun(ids):"";	
		ids = null;
	},
	t.btClick = function(e){
		e = window.event || e; e = e.srcElement || e.target;
		switch(e.tagName.toUpperCase()){
			case "SPAN" :
				if(e.getAttribute("itembt")=="yes"){
					if(t.itembuttonsFun){
						var rid = e.getAttribute("rid");
						var btType = e.getAttribute("type");
						t.itembuttonsFun(rid,btType);
					};
				}
				break;
		}
	},
	t.customerArgs = function(){
		if(!t.customerArgList)return;
		t.customerResults = [];
		var _arg = t.customerArgList.split(",");
		var tmpElements = document.getElementById(t.onlyFlag+"_sort_div").childNodes;
		T.each(_arg,function(o,m){
			var _r = [];
		    for(var i=0;i<tmpElements.length;i++){
				_r.push(tmpElements[i].getAttribute(o));
		    };
		    t.customerResults.push(_r);
		});
		return T.Obj2Str(t.customerResults);	
	}
}



/*Base Fucntion
 LatestVersion 2012-07-07
*/
(function() {
    var g = window.T = function(a, d) {
        return g.privt.init(a, d);
    };
    g.privt = g.prototype = {
        init: function(a, d) {
            a = (a == 'body') ? document.body: (a == 'doc') ? document: a;
            if ('string' == typeof(a)) {
                if (a.indexOf('#') == 0) {
                    var b = (d || document).getElementById(a.substr(1));
                    if (b) return b;
                    else return null;
                }
                var b = (d || document).getElementById(a);
                if (b) return g(b);
                else return null;
            } else {
                this[0] = a;
                this.length = 1;
                return this;
            }
        },
        html: function(t) {
            if (t) {
                this[0].innerHTML = t;
                return this;
            } else return this[0].innerHTML;
        },
        isnl: function() {
			var obj = this[0];
			var v='';
			if(obj.length){
				for(var i = 0;i<obj.length;i++){
					obj[i].checked||obj[i].selected?v += obj[i].value||"":""
				}
			}else{
				v= obj.value;
			};
            return (v == '' || v.length == 0) ? true: false;
        },
        val: function(v) {
            if (v) {
                this[0].value = v;
                return this;
            } else return this[0].value;
        },
        acls: function(c, p) {
            this[0].className = p ? this[0].className + ' ' + c: c;
            return this;
        },
        rcls: function(c) {
	        if(c){
	            var oc = new RegExp((c + "\s?"), "i");
				this[0].className = this[0].className.replace(oc, "").replace(/^\s?|\s?$/g, "");
	            return this;
	        }else{
	        	var a = g.ie ? 'className': 'class';
	            this[0].removeAttribute(a, 0);
	        }
        },
        crte: function(e) {
            return this[0].createElement(e);
        },
        stcs: function(d, s) {
            if (typeof(d) == 'object') {
                for (var n in d) this[0].style[n] = d[n];
                return this;
            } else {
                this[0].style[d] = s;
                return this;
            }
        },
        
        
        gtcs: function(p) {
            if (this[0].currentStyle) return this[0].currentStyle[p];
            else if(window.getComputedStyle) return window.getComputedStyle(this[0], null)[p];
            else return null
            //return this[0].ownerDocument.defaultView.getComputedStyle(this[0], '').getPropertyValue(p);
        },
        gtag: function(n) {
            return this[0].getElementsByTagName(n);
        },
        attr: function(k, v) {
            if (typeof(k) == 'object') {
                for (var n in k) this[0][n] = k[n];
                return this;
            }
            if (v) {
                this[0].setAttribute(k, v, 0);
                return this;
            } else {
                var a = this[0].attributes[k];
                if (a == null || !a.specified) return '';
                return this[0].getAttribute(k, 2);
            }
        },
        ratt: function(n) {
            var a = this[0].attributes[n];
            if (a == null || !a.specified) return this;
            this[0].removeAttribute(n, 0);
            return this;
        },
        aevt: function(n, f) {
            if (g.iev&&g.iev<9) this[0].attachEvent('on' + n, f);
            else this[0].addEventListener(n, f, false);
            return this;
        },
        revt: function(n, f) {
            if (g.iev&&g.iev<9) this[0].detachEvent('on' + n, f);
            else this[0].removeEventListener(n, f, false);
            return this;
        },
        apch: function(c, y) {
            switch (y) {
            case 'pr':
                return this[0].insertBefore(c, this[0].firstChild);
                break;
            case 'be':
                return this[0].parentNode.insertBefore(c, this[0]);
                break;
            case 'af':
                return this[0].parentNode.insertBefore(c, this[0].nextSibling);
                break;
            default:
                return this[0].appendChild(c);
                break;
            }
        }
	};
    g.privt.init.prototype = g.privt;
	/*��չ*/
    g.extend = g.privt.extend = function() {
        var a = arguments[0] || {},
        i = 1,
        length = arguments.length,
        deep = false,
        options;
        if (a.constructor == Boolean) {
            deep = a;
            a = arguments[1] || {};
            i = 2;
        }
        if (typeof a != 'object' && typeof a != 'function') a = {};
        if (length == i) {
            a = this; --i;
        }
        for (; i < length; i++) if ((options = arguments[i]) != null) for (var b in options) {
            var c = a[b],
            copy = options[b];
            if (a === copy) continue;
            if (deep && copy && typeof copy == 'object' && !copy.nodeType) a[b] = g.extend(deep, c || (copy.length != null ? [] : {}), copy);
            else if (copy !== undefined) a[b] = copy;
        }
        return a;
    };
    g.privt.extend({
        stopac: function(o) {
            if (g.ie) {
                o = Math.round(o * 100);
                this[0].style.filter = (o > 100 ? '': 'alpha(opacity=' + o + ')');
            } else this[0].style.opacity = o;
        },
        addentex: function(n, l, p) {
            if (g.ie) {
                var o = {};
                o.source = this[0];
                o.params = p || [];
                o.listen = function(a) {
                    return l.apply(o.source, [a].concat(o.params));
                };
                if (g.clean) g.clean.items(null, 
                function() {
                    o.source = null;
                    o.params = null;
                });
                try{this[0].attachEvent('on' + n, o.listen);}catch(e){};
                this[0] = null;
                p = null;
            } else this[0].addEventListener(n, 
            function(e) {
                l.apply(this[0], [e].concat(p || []));
            },
            false);
            return this;
        },
        click: function(f) {
            this[0].onclick = f;
            return this;
        },
        blur: function(f) {
            this[0].onblur = f;
            return this;
        },
        focus: function(f) {
            if (f) this[0].onfocus = f;
            else this[0].focus();
            return this;
        },
        msdown: function(f) {
            this[0].onmousedown = f;
            return this;
        },
        msmove: function(f) {
            this[0].onmousemove = f;
            return this;
        },
        msover: function(f) {
            this[0].onmouseover = f;
            return this;
        },
        msout: function(f) {
            this[0].onmouseout = f;
            return this;
        },
        msup: function(f) {
            this[0].onmouseup = f;
            return this;
        },
        submit: function(f) {
            if (f) this[0].onsubmit = f;
            else this[0].onsubmit();
            return this;
        },
        cmenu: function(f) {
            this[0].oncontextmenu = f;
            return this;
        },
        hover: function(r, t) {
            this[0].onmouseover = r;
            this[0].onmouseout = t;
            return this;
        }
    });
	/*����*/
    g.extend({
		LJC:function(p,t){
			var s,i;
			if(t == "j"){
				var ss = document.getElementsByTagName("script");
				for(i =0;i < ss.length; i++)
				{
					if(ss[i].src && ss[i].src.indexOf(p) != -1)return ss[i];
				}
				s      = document.createElement("script");
				s.t    = "text/javascript";
				s.src  = p;
			}
			else if(t == "c")
			{
				var ls = document.getElementsByTagName("link");
				for(i = 0; i < ls.length; i++)
				{
					if(ls[i].href && ls[i].href.indexOf(p)!=-1)return ls[i];
				}
				s          = document.createElement("link");
				s.rel      = "stylesheet";
				s.t        = "text/css";
				s.href     = p;
				s.disabled = false;
			}
			else return;
			var head = document.getElementsByTagName("head")[0];
			head.appendChild(s);
			return s;
		},
		each:function(o,fn){
			for(var j=0,len=o.length;j<len;j++){
				fn(o[j],j);
			}
		},
		gbh:function(_w) {
			var w,_w=_w?_w:0;
			w = document.body.scrollHeight;
			w = w<_w?_w:w;
			return parseInt(w);
		},
		gww:function(_w) {
			var w,_w=_w?_w:0;
			//alert(document.body.clientWidth )
			if (window.innerWidth) {
				w = window.innerWidth;
			}else{
				w = document.documentElement.clientWidth || document.body.clientWidth || 0;
//				if(g.iev&g.iev<8)
//				{
//					w += document.body.clientHeight<document.body.clientHeight?21:4
//				}
			};
			w = w<_w?_w:w;
			return parseInt(w);
		},
		gwh:function(_h) {
			var h,_h=_h?_h:0;
			if (window.innerHeight) {
				h = window.innerHeight;
			}else{
				h = document.documentElement.offsetHeight || document.body.clientHeight || 0;
			};
			if(g.iev&&g.iev<9)
			{
				h -= 1
			}
			h = h<_h?_h:h;
			return parseInt(h);
		},
		gow:function(o){
			var w;
			w = o.offsetWidth;
			return w;
		},
		goh:function(o){
			var h;
			h = o.offsetHeight;
			return h;
		},
		rform:function(nm){
			document.forms[nm].reset();
		},
		sform:function(nm){
			document.forms[nm].submit();
		},
		addcls:function (e,v) {
			if (!e.className) {
				e.className = v;
			} else {
				nC = e.className;
				nC += " ";
				nC += v;
				e.className = nC;
			}
		},
		recls:function (e,v) {
				e.className = v;
		},
		remcls:function (e,c) {
			var oc = new RegExp((c + "\s?"), "i");
			e.className = e.className.replace(oc, "").replace(/^\s?|\s?$/g, "");
		},
		gbycls:function(cls, oNode, t){
			if (!oNode) oNode = document;
			if (t == null) t = '*';
			var el = new Array();
			var tags = oNode.getElementsByTagName(t);
			var tcl = " "+cls+" ";
			for(i=0,j=0; i<tags.length; i++){
				var test = " " + tags[i].className + " ";
				if (test.indexOf(tcl) != -1)
				 el[j++] = tags[i];
			 };
			return el;
		},
		cursty : function(e){
		 return e.currentStyle || document.defaultView.getComputedStyle(e, null);
		},
		bind:function(el, e, fn) {
			(el.addEventListener) ? el.addEventListener(e, fn, false):el.attachEvent("on" + e, fn);
		},
		unbind:function(el, e, fn) {
			el.removeEventListener ? el.removeEventListener(e, fn, false) : el.detachEvent("on" + e, fn);
		},
		removech: function(c){
            return (typeof(c)=="string")?g("#"+c).parentNode.removeChild(g("#"+c)):c.parentNode.removeChild(c);
        },
		trim:function(t){
			return(t||'').replace(/^\s+|\s+$/g,'')
        },
		gpos: function(o) {
			var elem = typeof(o)=="object"?o:document.getElementById(o);
			if ( !elem ) {
				return {
					x: 0,
			        y: 0,
					top: 0,
					left: 0,
					width: 0,
					height: 0
				}
			};
			var top = 0, left = 0, w = elem.offsetWidth,h = elem.offsetHeight;
			if ( "getBoundingClientRect" in document.documentElement ){
				//jquery����
				var box = elem.getBoundingClientRect(), 
				doc = elem.ownerDocument, 
				body = doc.body, 
				docElem = doc.documentElement,
				clientTop = docElem.clientTop || body.clientTop || 0, 
				clientLeft = docElem.clientLeft || body.clientLeft || 0,
				top  = g.ie&&g.iev<8?box.top  + (self.pageYOffset || docElem && docElem.scrollTop  || body.scrollTop ) - clientTop:box.top,
				left = g.ie&&g.iev<8?box.left + (self.pageXOffset || docElem && docElem.scrollLeft || body.scrollLeft) - clientLeft:box.left;
//				top  = box.top,
//				left = box.left;
			}else{
				do{
					top += elem.offsetTop || 0;
					left += elem.offsetLeft || 0;
					elem = elem.offsetParent;
				} while (elem);
			};
			
			return {
				x:left,//IE7 ������body��ȥֵ
				y:top,//IE7 ������body��ȥֵ
				top:top - g.scrollFix().y,
				left:left - g.scrollFix().x,
				width: (w > 2 ? w - 2:0),
				height: (h > 2 ? h - 2:0)
			};	
		},
		scrollFix:function(o){//IE7 ����ר��
			var o = o?o:document.body
			var s = {x:0,y:0};
			g.iev&&g.iev<8?(s.x = o.scrollLeft,s.y = o.scrollTop):"";
			return s;
		},
		scok:function(name,value,Days)
		{
			var Days = Days?Days:3650;
			var exp  = new Date();
			exp.setTime(exp.getTime() + Days*24*60*60*1000);
			document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
		},
		gcok:function(name)
		{
			var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
			if(arr != null) return unescape(arr[2]);
			return null;
		},
		dcok:function (name) {
			var exp = new Date();
			exp.setTime(exp.getTime() - 10000);
			document.cookie = name + "=; expires=" + exp.toGMTString();
		},
		AindexOf : function(Arr,val) {
			for (var i = 0; i < Arr.length; i++) {
				if (Arr[i] == val) return i;
			}
			return -1;
		},
		Aremove : function(Arr,val) {
			var index = g.AindexOf(Arr,val);
			if (index > -1) {
				Arr.splice(index, 1);
			}
		},
		Apush : function(Arr,val) {//�������ظ�val
			var index = g.AindexOf(Arr,val);
			if (index == -1) {
				Arr.push(val);
			}
		},
		cancelBub:function(e){
			var e = g.getEv();
			if(!e)return;
			document.all ? (e.cancelBubble = true):(e.stopPropagation())
		},
		Obj2Str:function(o) {
			if (o == undefined) {
				return "";
			}
			var r = [];
			if (typeof o == "string") return "\"" + o.replace(/([\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
			if (typeof o == "object") {
				if (!o.sort) {
					for (var i in o)
						r.push("\"" + i + "\":" + g.Obj2Str(o[i]));
					if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
						r.push("toString:" + o.toString.toString());
					}
					r = "{" + r.join() + "}"
				} else {
					for (var i = 0; i < o.length; i++)
						r.push(g.Obj2Str(o[i]))
					r = "[" + r.join() + "]";
				}
				return r;
			}
			return o.toString().replace(/\"\:/g, '":""');
		},
		CloneObj: function(obj){ 
			if(obj){
				var o = obj.constructor === Array ? [] : {}; 
				for(var i in obj){ 
					if(obj.hasOwnProperty(i)){ 
						o[i] = typeof obj[i] === "object" ? g.CloneObj(obj[i]) : obj[i]; 
					} 
				} 
				return o; 
			}
		},
		utf8 : function(v){
			if(v == null||typeof(v) == "undefined"||v == ""){return ""};
			return  escape(encodeURIComponent(v.toString()));
		}

	});
		/*��ȡ��ǰʱ��*/
	g.extend({
		curt : function(){
			var date = new Date(); //���ڶ���
			var now = "";
			var Mo = (date.getMonth()+1).toString();
			Mo = Mo.length == 1 ? "0"+Mo:Mo;
			var Da = date.getDate().toString();
			Da = Da.length == 1 ? "0"+Da:Da;
			var Ho = date.getHours().toString();
			Ho = Ho.length == 1 ? "0"+Ho:Ho;
			var Mi = date.getMinutes().toString();
			Mi = Mi.length == 1 ? "0"+Mi:Mi;
			var Se = date.getSeconds().toString();
			Se = Se.length == 1 ? "0"+Se:Se;

			now = date.getFullYear()+"-"; 
			now = now + Mo+"-";
			now = now + Da+" ";
			now = now + Ho+":";
			now = now + Mi+":";
			now = now + Se;
			return now 
		}
	});
	/*������б�*/
	var w = navigator.userAgent.toLowerCase();
	var ieMode = document.documentMode;
    g.extend({
        ie: /msie/.test(w) && !/opera/.test(w),
        i7: (w.match(/msie (\d+)/) || [])[1] >= 7 && !/opera/.test(w),
        ch: /chrome/.test(w),
        op: /opera/.test(w),
        sa: /webkit/.test(w) && !/chrome/.test(w),
        mz: /mozilla/.test(w) && !/(compatible|webkit)/.test(w),
		//iev:document.documentMode == 10 ?10:((s =w.match(/msie ([\d.]+)/))?  parseInt(s[1]) : false),
		//iev : (/msie/.test(w) && !/opera/.test(w))?(!window.XMLHttpRequest?6:(ieMode?ieMode:7)):false,
		iev : (/msie/.test(w)&&!/opera/.test(w))?(ieMode?ieMode:(!window.XMLHttpRequest?6:7)):false,
		ffv:(s = w.match(/firefox\/([\d.]+)/)) ? s[1] : false,
		chv:(s = w.match(/chrome\/([\d.]+)/)) ?s[1] : false,		
		opv:(s = w.match(/opera.([\d.]+)/)) ? s[1] :false,
		sav:(s = w.match(/version\/([\d.]+).*safari/)) ?s[1] : 0
    });
    //alert(ieMode+"__"+g.iev)
    g.extend({
		/*��ȡEvent*/
		getEv:function(){   
			if(document.all)  return window.event;     
			func=g.getEv.caller;         
			while(func!=null){   
				var arg0=func.arguments[0];  
				if(arg0)  
				{  
				  if((arg0.constructor==Event || arg0.constructor ==MouseEvent) || (typeof(arg0)=="object" && arg0.preventDefault && arg0.stopPropagation))  
				  {   
				  return arg0;  
				  }  
				}  
				func=func.caller;  
			}  
			return null;  
		},
		/*���λ��*/
		mousePos : function(e){
		    var x,y;
		    var e = e||window.event||g.getEv();
		    return {
			        x:e.clientX+document.body.scrollLeft+document.documentElement.scrollLeft,
			        y:e.clientY+document.body.scrollTop+document.documentElement.scrollTop
			       }
		}
	})
	/*��ȡ��ǰʱ��*/
	g.extend({
		curt : function(){
			var date = new Date(); //���ڶ���
			var now = "";
			var Mo = (date.getMonth()+1).toString();
			Mo = Mo.length == 1 ? "0"+Mo:Mo;
			var Da = date.getDate().toString();
			Da = Da.length == 1 ? "0"+Da:Da;
			var Ho = date.getHours().toString();
			Ho = Ho.length == 1 ? "0"+Ho:Ho;
			var Mi = date.getMinutes().toString();
			Mi = Mi.length == 1 ? "0"+Mi:Mi;
			var Se = date.getSeconds().toString();
			Se = Se.length == 1 ? "0"+Se:Se;

			now = date.getFullYear()+"-"; 
			now = now + Mo+"-";
			now = now + Da+" ";
			now = now + Ho+":";
			now = now + Mi+":";
			now = now + Se;
			return now 
		}
	});
	/*�Ƿ��ַ��滻*/
	g.extend({
		rstr : function(str,MatchStr){
			return str.replace(/\\/g,"")
		},
		filterHtml:function (v){
			v = v.replace(/<\/?[^>]+>/g,''); //ȥ��HTML tag
			v = v.replace(/[ | ]*\n/g,'\n'); //ȥ����β�հ�
			v=  v.replace(/\n[\s| | ]*\r/g,'\n'); //ȥ���������
			return v;
		}
	});
	
	/*UI*/
	g.extend({
		loadingImg:function(){
			return "<img src='images/loading.gif' />"
		},
		/*������ʾ*/
		maskTip:function(t,c,ti,o,color) {
			g.pageCover(t,o,color);g.loadTip(t,c,ti,o);
				if(ti){
					setTimeout(function(){g.pageCover(0,o);},ti*1000);
				}
		},
		/*Tip��ʾ*/
		loadTip:function(t,c,ti,o,fs){
			var posT;
			var posL;
			if(o){
				posT = o.style.position == "relative"?10 : g.gpos(o).y + 10;
				posL = o.style.position == "relative"?o.offsetWidth/2: g.gpos(o).x + o.offsetWidth/2;
			}else{
				posT = g.gwh()/2;
				posL = g.gww()/2;
			};
			var indivId = o?o.id+"_loadtip":"loadtip";
			if (t == 1 || t ==2) {
				var indiv;
				if(!document.getElementById(indivId)){
					indiv = document.createElement("div");indiv.setAttribute('id',indivId);
				}else{
					indiv = document.getElementById(indivId)
				};
				var i = indiv.style;
				i.display = "block";
				i.visibility = "visible";
				i.position = "absolute";
				i.zIndex = o&&o.style&&o.style.zIndex?(o.style.zIndex+2):"9999";
				i.top = posT + "px";
				i.left = (posL>0?posL:0) + "px";
				i.width = "auto";
				i.height = "auto";
				i.padding = 5 + "px";
				i.backgroundColor = "#FFFF99";
				i.border = "1px solid #FF9900";
				i.textAlign = "center";
				i.fontSize=fs||15+"px";
				var tiphtml = "";

				tiphtml = (c=="")?g.loadingImg()+"���ݼ����У����Ժ�&hellip;&hellip;<br>����ʱ��δ�򿪣���<a href='#' style='color:#c00' onclick='location.reload(true);'>���ˢ��</a>��":c;
				if(t==2){
					if(o){
						tiphtml += "<br><span style=\"cursor:pointer;_cursor:hand\" onclick=\"javascript:try{document.getElementById('"+o.id+"_cover').style.display = 'none';document.getElementById('"+indivId+"').style.display = 'none';}catch(e){}\" title=\"�ر�\"><b style=\"color:#c00\">[�ر�]</b></span>"
					}else{
						tiphtml += "<br><span style=\"cursor:pointer;_cursor:hand\" onclick=\"javascript:try{document.getElementById('"+indivId+"').style.display = 'none';}catch(e){}\" title=\"�ر�\"><b style=\"color:#c00\">[�ر���ʾ]</b></span>"
					}
				};

				indiv.innerHTML = tiphtml
				if(!document.getElementById(indivId)){o&&o.style.position == "relative"?o.appendChild(indiv):document.body.appendChild(indiv);};

				indiv.style.left = parseInt(indiv.style.left) - indiv.offsetWidth/2 + "px";
				
				if(ti){
					setTimeout(function(){i.display = "none"},ti*1000);
				}
			};
			if (t == 0) {
				document.getElementById(indivId)?(document.getElementById(indivId).style.display = "none",document.getElementById(indivId).style.visibility = "hidden"):"";
			};
		},
		/*����*/

		pageCover:function(t,o,color){
			var coverId = o?o.id+"_cover":"cover";
			var coverW;
			var coverH;
			var coverIndex = 1;
			if(o){
				coverIndex = o.style&&o.style.zIndex?(o.style.zIndex+1):1;
				coverW = o.offsetWidth + "px";
				coverH = o.offsetHeight + "px";
			}else{
				coverW = "100%";
				coverH = g.iev&&g.iev<8?((T.gbh()>T.gwh())?T.gbh() + "px":"100%"):"100%";
			};
			var cover = document.getElementById(coverId);
			if(!cover){cover = document.createElement("div");cover.setAttribute('id',coverId);};
			if (t == 1 || t ==2) {
				var c = cover.style;
				c.display = "block";
				c.visibility = "visible";
				c.width = coverW;
				c.height = coverH;
				c.background =color?color:'#333';
				c.position ='absolute';
				cover.zIndex = coverIndex;
				c.top = "0px";
				c.left = "0px";
				c.cursor = "not-allowed";
				c.filter = o?"alpha(opacity=20)":"alpha(opacity=30)";
				c.opacity = o?"0.2":"0.3"
				//if(g.iev&&g.iev<10){
//					
//					c.filter = o?"alpha(opacity=20)":"alpha(opacity=30)"
//					alert(g.iev+"1")
//				}else{
//					
//					c.opacity = o?"0.2":"0.3"
//					alert(g.iev+"2")
//				};
				cover.innerHTML = g.iev==6?"<IFRAME style=\"BACKGROUND: #ccc; FILTER: alpha(opacity=30)\" src=\"about:blank\" frameBorder=\"0\" width=\"100%\" scrolling=\"no\" height=\"100%\"></IFRAME>":"";
				if(!document.getElementById(coverId)){o?o.appendChild(cover):document.body.appendChild(cover);};
			};
			if (t == 0){
				try{
					if(g.iev==6){
						o?o.removeChild(cover):document.body.removeChild(cover);
					}else{
						document.getElementById(coverId).style.display = "none";
						document.getElementById(coverId).style.visibility = "hidden";
					}
				}catch(e){}
			};
		},
		/*������*/
		tq_call_out:function(phone_num) {
			try {
				window.navigate("app:1234567@" + phone_num + "")
			} catch(e){}
		},
		login : function(e){ //���µ�½
//			top.login();
//			return;
			//return;
			var loginBlocObj = null;
		    Twin({
		    	Id:"sys_login_win",
		    	Title:"���ѳ�ʱ��δ����,�����µ�½",
		    	//Mask:(T("#cover")&&T("#cover").style.display=="none"),
		    	//Coverobj:loginBlocObj,
		    	zIndex:999999,
		   		sysfun:function(obj){
		   			obj.style.paddingTop = "10px";
		   			obj.style.paddingLeft = "20px";
		   			var loginHtml = "<form name='loginForm' id='loginForm' target='top' method='post' action=''>";
		   			loginHtml += "<div style='width:100%;float:left;'>���ѳ�ʱ��δ������Ϊ��֤���ݰ�ȫ��<br>��<b class='red'>���µ�¼</b>,<b>�ٽ��иղŵĲ�����</b></div>";
		   			loginHtml += "<div style='width:100px'>�û���:</div><input type='text' value='' name='uin' class = 'txt' style='width:230px;height:22px;'>";
		   			loginHtml +="<br>";
		   			loginHtml +="<div style='width:100px'>����:</div><input type='password' value='' name='passWord' class = 'txt' style='width:230px;height:22px'>"
		   			loginHtml +="</form>";
		   			obj.innerHTML = loginHtml
		   		},
		   		buttons:[
		   			{dname:"��½",iconcls:"icon16 icon16ok fl",
		   				onpress:function(){
		   					var condition = Serializ("loginForm");
		   					g.A.sendData("index.do?domainName=http://127.0.0.1&"+condition,"get","",function(ret){
		   						if(ret.indexOf("TQ8MenuCenterTml")!=-1){
		   							g.loadTip(1,"��½�ɹ�!<b class='red'>�����½��иղŵĲ�����</b>",3);
		   							TwinC("sys_login_win");
		   						}else{
		   							g.loadTip(1,"�û������������!",2)
		   						}
		   					},0,g("#sys_login_win"),"","���ڵ�¼...");
		   				}
		   			},
		   			{dname:"ȡ��",onpress:function(){TwinC("sys_login_win")}}//TwinC("sys_login_win","","",loginBlocObj)
		   		]
		    })
	    }
	}),
    g.ajax = g.A = {
        getXmlhttp: function() {
			var b = null;
			if (window.ActiveXObject) {  //for ie
				var httplist = ["MSXML2.XMLHttp.5.0","MSXML2.XMLHttp.4.0","MSXML2.XMLHttp.3.0","MSXML2.XMLHttp","Microsoft.XMLHttp"];
				for(var i = httplist.length -1;i >= 0;i--){
					try{
						b = new ActiveXObject(httplist[ i]);
						return b;
					}catch(ex){}
				}
			}else if (window.XMLHttpRequest) {  //for other
				b = new XMLHttpRequest(); 
			}
			return b;                
        },
        C : function(param){//sendData
        	var p = g.extend({
						url:"",
						method:"GET",//POST or GET
						param:"",//GETʱΪ��
						async:"",//�첽trueͬ��false Ϊ��ʱ�����Ƿ��лص�����(success)�ж�
						dataType:"2",//0text,1xml,2obj
						success:false,//����ɹ��ص�function(ret,tipObj,thirdParam) ret���
						failure:false,//����ʧ�ܻص�function(null,tipObj,thirdParam) Ĭ����ʾ�û�<����ʧ��>
						thirdParam:"",//�ص������еĵ���������
						tipObj:null,//�����ʾ��������(ֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
						waitTip:"",//Ĭ��Ϊ ���ݴ����У����Ժ�
						noCover:false, //true / false ��ʾ�Ƿ��� Ĭ��Ϊfalse����ʾ����
						rand:""//���ⱻ����������,Ĭ��Ϊ��ǰʱ��
					},param);
			g.A.sendData(p.url, p.method, p.param, p.success, p.dataType ,p.tipObj ,p.thirdParam ,p.waitTip ,p.noCover ,p.failure ,p.async ,p.rand)
        },
        /*
        	u:url
        	m:POST or GET
        	p:POST����
        	f:�ص�����(����ɹ�)
        	x:����ֵ����
        	o:�����ʾ��������(oֵΪ�ַ���"notip"ʱ��ʾ�����������ʾ)
        	t:�ص������еĵ���������
        	tip:�ȴ�ʱ��ʾ����
        	nocover: true / false ��ʾ�Ƿ��� Ĭ��Ϊfalse����ʾ����
        	failure: ����ʧ�ܺ��� ����ʧ��Ĭ�Ϸ��� null
        	asyncType:�첽trueͬ��false Ϊ��ʱ�����Ƿ��лص������ж�
        	r:���ⱻ����������,Ĭ��Ϊ��ǰʱ��
        */
        sendData : function(u, m, p, f, x, o ,t ,tip,nocover,failure,asyncType,r) {
//        	var tokens = g.gcok("token");
//        	var _token = tokens?"&token="+tokens:"";
        	if(!u){g.loadTip(1,"AJAX URL ����",3);return;};
        	var _random = r?r:new Date().getTime();
        	u = u + (u.indexOf("?")==-1? '?r=' :(u.lastIndexOf("?")== u.length - 1? "r=" : '&r=' ) ) + _random;// + _token;
        	var tip = tip?tip:g.loadingImg()+"���ݴ����У����Ժ�";
        	var t = t ? t:null;//����������
            var m = m ? m.toLocaleUpperCase() : 'GET';
            var x = x ? parseInt(x): 0;//0text,1xml,2obj,3json
            //var p = p ? p + '&rand=' + new Date().getTime() : 'rand=' + new Date().getTime();
            var a = (typeof(f) == 'function'),
            ret;
            var b = this.getXmlhttp();
            
            var async = (asyncType!=null&&asyncType!="undefined"&&asyncType!="")?asyncType:a; //û�лص�����ʱ,Ĭ��Ϊͬ��
			try{
	            b.open(m, u, async);
			}catch(e){
				g.loadTip(1,"AJAXϵͳ"+e,3);//�����Ч��AJAX�������!ͨ��ԭ��:<br />(<b style='color:#c00'>urlΪ�ջ��߿���</b>)
				return
			}
            if(async){
				o!="notip"?(nocover?g.loadTip(1,tip,"",o):g.maskTip(1,tip,"",o)):"";
                b.onreadystatechange = function(){
                    if (b.readyState == 4){
						if(b.status == 200){
							if(typeof(b.responseText)=="string"&&b.responseText.indexOf("<!DOCTYPE")!=-1&&b.responseText.indexOf("��¼�������Ĺ���ϵͳ")!=-1){
								g.login();
								ret = "gotologin";
							}else{
								switch(x){
									case 0:	
									ret = g.rstr(b.responseText);break; 
									case 1:	
									ret = b.responseXML;break; 
									case 2:	
									ret = function(str){
											try{
												return (new Function('return' + str))(); 
											}catch(e){return "err"}
										  }(g.rstr(b.responseText));break; 
									default:	
									ret = function(str){
											try{
												return (new Function('return' + str))(); 
											}catch(e){return "err"}
										  }(g.rstr(b.responseText)); 
								};
							}
							o!="notip"?(nocover?g.loadTip(0,"","",o):g.maskTip(0,"","",o)):"";
							f?(o&&o!="notip"?f(ret,o,t):f(ret,t)):"";
							b = null;
							delete(b);
							return
						}else if(b.status == 404){
							o!="notip"?(nocover?g.loadTip(0,"","",o):g.maskTip(0,"","",o)):"";
							g.loadTip(1,"���������ԭ����<br>����ʧ��,������(404)",3,o);
							b = null;
							delete(b);
							return
						}else if(b.status != 200){
							o!="notip"?(nocover?g.loadTip(0,"","",o):g.maskTip(0,"","",o)):"";
							f?(o&&o!="notip"?f(false,o,t):f(false,t)):"";
							failure?(o&&o!="notip"?failure(null,o,t):failure(null,t)):(o!="notip"?g.loadTip(2,"���������ԭ����<br>����ʧ��,������",3,o):"");
							b = null;
							delete(b);
							return
						}
                    }else{
						return false
					}
                }
            };
            if(m == 'GET')
			{
				b.send(null)
			}else{
                b.setRequestHeader('content-type', 'application/x-www-form-urlencoded');
                if(p){
					b.send(p)
				}else{
					return false
				}
            };
            if (!async) {
				if(b.readyState == 4) {
					if(b.status == 200){
						if(typeof(b.responseText)=="string"&&b.responseText.indexOf("<!DOCTYPE")!=-1&&b.responseText.indexOf("��¼�������Ĺ���ϵͳ")!=-1){
							g.login();
							ret = "gotologin";
						}else{
							switch(x){
								case 0:	
								ret = g.rstr(b.responseText);break; 
								case 1:	
								ret = b.responseXML;break; 
								case 2:	
								ret = function(str){
										try{
											return (new Function('return' + str))(); 
										}catch(e){return "err"}
									  }(g.rstr(b.responseText));break; 
							};
						}
						f?(o&&o!="notip"?f(ret,o,t):f(ret,t)):"";
						b = null;
						delete(b);
						return ret
					}else if(b.status != 200){
						f?(o&&o!="notip"?f(false,o,t):f(false,t)):"";
						failure?(o&&o!="notip"?failure(null,o,t):failure(null,t)):(o!="notip"?g.loadTip(2,"���������ԭ����<br>����ʧ��,������",3,o):"");
						b = null;
						delete(b);
						return false
//						failure?(o&&o!="notip"?failure(null,o,t):failure(null,t)):(o!="notip"?g.loadTip(2,"���������ԭ����<br>����ʧ��,������",3,o):"");
//						return false
					}
				}else{
					return false
				}
            };
//            if (!async) {
//				if(b.readyState == 4&&b.status == 200) {
//						if(typeof(b.responseText)=="string"&&b.responseText.indexOf("<!DOCTYPE")!=-1&&b.responseText.indexOf("��¼�������Ĺ���ϵͳ")!=-1){
//							g.login();
//							ret = false
//						}else{
//							switch(x){
//								case 0:	
//								ret = g.rstr(b.responseText);break; 
//								case 1:	
//								ret = b.responseXML;break; 
//								case 2:	
//								ret = function(str){
//										try{
//											return (new Function('return' + str))(); 
//										}catch(e){return "err"}
//									  }(g.rstr(b.responseText));break; 
//							};
//						}
//						b = null;
//						delete(b);
//						return ret
//
//				}else{
//					return false
//				}
//            };
        }
    }
})();
if(T.iev&&T.iev == 6){
	T.bind(window,"load",function(){
		var updateTip = "<div style=\"width:400px;float:left;text-align:left;\">����IE������汾���ɣ����ֹ��ܽ��޷�ʹ�ã��������������" +
						"<br/>�Ƽ�����װ<b class=\"red\">8.0</b>�汾��IE������������ԣ�" +
						"<br/>1�������������������ͨ�����е�ַ�����ʺ������Եİ汾����װ��" +
						"<br />���ص�ַ(1)��<a style=\"color:#c00\" href=\"http://download.microsoft.com/download/1/6/1/16174D37-73C1-4F76-A305-902E9D32BAC9/IE8-WindowsXP-x86-CHS.exe\" target=\"_blank\">΢��ٷ�����</a>" +
						"<br />���ص�ַ(2)��<a style=\"color:#c00\" href=\"http://download.pchome.net/internet/browser/browser/down-86392-1.html\" target=\"_blank\">����֮����������</a>" + 
						"<br />���ص�ַ(3)��<a style=\"color:#c00\" href=\"http://dl.pconline.com.cn/html_2/1/104/id=49581&pn=0&linkPage=1.html\" target=\"_blank\">̫ƽ����������</a>" + 
						"<br />���ص�ַ(4)��<a style=\"color:#c00\" href=\"http://www.microsoft.com/zh-cn/download/internet-explorer-8-details.aspx\" target=\"_blank\">΢��ٷ�����2</a>" + 
						"<br />2����ϵ������Ա���������" +
						"</div>"
		T.loadTip(2,updateTip,600);
	})
};
function purge(d) {
    var a = d.attributes, i, l, n;
    if (a) {
        for (i = a.length - 1; i >= 0; i -= 1) {
            n = a[i].name;
            if (typeof d[n] === 'function') {
                d[n] = null;
            }
        }
    }
    a = d.childNodes;
    if (a) {
        l = a.length;
        for (i = 0; i < l; i += 1) {
            purge(d.childNodes[i]);
        }
    }
};


/**
 * TQ����ѡ��ؼ�
 */
/*
  Tselect(sobj, slctd, sdata, saveId, noselectName)
  sobj:��ѡ�������Ķ���
  slctd:��ʼ��ѡ�е���ֵ
  sdata:��ѡԭʼ����(joson)
  saveId:ѡ��ֵ���ݲ�����(����ͬ����input)
  noselectName:ѡ����ʾ�Ĭ��Ϊ"��ѡ��"
      ����������
  var data = [//id:valueֵ,value_name:��ʾ��,pid:�ϼ�id(valueֵ)//id>0,pid>=0
	{"id":1,"value_name":"�������һ","pid":0},
	{"id":2,"value_name":"��������","pid":0},
	{"id":3,"value_name":"���������","pid":0},
	{"id":4,"value_name":"���������","pid":0},
	{"id":5,"value_name":"���������","pid":0},
	{"id":6,"value_name":"1��","pid":1},
	{"id":7,"value_name":"2��","pid":2},
	{"id":8,"value_name":"3��","pid":7},
	{"id":9,"value_name":"4��","pid":8},
	{"id":10,"value_name":"5��","pid":1}
  ]
*/

//example: Tselect(document.getElementById("selectdiv"),3,data,"saveObjName","")
var w = navigator.userAgent.toLowerCase();
var ieMode = document.documentMode;
var iev = (/msie/.test(w) && !/opera/.test(w))?(!window.XMLHttpRequest?6:(ieMode?ieMode:7)):false;
var Tselect = function(sobj, slctd, sdata, saveId, noselectName,noselectValue){
	var noselectName = noselectName?noselectName:"��ѡ��";
	var noselectValue = noselectValue?noselectValue:"";
	var Select = function(arr, chg, noselectName) {
		var getSel = function(_pid,vinput) {
			var _select = document.createElement("select");
			_select.className = "tselect";
			_select.options.add(new Option(noselectName, -1));
			for (var i = 0; i < arr.length; i++) {
				if (arr[i].pid == _pid) {
					_select.options.add(new Option(arr[i].name, arr[i].id));
				}
			};
			var delChildfun = function(obj) {
				if (obj.child) {
					var _child = obj.child;
					if (_child.parentNode) {
						_child.parentNode.removeChild(_child);
					};
					delChildfun(_child);
				}
			};
			
			_select.pid = _pid;
			_select.onchange = function() {
				delChildfun(this);
				this.child = getSel(this.options[this.selectedIndex].value,vinput);
				if(this.value!="-1"){
					vinput.value = this.options[this.selectedIndex].value
				}else{
					vinput.value = this.pid!=0?this.pid:noselectValue
				};
				chg(this.child);
			};
			return _select;
		}
		var r_arr = [];
		var getPidById = function(id) {
			for (var i = 0; i < arr.length; i++){
				if (arr[i].id == id) return arr[i].pid
			};
			return -1;
		};
		var getSelBySid = function(sid,vinput,selectid) {
			var _pid = getPidById(sid);
			var sel = getSel(_pid,vinput);
			for (var i = 0; i < sel.options.length; i++) {
				if (sel.options[i].value == sid) {
					sel.selectedIndex = selectid!="undefined"&&selectid!=null&&selectid!=""?i:0;
					break;
				}
			};
			if (_pid > 0) getSelBySid(_pid,vinput,selectid);
			r_arr.push(sel);
		};
		var IsHasChild = function(selectid) {
			for (var i = 0; i < arr.length; i++) {
				if (arr[i].pid == selectid) {
					return true;
					break;
				};
			};
			return false;
		};
		var IsExist = function(selectid) {
			for (var i = 0; i < arr.length; i++) {
				if (arr[i].id == selectid) {
					return true;
					break;
				};
			};
			return false;
		};
		var GetRootId = function(){
			for (var i = 0; i < arr.length; i++) {
				if (arr[i].pid == 0) {
					return arr[i].id;
					break;
				};
			};
		};
		this.getDom = function(selectid,vinput) {
			if(selectid!="undefined"&&selectid!=null&&selectid!=""){
				selectid = IsExist(selectid)?selectid:null;//Ҫ��Ҫ��ʾһ��?
			};
			getSelBySid(selectid || GetRootId(),vinput,selectid);
			selectid&&IsHasChild(selectid)?r_arr.push(getSel(selectid,vinput)):"";
			for (var i = 0; i < r_arr.length; i++)
			 if (i + 1 < r_arr.length)
			 r_arr[i].child = r_arr[i + 1];
			return r_arr;
		}
	};
	
	//��ʼ��
	var input = iev!=false&&iev<9?document.createElement("<input name=\""+saveId+"\">"):document.createElement("input");
	input.name = saveId;
	input.id = saveId;
	input.type = "hidden";
	input.value = slctd || noselectValue;
	sobj.appendChild(input);
	var chg = function(obj) {
		if (obj.options.length > 1) {
			obj.selectedIndex = 0;
			sobj.appendChild(obj);
		}
	};
	var _sel = new Select(sdata, chg, noselectName);
	var _arr = _sel.getDom(slctd,input);
	for (var i = 0; i < _arr.length; i++) {
		sobj.appendChild(_arr[i]);
	};
}

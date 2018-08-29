var OFFSET = 5;
var page = 1;
var PAGESIZE = 99999;

var myScroll,
	pullDownEl, pullDownOffset,
	pullUpEl, pullUpOffset,
	generatedCount = 0;
var maxScrollY = 0;

var hasMoreData = false;
var today = new Date();
today.setHours(0);
today.setMinutes(0);
today.setSeconds(0);
today.setMilliseconds(0);
today = today/1000 + 24*60*60;//�����ʼʱ��

var ticketidtemp = -2;//Ĭ�ϲ�ʹ��ȯ
var limittemp = 0;//Ĭ�ϵֿ�0
$(document).ready(function() {
	
});

function loaded(mobile,ticketid,total,uid) {
	pullDownEl = document.getElementById('pullDown');
	pullDownOffset = pullDownEl.offsetHeight;
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;

	hasMoreData = false;
	$("#pullUp").hide();

	pullDownEl.className = 'loading';
	pullDownEl.querySelector('.pullDownLabel').innerHTML = '������...';

	page = 1;
	if(mobile.length != 11){
		return false;
	}
	
	$.post("carinter.do", {
			"page": page,
			"pagesize": PAGESIZE,
			"mobile" : mobile,
			"total"	: total,
			"preid"	: ticketid,
			"uid"	: uid,
			"utype"	: 2,
			"action" : "usetickets"
		},
		function(response, status) {
			if (status == "success") {
				if($("#thelist")[0].children.length > 0){
					return false;
				}
				$("#thelist").show();
				
				$("#pullUp").hide();
				$("#pullDown").hide();
				// document.getElementById('wrapper').style.left = '0';

				myScroll = new iScroll('wrapper', {
					useTransition: true,
					topOffset: pullDownOffset,
					onRefresh: function() {
						
					},
					onScrollMove: function() {
						
					},
					onScrollEnd: function() {
						
					}
				});
				
				$.each(response, function(key, value) {
					var money = value.money;//ͣ��ȯ���
					var limitday = value.limitday;//ͣ��ȯ����ʱ��
					var ttype = value.type;//ͣ��ȯ����
					var company_belong = value.cname;
					var iscanuse = value.iscanuse;
					var id = value.id;
					var resources = value.isbuy;
					var limit = value.limit;
					var desc = value.desc;
					
					var time = getSmpFormatDateByLong(parseInt(limitday)*1000,false);
					var fuhao = "Ԫ";
					var money_class = "money";
					var ticketname_class = "ticketname";
					var ticketinfo_class = "ticketinfo";
					var ticketlimit_class = "normal";
					var line_class = "line";
					var ticketinfo = desc;
					var ticketlimit = "����ͣ������������";
					var exptime = "��Ч���� "+time;
					var ticketname = "��ͨȯ";
					var useinfo_class = "userinfo";
					var choosefun = 'choose('+id+','+limit+');';
					var buy = '';
					var buy_class = "buy";
					
					var guoqi = Math.round((limitday - today + 1)/(24*60*60));
					
					guoqi = "����" + guoqi +"�����";
					if(ttype == "2"){
						fuhao = "��";
						ticketinfo = "���������";
					}else if(ttype == "1"){
						ticketlimit_class = "zhuan";
						ticketname = "ר��ȯ";
						ticketlimit = "��"+company_belong+"ר��";
					}
					
					if(iscanuse == 0){
						money_class = "moneyused";
						ticketname_class = "ticketnameused";
						ticketinfo_class = "ticketinfoused";
						ticketlimit_class = "normalused";
						line_class = "lineuesd";
						useinfo_class = "useinfoused";
						choosefun = '';
						buy_class = "buyused";
					}
					if(resources == "1"){
						ticketinfo = desc.split(",")[0];
						ticketlimit = desc.split(",")[1];
						buy = '<div class="'+buy_class+'">����</div>';
					}
					$("#thelist").append('<li onclick="'+choosefun+'" class="li1 left1 choose_'+id+'"><div class="moneyouter"><span class="'+money_class+'">'+money+'<span class="fuhao">'+fuhao+'</span></span></div><a class="a1" href="#"><div class="'+ticketname_class+'">'+ticketname+'</div><div class="'+ticketinfo_class+'">'+ticketinfo+'</div><div class="ticketlimit"><span class="sel_fee '+ticketlimit_class+'">'+ticketlimit+'</span></div></a>'+buy+'</li>');
					$("#thelist").append('<li class="li2 after1 left1 choose1_'+id+'"><div class="'+line_class+'"></div><a class="a2" href="#"><div class="'+useinfo_class+'">'+guoqi+'</div><div class="limittime">'+exptime+'</div></a></li>');
					
					if(id == ticketid){//Ĭ��ѡ��
						ticketidtemp = ticketid;
						choose(ticketid,limit);
					}
				});
				myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)
			};
		},
		"json");
}

var t1 = null;
function choose(ticketid,limit){
	if(t1 == null){
		t1 = new Date().getTime();
	}else{       
        var t2 = new Date().getTime();
        if(t2 - t1 < 500){
            t1 = t2;
            return;
        }else{
            t1 = t2;
        }
    }
	if($(".choose_"+ticketid).hasClass("choosed")){
		$(".choose_"+ticketid).removeClass("choosed");
		$(".choose_"+ticketid).removeClass("left2");
		$(".choose_"+ticketid).addClass("left1");
		$(".choose1_"+ticketid).removeClass("left2");
		$(".choose1_"+ticketid).addClass("left1");
		$(".choose1_"+ticketid).removeClass("after2");
		$(".choose1_"+ticketid).addClass("after1");
		
		ticketidtemp = -2;
		limittemp = 0;
	}else{
		var thelist = $("#thelist")[0];
		for(var i=0;i<thelist.children.length;i++){
			var li = thelist.children[i];
			if(hasClass(li,"choosed")){
				removeClass(li,"choosed");
			}
			if(hasClass(li,"left2")){
				removeClass(li,"left2");
				addClass(li,"left1");
			}
			if(hasClass(li,"after2")){
				removeClass(li,"after2");
				addClass(li,"after1");
			}
		}
		$(".choose_"+ticketid).addClass("choosed");
		$(".choose_"+ticketid).removeClass("left1");
		$(".choose_"+ticketid).addClass("left2");
		$(".choose1_"+ticketid).removeClass("left1");
		$(".choose1_"+ticketid).addClass("left2");
		$(".choose1_"+ticketid).removeClass("after1");
		$(".choose1_"+ticketid).addClass("after2");
		
		ticketidtemp = ticketid;
		limittemp = limit;
	}
}

function chooseok(openid,uid,total){
	window.location.href = "wxpfast.do?action=toepaypage&openid="+openid+"&uid="+uid+"&fee="+total+"&ticketid="+ticketidtemp+"&limit="+limittemp+"&r="+Math.random();
}

//ÿ���Ƴ�һ��class
function removeClass(currNode, curClass){
	var oldClass,newClass1 = "";
    oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
    if(oldClass !== null) {
	   oldClass = oldClass.split(" ");
	   for(var i=0;i<oldClass.length;i++){
		   if(oldClass[i] != curClass){
			   if(newClass1 == ""){
				   newClass1 += oldClass[i]
			   }else{
				   newClass1 += " " + oldClass[i];
			   }
		   }
	   }
	}
	currNode.className = newClass1; //IE ��FF��֧��
}

//ÿ�����һ��class
function addClass(currNode, newClass){
    var oldClass;
    oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
    if(oldClass !== null) {
	   newClass = oldClass+" "+newClass; 
	}
	currNode.className = newClass; //IE ��FF��֧��
}
//����Ƿ������ǰclass
function hasClass(currNode, curClass){
	var oldClass;
	oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
	if(oldClass !== null){
		oldClass = oldClass.split(" ");
		for(var i=0;i<oldClass.length;i++){
		   if(oldClass[i] == curClass){
			   return true;
		   }
	   }
	}
	return false;
}

//��չDate��format����   
Date.prototype.format = function (format) {  
  var o = {  
      "M+": this.getMonth() + 1,  
      "d+": this.getDate(),  
      "h+": this.getHours(),  
      "m+": this.getMinutes(),  
      "s+": this.getSeconds(),  
      "q+": Math.floor((this.getMonth() + 3) / 3),  
      "S": this.getMilliseconds()  
  }  
  if (/(y+)/.test(format)) {  
      format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
  }  
  for (var k in o) {  
      if (new RegExp("(" + k + ")").test(format)) {  
          format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
      }  
  }  
  return format;  
}

/**   
*ת��longֵΪ�����ַ���   
* @param l longֵ   
* @param isFull �Ƿ�Ϊ��������������,   
*               Ϊtrueʱ, ��ʽ��"2000-03-05 01:05:04"   
*               Ϊfalseʱ, ��ʽ�� "2000-03-05"   
* @return ����Ҫ��������ַ���   
*/    

function getSmpFormatDateByLong(l, isFull) {  
   return getSmpFormatDate(new Date(l), isFull);  
}  

/**   
*ת�����ڶ���Ϊ�����ַ���   
* @param date ���ڶ���   
* @param isFull �Ƿ�Ϊ��������������,   
*               Ϊtrueʱ, ��ʽ��"2000-03-05 01:05:04"   
*               Ϊfalseʱ, ��ʽ�� "2000-03-05"   
* @return ����Ҫ��������ַ���   
*/    
function getSmpFormatDate(date, isFull) {  
    var pattern = "";  
    if (isFull == true || isFull == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    } else {  
        pattern = "yyyy-MM-dd";  
    }  
    return getFormatDate(date, pattern);  
} 

/**   
 *ת�����ڶ���Ϊ�����ַ���   
 * @param l longֵ   
 * @param pattern ��ʽ�ַ���,���磺yyyy-MM-dd hh:mm:ss   
 * @return ����Ҫ��������ַ���   
 */    
 function getFormatDate(date, pattern) {  
     if (date == undefined) {  
         date = new Date();  
     }  
     if (pattern == undefined) {  
         pattern = "yyyy-MM-dd hh:mm:ss";  
     }  
     return date.format(pattern);  
 }

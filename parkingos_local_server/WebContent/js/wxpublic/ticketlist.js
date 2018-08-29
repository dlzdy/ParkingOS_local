var OFFSET = 5;
var page = 1;
var PAGESIZE = 20;

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

document.addEventListener('touchmove', function(e) {
	e.preventDefault();
}, false);

document.addEventListener('DOMContentLoaded', function() {
	$(document).ready(function() {
		var mobile=$("#mobile")[0].value;
		var ticket_state=$("#ticket_state")[0].value;
		loaded(mobile,ticket_state);
	});
}, false);

function loaded(mobile,ticket_state) {
	pullDownEl = document.getElementById('pullDown');
	pullDownOffset = pullDownEl.offsetHeight;
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;

	hasMoreData = false;
	// $("#thelist").hide();
	$("#pullUp").hide();

	pullDownEl.className = 'loading';
	pullDownEl.querySelector('.pullDownLabel').innerHTML = '������...';

	page = 1;
	$.post("carinter.do", {
			"page": page,
			"pagesize": PAGESIZE,
			"mobile" : mobile,
			"from"	: "wxpublic",
			"type"	: ticket_state,
			"action" : "gettickets"
		},
		function(response, status) {
			if (status == "success") {
				$("#thelist").show();

				if (response.length < PAGESIZE) {
					hasMoreData = false;
					$("#pullUp").hide();
				} else {
					hasMoreData = true;
					$("#pullUp").show();
				}

				// document.getElementById('wrapper').style.left = '0';

				myScroll = new iScroll('wrapper', {
					useTransition: true,
					topOffset: pullDownOffset,
					onRefresh: function() {
						if (pullDownEl.className.match('loading')) {
							pullDownEl.className = 'idle';
							pullDownEl.querySelector('.pullDownLabel').innerHTML = '����ˢ��...';
							this.minScrollY = -pullDownOffset;
						}
						if (pullUpEl.className.match('loading')) {
							pullUpEl.className = 'idle';
							pullUpEl.querySelector('.pullUpLabel').innerHTML = '�������ظ���...';
						}
					},
					onScrollMove: function() {
						if (this.y > OFFSET && !pullDownEl.className.match('flip')) {
							pullDownEl.className = 'flip';
							pullDownEl.querySelector('.pullDownLabel').innerHTML = '���ֿ�ʼˢ��...';
							this.minScrollY = 0;
						} else if (this.y < OFFSET && pullDownEl.className.match('flip')) {
							pullDownEl.className = 'idle';
							pullDownEl.querySelector('.pullDownLabel').innerHTML = '����ˢ��...';
							this.minScrollY = -pullDownOffset;
						} 
						if (this.y < (maxScrollY - pullUpOffset - OFFSET) && !pullUpEl.className.match('flip')) {
							if (hasMoreData) {
								this.maxScrollY = this.maxScrollY - pullUpOffset;
								pullUpEl.className = 'flip';
								pullUpEl.querySelector('.pullUpLabel').innerHTML = '���ֿ�ʼˢ��...';
							}
						} else if (this.y > (maxScrollY - pullUpOffset - OFFSET) && pullUpEl.className.match('flip')) {
							if (hasMoreData) {
								this.maxScrollY = maxScrollY;
								pullUpEl.className = 'idle';
								pullUpEl.querySelector('.pullUpLabel').innerHTML = '�������ظ���...';
							}
						}
					},
					onScrollEnd: function() {
						if (pullDownEl.className.match('flip')) {
							pullDownEl.className = 'loading';
							pullDownEl.querySelector('.pullDownLabel').innerHTML = '������...';
							// pullDownAction(); // Execute custom function (ajax call?)
							refresh();
						}
						if (hasMoreData && pullUpEl.className.match('flip')) {
							pullUpEl.className = 'loading';
							pullUpEl.querySelector('.pullUpLabel').innerHTML = '������...';
							// pullUpAction(); // Execute custom function (ajax call?)
							nextPage();
						}
					}
				});

				$("#thelist").empty();
				$.each(response, function(key, value) {
					var state = value.state;//0δʹ�ã�1��ʹ��
					var exp = value.exp;//0�ѹ��ڣ�1δ����
					var money = value.money;//ͣ��ȯ���
					var limitday = value.limitday;//ͣ��ȯ����ʱ��
					var ttype = value.type;//ͣ��ȯ����
					var company_belong = value.cname;
					var resources = value.isbuy;
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
					
					if(ticket_state == "0"){
						if(state == "0" && exp == "1"){
							var buy = '';
							if(resources == "1"){
								buy = '<div class="buy">����</div>';
								ticketinfo = desc.split(",")[0];
								ticketlimit = desc.split(",")[1];
							}
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
							$("#thelist").append('<li class="li1"><div class="moneyouter"><span class="'+money_class+'">'+money+'<span class="fuhao">'+fuhao+'</span></span></div><a class="a1" href="#"><div class="'+ticketname_class+'">'+ticketname+'</div><div class="'+ticketinfo_class+'">'+ticketinfo+'</div><div class="ticketlimit"><span class="sel_fee '+ticketlimit_class+'">'+ticketlimit+'</span></div></a>'+buy+'</li>');
							$("#thelist").append('<li class="li2"><div class="'+line_class+'"></div><a class="a2" href="#"><div class="useinfo">'+guoqi+'</div><div class="limittime">'+exptime+'</div></a></li>');
						}
					}else if(ticket_state ==1){
							if(state == "1" || exp == "0"){
								var money_class = "moneyused";
								var ticketname_class = "ticketnameused";
								var ticketinfo_class = "ticketinfoused";
								var ticketlimit_class = "normalused";
								var line_class = "lineuesd";
								var useinfo_class = "useinfoused";
								var exp = "��ʹ��";
								if(ttype == "2"){
									fuhao = "��";
									ticketinfo = "���������";
								}else if(ttype == "1"){
									ticketlimit_class = "zhuanused";
									ticketname = "ר��ȯ";
									ticketlimit = "��"+company_belong+"ר��";
								}
								if(state != "1"){
									exp = "�ѹ���";
									useinfo_class = "useinfoexp";
								}
								var buy = '';
								if(resources == "1"){
									ticketinfo = desc.split(",")[0];
									buy = '<div class="buyused">����</div>';
								}
								$("#thelist").append('<li class="li1"><div class="moneyouter"><span class="'+money_class+'">'+money+'<span class="fuhao">'+fuhao+'</span></span></div><a class="a1" href="#"><div class="'+ticketname_class+'">'+ticketname+'</div><div class="'+ticketinfo_class+'">'+ticketinfo+'</div><div class="ticketlimit"><span class="sel_fee '+ticketlimit_class+'">'+ticketlimit+'</span></div></a>'+buy+'</li>');
								$("#thelist").append('<li class="li2"><div class="'+line_class+'"></div><a class="a2" href="#"><div class="'+useinfo_class+'">'+exp+'</div><div class="limittime">'+exptime+'</div></a></li>');
							}
						}
					
				});
				// $("#thelist").listview("refresh");
				myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)
				// pullDownEl.className = 'idle';
				// pullDownEl.querySelector('.pullDownLabel').innerHTML = 'Pull down to refresh...';
				// this.minScrollY = -pullDownOffset;
				if(ticket_state == 0 && response.length == 0){
					$(".middle").removeClass("hide");
				}
				if (hasMoreData) {
					myScroll.maxScrollY = myScroll.maxScrollY + pullUpOffset;
				} else {
					myScroll.maxScrollY = myScroll.maxScrollY;
				}
				maxScrollY = myScroll.maxScrollY;
			};
		},
		"json");
}

function refresh() {
	var mobile=$("#mobile")[0].value;
	var ticket_state=$("#ticket_state")[0].value;
	page = 1;
	$.post("carinter.do", {
		"page": page,
		"pagesize": PAGESIZE,
		"mobile" : mobile,
		"from"	: "wxpublic",
		"type"	: ticket_state,
		"action" : "gettickets"
	},function(response, status) {
			if (status == "success") {
				$("#thelist").empty();

				myScroll.refresh();

				if (response.length < PAGESIZE) {
					hasMoreData = false;
					$("#pullUp").hide();
				} else {
					hasMoreData = true;
					$("#pullUp").show();
				}

				$.each(response, function(key, value) {
					var state = value.state;//0δʹ�ã�1��ʹ��
					var exp = value.exp;//0�ѹ��ڣ�1δ����
					var money = value.money;//ͣ��ȯ���
					var limitday = value.limitday;//ͣ��ȯ����ʱ��
					var ttype = value.type;//ͣ��ȯ����
					var company_belong = value.cname;
					var resources = value.isbuy;
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
					
					if(ticket_state == "0"){
						if(state == "0" && exp == "1"){
							var buy = '';
							if(resources == "1"){
								buy = '<div class="buy">����</div>';
								ticketinfo = desc.split(",")[0];
								ticketlimit = desc.split(",")[1];
							}
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
							$("#thelist").append('<li class="li1"><div class="moneyouter"><span class="'+money_class+'">'+money+'<span class="fuhao">'+fuhao+'</span></span></div><a class="a1" href="#"><div class="'+ticketname_class+'">'+ticketname+'</div><div class="'+ticketinfo_class+'">'+ticketinfo+'</div><div class="ticketlimit"><span class="sel_fee '+ticketlimit_class+'">'+ticketlimit+'</span></div></a>'+buy+'</li>');
							$("#thelist").append('<li class="li2"><div class="'+line_class+'"></div><a class="a2" href="#"><div class="useinfo">'+guoqi+'</div><div class="limittime">'+exptime+'</div></a></li>');
						}
					}else if(ticket_state ==1){
							if(state == "1" || exp == "0"){
								var money_class = "moneyused";
								var ticketname_class = "ticketnameused";
								var ticketinfo_class = "ticketinfoused";
								var ticketlimit_class = "normalused";
								var line_class = "lineuesd";
								var useinfo_class = "useinfoused";
								var exp = "��ʹ��";
								if(ttype == "2"){
									fuhao = "��";
									ticketinfo = "���������";
								}else if(ttype == "1"){
									ticketlimit_class = "zhuanused";
									ticketname = "ר��ȯ";
									ticketlimit = "��"+company_belong+"ר��";
								}
								if(state != "1"){
									exp = "�ѹ���";
									useinfo_class = "useinfoexp";
								}
								var buy = '';
								if(resources == "1"){
									ticketinfo = desc.split(",")[0];
									buy = '<div class="buyused">����</div>';
								}
								$("#thelist").append('<li class="li1"><div class="moneyouter"><span class="'+money_class+'">'+money+'<span class="fuhao">'+fuhao+'</span></span></div><a class="a1" href="#"><div class="'+ticketname_class+'">'+ticketname+'</div><div class="'+ticketinfo_class+'">'+ticketinfo+'</div><div class="ticketlimit"><span class="sel_fee '+ticketlimit_class+'">'+ticketlimit+'</span></div></a>'+buy+'</li>');
								$("#thelist").append('<li class="li2"><div class="'+line_class+'"></div><a class="a2" href="#"><div class="'+useinfo_class+'">'+exp+'</div><div class="limittime">'+exptime+'</div></a></li>');
							}
						}
					
				});
				if(response.length == 0 && ticket_state == "0"){
					$(".middle").removeClass("hide");
				}
				// $("#thelist").listview("refresh");
				myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)

				if (hasMoreData) {
					myScroll.maxScrollY = myScroll.maxScrollY + pullUpOffset;
				} else {
					myScroll.maxScrollY = myScroll.maxScrollY;
				}
				maxScrollY = myScroll.maxScrollY;
			};
		},
		"json");
}

function nextPage() {
	var mobile=$("#mobile")[0].value;
	var ticket_state=$("#ticket_state")[0].value;
	page++;
	$.post("carinter.do", {
		"page": page,
		"pagesize": PAGESIZE,
		"mobile" : mobile,
		"from"	: "wxpublic",
		"type"	: ticket_state,
		"action" : "gettickets"
	},function(response, status) {
			if (status == "success") {
				if (response.length < PAGESIZE) {
					hasMoreData = false;
					$("#pullUp").hide();
				} else {
					hasMoreData = true;
					$("#pullUp").show();
				}

				$.each(response, function(key, value) {
					var state = value.state;//0δʹ�ã�1��ʹ��
					var exp = value.exp;//0�ѹ��ڣ�1δ����
					var money = value.money;//ͣ��ȯ���
					var limitday = value.limitday;//ͣ��ȯ����ʱ��
					var ttype = value.type;//ͣ��ȯ����
					var company_belong = value.cname;
					var resources = value.isbuy;
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
					
					if(ticket_state == "0"){
						if(state == "0" && exp == "1"){
							var buy = '';
							if(resources == "1"){
								buy = '<div class="buy">����</div>';
								ticketinfo = desc.split(",")[0];
								ticketlimit = desc.split(",")[1];
							}
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
							$("#thelist").append('<li class="li1"><div class="moneyouter"><span class="'+money_class+'">'+money+'<span class="fuhao">'+fuhao+'</span></span></div><a class="a1" href="#"><div class="'+ticketname_class+'">'+ticketname+'</div><div class="'+ticketinfo_class+'">'+ticketinfo+'</div><div class="ticketlimit"><span class="sel_fee '+ticketlimit_class+'">'+ticketlimit+'</span></div></a>'+buy+'</li>');
							$("#thelist").append('<li class="li2"><div class="'+line_class+'"></div><a class="a2" href="#"><div class="useinfo">'+guoqi+'</div><div class="limittime">'+exptime+'</div></a></li>');
						}
					}else if(ticket_state ==1){
							if(state == "1" || exp == "0"){
								var money_class = "moneyused";
								var ticketname_class = "ticketnameused";
								var ticketinfo_class = "ticketinfoused";
								var ticketlimit_class = "normalused";
								var line_class = "lineuesd";
								var useinfo_class = "useinfoused";
								var exp = "��ʹ��";
								if(ttype == "2"){
									fuhao = "��";
									ticketinfo = "���������";
								}else if(ttype == "1"){
									ticketlimit_class = "zhuanused";
									ticketname = "ר��ȯ";
									ticketlimit = "��"+company_belong+"ר��";
								}
								if(state != "1"){
									exp = "�ѹ���";
									useinfo_class = "useinfoexp";
								}
								var buy = '';
								if(resources == "1"){
									ticketinfo = desc.split(",")[0];
									buy = '<div class="buyused">����</div>';
								}
								$("#thelist").append('<li class="li1"><div class="moneyouter"><span class="'+money_class+'">'+money+'<span class="fuhao">'+fuhao+'</span></span></div><a class="a1" href="#"><div class="'+ticketname_class+'">'+ticketname+'</div><div class="'+ticketinfo_class+'">'+ticketinfo+'</div><div class="ticketlimit"><span class="sel_fee '+ticketlimit_class+'">'+ticketlimit+'</span></div></a>'+buy+'</li>');
								$("#thelist").append('<li class="li2"><div class="'+line_class+'"></div><a class="a2" href="#"><div class="'+useinfo_class+'">'+exp+'</div><div class="limittime">'+exptime+'</div></a></li>');
							}
						}
					
				});
				// $("#thelist").listview("refresh");
				myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)
				if (hasMoreData) {
					myScroll.maxScrollY = myScroll.maxScrollY + pullUpOffset;
				} else {
					myScroll.maxScrollY = myScroll.maxScrollY;
				}
				maxScrollY = myScroll.maxScrollY;
			};
		},
		"json");
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

var OFFSET = 5;
var page = 1;
var PAGESIZE = 15;

var myScroll,
	pullDownEl, pullDownOffset,
	pullUpEl, pullUpOffset,
	generatedCount = 0;
var maxScrollY = 0;

var hasMoreData = false;

document.addEventListener('touchmove', function(e) {
	e.preventDefault();
}, false);

document.addEventListener('DOMContentLoaded', function() {
	$(document).ready(function() {
		var mobile=$("#mobile")[0].value;
		loaded(mobile);
	});
}, false);

function loaded(mobile) {
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
	$.post("carowner.do", {
			"page": page,
			"pagesize": PAGESIZE,
			"mobile" : mobile,
			"action" : "accountdetail"
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
					var create_time = value.create_time;
					var amount = value.amount;//���
					var pay_name = value.pay_name;//���㷽ʽ
					var type = value.type;//0:��ֵ��1:����,
					var pay_type = value.pay_type;//���㷽ʽ
					var datestring = getSmpFormatDateByLong(parseInt(create_time)*1000,true);
					if(type == "0"){
						$("#thelist").append('<li><div class="company_name"><span>' + value.remark + '</span><span class="right money_in">+' +value.amount + '</span></div><div><span>' + datestring + '</span><span class="right">'+pay_name+'</span></div></li>');
					}else if(type ==1){
						$("#thelist").append('<li><div class="company_name"><span>' + value.remark + '</span><span class="right money_out">-' +value.amount + '</span></div><div><span>' + datestring + '</span><span class="right">'+pay_name+'</span></div></li>');
					}
					
				});
				// $("#thelist").listview("refresh");
				myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)
				// pullDownEl.className = 'idle';
				// pullDownEl.querySelector('.pullDownLabel').innerHTML = 'Pull down to refresh...';
				// this.minScrollY = -pullDownOffset;

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
	page = 1;
	$.post("carowner.do", {
			"page": page,
			"pagesize": PAGESIZE,
			"mobile" : mobile,
			"action" : "accountdetail"
		},
		function(response, status) {
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
					var create_time = value.create_time;
					var amount = value.amount;//���
					var pay_name = value.pay_name;//���㷽ʽ
					var type = value.type;//0:��ֵ��1:����,
					var pay_type = value.pay_type;//���㷽ʽ
					var datestring = getSmpFormatDateByLong(parseInt(create_time)*1000,true);
					if(type == "0"){
						$("#thelist").append('<li><div class="company_name"><span>' + value.remark + '</span><span class="right money_in">+' +value.amount + '</span></div><div><span>' + datestring + '</span><span class="right">'+pay_name+'</span></div></li>');
					}else if(type ==1){
						$("#thelist").append('<li><div class="company_name"><span>' + value.remark + '</span><span class="right money_out">-' +value.amount + '</span></div><div><span>' + datestring + '</span><span class="right">'+pay_name+'</span></div></li>');
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

function nextPage() {
	var mobile=$("#mobile")[0].value;
	page++;
	$.post("carowner.do", {
			"page": page,
			"pagesize": PAGESIZE,
			"mobile" : mobile,
			"action" : "accountdetail"
		},
		function(response, status) {
			if (status == "success") {
				if (response.length < PAGESIZE) {
					hasMoreData = false;
					$("#pullUp").hide();
				} else {
					hasMoreData = true;
					$("#pullUp").show();
				}

				$.each(response, function(key, value) {
					var create_time = value.create_time;
					var amount = value.amount;//���
					var pay_name = value.pay_name;//���㷽ʽ
					var type = value.type;//0:��ֵ��1:����,
					var pay_type = value.pay_type;//���㷽ʽ
					var datestring = getSmpFormatDateByLong(parseInt(create_time)*1000,true);
					if(type == "0"){
						$("#thelist").append('<li><div class="company_name"><span>' + value.remark + '</span><span class="right money_in">+' +value.amount + '</span></div><div><span>' + datestring + '</span><span class="right">'+pay_name+'</span></div></li>');
					}else if(type ==1){
						$("#thelist").append('<li><div class="company_name"><span>' + value.remark + '</span><span class="right money_out">-' +value.amount + '</span></div><div><span>' + datestring + '</span><span class="right">'+pay_name+'</span></div></li>');
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

function TqCookie(formKey){
	this.form = {};
	if(typeof(this.form[formKey]) == "undefined"){
        this.form[formKey] = null;
    } else {
    	this.form[formKey] = formKey;
    }
}

TqCookie.prototype.setCookie=function(name,value,option){
   var  str=name+"="+escape(value); 
   if(option){
   	 //��������˹���ʱ�� 
     if(option.expireDays){ 
        var date=new Date(); 
        var ms=option.expireDays*24*3600*1000; 
        date.setTime(date.getTime()+ms); 
        str+=";expires="+date.toGMTString(); 
      }
     if(option.path) str+=";path="+path;       //���÷���·�� 
     if(option.domain)str+=";domain"+domain;   //���÷������� 
     if(option.secure)str+=";true";            //���ð�ȫ�� 
   } 
   document.cookie=str;
};

TqCookie.prototype.getCookie=function(name){ 
    var cookieValue = "";
	var search = key + "=";
	if(document.cookie.length > 0){
		offset = document.cookie.indexOf(name+"\=");
		if (offset != -1){ 
			offset += search.length;
			end = document.cookie.indexOf(";", offset);
			if (end == -1) 
				end = document.cookie.length;
			cookieValue = unescape(document.cookie.substring(offset, end))
		}
	}
    return cookieValue;
};

TqCookie.prototype.deleteCookie=function(name){
	//������ʱ������Ϊ��ȥ��ɾ��һ��cookie 
     this.setCookie(name,"",{expireDays:-1});
}

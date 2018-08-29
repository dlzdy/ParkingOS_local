(function($) {
    $.addFlex = function(t, p) {
        if (t.grid){return false;}; //���Grid�Ѿ������򷵻�
        var dic;
        //�����е��ֵ����ݴ洢
        dic = $.extend(
            new Dictionary(),
            dic);
        // ����Ĭ������
        p = $.extend({
            height: 300, //�߶ȣ���λΪpx
            width: 700, //���ֵ��auto��ʾ����ÿ�еĿ���Զ�����
            striped: true, //�Ƿ���ʾ����Ч����Ĭ������ż��������ʽ
            novstripe: false,
            minwidth: 20, //�е���С���
            minheight: 80, //�е���С�߶�
            url: false, //��ʽ��Ӧ��url��ַ
            method: 'POST', //���ݷ��ͷ�ʽ
            dataType: 'json', // ���ݼ��ص�����,json
			errormsg: '�쳣����������',
            usepager: true, //�Ƿ��ҳ
            nowrap: true, //�Ƿ񲻻���
            page: 1, //Ĭ�ϵ�ǰҳ
            total: 0, //��ҳ����
            useRp: false, //�Ƿ���Զ�̬����ÿҳ��ʾ�Ľ����
            rp: 10, // ÿҳĬ�ϵĽ����
			rpOptions: [10,15,20,30,50], //��ѡ���趨��ÿҳ�����
            title: false, //�Ƿ��������
            //pagestat: '��ʾ{from}��{to}���ܹ� {total} ����¼', //��ʾ��ǰҳ����ҳ�����ʽ
            pagestat: '�ܹ� {total} ����¼', //��ʾ��ǰҳ����ҳ�����ʽ
            procmsg: '�����������ݣ����Ժ� ...', //���ڴ������ʾ��Ϣ
            query: '', //������ѯ������
            qtype: '', //������ѯ�����
            qop: "Eq", //�����Ĳ�����
            nomsg: '<font style="color:#D34319;font-weight:bold;">���޷�������������</font>', //�޽������ʾ��Ϣ
			minColToggle: 1, //������ʾ����С����
            showToggleBtn: true, //�Ƿ�������
			hideOnSubmit: true, //�Ƿ��ڻص�ʱ��ʾ�ڸ�
            showTableToggleBtn: false, //��ʾ����Grid 
            autoload: true, //�Զ�����
            blockOpacity: 0.5, //͸��������
            onChangeSort: false, //���ı�����ʱ
            onSuccess: false, //�ɹ���ִ��
            onSubmit: false, // �����Զ���ļ��㺯��
			showcheckbox: true,//�Ƿ���ʾ��һ�е�checkbox������ȫѡ��
            rowhandler: false, //�Ƿ������е���չ���鹦��,��������ʱ���¼�����˫�����Ҽ���
            rowbinddata: true,//�����һ������������˫���¼��л�ȡ���е�����
            extParam: false,//���extParam�����ɽ��ⲿ������̬ע�ᵽgrid��ʵ�����ѯ�Ȳ���
			dragcolumn:true,//�ı���˳��
			sortname: "id",
			sortorder: "asc",
			showoperationswidth:0,
            //Style
            gridClass: "tq-grid",
            onrowchecked: false,//��ÿһ�еĵ�checkboxѡ��״̬�����仯ʱ����ĳ���¼�
            ishistorydata : false,
            historydata : {},//����������
			gridname:"tq"//������ƣ� ����cookiesʱ����
        }, p);

        $(t)
		.show()
		.attr({ cellPadding: 0, cellSpacing: 0, border: 0 })
		.removeAttr('width');

        //create grid class
        var g = {
			ie9Fix: function() {//�޸�IE9
					if($(".bDiv").height() != $(".bDiv table").height() && p.height=='auto') {
					   $(".bDiv").css({height: $(".bDiv table").height() + 18});
					}
					},

            hset: {},
			scok:function(name,value)
			{
				var Days = 30;
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
            dragStart: function(dragtype, e, obj) { //default drag function start

			 if (dragtype == 'colMove') //column header drag
                {
                    this.hset = $(this.hDiv).offset();
                    this.hset.right = this.hset.left + $('table', this.hDiv).width();
                    this.hset.bottom = this.hset.top + $('table', this.hDiv).height();
                    this.dcol = obj;
                    this.dcoln = $('th', this.hDiv).index(obj);

                    this.colCopy = document.createElement("div");
                    this.colCopy.className = "colCopy";
                    this.colCopy.innerHTML = obj.innerHTML;
                    if ($.browser.msie) {
                        this.colCopy.className = "colCopy ie";
                    }

                    $(this.colCopy).css({ position:'absolute',display: 'none', textAlign: obj.align });//float:'left', 
                    $('body').append(this.colCopy);
                    $(this.cDrag).hide();

                }
                $('body').noSelect();
            },

            reSize: function() {
                this.gDiv.style.width = p.width;
                this.bDiv.style.height = p.height;
            },
            dragEnd: function() {
                if (this.colresize) {
                    var n = this.colresize.n;
                    var nw = this.colresize.nw;
                    //$('th:visible div:eq(' + n + ')', this.hDiv).css('width', nw);
                    $('th:visible:eq(' + n + ') div', this.hDiv).css('width', nw);

                    $('tr', this.bDiv).each(
									function() {
									    //$('td:visible div:eq(' + n + ')', this).css('width', nw);
									    $('td:visible:eq(' + n + ') div', this).css('width', nw);
									}
								);
                    this.hDiv.scrollLeft = this.bDiv.scrollLeft;
                    $('div:eq(' + n + ')', this.cDrag).siblings().show();
                    $('.dragging', this.cDrag).removeClass('dragging');
                    this.colresize = false;
                }
                else if (this.vresize) {
                    this.vresize = false;
                }
                else if (this.colCopy) {
                    $(this.colCopy).remove();
                    if (this.dcolt != null) {
						if(this.dcolt > 0 ){
                        if (this.dcoln > this.dcolt)
                        { $('th:eq(' + this.dcolt + ')', this.hDiv).before(this.dcol); }
                        else
                        { $('th:eq(' + this.dcolt + ')', this.hDiv).after(this.dcol); }
                        this.switchCol(this.dcoln, this.dcolt);
                        $(this.cdropleft).remove();
                        $(this.cdropright).remove();
                    }
				}
                    this.dcol = null;
                    this.hset = null;
                    this.dcoln = null;
                    this.dcolt = null;
                    this.colCopy = null;
                    $('.thMove', this.hDiv).removeClass('thMove');
                    $(this.cDrag).show();
                }
                $('body').css('cursor', 'default');
                $('body').noSelect(false);
            },
            toggleCol: function(cid, visible) {//��ʾ������
                var ncol = $("th[axis='col" + cid + "']", this.hDiv)[0];
                var n = $('thead th', g.hDiv).index(ncol);
                var cb = $('input[value=' + cid + ']', g.nDiv)[0];
				var colcookie;
				if(g.gcok(cb.name)==1){colcookie=true}else if(g.gcok(cb.name)==0){colcookie=false}else{colcookie=ncol.hide};
                if (visible == null){
                    visible = colcookie;
                }
                if ($('input:checked', g.nDiv).length < p.minColToggle && !visible) return false;
                if (visible){
                    ncol.hide = false;
					g.scok(cb.name,0);
                    $(ncol).show();
                    cb.checked = true;
                }
                else{
                    ncol.hide = true;
                    $(ncol).hide();
					g.scok(cb.name,1);
                    cb.checked = false;
                }
                $('tbody tr', t).each
							(
								function() {
								    if (visible)
								        $('td:eq(' + n + ')', this).show();
								    else
								        $('td:eq(' + n + ')', this).hide();
								}
							);
                return visible;
            },
            switchCol: function(cdrag, cdrop) { //switch columns
                $('tbody tr', t).each
					(
						function() {
						    if (cdrag > cdrop)
						        $('td:eq(' + cdrop + ')', this).before($('td:eq(' + cdrag + ')', this));
						    else
						        $('td:eq(' + cdrop + ')', this).after($('td:eq(' + cdrag + ')', this));
						}
					);
                //switch order in nDiv
                if (cdrag > cdrop)
                    $('tr:eq(' + cdrop + ')', this.nDiv).before($('tr:eq(' + cdrag + ')', this.nDiv));
                else
                    $('tr:eq(' + cdrop + ')', this.nDiv).after($('tr:eq(' + cdrag + ')', this.nDiv));
                if ($.browser.msie && $.browser.version < 7.0) $('tr:eq(' + cdrop + ') input', this.nDiv)[0].checked = true;
                this.hDiv.scrollLeft = this.bDiv.scrollLeft;
            },
            scroll: function() {
                this.hDiv.scrollLeft = this.bDiv.scrollLeft;
            },
            hideLoading: function() {
                $('.pReload', this.pDiv).removeClass('loading');
                if (p.hideOnSubmit) $(g.block).remove();
                $('.pPageStat', this.pDiv).html(p.errormsg);
                this.loading = false;
            },
            addRowToDic: function(row, ths) {
                if (row != null) {
                    var dicKey = row.id;
                    var dicValue = new Dictionary();
                    var dicValueKey, dicValueValue;
                    dicValue.add('id', row.id); //����Ϊid��һ�С�
                    $(ths).each(function() {
                        var idx = $(this).attr('axis').substr(3);
                        dicValueKey = $(this).attr('abbr');
                        if (dicValueKey) {
                            dicValueValue = row.cell[idx];
                            dicValue.add(dicValueKey, dicValueValue);
                        }

                    });
                    dic.add(dicKey, dicValue);
                }
            },
            addDataToDic: function(rows) {
                if (rows != null) {
                    var self = this;
                    var ths = $('thead tr:first th', g.hDiv);
                    $(rows).each(function() {
                        self.addRowToDic(this, ths);
                    });
                }
            },
            addData: function(data) { //parse data                
                if (p.preProcess)
                { data = p.preProcess(data); }
                $('.pReload', this.pDiv).removeClass('loading');
                this.loading = false;

                if (!data) {
                    $('.pPageStat', this.pDiv).html(p.errormsg);
                    return false;
                }
                var temp = p.total;
                p.total = data.total;
                if (p.total < 0) {
                    p.total = temp;
                }
                if (p.total == 0) {
                    $('tr, a, td, div', t).unbind();
                    $(t).empty();
                    p.pages = 1;
                    p.page = 1;
                    this.buildpager();
                    $('.pPageStat', this.pDiv).html(p.nomsg);
                    if (p.hideOnSubmit) $(g.block).remove();
                    return false;
                }

                p.pages = Math.ceil(p.total / p.rp);
                p.page = data.page;
                this.buildpager();

                var ths = $('thead tr:first th', g.hDiv);
                var thsdivs = $('thead tr:first th div', g.hDiv);
                var tbhtml = [];
                
                //���ֵ��dic
                dic.removeAll();
                this.addDataToDic(data.rows);
                
                tbhtml.push("<tbody>");
                if (p.dataType == 'json') {
                    if (data.rows != null) {
                        $.each(data.rows, function(i, row) {
                            tbhtml.push("<tr id='", "row", row.id, "'");

                            if (i % 2 && p.striped) {
                                tbhtml.push(" class='erow'");
                            }
                            if (p.rowbinddata) {
                               // tbhtml.push("ch='", row.cell.join("_FG$SP_"), "'");
                            	
                            	var rCell = row.cell.join("_FG$SP_");
                                //tbhtml.push("ch='", rCell, "'");
                                //if(p.ishistorydata){
            					//	var id = 'id'+row.id;
            		            //  	p.historydata.id=rCell;
                                //}
                                
                            }
                            tbhtml.push(">");
                            var trid = row.id;
                            $(ths).each(function(j) {
                                var tddata = "";
                                var tdclass = "";
                                tbhtml.push("<td align='", this.align, "'");
                                var idx = $(this).attr('axis').substr(3);

                                if (p.sortname && p.sortname == $(this).attr('abbr')) {
                                    tdclass = 'sorted';
                                }
								if(g.gcok(p.gridname+this.abbr.substr(1))==1){
									tbhtml.push(" style='display:none;'");
								};
								 if ((g.gcok(p.gridname+this.abbr.substr(1))==null||g.gcok(p.gridname+this.abbr.substr(1))=="")&&this.hide){tbhtml.push(" style='display:none;'");};
                                var width = thsdivs[j].style.width;
                                var div = [];
                                div.push("<div style='text-align:", this.align, ";width:", width, ";");
                                if (p.nowrap == false) {
                                    div.push("white-space:normal");
                                };
                                div.push("'>");
                                if (idx == "-1") { //checkbox
                                    div.push("<input type='checkbox' id='chk_", row.id, "' class='itemchk' value='", row.id, "'/>");
                                    if (tdclass != "") {
                                        tdclass += " chboxtd";
                                    } else {
                                        tdclass += "chboxtd";
                                    }
                                }
                                else if (idx == "-2") { //����
									if (p.operation_obj) {
										var otDiv = document.createElement('div');
										//alert(p.operation_obj.length);
										for (i = 0; i < p.operation_obj.length; i++) {
											var obtn = p.operation_obj[i];
											//alert(obtn.slice);
											if (obtn != "" && !obtn.separator) {
												var obtnDiv = document.createElement('div');
												obtnDiv.className = 'fbutton';
												obtnDiv.innerHTML =(obtn.name)? "<div onclick=\"operateItem('"+obtn.name+"',"+row.id+");\"><span></span>" + obtn.displayname + "</div>":"";
												if (obtn.title) {
													obtnDiv.title = obtn.title;
												}
												if (obtn.bclass){ $('span', obtnDiv).addClass(obtn.bclass);}
												obtnDiv.Oonpress = obtn.Oonpress;
												obtnDiv.name = obtn.name;
												
												if(obtn.Oonpress){
													$(obtnDiv).click
														(
															function() {
																this.Oonpress(this.name,row.id);
															}
														);
												}
												$(otDiv).append(obtnDiv);
												if ($.browser.msie && $.browser.version < 7.0) {
													$(obtnDiv).hover(function() { $(this).addClass('fbOver'); }, function() { $(this).removeClass('fbOver'); });
												}
							
											} else {
												$(otDiv).append("<div class='btnseparator'></div>");
											}
										}
										//$(g.gDiv).prepend(otDiv);
										div.push(otDiv.innerHTML);
									}
										
									}
                                else {
                                    var divInner = row.cell[idx] || "&nbsp;";
                                    if (this.process) {
                                        divInner = this.process(divInner,trid);
                                    }
                                    div.push(divInner);
                                }
                                div.push("</div>");
                                if (tdclass != "") {
                                    tbhtml.push(" class='", tdclass, "'");
                                }
                                tbhtml.push(">", div.join(""), "</td>");
                            });
                            tbhtml.push("</tr>");
                        }
					    );
                    }
                } 
                tbhtml.push("</tbody>");
                $(t).html(tbhtml.join(""));
                this.addRowProp();
                if (p.onSuccess) p.onSuccess();
                if (p.hideOnSubmit) $(g.block).remove(); //$(t).show();
                this.hDiv.scrollLeft = this.bDiv.scrollLeft;
                if ($.browser.opera) $(t).css('visibility', 'visible');

            },
            changeSort: function(th) { //change sortorder

                if (this.loading) return true;
                if (p.sortname == $(th).attr('abbr')) {
                    if (p.sortorder == 'asc') p.sortorder = 'desc';
                    else p.sortorder = 'asc';
                }

                $(th).addClass('sorted').siblings().removeClass('sorted');
                $('.sdesc', this.hDiv).removeClass('sdesc');
                $('.sasc', this.hDiv).removeClass('sasc');
                $('div', th).addClass('s' + p.sortorder);
                p.sortname = $(th).attr('abbr');

                if (p.onChangeSort)
                    p.onChangeSort(p.sortname, p.sortorder);
                else
                    this.populate();

            },
            buildpager: function() { //rebuild pager based on new properties

                $('.pcontrol input', this.pDiv).val(p.page);
                $('.pcontrol span', this.pDiv).html(p.pages);

                var r1 = (p.page - 1) * p.rp + 1;
                var r2 = r1 + p.rp - 1;

                if (p.total < r2) r2 = p.total;

                var stat = p.pagestat;

                stat = stat.replace(/{from}/, r1);
                stat = stat.replace(/{to}/, r2);
                stat = stat.replace(/{total}/, p.total);
                $('.pPageStat', this.pDiv).html(stat);
            },
            populate: function() { //get latest data 
                if (this.loading) return true;
                if (p.onSubmit) {
                    var gh = p.onSubmit();
                    if (!gh) return false;
                }
                this.loading = true;
                if (!p.url) return false;
                $('.pPageStat', this.pDiv).html(p.procmsg);
                $('.pReload', this.pDiv).addClass('loading');
                $(g.block).css({ top: g.bDiv.offsetTop });
                if (p.hideOnSubmit) $(this.gDiv).prepend(g.block); //$(t).hide();
                if ($.browser.opera) $(t).css('visibility', 'hidden');
                if (!p.newp) p.newp = 1;
                if (p.page > p.pages) p.page = p.pages;
				var fieldslist = "";
				for(var i=0;i<p.colModel.length;i++){
					fieldslist += p.colModel[i].name+"__";
				};
				fieldslist = fieldslist.substr(0, fieldslist.length-2)
                var param = {page:p.newp, rp: p.rp, sortname: p.sortname, sortorder: p.sortorder, fieldsstr:fieldslist};
                if (p.extParam) {param = $.extend(param, p.extParam);}
                $.ajax({
                    type: p.method,
                    url: p.url,
                    data: param,
                    dataType: p.dataType,
                    success: function(data) { if (data != null && data.error != null) { if (p.onError) { p.onError(data); g.hideLoading(); } } else { g.addData(data); } },
                    error: function(data) { try { if (p.onError) { p.onError(data); } else { alert("��ȡ���ݷ����쳣;") } g.hideLoading(); } catch (e) { } }
                });
            },
            doSearch: function() {
                var queryType = $('select[name=qtype]', g.sDiv).val();
                var qArrType = queryType.split("$");
                var index = -1;
                if (qArrType.length != 3) {
                    p.qop = "Eq";
                    p.qtype = queryType;
                }
                else {
                    p.qop = qArrType[1];
                    p.qtype = qArrType[0];
                    index = parseInt(qArrType[2]);
                }
                p.query = $('input[name=q]', g.sDiv).val();
                //�����֤����
                if (p.query != "" && p.searchitems && index >= 0 && p.searchitems.length > index) {
                    if (p.searchitems[index].reg) {
                        if (!p.searchitems[index].reg.test(p.query)) {
                            alert("������벻����Ҫ��!");
                            return;
                        }
                    }
                }
                p.newp = 1;
                this.populate();
            },
            changePage: function(ctype) { //change page

                if (this.loading) return true;

                switch (ctype) {
                    case 'first': p.newp = 1; break;
                    case 'prev': if (p.page > 1) p.newp = parseInt(p.page) - 1; break;
                    case 'next': if (p.page < p.pages) p.newp = parseInt(p.page) + 1; break;
                    case 'last': p.newp = p.pages; break;
                    case 'input':
                        var nv = parseInt($('.pcontrol input', this.pDiv).val());
                        if (isNaN(nv)) nv = 1;
                        if (nv < 1) nv = 1;
                        else if (nv > p.pages) nv = p.pages;
                        $('.pcontrol input', this.pDiv).val(nv);
                        p.newp = nv;
                        break;
                }

                if (p.newp == p.page) return false;

                if (p.onChangePage)
                    p.onChangePage(p.newp);
                else
                    this.populate();

            },
            cellProp: function(n, ptr, pth) {
                var tdDiv = document.createElement('div');
                if (pth != null) {
                    if (p.sortname == $(pth).attr('abbr') && p.sortname) {
                        this.className = 'sorted';
                    }
                    $(tdDiv).css({ textAlign: pth.align, width: $('div:first', pth)[0].style.width });
                    if (pth.hide) $(this).css('display', 'none');
                }
                if (p.nowrap == false) $(tdDiv).css('white-space', 'normal');

                if (this.innerHTML == '') this.innerHTML = '&nbsp;';

                //tdDiv.value = this.innerHTML; //store preprocess value
                tdDiv.innerHTML = this.innerHTML;

                var prnt = $(this).parent()[0];
                var pid = false;
                if (prnt.id) pid = prnt.id.substr(3);
                if (pth != null) {
                    if (pth.process)
                    { pth.process(tdDiv, pid); }
                }
                $("input.itemchk", tdDiv).each(function() {
                    $(this).click(function() {
                        if (this.checked) {
                            $(ptr).addClass("trSelected");
                        }
                        else {
                            $(ptr).removeClass("trSelected");
                        }
                        if (p.onrowchecked) {
                            p.onrowchecked.call(this);
                        }
                    });
                });
                $(this).empty().append(tdDiv).removeAttr('width'); //wrap content
                //add editable event here 'dblclick',�����Ҫ�ɱ༭��������ӿɱ༭���� 
            },
            addCellProp: function() {
                var $gF = this.cellProp;

                $('tbody tr td', g.bDiv).each
					(
						function() {
						    var n = $('td', $(this).parent()).index(this);
						    var pth = $('th:eq(' + n + ')', g.hDiv).get(0);
						    var ptr = $(this).parent();
						    $gF.call(this, n, ptr, pth);
						}
					);
                $gF = null;
            },
            updateRowData: function(rowId,index,value) {
                var ths = $('thead tr:first th', g.hDiv);
                var tr = $("#row" + rowId, g.bDiv).eq(0);
                $(ths).each(function(i) {
                    var idx = $(this).attr('axis').substr(3);
                    //������
                   if(idx==index){
                    	var td = $('td', $(tr)).get(i);
                    	if (td) {
                    		var width = parseFloat($(td).css('width')) - 4;
                            $(td).html("<div style='text-algin:left;width:"+width+"px;'>"+value+"</div>")
                            //$(td).text(value);
                        }
                    }
                });
            },
            getCellDatas: function(id) {
            	//var id = 'id'+id
                //return p.historydata.id.split("_FG$SP_");
                var array = new Array();
                var ths = $('thead tr:first th', g.hDiv);
                var trdata;
                if (dic.exists(id)) {
                    trdata = dic.item(id);
                }
                if (trdata) {
                    $.each(ths, function(i) {
                        var idx = $(this).attr('axis').substr(3);
                        var name = $(this).attr('abbr');
                        if (idx && name) {
                            var txt = trdata.item(name);
                            array[idx] = txt;
                        }
                    });
                }
                return array;
            },
            getCheckedRows: function() {
            	var _idstr = "";
                var ids = [];
                $(":checkbox:checked", g.bDiv).each(function() {
                    ids.push($(this).val());
                });
                var idsLength = ids.length;
                for(i=0;i<idsLength;i++){
                	if(i == 0){
                		_idstr = ids[i];//p.historydata[ids[i]].split("_FG$SP_")[0];//
                	}else{
                		_idstr = _idstr + "_" + ids[i];//p.historydata[ids[i]].split("_FG$SP_")[0];//
                	}
                }
                return _idstr;
            },
             getRowsId: function() {
                var ids = [];
                $(":checkbox", g.bDiv).each(function() {
                    ids.push($(this).val());
                });
                return ids;
            },
            getCellDim: function(obj) // get cell prop for editable event
            {
                var ht = parseInt($(obj).height());
                var pht = parseInt($(obj).parent().height());
                var wt = parseInt(obj.style.width);
                var pwt = parseInt($(obj).parent().width());
                var top = obj.offsetParent.offsetTop;
                var left = obj.offsetParent.offsetLeft;
                var pdl = parseInt($(obj).css('paddingLeft'));
                var pdt = parseInt($(obj).css('paddingTop'));
                return { ht: ht, wt: wt, top: top, left: left, pdl: pdl, pdt: pdt, pht: pht, pwt: pwt };
            },
            rowProp: function() {
                if (p.rowhandler) {
                    p.rowhandler(this);
                }
                if ($.browser.msie && $.browser.version < 7.0) {
                    $(this).hover(function() { $(this).addClass('trOver'); }, function() { $(this).removeClass('trOver'); });
                }
            },
            addRowProp: function() {//�����ѡ���¼�
                var $gF = this.rowProp;
                $('tbody tr', g.bDiv).each(
                    function() {
                        $("input.itemchk", this).each(function() {
                            var ptr = $(this).parent().parent().parent();
                            $(this).click(function() {
                                if (this.checked) {
                                    ptr.addClass("trSelected");
                                }
                                else {
                                    ptr.removeClass("trSelected");
                                }
                                if (p.onrowchecked) {
                                    p.onrowchecked.call(this);
                                }
                            });
                        });
                        $gF.call(this);
                    }
                );
                $gF = null;
            },
            checkAllOrNot: function(parent) {
                var ischeck = $(this).attr("checked");
                $('tbody tr', g.bDiv).each(function() {
                    if (ischeck) {
                        $(this).addClass("trSelected");
                    }
                    else {
                        $(this).removeClass("trSelected");
                    }
                });
                $("input.itemchk", g.bDiv).each(function() {
                    this.checked = ischeck;
                    //Raise Event
                    if (p.onrowchecked) {
                        p.onrowchecked.call(this);
                    }
                });
            },
            pager: 0
        };

        //create model if any
        if (p.colModel) {
            thead = document.createElement('thead');
            tr = document.createElement('tr');
            if (p.showcheckbox) {
                var cth = jQuery('<th/>');
                var cthch = jQuery('<input type="checkbox"/>');
                cthch.addClass("noborder");
                cth.addClass("cth").attr({ 'axis': "col-1", width: "16", "isch": false }).append(cthch);
                $(tr).append(cth);
            }
            if (p.operation_obj) {
                var cth = jQuery('<th/>');
                var is_show_operation = true;
                if(p.showoperationswidth > 0 ){ // ������ʹ�ù̶����
                	 cth.addClass("cth").attr({ 'axis': "col-2", width: p.showoperationswidth, "isch": false }).append('<center>����</center>');
                }else{
	                for (i = 0; i < p.operation_obj.length; i++) {
						var obtn = p.operation_obj[i];
						if (!obtn.separator && obtn.width) {
							p.showoperationswidth = p.showoperationswidth + obtn.width;
						}else{
							break;
						}
					}
					if(p.showoperationswidth > 0 ) // ʹ��ÿ���������趨��ȵĿ�Ⱥ�
						 cth.addClass("cth").attr({ 'axis': "col-2", width: p.showoperationswidth, "isch": false }).append('<center>����</center>');
					else if(p.showoperationswidth < 0 ) // ���κβ�������Ӳ�����
						 is_show_operation = false;
					else // ��������Ŀ���趨������� ���ÿ����������������4������
						 cth.addClass("cth").attr({ 'axis': "col-2", width: (p.operation_obj.length-1)*80, "isch": false }).append('<center>����</center>');
                }
                if(is_show_operation)
                	$(tr).append(cth);
            }
            for (i = 0; i < p.colModel.length; i++) {
                var cm = p.colModel[i];
                var th = document.createElement('th');

                th.innerHTML = cm.display;

                if (cm.name)// if (cm.name && cm.sortable)
                    $(th).attr('abbr', "_"+cm.name);

                //th.idx = i;
                $(th).attr('axis', 'col' + i);

                if (cm.align)
                    th.align = cm.align;

                if (cm.width)
                    $(th).attr('width', cm.width);

                if (cm.hide || cm.fhide) {
                    th.hide = true;
                }
                
                if (cm.toggle != undefined) {
                    th.toggle = cm.toggle
                }
                
                if (cm.process) {
                    th.process = cm.process;
                }

                $(tr).append(th);
            }
            $(thead).append(tr);
            $(t).prepend(thead);
        } // end if p.colmodel	

        //init divs
        g.gDiv = document.createElement('div'); //������������
        g.mDiv = document.createElement('div'); //����������
        g.hDiv = document.createElement('div'); //��������б���
        g.bDiv = document.createElement('div'); //�������������
        g.cDrag = document.createElement('div'); //create column drag
        g.block = document.createElement('div'); //�������ع��ɲ�
        g.nDiv = document.createElement('div'); //create column show/hide popup
        g.tDiv = document.createElement('div'); //����������
        g.sDiv = document.createElement('div'); //���������ɸѡ
		g.clDiv = document.createElement('div');//��������ʾ��ť


        if (p.usepager) g.pDiv = document.createElement('div'); //create pager container
        g.hTable = document.createElement('table');

        //set gDiv
        g.gDiv.className = p.gridClass;
        if (p.width != 'auto') g.gDiv.style.width = p.width + 'px';
        //add conditional classes
        if ($.browser.msie)
            $(g.gDiv).addClass('ie');

        if (p.novstripe)
            $(g.gDiv).addClass('novstripe');

        $(t).before(g.gDiv);
        $(g.gDiv)
		.append(t)
		;

        //��񹤾�������
        if (p.buttons) {
            g.tDiv.className = 'tDiv';
            var tDiv2 = document.createElement('div');
            tDiv2.className = 'tDiv2';
            for (i = 0; i < p.buttons.length; i++) {
                var btn = p.buttons[i];
                if (!btn.separator) {
                    var btnDiv = document.createElement('div');
                    btnDiv.className = 'fbutton';
                    if(btn.name != ""){
	                    btnDiv.innerHTML = "<div id='toole_botton" +i+ "'><span></span>" + btn.displayname + "</div>";
                    }
                    if (btn.title) {
                        btnDiv.title = btn.title;
                    }
                    if (btn.bclass)
                        $('span', btnDiv)
							.addClass(btn.bclass);
                    btnDiv.onpress = btn.onpress;
                    btnDiv.name = btn.name;
                    if (btn.onpress) {
                        $(btnDiv).click
							(
								function() {
								    this.onpress(this.name, g.gDiv);
								}
							);
                    }
                    $(tDiv2).append(btnDiv);
                    if ($.browser.msie && $.browser.version < 7.0) {
                        $(btnDiv).hover(function() { $(this).addClass('fbOver'); }, function() { $(this).removeClass('fbOver'); });
                    }

                } else {
                    $(tDiv2).append("<div class='btnseparator'></div>");
                }
            }
			if (p.showToggleBtn){
				g.clDiv.className = 'fbutton';
				g.clDiv.innerHTML = "<div id='toole_botton_lsz' title='��������ʾ(���ý������ڱ��ص���)'><span class='columnset'></span>������</div>";
				$(tDiv2).append(g.clDiv);
			}
            $(g.tDiv).append(tDiv2);
            $(g.tDiv).append("<div style='clear:both'></div>");
            $(g.gDiv).prepend(g.tDiv);
        }

        //set hDiv
        g.hDiv.className = 'hDiv';
        $(t).before(g.hDiv);

        //set hTable
        g.hTable.cellPadding = 0;
        g.hTable.cellSpacing = 0;
        $(g.hDiv).append('<div class="hDivBox"></div>');
        $('div', g.hDiv).append(g.hTable);
        var thead = $("thead:first", t).get(0);
        if (thead) $(g.hTable).append(thead);
        thead = null;

        if (!p.colmodel) var ci = 0;

        //���ñ�����			
        $('thead tr:first th', g.hDiv).each
			(
			 	function() {
			 	    var thdiv = document.createElement('div');
			 	    if ($(this).attr('abbr')) {
			 	        $(this).click(
								function(e) {
								    if (!$(this).hasClass('thOver')) return false;
								    var obj = (e.target || e.srcElement);
								    if (obj.href || obj.type) return true;
								    g.changeSort(this);
								}
							);

			 	        if ($(this).attr('abbr') == p.sortname) {
			 	            this.className = 'sorted';
			 	            thdiv.className = 's' + p.sortorder;
			 	        }
			 	    };
					if(g.gcok(p.gridname+this.abbr.substr(1))==1) $(this).hide();
			 	    if((g.gcok(p.gridname+this.abbr.substr(1))==null||g.gcok(p.gridname+this.abbr.substr(1))=="")&&this.hide) $(this).hide();
			 	    if(!p.colmodel && !$(this).attr("isch")) {
			 	        $(this).attr('axis', 'col' + ci++);
			 	    };
			 	    $(thdiv).css({ textAlign: this.align, width: this.width + 'px' });
			 	    thdiv.innerHTML = this.innerHTML;

			 	    $(this).empty().append(thdiv).removeAttr('width');
			 	    if (!$(this).attr("isch")) {
			 	        $(this).mousedown(function(e) {
							if(p.dragcolumn){g.dragStart('colMove', e, this);}
			 	        })
						.hover(
							function() {

							    if (!g.colresize && !$(this).hasClass('thMove') && !g.colCopy) $(this).addClass('thOver');

							    if ($(this).attr('abbr') != p.sortname && !g.colCopy && !g.colresize && $(this).attr('abbr')) $('div', this).addClass('s' + p.sortorder);
							    else if ($(this).attr('abbr') == p.sortname && !g.colCopy && !g.colresize && $(this).attr('abbr')) {
							        var no = '';
							        if (p.sortorder == 'asc') no = 'desc';
							        else no = 'asc';
							        $('div', this).removeClass('s' + p.sortorder).addClass('s' + no);
							    }

							    if (g.colCopy) {
							        var n = $('th', g.hDiv).index(this);
							        if (n == g.dcoln) return false;
							        if (n < g.dcoln){$(this).append(g.cdropleft);}
							        else{$(this).append(g.cdropright);}
							        g.dcolt = n;

							    } else if (!g.colresize) {
							        var thsa = $('th:visible', g.hDiv);
							        var nv = -1;
							        for (var i = 0, j = 0, l = thsa.length; i < l; i++) {
							            if ($(thsa[i]).css("display") != "none") {
							                if (thsa[i] == this) {
							                    nv = j;
							                    break;
							                }
							                j++;
							            }
							        }
							    }

							},
							function() {
							    $(this).removeClass('thOver');
							    if ($(this).attr('abbr') != p.sortname) $('div', this).removeClass('s' + p.sortorder);
							    else if ($(this).attr('abbr') == p.sortname) {
							        var no = '';
							        if (p.sortorder == 'asc'){no = 'desc';}else{no = 'asc';}
							        $('div', this).addClass('s' + p.sortorder).removeClass('s' + no);
							    }
							    if (g.colCopy) {
							        $(g.cdropleft).remove();
							        $(g.cdropright).remove();
							        g.dcolt = null;
							    }
							}); 
			 	    }
			 	}
			);

        //set bDiv
        g.bDiv.className = 'bDiv';
        $(t).before(g.bDiv);
        $(g.bDiv)
		.css({ height: (p.height == 'auto') ? 'auto' : p.height + "px" })
		.scroll(function(e) { g.scroll() })
		.append(t)
		;

        if (p.height == 'auto') {
            $('table', g.bDiv).addClass('autoht');
        }

        //add td properties
        if (p.url == false || p.url == "") {
            g.addCellProp();
            g.addRowProp();
           // g.addRowProp().mouseleave(function(){ g.ie9Fix(); });//�޸�IE9
        }


        //add strip		
        if (p.striped)
            $('tbody tr:odd', g.bDiv).addClass('erow');

        // add pager
        if (p.usepager) {
            g.pDiv.className = 'pDiv';
            g.pDiv.innerHTML = '<div class="pDiv2"></div>';
            $(g.bDiv).after(g.pDiv);
            var html = '<div class="pGroup"><div class="pFirst pButton" title="ת����һҳ"><span></span></div><div class="pPrev pButton" title="ת����һҳ"><span></span></div> </div><div class="btnseparator"></div> <div class="pGroup"><span class="pcontrol">��ǰ�� <input class="txt" type="text" size="1" value="1" title="����ҳ�룬���س�����ת"/> ҳ&nbsp;&nbsp;��<span> 1 </span>ҳ</span></div><div class="btnseparator"></div><div class="pGroup"> <div class="pNext pButton" title="ת����һҳ"><span></span></div><div class="pLast pButton" title="ת�����һҳ"><span></span></div></div><div class="btnseparator"></div><div class="pGroup"> <div class="pReload pButton" title="ˢ������"><span></span></div> </div> <div class="btnseparator"></div><div class="pGroup"><span class="pPageStat"></span></div>';
            $('div', g.pDiv).html(html);

            $('.pReload', g.pDiv).click(function() { g.populate() });
            $('.pFirst', g.pDiv).click(function() { g.changePage('first') });
            $('.pPrev', g.pDiv).click(function() { g.changePage('prev') });
            $('.pNext', g.pDiv).click(function() { g.changePage('next') });
            $('.pLast', g.pDiv).click(function() { g.changePage('last') });
            if ($.browser.msie && (parseInt($.browser.version) <= 7)){
				$('.pcontrol input', g.pDiv).keypress(function(e) { if (e.keyCode == 13) g.changePage('input') })
			}else{
				$('.pcontrol input', g.pDiv).keydown(function(e) { if (e.keyCode == 13) g.changePage('input') })
			};
            if ($.browser.msie && $.browser.version < 7) $('.pButton', g.pDiv).hover(function() { $(this).addClass('pBtnOver'); }, function() { $(this).removeClass('pBtnOver'); });

            if (p.useRp) {
                var opt = "";
                for (var nx = 0; nx < p.rpOptions.length; nx++) {
                    if (p.rp == p.rpOptions[nx]) sel = 'selected="selected"'; else sel = '';
                    opt += "<option value='" + p.rpOptions[nx] + "' " + sel + " >" + p.rpOptions[nx] + "&nbsp;&nbsp;</option>";
                };
                $('.pDiv2', g.pDiv).prepend("<div class='pGroup'>ÿҳ <select name='rp'>" + opt + "</select>��</div> <div class='btnseparator'></div>");
                $('select', g.pDiv).change(
					function() {
					    if (p.onRpChange)
					        p.onRpChange(+this.value);
					    else {
					        p.newp = 1;
					        p.rp = +this.value;
					        g.populate();
					    }
					}
				);
            }

            //�������ģ��
            if (p.searchitems) {
                /*��ʾ/��������ģ��
				$('.tDiv2', g.tDiv).after("<div class='btnseparator'></div><div class='fbutton'><div><span class='pSearch' title='ɸѡ��ǰ���������(������ҳ)'>ɸѡ</span></div> </div>");
                $('.pSearch', g.tDiv).click(function() { $(g.sDiv).slideToggle('fast', function() { $('.sDiv:visible input:first', g.gDiv).trigger('focus'); }); });
				*/
                //����ģ��
                g.sDiv.className = 'sDiv';

                sitems = p.searchitems;

                var sopt = "";
                var op = "Eq";
                for (var s = 0; s < sitems.length; s++) {
                    if (p.qtype == '' && sitems[s].isdefault == true) {
                        p.qtype = sitems[s].name;
                        sel = 'selected="selected"';
                    } else sel = '';
                    if (sitems[s].operater == "Like") {
                        op = "Like";
                    }
                    else {
                        op = "Eq";
                    }
                    sopt += "<option value='" + sitems[s].name + "$" + op + "$" + s + "' " + sel + " >" + sitems[s].display + "&nbsp;&nbsp;</option>";
                }

               
                var Squcikdatetime = "";
				if(p.Squcikdt_initializes){
					Squcikdt_initializes_ = p.Squcikdt_initializes;
					for (var n = 0; n < Squcikdt_initializes_.length; n++) {
						if (Squcikdt_initializes_[n].isdefault == true) {
							sel = 'selected="selected"';
						} else sel = '';
						Squcikdatetime += "<option value='" + Squcikdt_initializes_[n].opvalue + "' " + sel + " >" + Squcikdt_initializes_[n].Squcikdt + "</option>";
					}
				}
				
			    var Sdatetimestart = "";
			    var Sdatetimeend = "";
				if(p.Sdt_initializes){
				var search_initialize = p.Sdt_initializes;
                var m = search_initialize.length
						if( m == 1 )
						{
							alert(m)
                   		 Sdatetimestart = "<li><input type=\"text\" id=\"pre_date\" name=\"pre_date\" class=\"Wdate\" value='"+search_initialize[0].initializes_date+"' onclick=\"WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})\"\/><\/li>";
						}
						 if( m == 2){
                   		 Sdatetimestart = "<li><input type=\"text\" id=\"pre_date\" name=\"pre_date\" class=\"Wdate\" value='"+search_initialize[0].initializes_date+"' onclick=\"WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})\"\/><\/li>";
                   		 Sdatetimeend = "<li style=\"line-height:26px;\">��<\/li><li><input type=\"text\" id=\"end_date\" name=\"end_date\" class=\"Wdate\" value='"+search_initialize[1].initializes_date+"' onclick=\"WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})\"\/><\/li>";
						}

				}
				
                if (p.qtype == '') p.qtype = sitems[0].name;
				var aaa = "<div class=\"sDiv2\"><li><select name=\"quicktime_sel\">"+Squcikdatetime+"<\/select><\/li>"+Sdatetimestart+""+Sdatetimeend+"<li  style=\"line-height:22px;\">&nbsp;��<\/li><li><select name=\"qtype\">" + sopt + "<\/select><\/li><li><input type=\"text\"  name=\"q\" class=\"l-text\"\/><\/li><li><input type=\"image\" style=\"border:none;cursor:pointer\" src=\"images\/form\/button_search.gif\" name=\"qsubmitbtn\" value=\"��ѯ\" \/><\/li><!--<input type=\"button\" name=\"qsubmitbtn\" value=\"��ѯ\" \/><input type=\"button\" name=\"qclearbtn\" value=\"ȡ����ѯ\" \/>--><\/div>";
                $(g.sDiv).append(aaa);

                $('input[name=q],select[name=qtype]', g.sDiv).keydown(function(e) { if (e.keyCode == 13) g.doSearch(); });
                $('input[name=qsubmitbtn]', g.sDiv).click(function() { g.doSearch(); });
                //$('input[name=qclearbtn]', g.sDiv).click(function() { $('input[name=q]', g.sDiv).val(''); p.query = ''; g.doSearch(); });//ȡ����ѯ
                $(g.tDiv).after(g.sDiv);
            }

        }
        $(g.pDiv, g.sDiv).append("<div style='clear:both'></div>");


        // ��ӱ�����
        if (p.title) {
            g.mDiv.className = 'mDiv';
            g.mDiv.innerHTML = '<div class="ftitle">' + p.title + '</div>';
            $(g.gDiv).prepend(g.mDiv);
            if (p.showTableToggleBtn) {
                $(g.mDiv).append('<div class="ptogtitle" title="Minimize/Maximize Table"><span></span></div>');
                $('div.ptogtitle', g.mDiv).click
					(
					 	function() {
					 	    $(g.gDiv).toggleClass('hideBody');
					 	    $(this).toggleClass('vsble');
					 	}
					);
            }
        }

        //setup cdrops
        g.cdropleft = document.createElement('span');
        g.cdropleft.className = 'cdropleft';
        g.cdropright = document.createElement('span');
        g.cdropright.className = 'cdropright';

        //add block
        g.block.className = 'gBlock';
        var blockloading = $("<div/>");
        blockloading.addClass("loading");
        $(g.block).append(blockloading);
        var gh = $(g.bDiv).height();
        var gtop = g.bDiv.offsetTop;
        $(g.block).css(
		{
		    width: g.bDiv.style.width,
		    height: gh,
		    position: 'relative',
		    marginBottom: (gh * -1),
		    zIndex: 1,
		    top: gtop,
		    left: '0px'
		}
		);
        $(g.block).fadeTo(0, p.blockOpacity);

      
	  if(p.showcheckbox){// ȫѡ
	   $('th div', g.hDiv).each
			(
			 	function() {
			 	    var kcol = $("th[axis='col0']", g.hDiv)[0];
			 	    if (kcol == null) return;
			 	    var chkall = $("input[type='checkbox']", this);
			 	    if (chkall.length > 0) {
			 	        chkall[0].onclick = g.checkAllOrNot;
			 	        return;
			 	    }
			 	}
			);
	  }
		
		
		if (p.showToggleBtn){// ������
        if ($('th', g.hDiv).length) {
			var Lwid;
			var Thei;
			if(g.clDiv){Lwid = g.clDiv.offsetLeft; Thei = g.hDiv.offsetTop;}else{Lwid=0;Thei=0;}
            g.nDiv.className = 'nDiv';
            g.nDiv.innerHTML = "<table cellpadding='0' cellspacing='0' style='overflow-x:hidden'><tbody></tbody></table>";
            $(g.nDiv).css(
			{
			    marginBottom: (gh * -1),
			    display: 'none',
				left:Lwid,
			    top:Thei,
				height:p.colModel.length*29<g.bDiv.offsetHeight?p.colModel.length*29:g.bDiv.offsetHeight
			}
			).noSelect();

			var chk = 'checked="checked"';
			for (i = 0; i < p.colModel.length; i++){
			 var cm = p.colModel[i];
			 if(cm.fhide == true){
			 	continue;
			 };
			if(g.gcok(p.gridname+cm.name)==1){chk=""}else if(g.gcok(p.gridname+cm.name)==0){}else{(cm.hide == true)?chk="":""};
			$('tbody', g.nDiv).append('<tr><td class="ndcol1"><input type="checkbox" ' + chk + ' name="' + p.gridname + '' + cm.name + '" class="togCol noborder" value="' + i + '" /></td><td class="ndcol2"  style="cursor:pointer;">' + cm.display + '</td></tr>');
				chk = 'checked="checked"';
			}

            if ($.browser.msie && $.browser.version < 7.0)
                $('tr', g.nDiv).hover
				(
				 	function() { $(this).addClass('ndcolover'); },
					function() { $(this).removeClass('ndcolover'); }
				);

            $(g.clDiv).click//�е���
			(
			 	function() {
					$(g.nDiv).height(p.colModel.length*29<g.bDiv.offsetHeight?p.colModel.length*29:g.bDiv.offsetHeight)
			 	    $(g.nDiv).toggle(); return true;					
			 	}
			);
            $('td.ndcol2', g.nDiv).click
			(
			 	function(){
			 	    if ($('input:checked', g.nDiv).length <= p.minColToggle && $(this).prev().find('input')[0].checked) return false;
			 	    g.toggleCol($(this).prev().find('input').val());
			 	}
			);
            $('input.togCol', g.nDiv).click
			(
			 	function() {
			 	    if ($('input:checked', g.nDiv).length < p.minColToggle && this.checked == false) return false;
					g.toggleCol($(this).val());
			 	}
			);
            $(g.gDiv).prepend(g.nDiv);
		};
        }

        // add flexigrid events
        $(g.bDiv)
		.hover(function() { $(g.nDiv).hide(); }, function() { if (g.multisel){g.multisel = false;}})
		;
        $(g.gDiv)
		.hover(function() { }, function() { $(g.nDiv).hide(); })
		;

        //add document events
        $(document)
		.mouseup(function(e) { g.dragEnd() })
		.hover(function() { }, function() { g.dragEnd() });
		//function(){this.ie9Fix()}//�޸�IE9
		

        //browser adjustments
        if ($.browser.msie && $.browser.version < 7.0) {
            $('.hDiv,.bDiv,.mDiv,.pDiv,.vGrip,.tDiv, .sDiv', g.gDiv)
			.css({ width: '100%' });
            $(g.gDiv).addClass('ie6');
            if (p.width != 'auto') $(g.gDiv).addClass('ie6fullwidthbug');
        }


        //make grid functions accessible
        t.p = p;
        t.grid = g;

        // load data
        if (p.url && p.autoload) {
            g.populate();
        }

        return t;

    };

    var docloaded = false;

    $(document).ready(function() { docloaded = true });

    $.fn.flexigrid = function(p) {

        return this.each(function() {
            if (!docloaded) {
                $(this).hide();
                var t = this;
                $(document).ready
					(
						function() {
						    $.addFlex(t, p);
						}
					);
            } else {
                $.addFlex(this, p);
            }
        });

    }; //end flexigrid

    $.fn.flexReload = function(p) { // function to reload grid

        return this.each(function() {
            if (this.grid && this.p.url) this.grid.populate();
        });

    }; //end flexReload
    //����ָ����Ⱥ͸߶�
    $.fn.flexResize = function(w, h) {
        var p = { width: w, height: h };
        return this.each(function() {
            if (this.grid) {
                $.extend(this.p, p);
                this.grid.reSize();
            }
        });
    };
    $.fn.ChangePage = function(type) {
        return this.each(function() {
            if (this.grid) {
                this.grid.changePage(type);
            }
        })
    };
    $.fn.flexOptions = function(p) { //function to update general options

        return this.each(function() {
            if (this.grid) $.extend(this.p, p);
        });

    }; //end flexOptions
    $.fn.GetOptions = function() {
        if (this[0].grid) {
            return this[0].p;
        }
        return null;
    };
    // ��ȡѡ�е��У�����ѡ���е�ID������checkboxģʽ��Ч
    $.fn.getCheckedRows = function() {
        if (this[0].grid) {
            return this[0].grid.getCheckedRows();
        }
        return [];
    };
    // ��ȡѡ�е��У�����ѡ���е��������ݵ�Dictionary
    $.fn.getRowsId = function() {
        if (this[0].grid) {
            return this[0].grid.getRowsId();
        }
        return [];
    };
    //��ȡ����ѡ���е�IDS���κ�ģʽ��Ч
    $.fn.getSelectedRowsIds = function() {
        if (this[0].grid) {
            return this[0].grid.getSelectedRowsIds();
        }
        return [];
    };
    $.fn.flexToggleCol = function(cid, visible) { // function to reload grid

        return this.each(function() {
            if (this.grid) this.grid.toggleCol(cid, visible);
        });

    }; //end flexToggleCol

    $.fn.flexAddData = function(data) { // function to add data to grid

        return this.each(function() {
            if (this.grid) this.grid.addData(data);
        });

    };

    $.fn.noSelect = function(p) { //no select plugin
        if (p == null)
            prevent = true;
        else
            prevent = p;

        if (prevent) {

            return this.each(function() {
                if ($.browser.msie || $.browser.safari) $(this).bind('selectstart', function() { return false; });
                else if ($.browser.mozilla) {
                    $(this).css('MozUserSelect', 'none');
                    $('body').trigger('focus');
                }
                else if ($.browser.opera) $(this).bind('mousedown', function() { return false; });
                else $(this).attr('unselectable', 'on');
            });

        } else {


            return this.each(function() {
                if ($.browser.msie || $.browser.safari) $(this).unbind('selectstart');
                else if ($.browser.mozilla) $(this).css('MozUserSelect', 'inherit');
                else if ($.browser.opera) $(this).unbind('mousedown');
                else $(this).removeAttr('unselectable', 'on');
            });

        };

    }; //end noSelect
    $.fn.updateRowData = function(rowId,index,value) {
        if (this[0].grid) {
            this[0].grid.updateRowData(rowId,index,value);
        }
    };
    //��ȡָ��id�е����ݣ������ʽ
    $.fn.getCellDatas = function(id) {
        if (this[0].grid) {
            return this[0].grid.getCellDatas(id);
        }
        return [];
    };
    $.fn.getGridJsonData = function() {
        if (this[0].grid) {
            return this[0].grid.getGridJsonData();
        }
        return '';
    };
    //�ڱ����׷��һ��
    $.fn.insertNewRow = function(row) {
        if (this[0].grid) {
            var self = this[0];

            var ths = $('thead tr:first th', self.hDiv);
            self.grid.addRowToDic(row, ths);
            //Ĭ�ϵ�Table�����ı���Ȳ���һ�С�
            var r = self.insertRow(0);
            r.id = 'row' + row.id;
            $(r).addClass = 'erow';
            if (self.p.rowbinddata)
                $(r).attr({ 'CH': row.cell.join("_FG$SP_") });

            //hTable�Ǳ����񡣱������е�td����һ��������td
            $.each(ths, function(i) {
                var idx = $(this).attr('axis').substr(3);
                if (i == 0 && self.p.showcheckbox) {
                    var chk = r.insertCell(0);
                    if (!self.p.url && self.p.url.length == 0){
                        chk.innerHTML = "<input type='checkbox' id='chk_" + row.id + "' class='itemchk' value='" + row.id + "'/>";
					}else{
                     ����chk.innerHTML = "<input type='hidden' id='chk_" + row.id + "' value='" + row.id + "'/>";
					}
                }
                else {
                    var col = r.insertCell(i);
                    var width;
                    var align = this.align;
                    $("div", this).each(function() {
                        width = this.style.width;
                        return false;
                    });
                    var divHtml = "<div style='text-align:" + align + ";width:" + width + ";";
                    if (self.p.nowrap == false) {
                        divHtml += "white-space:normal;";
                    }
                    divHtml += "'/>" + row.cell[idx] + "</div>";
                    col.innerHTML = divHtml;
                    if ($(this).css("display") == "none") {
                        $(col).css({ 'display': "none" });
                    }
                }
            });
            var $gF = self.grid.rowProp;
            var $cf = self.grid.checkhandler;
            if (self.p.showcheckbox) {
                $('.itemchk', $(r)).click(function(e) {
                    $cf.call(r);
                    e.stopPropagation();
                });
            }
            if (self.p.selectedonclick) {
                $(r).click($cf);
            }
            $gF.call(r);
            self.p.rpoffset++;
            self.grid.buildpager();
        }
    };
    //ɾ��ָ������
    $.fn.deleteRow = function(ids) {
        if (this[0].grid) {
            var tb = this[0];
            $(ids).each(function() {
                var self = tb.grid.jQueryEscape(this);
                $('#row' + self, tb).remove();
                //ɾ����Ӧ�ֵ�
                tb.grid.removeRowFromDic(this);
                tb.p.rpoffset--;
            });
            this[0].grid.buildpager();
        }
    };
    //�ж�ָ��Id�����Ƿ����
    $.fn.containsRowId = function(rowid) {
        if (this[0].grid) {
            var grid = this[0].grid;
            return grid.containsRowId(rowid);
        }
        else {
            return false;
        }

    };
    //ΪOptions�����µ�ExtParams
    $.fn.setNewExtParam = function(np) {
        this.each(function() {
            if (this.grid) {
                var op = this.p;
                var $extParam = $(op.extParam);
                var curr;
                $(np).each(function() {
                    var has = false;
                    curr = this;
                    $extParam.each(function() {
                        if (curr.name == this.name) {
                            this.value = curr.value;
                            has = true;
                            return false; //���¸�ֵ������ѭ��
                        }
                    });
                    if (!has) {
                        //�����µ�ֵ
                        op.extParam.push({ name: curr.name, value: curr.value });
                        has = false;
                    }
                });
            }
            $.extend(this.p, op);
        });
    };
    
})(jQuery);
var getObj = function(id) {
	return document.getElementById(id);
};


function loaddata(){
	url = "parklalaanly.do?action=query&qdate="+ getObj('qdate').value +"&btime="+ 
		getObj('btime').value +"&etime="+ getObj('etime').value +"&comid="+comid;
	$.post(url, function(result) {
		hiddlecontent(result);
	});
}


function handleData(data){
	
	for(var i=0;i<data.length;i++){
		if(data[i]==0&&i!=0){
			data[i]=data[i-1];
		}
	}
	return data;
}

function hiddlecontent(result) {
	
	var data1 = new Array();
	var data2 = new Array();
	var data3 = new Array();
	var yAxisTitle = "��λ��";
	var titleText = "��λ�仯����";
	var subtitleText = "";
	xAxisTitle = "ѡ��ʱ��ε���:"+getObj('qdate').value;
	var xAxisCategories = new Array();
	$.each(eval(result), function(i, laladate) {
		if (xAxisCategories[i] == "") {

		} else {
			xAxisCategories[i] = laladate.time;
			data1[i] = parseInt(laladate.total);
			data2[i] = parseInt(laladate.shared);
			data3[i] = parseInt(laladate.used);
		}
	});
	
	data2=handleData(data2);
	
	$(document).ready(
			function() {
				var chart = new Highcharts.Chart( {
					chart : {
						renderTo : "chart_container",
						defaultSeriesType : "line",
						plotBorderColor : "#e0e0e0",
						plotBorderWidth : 1
					//zoomType: "xy" // �Ƿ񼰷Ŵ���
					},
					title : {
						text : titleText,
						style : {
							font : 'bold 16px  ����, sans-serif',
							color : '#000'
						}
					},
					subtitle : {
						text : subtitleText,
						style : {
							font : 'normal 12px  ����, sans-serif',
							color : '#999'
						}
					},
					legend : {
						enabled : true
					},
					xAxis : {
						title : {
							text : xAxisTitle,
							style : {
								font : 'normal 12px ����, sans-serif',
								color : '#000',
								margin : '7px000'
							}
						},
						categories : xAxisCategories,
						labels : {
							rotation : -40, //����ֵ��ʾ����б��
							align : 'right',
							style : {
								font : 'normal 10px Verdana, sans-serif'
						}
					}
				},
				yAxis : {
					min : 0,
					maxPadding : 0,
					title : {
						text : yAxisTitle,
						style : {
							font : 'normal 12px ����, sans-serif',
							color : '#000'
						}
					}
				},
				tooltip : {
					//enabled : true,
					formatter : function() {
						return "<b>" + this.series.name + "</b><br/>"
								+ this.x + ": " + this.y + "��";
					}
				},
				plotOptions : {
					line : {
						dataLabels : {
							enabled : true
						},
						enableMouseTracking : true
					}
				},
				series : [ {
					name : "�ܳ�λ��",
					data : data1
				}, {
					name : "����λ��",
					data : data2
				}, {
					name : "ռ�ó�λ��",
					data : data3
				}]
			});
		});
}
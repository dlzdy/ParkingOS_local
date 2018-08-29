var getObj = function(id) {
	return document.getElementById(id);
};
function setVisiable() {
	// ��ʼ��ʱ��ؼ�

	getObj("rangeSelect").value = "currentMon";
	var rangeV = getObj("rangeSelect").value;
	if (rangeV == 2 || rangeV == 3 || rangeV == 'currentWeek'
			|| rangeV == 'preWeek' || rangeV == 'currentMon'
			|| rangeV == 'preMon' || rangeV == 'currentSeason'
			|| rangeV == 'preSeason' || rangeV == 'currentYear'
			|| rangeV == 'preYear') {
		getObj("seconddateinput").style.display = "";
	} else {
		getObj("seconddateinput").style.display = "none";
	}

	var myDate = new Date();
	var year = myDate.getFullYear();
	var month = myDate.getMonth() + 1;
	if (month < 10) {
		month = "0" + month;
	}
	var firstDay = year + "-" + month + "-01";
	firstDay = firstDay.toString('yyyy-MM-dd');
	getObj("startDateSelect_field").value = firstDay;
	getObj("endDateSelect_field").value = myDate.toString('yyyy-MM-dd');

}
function hiddlecontent(str) {

	var url = "";
	var value = document.getElementById("rangeSelect").value;
	if (str == "currentMon") {
		url = "workImage.do?action=phoneAnalysis&rangeSelect=currentMon&startDateSelect="
				+ getObj('startDateSelect_field').value
				+ "&endDateSelect="
				+ getObj('endDateSelect_field').value;
	} else {

		if (value == 4 || value == 1 || value == 5 || value == "currentDay"
				|| value == "preDay" || value == "currentDay1"
				|| value == "preDay1") {

			url = "workImage.do?action=phoneAnalysis&department_id="
					+ getObj('department_id').value + "&kefu_uin="
					+ getObj('kefu_uin').value + "&startDateSelect="
					+ getObj('startDateSelect_field').value + "&rangeSelect="
					+ getObj('rangeSelect').value;
		} else {

			url = "workImage.do?action=phoneAnalysis&department_id="
					+ getObj('department_id').value + "&kefu_uin="
					+ getObj('kefu_uin').value + "&startDateSelect="
					+ getObj('startDateSelect_field').value + "&endDateSelect="
					+ getObj('endDateSelect_field').value + "&rangeSelect="
					+ getObj('rangeSelect').value;
		}
	}
	$.post(url, function(result) {
		var data1 = new Array();
		var data2 = new Array();
		var data3 = new Array();
		var data4 = new Array();
		var data5 = new Array();
		var data6 = new Array();
		var data7 = new Array();
		var data8 = new Array();

		var xAxisCategories = new Array();
		var yAxisTitle = "�绰��(��)";
		var titleText = "�绰���仯����";
		var subtitleText = "";
		var range = document.getElementById("rangeSelect").value;

		if (range == '4' || range == '1' || range == 'preDay'
				|| range == 'currentDay' || range == 'currentDay1'
				|| range == 'preDay1') {
			xAxisTitle = "ѡ�����е�Сʱ";
		} else if (range == 'preYear' || range == 'currentYear') {
			xAxisTitle = "ѡ��ʱ��ε���";
		} else if (range == '5') {
			xAxisTitle = "ѡ���µ���";
		} else {
			xAxisTitle = "ѡ��ʱ��ε���";
		}
		if (eval(result) == undefined || eval(result) == "") {

		} else {
			$.each(eval(result)[0], function(i, phone) {
				if (xAxisCategories[i] == "") {

				} else {
					xAxisCategories[i] = phone.timeStr;
					data1[i] = phone.phoneTotal;
					data2[i] = phone.freeCallTotal;
					data3[i] = phone.total400;
					data4[i] = phone.comeinPhoneTotal;
					data5[i] = phone.outCallTotal;
					data6[i] = phone.comeinPhoneAbandonedcallTotal
					data7[i] = phone.outcallAbandonedcallTotal;
					data8[i] = phone.ioAbandonedcallTotal;
				}
			});
		}
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
								rotation : -45,
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
							enabled : true,
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
							name : "�ܵ绰��",
							data : data1
						}, {
							name : "��ѵ绰",
							data : data2
						}, {
							name : "400�绰",
							data : data3
						}, {
							name : "ֱ�ߺ���",
							data : data4
						}, {
							name : "����绰",
							data : data5
						}, {
							name : "����δ��ͨ",
							data : data6
						}, {
							name :��"����δ��ͨ",
							data : data7
						}, {
							name : "δ��ͨ����",
							data : data8
						} ]
					});
				});
	});
}
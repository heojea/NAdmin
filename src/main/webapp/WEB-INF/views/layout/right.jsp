<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<c:import url="/view.do?viewName=header&layout=common" />
<c:import url="/view.do?viewName=ready&layout=common" />
<script type="text/javascript">
var carTpList = [];
var xLabel = [];
var yLabel = []; 
var today;
var yesterday;
$(document).ready(function() {
    
    var date = getDate();
    today = date.YYYYMMDD;
    yesterday = date.YESTERDAY;
    
    $("#h_retreive_dy").val(today);
    $("#h_cal_start_dy").val(date.LAST_7_DAY);
    $("#h_cal_end_dy").val(today);
    
    loadCarHourStatList(true);
    loadCar7Days(true);
});

//시간대별 예약건수
function loadCarHourStatList(isLoop) {
    $.ajax({
        type: "POST",
        url: "<c:url value='/zsta/zstam101/carCount.json'/>",
        data: formSerialize("#f_cond"),
        dataType: "json",
        success: function(data) {
            var list = eval(data); 
            var result = [];
            if (list) {
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    result.push([[today+" 0:00AM",item.T0000],[today+" 0:30AM",item.T0030],[today+" 1:00AM",item.T0100],[today+" 1:30AM",item.T0130],[today+" 2:00AM",item.T0200],[today+" 2:30AM",item.T0230],
                                 [today+" 3:00AM",item.T0300],[today+" 3:30AM",item.T0330],[today+" 4:00AM",item.T0400],[today+" 4:30AM",item.T0430],[today+" 5:00AM",item.T0500],[today+" 5:30AM",item.T0530],
                                 [today+" 6:00AM",item.T0600],[today+" 6:30AM",item.T0630],[today+" 7:00AM",item.T0700],[today+" 7:30AM",item.T0730],[today+" 8:00AM",item.T0800],[today+" 8:30AM",item.T0830],
                                 [today+" 9:00AM",item.T0900],[today+" 9:30AM",item.T0930],[today+" 10:00AM",item.T1000],[today+" 10:30AM",item.T1030],[today+" 11:00AM",item.T1100],[today+" 11:30AM",item.T1130],
                                 [today+" 12:00AM",item.T1200],[today+" 12:30AM",item.T1230],[today+" 1:00PM",item.T1300],[today+" 1:30PM",item.T1330],[today+" 2:00PM",item.T1400],[today+" 2:30PM",item.T1430],
                                 [today+" 3:00PM",item.T1500],[today+" 3:30PM",item.T1530],[today+" 4:00PM",item.T1600],[today+" 4:30PM",item.T1630],[today+" 5:00PM",item.T1700],[today+" 5:30PM",item.T1730],
                                 [today+" 6:00PM",item.T1800],[today+" 6:30PM",item.T1830],[today+" 7:00PM",item.T1900],[today+" 7:30PM",item.T1930],[today+" 8:00PM",item.T2000],[today+" 8:30PM",item.T2030],
                                 [today+" 9:00PM",item.T2100],[today+" 9:30PM",item.T2130],[today+" 10:00PM",item.T2200],[today+" 10:30PM",item.T2230],[today+" 11:00PM",item.T2300],[today+" 11:30PM",item.T2330]
                                ]);
                }
            }
            paintCarHourStatChart(result); 
        } 
    });
    
    if (isLoop)
        setTimeout("loadCarHourStatList(true)", 100000);
}

/*
 * 시간대별 예약건수 그래프 그리기
 */
function paintCarHourStatChart(data) {
    $("#car_hour_stat_chart").html("");
    
    $.jqplot("car_hour_stat_chart", data,{
        title: {
            text: "시간대별 예약건수",
            fontFamily:"Dotum",            
            fontSize: "10pt" 
        },
        animate: true,
        axesDefaults: {
            tickRenderer: $.jqplot.CanvasAxisTickRenderer,
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,            
            labelOptions:{            
                fontFamily:"Dotum",            
                fontSize: "10pt"          
            },
            tickOptions: {                 
                fontSize: "10pt",
                angle: -1
            }  
        },
        axes: {
            xaxis: { 
                tickInterval:'1 hours',
                min: today+" 0:00AM",
                max: today+" 11:30PM",
                tickOptions: {
                    formatString: "%#H",
                    angle: 0
                },
                renderer: $.jqplot.DateAxisRenderer,
                label: "시간"
            }, 
            yaxis: { 
                tickOptions: { formatString: "%i" },
                label: "예약건수"}
            },
        highlighter: {
            sizeAdjust: 20,
            show: true,
            fadeTooltip: true
        },     
        cursor: {         
            show: true,
            tooltipLocation: "sw"
        }  
    });
}


// 최근 7일 예약건수
function loadCar7Days(isLoop) {
    var format = "YYYY-MM-DD";
    $.ajax({
        type: "POST",
        url: "<c:url value='/zsta/zstam101/carStatisticsList.json'/>",
        data: formSerialize("#f_cond")+"&format="+encodeURIComponent(format)+"&report_pg_no=1",
        dataType: "json",
        async: false,
        success: function(data) {
            var list = eval(data);
            var arry = [];
            if (list) {
                for (var i = 0; i < list.length; i++) {
                    var item = eval(list[i]);
                    arry.push([item.CAL_DY, item.USE_CNT]);
                }               
            }
            if (list.length == 0) {                
                arry.push([today, 0]);
                arry.push([getCalDate(today,-1), 0]);
                arry.push([getCalDate(today,-2), 0]);
                arry.push([getCalDate(today,-3), 0]);
                arry.push([getCalDate(today,-4), 0]);
                arry.push([getCalDate(today,-5), 0]);
                arry.push([getCalDate(today,-6), 0]);                
            }
            paintCar7DaysChart([arry]);
        } 
    });
    if (isLoop)
        setTimeout("loadCar7Days(true)", 100000);
}

function paintCar7DaysChart(data) {
    $("#car_day_chart").html("");
    
    $.jqplot("car_day_chart", data,{
        title: {
            text: "최근 7일 예약건수",
            fontFamily:"Dotum",            
            fontSize: "10pt" 
        },
        animate: true,
        axesDefaults: {
            tickRenderer: $.jqplot.CanvasAxisTickRenderer,
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,            
            labelOptions:{            
                fontFamily:"Dotum",            
                fontSize: "10pt"          
            },
            tickOptions: {                 
                fontSize: "10pt",
                angle: -1
            }  
        },
        axes: {
            xaxis: { 
                renderer: $.jqplot.DateAxisRenderer, 
                tickOptions: { formatString: "%#m-%#d" },
                label: "일자"
            }, 
            yaxis: { 
                tickOptions: { formatString: "%i" },
                label: "예약건수"}
            },
        highlighter: {
            sizeAdjust: 20,
            show: true,
            fadeTooltip: true
        },     
        cursor: {         
            show: true,
            tooltipLocation: "sw"
        }  
    });
}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">

    <c:import url="/view.do?viewName=location&layout=common" />
        
    <form name="f_cond" id="f_cond" onsubmit="return false">
    <input type="hidden" name="h_retreive_dy" id="h_retreive_dy"/>
    <input type="hidden" name="h_cal_start_dy" id="h_cal_start_dy"/>
    <input type="hidden" name="h_cal_end_dy" id="h_cal_end_dy"/>
    <input type="hidden" name="h_report_tp_cd" id="h_report_tp_cd" value="d"/>
    
    </form>
    
    <div id="car_hour_stat_chart" style="width:1100px;height:280px;clear:both;float:left; margin-bottom:10px;"></div>
    
    <div id="car_day_chart" style="width:1100px;height:280px;float:left"></div>
</div>
</body>
</html>


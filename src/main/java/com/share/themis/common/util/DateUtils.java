package com.share.themis.common.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import com.share.themis.common.map.DataMap;

public class DateUtils {
    
    public static String getDate(java.util.Date date, String format) {
        if (date==null || format == null)
                return "";

        SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.ENGLISH);
        return sdf.format(date);
    }
    
    public static String getCurrentMonth01() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());       
        int field = calendar.getActualMinimum(Calendar.DATE);
        return getDate(new Date(), "yyyyMM")+(field < 10? "0"+field:String.valueOf(field));
    }
    
    public static String getCurrentMonth31() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());       
        return getDate(new Date(), "yyyyMM")+calendar.getActualMaximum(Calendar.DATE);
    }
    
    public static String getCurrentDate(String format) {
        return getDate(new Date(), format);
    }
    
    public static String getCurrentDate() {
        return getDate(new Date(), "yyyyMMdd");
    }
    
    public static String getDate(int day) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DATE, day);
        return getDate(calendar.getTime(), "yyyyMMdd");
    }
    
    public static String getDate(int day, String format) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DATE, day);
        return getDate(calendar.getTime(), format);
    }
    
    /**
     * 다음시간 가져오기
     * h (시간)
     * @return HashMap (aDay, aHour, aMin ,bDay, bHour, bMin)
     */
    public static DataMap getNextHour(int h){
        
        Calendar calendar = Calendar.getInstance();
        
        calendar.add(Calendar.HOUR_OF_DAY, 0);

        String aDay = getDate(calendar.getTime(), "yyyy-MM-dd,HH,mm");
        
        calendar.add(Calendar.HOUR_OF_DAY, h);
        
        String bDay = getDate(calendar.getTime(), "yyyy-MM-dd,HH,mm");
        
        String arrADay[] = aDay.split(",");
        String arrBDay[] = bDay.split(",");
        
        if(Integer.parseInt(arrADay[2]) > 30){
            arrADay[2] = "00";
            arrADay[0] = arrBDay[0];
            arrADay[1] = arrBDay[1];
        }else{
            arrADay[2] = "30";
        }
        
        if(Integer.parseInt(arrBDay[2]) > 30){
            arrBDay[2] = "00";
            calendar.add(Calendar.HOUR_OF_DAY, 1);
            String cDay = getDate(calendar.getTime(), "yyyy-MM-dd,HH,mm");
            String arrCDay[] = cDay.split(",");
            arrBDay[0] = arrCDay[0];
            arrBDay[1] = arrCDay[1];
        }else{
            arrBDay[2] = "30";
        }
        
        DataMap map = new DataMap();
        map.put("aDay", arrADay[0]);
        map.put("aHour", arrADay[1]);
        map.put("aMin", arrADay[2]);
        map.put("day1", arrADay[0]+arrADay[1]+arrADay[2]);
        
        map.put("bDay", arrBDay[0]);
        map.put("bHour", arrBDay[1]);
        map.put("bMin", arrBDay[2]);
        map.put("day2", arrBDay[0]+arrBDay[1]+arrBDay[2]);
        
        return map;
    }
    
    /** 
     * 특정 날짜가 어떤 날짜 구간에 존재하는 가를 검사한다. 
     * 비교할 날짜와 구간을 시작하는 날짜, 구간이 끝나는 날짜는 같은 패턴을 가져야 한다. 
     * 
     * @param startBasis 구간의 시작 날짜 
     * @param endBasis 구간의 끝날짜 
     * @param target 비교할 날짜 
     * @param format 날짜의 형식화 패턴 
     * @return true-구간 사이에 존재한다. (startBasis <= target <= endBasis)이다. 
     * @throws ParseException 각 날짜가 형식화 패턴과 일치하지 않을 때 발생한다. 
     * @author neoburi@nowonplay.com
     * 타겟이 널이면 오늘날자 비교 
     */ 
     public static boolean isBetweenOfStartDateAndEndDate(String startBasis, String endBasis, String target, String format){ 
     DateFormat df = getSimpleDateFormat(format);
     SimpleDateFormat simpleDate = new SimpleDateFormat(format);
     Date date = new Date();
         
     if(target.equals("")) target = simpleDate.format(date);
         
     Date td = parseDate(target, df); 
         
        return parseDate(startBasis, df).getTime() <= td.getTime() && td.getTime() < parseDate(endBasis, df).getTime();
     } 
         
     private static DateFormat getSimpleDateFormat(String format){ 
         return new SimpleDateFormat(format); 
     } 

     private static Date parseDate(String date, DateFormat formatter){
         Date returnVal = null;
         try{
             returnVal = formatter.parse(date); 
         }catch(Exception e){
                 
         }
             
         return returnVal;
     }
     
     public static String getDbDateFormat(String format) {
         if (format == null || format.length() != 14)
             return null;
         return format.substring(0,4)+"-"+format.substring(4,6)+"-"+format.substring(6,8)+" "+format.substring(8,10)+":"+format.substring(10,12)+":"+format.substring(12,14);
     }
}

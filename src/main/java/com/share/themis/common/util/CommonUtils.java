package com.share.themis.common.util;

import java.text.DecimalFormat;

import com.share.themis.common.map.DataMap;

import org.apache.commons.lang3.StringUtils;

public class CommonUtils {

    public static void getTelFormat(DataMap param, String[] tels) {
        if (StringUtils.isNotEmpty(param.getString(tels[1])))
            param.put(tels[1], StringUtils.rightPad(param.getString(tels[1]), 4, ' '));
        if (StringUtils.isNotEmpty(param.getString(tels[2])))
            param.put(tels[2], StringUtils.rightPad(param.getString(tels[2]), 4, ' '));
        if (StringUtils.isNotEmpty(param.getString(tels[3])))
            param.put(tels[3], StringUtils.rightPad(param.getString(tels[3]), 4, ' '));
        param.put(tels[0], param.getString(tels[1])+param.getString(tels[2])+param.getString(tels[3]));
    }
    
    public static String generateKey() {
        DecimalFormat decimalFormat = new DecimalFormat("00");
        return String.valueOf(System.currentTimeMillis()) + decimalFormat.format(Math.random()*99);
    }
    
    /**
     * LPAD
     * @param str 원본 String
     * @param num LPAD 숫자
     * @param join 문자열
     * @return
     */
    public static String lpad(String str, int num, String join){
        
        String returnVal = str;
        String appendVal = "";
        
        if(str.length() >= num) return returnVal;
        
        for(int i=0; i<num-str.length();i++){
            appendVal += join;
        }
        
        returnVal = join+returnVal;
        
        return returnVal;
    }
    
    /**
     * RPAD
     * @param str 원본 String
     * @param num RPAD 숫자
     * @param join 문자열
     * @return
     */
    public static String rpad(String str, int num, String join){
        
        String returnVal = str;
        String appendVal = "";
        
        if(str.length() >= num) return returnVal;
        
        for(int i=0; i<num-str.length();i++){
            appendVal += join;
        }
        
        returnVal = returnVal+join;
        
        return returnVal;
    }
}

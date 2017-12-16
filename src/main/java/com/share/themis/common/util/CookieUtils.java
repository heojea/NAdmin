package com.share.themis.common.util;

import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtils {
    
    public static String getCookieObject(HttpServletRequest request, String cookieName, String replace) {
        String value = getCookieObject(request, cookieName);
        return (value == null || ("null".equals(value)))? replace : value;      
    }
    
    public static String getCookieObject(HttpServletRequest request, String cookieName) {
        String value = null;
        try {
            Cookie [] cookies = request.getCookies();
            
            if (cookies==null) return null;
            for(int i=0;i<cookies.length;i++) {
                
                if(cookieName.equals(cookies[i].getName())) {
                    value = cookies[i].getValue();
                    if ("".equals(value)) value = null;
                        break;
                }
            }
            value = value == null? null : URLDecoder.decode(value, "euc-kr");
        } catch (Exception e) {}

        return value; 
    }   
    
    public static void setCookieObject(HttpServletResponse response,
                                 String name,
                                 String value,
                                 int iMinute) {
        try {
            Cookie cookie = new Cookie(name, URLEncoder.encode(value, "euc-kr"));
            cookie.setMaxAge(60 * iMinute);
            cookie.setPath("/");
            response.addCookie(cookie);
        } catch (Exception e) {}
    }
}

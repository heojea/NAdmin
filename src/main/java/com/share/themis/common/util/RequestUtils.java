package com.share.themis.common.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.share.themis.common.Constants;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;

public class RequestUtils {
    
    @SuppressWarnings("rawtypes")
    public static Map<String, String> getStringParamMap(HttpServletRequest request) {
        Map<String, String> paramMap = new HashMap<String, String>();
        Enumeration names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = (String)names.nextElement();
            paramMap.put(name, request.getParameter(name));
        }
        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        if (loginSession != null) {
            if ("N".equals(loginSession.getSite_auth()))            
                paramMap.put("site_id", (String)request.getAttribute("site_id"));
            paramMap.put("reg_id", loginSession.getAdmin_id());
            paramMap.put("mod_id", loginSession.getAdmin_id());
        }
        return paramMap;
    }
    
    @SuppressWarnings("rawtypes")
    public static DataMap getStringParamDataMap(HttpServletRequest request) {
        DataMap paramMap = new DataMap();
        Enumeration<String> names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = (String)names.nextElement();
            paramMap.put(name, request.getParameter(name));
        }
        
        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        if (loginSession != null) {
            if ("N".equals(loginSession.getSite_auth()))            
                paramMap.put("site_id", request.getAttribute("site_id"));
            	paramMap.put("reg_id", loginSession.getAdmin_id());
            	paramMap.put("mod_id", loginSession.getAdmin_id());
            	paramMap.put("curLogin_id", loginSession.getLogin_id());
        }
        return paramMap;
    }
    
    
    @SuppressWarnings("rawtypes")
    public static DataMap getStringParamDataMapArr(HttpServletRequest request) {
        DataMap paramMap = new DataMap();
        Enumeration<String> names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = (String)names.nextElement();
            if(name.contains("[]")) paramMap.put(name.replace("[]", ""), request.getParameterValues(name));
            else  paramMap.put(name, request.getParameter(name));
        }
        
        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        if (loginSession != null) {
            if ("N".equals(loginSession.getSite_auth()))            
                paramMap.put("site_id", request.getAttribute("site_id"));
            	paramMap.put("reg_id", loginSession.getAdmin_id());
            	paramMap.put("mod_id", loginSession.getAdmin_id());
            	paramMap.put("curLogin_id", loginSession.getLogin_id());
        }
        return paramMap;
    }
}

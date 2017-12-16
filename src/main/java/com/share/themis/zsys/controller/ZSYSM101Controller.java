package com.share.themis.zsys.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.Constants;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.CookieUtils;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.zsys.service.ZSYSM101Service;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ZSYSM101Controller {
    private static final Logger logger = LoggerFactory.getLogger(ZSYSM101Controller.class);
    
    @Autowired
    private ZSYSM101Service zsysm101Service;
    
    /**
     * 로그인 화면
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/zsys/zsysm101/main.do")
    public String main(HttpServletRequest request, Model model) {
    	System.out.println("12222222333");
        model.addAttribute("site_login_id", CookieUtils.getCookieObject(request, "BOS_SITE_LOGIN_ID"));
        model.addAttribute("login_id", CookieUtils.getCookieObject(request, "BOS_LOGIN_ID"));
        return "zsys/zsysm1/zsysm1010";
    }
    
    /**
     * 로그인 처리
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/zsys/zsysm101/login.do", method = RequestMethod.POST)
    public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap map = new DataMap();
        boolean result = true;
        map.put("pwdErr", false);
        map.put("adminTpCdErr", false);
        
        DataMap param = RequestUtils.getStringParamDataMap(request);
        if ("Y".equals(param.getString("save_yn"))) {
            CookieUtils.setCookieObject(response, "BOS_LOGIN_ID", param.getString("login_id"), 60*24*3);
        }
        else {
            CookieUtils.setCookieObject(response, "BOS_LOGIN_ID", "", 60*24*3);
        }
        
        if (StringUtils.isEmpty(param.getString("login_id")) ||
            StringUtils.isEmpty(param.getString("login_pw"))    )
            result = false;
        else
            result = zsysm101Service.login(request, param);
        
        DataMap adminUser = zsysm101Service.selectAdminUser(param);
        
        
        if (adminUser != null){
            if (adminUser.getInt("PWD_ERROR_CNT") > 5) {
                map.put("pwdErr", true);
            }
            if("30".equals(adminUser.getString("ADMIN_TP_CD"))) {
            	map.put("adminTpCdErr", true);
            	result = false;
            }
        }
        
        map.put("result", result);
        
        ResponseUtils.jsonMap(response, map);
    }
    
    /**
     * 법인 로그인 처리
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/zsys/zsysm101/corpLogin.do", method = RequestMethod.POST)
    public void corpLogin(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
    	DataMap map = new DataMap();
    	boolean result = true;
    	map.put("pwdErr", false);
    	map.put("biz_no_err", true);
    	
    	DataMap param = RequestUtils.getStringParamDataMap(request);
    	
    	if("Y".equals(param.getString("save_yn"))) {
    		CookieUtils.setCookieObject(response, "BOS_LOGIN_ID", param.getString("login_id"), 60*24*3);
    	}
    	else {
    		CookieUtils.setCookieObject(response, "BOS_LOGIN_ID", "", 60*24*3);
    	}
    	
    	if(StringUtils.isEmpty(param.getString("login_id")) ||
    	   StringUtils.isEmpty(param.getString("login_pw")) ||
    	   StringUtils.isEmpty(param.getString("biz_no")))
    		result = false;
    	else
    		result = zsysm101Service.corpLogin(request, param);
    	
    	DataMap corpUser = zsysm101Service.selectCorpUser(param);
        
    	if(corpUser != null) {
    		if(corpUser.getInt("PWD_ERROR_CNT") > 5) {
    			map.put("pwdErr", true);
    		}
    	}
    	
    	if(corpUser != null) {
    		if(corpUser.getString("BIZ_NO") != param.put(param.getString("BIZ_NO"), "biz_no")) {
    			map.put("biz_no_err", false);
    		}
    	}
    	
    	map.put("result", result);
    	model.addAttribute("corpUser", corpUser);
    	
    	ResponseUtils.jsonMap(response, map);
    }
    
    /**
     * 로그아웃
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/zsys/zsysm101/logout.do")
    public String logout(HttpServletRequest request, Model model) {
        request.getSession().removeAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        model.addAttribute("site_login_id", CookieUtils.getCookieObject(request, "BOS_SITE_LOGIN_ID"));
        model.addAttribute("login_id", CookieUtils.getCookieObject(request, "BOS_LOGIN_ID"));
        return "zsys/zsysm1/zsysm1010";
    }
}

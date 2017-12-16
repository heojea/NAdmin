package com.share.themis.common.controller;


import java.util.ArrayList;

import java.util.List;
import java.util.Locale;
import java.util.Map;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;


import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.common.property.ConfigurationService;
import com.share.themis.common.service.CommonService;
import com.share.themis.common.util.ConfigUtils;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.common.util.seedCrypt.AES;

@Controller
public class CommonController {

    @Autowired
    private CommonService commonService;
    @Autowired
    private ConfigurationService config;
    
    private Logger logger = LoggerFactory.getLogger("CommandControll");
    
    /**
     * @param request
     * @return
     */
    @RequestMapping(value = "/home")
    public String home(HttpServletRequest request) {
        return "home";
    }
    
    /**
     * @param request
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/view")
    public String view(HttpServletRequest request, Locale locale, Model model) {
        String viewName = request.getParameter("viewName"); 
        String layout = request.getParameter("layout");
        model.addAttribute("param", RequestUtils.getStringParamDataMap(request));
        return layout+"/"+viewName;
    }
    
    
    /**
     * @param request
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/calendar")
    public String calendar(HttpServletRequest request, Locale locale, Model model) {
        model.addAttribute("inputName", request.getParameter("inputName"));
        model.addAttribute("callbackFunc", request.getParameter("callbackFunc"));        
        return "common/calendar";
    }
    
    /**
     * @param request
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/player")
    public String player(HttpServletRequest request, Locale locale, Model model) {
        model.addAttribute("param", RequestUtils.getStringParamDataMap(request));
        return "common/player";
    }
    
    /**
     * @param request
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/controller")
    public String controller(HttpServletRequest request, Locale locale, Model model) {
    	String loginCheck = "N";
        model.addAttribute("param", RequestUtils.getStringParamDataMap(request));
        LoginSession loginSession = LoginSession.getLoginSession((HttpServletRequest)request);
        
        if(loginSession != null){
        	if(loginSession.getLogin_id().indexOf(config.getString("admin.login")) >= 0){
        		loginCheck = "Y";	
        	}else{
        		loginCheck = "N";
        	}
        	
        }      
        System.out.println("aaa : " + loginSession.getLogin_id().indexOf(config.getString("admin.login")));
        
        model.addAttribute("login_check", loginCheck);
        
        return "common/controller";
    }
    

    
    /**
     *  decoder main
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/common/decoder.do")
    public String decoder(HttpServletRequest request, Model model) throws Exception {
    	DataMap param = RequestUtils.getStringParamDataMap(request);
        return "common/decoder";
    }
    
    
    /**
     * decoder Str
     * @param request
     * @param locale
     * @param model                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
     */
    @RequestMapping(value = "/common/decoderStr.json")
    public void decoderStr(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
    	String masterKey = ConfigUtils.getString("encryption.masterKey");
    	String dStr = AES.aesDecode(param.getString("enStr"), masterKey);
	    param.put("dStr", dStr);
	    ResponseUtils.jsonMap(response, param);
	}
    
    /**
     * common Code Str
     * @param request
     * @param locale
     * @param model                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
     */
    @RequestMapping(value = "/common/commonCode.json")
    public void commonCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        List<DataMap> list = new ArrayList<DataMap>();
        list = commonService.selectCommonCode(param);
        ResponseUtils.jsonList(response, list);
	}
}

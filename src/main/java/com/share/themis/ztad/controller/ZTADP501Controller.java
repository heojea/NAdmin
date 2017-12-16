package com.share.themis.ztad.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.Constants;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.common.service.CommonService;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.ztad.service.ZTADM501Service;


import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ZTADP501Controller {
    @Autowired
    private CommonService commonService;
   
    @Autowired
    private ZTADM501Service ztadm501Service;
    
    /**
     * 템플릿발급 팝업 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadp501/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        
        return "ztad/ztadp5/ztadp5010";
    }
    
    /**
     * 템플릿 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadp501/templete.json")
    public void templete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        DataMap templete = ztadm501Service.selectTemplete(param); 
        ResponseUtils.jsonMap(response, templete);
    }
    
}

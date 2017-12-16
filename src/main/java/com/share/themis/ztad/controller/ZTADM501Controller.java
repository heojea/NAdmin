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
public class ZTADM501Controller {
    @Autowired
    private CommonService commonService;
    @Autowired
    private ZTADM501Service ztadm501Service;
    
    /**
     * 템플릿 생성 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm501/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        
        DataMap param = new DataMap();
        param.put("major_cd", "OPR01");
        List<DataMap> templeteTpList = commonService.selectCodeList(param);
        model.addAttribute("templeteTpList", templeteTpList);
        
        return "ztad/ztadm5/ztadm5010";
    }
    
    /**
     * 템플릿 목록 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm501/templeteList.json")
    public void templeteList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        List<DataMap> templeteList = ztadm501Service.selectTempleteList(param); 
        ResponseUtils.jsonList(response, templeteList);
    }
    
    /**
     * 템플릿 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm501/templete.json")
    public void templete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        DataMap templete = ztadm501Service.selectTemplete(param); 
        ResponseUtils.jsonMap(response, templete);
    }
    
    /**
     * 템플릿 정보 갱신
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm501/updateTemplete.json")
    public void updateTemplete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("temp_no")))
            result = false;
        else
            result = ztadm501Service.updateTemplete(param) == 1; 
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 템플릿 등록
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm501/insertTemplete.json")
    public void insertTemplete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("temp_nm")) ||
            StringUtils.isEmpty(param.getString("temp_tp_cd")))
            result = false;
        else
            ztadm501Service.insertTemplete(param); 
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 템플릿 삭제
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm501/deleteTemplete.json")
    public void deleteTemplete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("temp_no")))
            result = false;
        else
            ztadm501Service.deleteTemplete(param); 
        ResponseUtils.jsonBoolean(response, result);
    }
}

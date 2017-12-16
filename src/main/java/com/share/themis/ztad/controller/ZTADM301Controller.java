package com.share.themis.ztad.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.Constants;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.ztad.service.ZTADM301Service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ZTADM301Controller {
    @Autowired
    private ZTADM301Service ztadm301Service;

    /**
     * 코드관리 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        return "ztad/ztadm3/ztadm3010";
    }
    
    /**
     * 코드 마스터 목록 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/majorCodeList.json")
    public void majorCodeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);        
        List<DataMap> majorCodeList = ztadm301Service.selectMajorCodeList(param); 
        ResponseUtils.jsonList(response, majorCodeList);
    }
    
    /**
     * 코드 마스터 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/majorCode.json")
    public void majorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);        
        DataMap majorCode = ztadm301Service.selectMajorCode(param); 
        ResponseUtils.jsonMap(response, majorCode);
    }
    
    /**
     * 코드 상세 목록 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/minorCodeList.json")
    public void minorCodeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);        
        List<DataMap> minorCodeList = ztadm301Service.selectMinorCodeList(param); 
        ResponseUtils.jsonList(response, minorCodeList);
    }
    
    /**
     * 코드 상세 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/minorCode.json")
    public void minorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);        
        DataMap minorCode = ztadm301Service.selectMinorCode(param); 
        ResponseUtils.jsonMap(response, minorCode);
    }
    
    /**
     * 마스터 코드 갱신
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/updateMajorCode.json")
    public void updateMajorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("major_cd")))
            result = false;
        else
            result = ztadm301Service.updateMajorCode(param) == 1; 
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 상세 코드 갱신
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/updateMinorCode.json")
    public void updateMinorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("major_cd")) ||
            StringUtils.isEmpty(param.getString("minor_cd")))
            result = false;
        else
            result = ztadm301Service.updateMinorCode(param) == 1; 
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 마스터 코드 입력
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/insertMajorCode.json")
    public void insertMajorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("cd_grp_nm")))
            result = false;
        else
            ztadm301Service.insertMajorCode(param); 
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 상세 코드 입력
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/insertMinorCode.json")
    public void insertMinorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("major_cd")) ||
            StringUtils.isEmpty(param.getString("cd_nm")))
            result = false;
        else
            ztadm301Service.insertMinorCode(param); 
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 마스터 코드 삭제
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/deleteMajorCode.json")
    public void deleteMajorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("major_cd")))
            result = false;
        else
            ztadm301Service.deleteMajorCode(param); 
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 상세 코드 삭제
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm301/deleteMinorCode.json")
    public void deleteMinorCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("major_cd")) ||
            StringUtils.isEmpty(param.getString("minor_cd")))
            result = false;
        else
            ztadm301Service.deleteMinorCode(param); 
        ResponseUtils.jsonBoolean(response, result);
    }
    
}

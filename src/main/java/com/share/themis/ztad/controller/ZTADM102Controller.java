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
import com.share.themis.ztad.service.ZTADM102Service;
import com.share.themis.ztad.service.ZTADM202Service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ZTADM102Controller {
    @Autowired
    private CommonService commonService;
    @Autowired
    private ZTADM102Service ztadm102Service;
    @Autowired
    private ZTADM202Service ztadm401Service;
    
    /**
     * 관리자 그룹 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm102/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        return "ztad/ztadm1/ztadm1020";
    }
    
    /**
     * 관리자 권한 입력
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm102/insertRole.json", method = RequestMethod.POST)
    public void insertRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        DataMap param = RequestUtils.getStringParamDataMap(request);
        ztadm102Service.insertAdminRole(param);
            
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 관리자 권한 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm102/role.json", method = RequestMethod.POST)
    public void role(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        DataMap role = ztadm102Service.selectAdminRole(param);
        ResponseUtils.jsonMap(response, role);
    }
    
    /**
     * 관리자 권한 삭제
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm102/deleteRole.json", method = RequestMethod.POST)
    public void deleteRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        DataMap param = RequestUtils.getStringParamDataMap(request);
        if (StringUtils.isEmpty(param.getString("role_id")))
            result = false;
        else 
            ztadm102Service.deleteAdminRole(param);
            
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 관리자 권한 갱신
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm102/updateRole.json", method = RequestMethod.POST)
    public void updateRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        DataMap param = RequestUtils.getStringParamDataMap(request);
        if (StringUtils.isEmpty(param.getString("role_id")))
            result = false;
        else 
            result = ztadm102Service.updateAdminRole(param) == 1;
            
        ResponseUtils.jsonBoolean(response, result);
    }
}

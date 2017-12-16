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
import com.share.themis.ztad.service.ZTADM202Service;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ZTADM202Controller {
    
    @Autowired
    private CommonService commonService;
    @Autowired
    private ZTADM202Service ztadm202Service;
    
    /**
     * 메뉴 할당 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm202/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        return "ztad/ztadm2/ztadm2020";
    }
    
    /**
     * 관리자 권한 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm202/roleList.json")
    public void roleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        
        List<DataMap> adminRoleList = ztadm202Service.selectAdminRoleList(param); 
        ResponseUtils.jsonList(response, adminRoleList);
    }
    
    /**
     * 메뉴 리스트 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm202/menuList.json")
    public void menuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        
        List<DataMap> adminRoleList = ztadm202Service.selectMenuRoleList(param); 
        ResponseUtils.jsonList(response, adminRoleList);
    }
    
    @RequestMapping(value = "/ztad/ztadm202/modifyRole.json")
    public void modifyRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
       
        boolean result = true;
        if (StringUtils.isEmpty(param.getString("role_id")))
            result = false;
        else
            ztadm202Service.updateAdminMenuAssign(param);
        ResponseUtils.jsonBoolean(response, result);
    }
    
}

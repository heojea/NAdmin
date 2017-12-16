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
import com.share.themis.ztad.service.ZTADM103Service;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ZTADM103Controller {
    
    @Autowired
    private CommonService commonService;
    @Autowired
    private ZTADM103Service ztadm103Service;
    
    /**
     * 메인화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm103/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        DataMap param = new DataMap();
        param.put("major_cd", "ADM01");
        List<DataMap> adminTpList = commonService.selectCodeList(param);
        model.addAttribute("adminTpList", adminTpList);
        return "ztad/ztadm1/ztadm1030";
    }
    
    /**
     * 관리자 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm103/adminList.json")
    public void adminList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        
        List<DataMap> adminList = ztadm103Service.adminList(param); 
        ResponseUtils.jsonList(response, adminList);
    }
}

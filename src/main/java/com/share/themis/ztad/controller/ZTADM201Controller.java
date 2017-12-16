package com.share.themis.ztad.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.ztad.service.ZTADM201Service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ZTADM201Controller {

    @Autowired
    private ZTADM201Service ztadm201Service;
    
    /**
     * 메뉴 생성 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm201/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        return "ztad/ztadm2/ztadm2010";
    }
    
    /**
     * 메뉴 리스트 화면 (좌측)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm201/menuList.json")
    public void menuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        List<DataMap> menuList = ztadm201Service.selectMenuListAll(param); 
        ResponseUtils.jsonList(response, menuList);
    }
    
    /**
     * MENU 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm201/menu.json")
    public void menu(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        DataMap menu = ztadm201Service.selectMenu(param);
        
        ResponseUtils.jsonMap(response, menu);
    }
    
    /**
     * 하위메뉴 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm201/menuSubList.json")
    public void menuSubList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        List<DataMap> menuList = ztadm201Service.selectMenuList(param); 
        ResponseUtils.jsonList(response, menuList);
    }
    
    /**
     * 메뉴 수정
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm201/updateMenu.json", method = RequestMethod.POST)
    public void updateMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        DataMap param = RequestUtils.getStringParamDataMap(request);
        if (StringUtils.isEmpty(param.getString("menu_id")))
            result = false;
        else 
            result = ztadm201Service.updateMenu(param) == 1;
            
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 메뉴 삭제
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm201/deleteMenu.json", method = RequestMethod.POST)
    public void deleteMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        DataMap param = RequestUtils.getStringParamDataMap(request);
        if (StringUtils.isEmpty(param.getString("menu_id")))
            result = false;
        else 
            ztadm201Service.deleteMenu(param);
            
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 메뉴 추가
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm201/insertMenu.json", method = RequestMethod.POST)
    public void insertMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        DataMap param = RequestUtils.getStringParamDataMap(request);
        if (StringUtils.isEmpty(param.getString("menu_nm")))
            result = false;
        else 
            ztadm201Service.insertMenu(param);
            
        ResponseUtils.jsonBoolean(response, result);
    }

}

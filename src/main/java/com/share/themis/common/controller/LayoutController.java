package com.share.themis.common.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import com.share.themis.common.Constants;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.common.service.CommonService;
import com.share.themis.common.util.RequestUtils;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LayoutController {
    
    @Autowired
    private CommonService commonService;
    
    /**
     * 레이아웃 화면 헤더 화면
     * @param request
     * @param locale
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/layout/header")
    public String header(HttpServletRequest request, Locale locale, Model model) throws Exception {
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);        
        String formattedDate = dateFormat.format(date);        
        model.addAttribute("serverTime", formattedDate );
        
        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        
        DataMap param = new DataMap();
        param.put("admin_id", loginSession.getAdmin_id());
        List<DataMap> menuList = commonService.selectDepth1MenuList(param);
        model.addAttribute("menuList", menuList);
        
        return "layout/header";
    }
    
    /**
     * 레이아웃 좌측 메뉴 화면
     * @param request
     * @param locale
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/layout/left")
    public String left(HttpServletRequest request, Locale locale, Model model) throws Exception {
        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        
        DataMap reqParams = RequestUtils.getStringParamDataMap(request);
        reqParams.put("admin_id", loginSession.getAdmin_id());
        
        DataMap menuDepth1 = new DataMap();
        // 부모 메뉴ID가 없으면 디폴트 1뎁스 메뉴 조회
        if (StringUtils.isEmpty(reqParams.getString("menu_id"))) {
            menuDepth1 = commonService.selectDefaultDepth1Menu(reqParams);
        }
        else {
            DataMap svcParam2 = new DataMap();
            svcParam2.put("admin_id", loginSession.getAdmin_id());
            svcParam2.put("menu_id", reqParams.getString("menu_id"));
            
            // Depth1 메뉴 조회
            menuDepth1 = commonService.selectDefaultDepth1Menu(svcParam2);  
        }
        
        // 메뉴 트리구조 생성
        List<DataMap> menuList = new ArrayList<DataMap>();
        if (menuDepth1 != null) {
            // Depth2 메뉴 조회
            DataMap svcParam3 = new DataMap();
            svcParam3.put("admin_id", loginSession.getAdmin_id());
            svcParam3.put("up_menu_id", menuDepth1.getString("MENU_ID"));
            List<DataMap> menuDepth2List = commonService.selectDepth2MenuList(svcParam3);
            
            // Depth3 메뉴 조회        
            DataMap svcParam1 = new DataMap();
            svcParam1.put("admin_id", loginSession.getAdmin_id());
            List<DataMap> menuDepth3List = commonService.selectDepth3MenuList(svcParam1);
            
            if (menuDepth2List != null && menuDepth3List != null) {
                int depth2Size = menuDepth2List.size();
                int depth3Size = menuDepth3List.size();
                
                //menuDepth1.put("UP_ORDER_SEQ", "1");
                menuList.add(menuDepth1);
                for (int i = 0; i < depth2Size; i++) {
                    DataMap parent = menuDepth2List.get(i);
                    //parent.put("UP_ORDER_SEQ", "1");
                    menuList.add(parent);
                    for (int k = 0; k < depth3Size; k++) {
                        DataMap child = menuDepth3List.get(k);
                        //child.put("UP_ORDER_SEQ", parent.getString("ORDER_SEQ"));
                        if (child.getString("UP_MENU_ID").equals(parent.getString("MENU_ID"))) {
                            menuList.add(child);
                        }
                    }
                }
            }            
        }
        model.addAttribute("menuList", menuList);        
        
        return "layout/left";
    }
}

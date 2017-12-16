package com.share.themis.ztad.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.share.themis.common.map.DataMap;
import com.share.themis.ztad.dao.ZTADM202Dao;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM202Service {

    @Autowired
    private ZTADM202Dao ztadm202Dao;
    
    public List<DataMap> selectAdminRoleList(DataMap param) throws Exception {
        return ztadm202Dao.selectAdminRoleList(param);
    }
    
    public List<DataMap> selectMenuRoleList(DataMap param) throws Exception {
        List<DataMap> menuList = new ArrayList<DataMap>();
        List<DataMap> menuAllList = ztadm202Dao.selectMenuRoleList(param);
        
        for (DataMap depth1Menu : menuAllList) {
            if ("1".equals(depth1Menu.getString("MENU_DEPTH"))) {
                menuList.add(depth1Menu);
            
                for (DataMap depth2Menu : menuAllList) {
                    if ("2".equals(depth2Menu.getString("MENU_DEPTH")) && depth1Menu.getString("MENU_ID").equals(depth2Menu.getString("UP_MENU_ID"))) {
                        menuList.add(depth2Menu);
                    
                        for (DataMap depth3Menu : menuAllList) {
                            if ("3".equals(depth3Menu.getString("MENU_DEPTH")) && depth2Menu.getString("MENU_ID").equals(depth3Menu.getString("UP_MENU_ID"))) {
                                menuList.add(depth3Menu);
                                
                                for (DataMap depth4Menu : menuAllList) {
                                    if ("4".equals(depth4Menu.getString("MENU_DEPTH")) && depth3Menu.getString("MENU_ID").equals(depth4Menu.getString("UP_MENU_ID"))) {
                                        menuList.add(depth4Menu);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return menuList;
    }
    
    public void updateAdminMenuAssign(DataMap param) throws Exception {
        Set<Object> keys = param.keySet();
        Iterator<Object> itor = keys.iterator();
        
        ztadm202Dao.deleteAdminMenuAssign(param);
        
        while (itor.hasNext()) {
            String key = (String)itor.next();
            if (key.indexOf("auth_yn_") > -1) {
                String menu_id = key.substring("auth_yn_".length()); 
                //System.out.println(key +":"+menu_id);   
                String reg_view_divn_cd = param.getString("reg_view_divn_cd_"+menu_id);
                if (StringUtils.isEmpty(reg_view_divn_cd))
                    reg_view_divn_cd = "20";
                
                DataMap p = new DataMap();
                p.put("menu_id", menu_id);
                p.put("role_id", param.getString("role_id"));
                p.put("reg_view_divn_cd", reg_view_divn_cd);
                p.put("reg_id", param.getString("reg_id"));
                p.put("mod_id", param.getString("mod_id"));                
                ztadm202Dao.insertAdminMenuAssign(p);
            }
        }
    }
}

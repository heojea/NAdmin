package com.share.themis.ztad.service;

import java.util.ArrayList;
import java.util.List;

import com.share.themis.common.map.DataMap;
import com.share.themis.ztad.dao.ZTADM201Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM201Service {
    @Autowired
    private ZTADM201Dao ztadm201Dao;    
    
    public List<DataMap> selectMenuListAll(DataMap param) throws Exception {
        List<DataMap> menuList = new ArrayList<DataMap>();
        List<DataMap> menuAllList = ztadm201Dao.selectMenuList(param);
        
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
    
    public List<DataMap> selectMenuList(DataMap param) throws Exception {        
        return ztadm201Dao.selectMenuList(param);
    }
    
    public DataMap selectMenu(DataMap param) throws Exception {
        return ztadm201Dao.selectMenu(param);
    }
    
    public int updateMenu(DataMap param) throws Exception {
        System.out.println(param);
        return ztadm201Dao.updateMenu(param);
    }
    
    public void deleteMenu(DataMap param) throws Exception {
        ztadm201Dao.deleteMenu(param);
    }
    
    public void insertMenu(DataMap param) throws Exception {
        DataMap daoParam = new DataMap();
        daoParam.put("menu_id", param.getString("up_menu_id"));
        DataMap menu = ztadm201Dao.selectMenu(daoParam);
        
        param.put("menu_id", System.currentTimeMillis());
        param.put("leaf_menu_yn", menu.getInt("MENU_DEPTH")+1 == 3 || menu.getInt("MENU_DEPTH")+1 == 4 ? "Y":"N");
        param.put("menu_yn", menu.getInt("MENU_DEPTH")+1 == 4? "N":"Y");
        param.put("menu_depth", menu.getInt("MENU_DEPTH")+1);
        param.put("url", "#");
        
        ztadm201Dao.insertMenu(param);
    }
}

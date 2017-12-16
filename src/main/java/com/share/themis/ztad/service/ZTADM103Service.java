package com.share.themis.ztad.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.share.themis.common.map.DataMap;
import com.share.themis.ztad.dao.ZTADM103Dao;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM103Service {

    @Autowired
    private ZTADM103Dao ztadm103Dao;
    
    public List<DataMap> adminList(DataMap param) throws Exception {
        return ztadm103Dao.adminList(param);
    }
    
    public List<DataMap> adminComplexAssignList(DataMap param) throws Exception {
        return ztadm103Dao.adminComplexAssignList(param);
    }
    
    public void modifyAdminComplexAssign(DataMap param) throws Exception {
        Set<Object> keys = param.keySet();
        Iterator<Object> itor = keys.iterator();
        
        ztadm103Dao.deleteAdminComplexAssign(param);
        
        while (itor.hasNext()) {
            String key = (String)itor.next();
            if (key.indexOf("auth_yn_") > -1) {
                String complex_data = key.substring("auth_yn_".length()); 
                DataMap p = new DataMap();
                p.put("sido_cd", complex_data.substring(0,2));
                p.put("complex_cd", complex_data.substring(2));
                p.put("admin_id", param.getString("admin_id"));
                p.put("reg_id", param.getString("reg_id"));
                p.put("mod_id", param.getString("mod_id"));                
                ztadm103Dao.insertAdminComplexAssign(p);
            }
        }
    }
    
    // 단지 매핑 여부 체크
    public String selectAdminComplexAssignCnt(DataMap param) throws Exception {
    	return ztadm103Dao.selectAdminComplexAssignCnt(param);
    }
}

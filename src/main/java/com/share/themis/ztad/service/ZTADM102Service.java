package com.share.themis.ztad.service;

import com.share.themis.common.map.DataMap;
import com.share.themis.ztad.dao.ZTADM102Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM102Service {
    @Autowired
    private ZTADM102Dao ztadm102Dao;
    
    public void insertAdminRole(DataMap param) throws Exception {
        param.put("role_id", System.currentTimeMillis());
        ztadm102Dao.insertAdminRole(param);
    }
    
    public DataMap selectAdminRole(DataMap param) throws Exception {
        return ztadm102Dao.selectAdminRole(param);
    }
    
    public int updateAdminRole(DataMap param) throws Exception {
        return ztadm102Dao.updateAdminRole(param);
    }
    
    public void deleteAdminRole(DataMap param) throws Exception {
        ztadm102Dao.deleteAdminRole(param);
    }
}

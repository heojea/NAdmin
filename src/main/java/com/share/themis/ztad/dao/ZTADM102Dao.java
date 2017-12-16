package com.share.themis.ztad.dao;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM102Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate; 
    //private SqlMapClient sqlMapClient;
    
    public void insertAdminRole(DataMap param) throws Exception {
    	sqlTemplate.insert("ztadm102.insertAdminRole", param);
    }
    
    public DataMap selectAdminRole(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("ztadm102.selectAdminRole", param);
    }
    
    public int updateAdminRole(DataMap param) throws Exception {
        return sqlTemplate.update("ztadm102.updateAdminRole", param);
    }
    
    public void deleteAdminRole(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm102.deleteAdminRole", param);
    	sqlTemplate.delete("ztadm102.deleteAdminMenuAssign", param);
    	sqlTemplate.delete("ztadm102.deleteAdminRoleAssign", param);
    }
}

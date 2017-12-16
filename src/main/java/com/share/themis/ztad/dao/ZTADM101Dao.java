package com.share.themis.ztad.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM101Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate; 
    //private SqlMapClient sqlMapClient;
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectAdminList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm101.selectAdminList", param);
    }
    
    public DataMap selectAdmin(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("ztadm101.selectAdminList", param);
    }
    
    public void insertAdmin(DataMap param) throws Exception {        
    	sqlTemplate.insert("ztadm101.insertAdmin", param);
    }
    
    public void insertAdminRoleAssign(DataMap param) throws Exception {
    	sqlTemplate.insert("ztadm101.insertAdminRoleAssign", param);
    }
    
    public int updateAdmin(DataMap param) throws Exception {        
        return sqlTemplate.update("ztadm101.updateAdmin", param);
    }
    
    public void deleteAdmin(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm101.deleteAdmin", param);
    	sqlTemplate.delete("ztadm101.deleteAdminRoleAssign", param);
    }
    
    public void deleteAdminRoleAssign(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm101.deleteAdminRoleAssign", param);
    }
}

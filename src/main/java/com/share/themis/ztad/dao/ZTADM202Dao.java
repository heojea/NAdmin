package com.share.themis.ztad.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM202Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate;
    //private SqlMapClient sqlMapClient;
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectAdminRoleList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm202.selectAdminRoleList", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectMenuRoleList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm202.selectMenuRoleList", param);
    }
    
    public void insertAdminMenuAssign(DataMap param) throws Exception {
    	sqlTemplate.insert("ztadm202.insertAdminMenuAssign", param);
    }
    
    public void deleteAdminMenuAssign(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm202.deleteAdminMenuAssign", param);
    }
}

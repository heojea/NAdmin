package com.share.themis.ztad.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM103Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate;
    //private SqlMapClient sqlMapClient;
    
    @SuppressWarnings("unchecked")
    public List<DataMap> adminList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm103.adminList", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<DataMap> adminComplexAssignList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm103.adminComplexAssignList", param);
    }
    
    public void insertAdminComplexAssign(DataMap param) throws Exception {
    	sqlTemplate.insert("ztadm103.insertAdminComplexAssign", param);
    }
    
    public void deleteAdminComplexAssign(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm103.deleteAdminComplexAssign", param);
    }
    
    // 단지 매핑 여부 체크
    public String selectAdminComplexAssignCnt(DataMap param) throws Exception {
        return (String)sqlTemplate.queryForObject("ztadm103.selectAdminComplexAssignCnt", param);
    }
}

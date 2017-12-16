package com.share.themis.zsys.dao;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZSYSM101Dao {
    @Autowired
	private SqlMapClientTemplate sqlTemplate; 
    //private SqlMapClient sqlMapClient;
    
    public DataMap selectAdminUser(DataMap dataMap) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("zsysm101.selectAdminUser", dataMap);
    }
    
    public DataMap selectCorpUser(DataMap dataMap) throws Exception {
    	return (DataMap)sqlTemplate.queryForObject("zsysm101.selectCorpUser", dataMap);
    }
    
    public DataMap selectAuth(DataMap dataMap) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("zsysm101.selectAuth", dataMap);
    }

    public void insertSadLoginHis(DataMap adminUser) throws Exception {
    	sqlTemplate.insert("zsysm101.insertSadLoginHis", adminUser);
    }

    public void updateAdminUserPwdErrorDy(DataMap dataMap) throws Exception {
    	sqlTemplate.update("zsysm101.updateAdminUserPwdErrorDy", dataMap);
    }

    public int updateAdminUserPwdErrorCnt(DataMap param) throws Exception {
        return sqlTemplate.update("zsysm101.updateAdminUserPwdErrorCnt", param);
    }
} 

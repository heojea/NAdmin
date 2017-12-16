package com.share.themis.zsys.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZSYSP201Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate;  
    //private SqlMapClient sqlMapClient;
    
    public List<DataMap> selectZipList(DataMap dataMap) throws Exception {
        return (List<DataMap>) sqlTemplate.queryForList("zsysp201.selectZipList", dataMap);
    }

    public List<DataMap> selectSidoList() throws Exception {
        return (List<DataMap>) sqlTemplate.queryForList("zsysp201.selectSidoList");
    }

    public List<DataMap> selectGugunList(DataMap param) throws Exception {
        return (List<DataMap>) sqlTemplate.queryForList("zsysp201.selectGugunList", param);
    }
    
   
} 

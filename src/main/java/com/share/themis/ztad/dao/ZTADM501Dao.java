package com.share.themis.ztad.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM501Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate;
    //private SqlMapClient sqlMapClient;
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectTempleteList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm501.selectTempleteList", param);
    }
    
    public DataMap selectTemplete(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("ztadm501.selectTemplete", param);
    }
    
    public void insertTemplete(DataMap param) throws Exception {        
    	sqlTemplate.insert("ztadm501.insertTemplete", param);
    }
    
    public int updateTemplete(DataMap param) throws Exception {        
        return sqlTemplate.update("ztadm501.updateTemplete", param);
    }
    
    public void deleteTemplete(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm501.deleteTemplete", param);
    }
}

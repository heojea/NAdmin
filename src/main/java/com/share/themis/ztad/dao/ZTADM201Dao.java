package com.share.themis.ztad.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM201Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate;
    //private SqlMapClient sqlMapClient;

    @SuppressWarnings("unchecked")
    public List<DataMap> selectMenuList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm201.selectMenuList", param);
    }
    
    public DataMap selectMenu(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("ztadm201.selectMenu", param);
    }
    
    public int updateMenu(DataMap param) throws Exception {
        return sqlTemplate.update("ztadm201.updateMenu", param);
    }
    
    public void deleteMenu(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm201.deleteMenu", param);
    	sqlTemplate.delete("ztadm201.deleteMenuAssign", param);
    }
    
    public void insertMenu(DataMap param) throws Exception {
    	sqlTemplate.insert("ztadm201.insertMenu", param);
    }
}


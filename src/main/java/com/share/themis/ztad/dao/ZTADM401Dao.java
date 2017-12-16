package com.share.themis.ztad.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM401Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate;
    //private SqlMapClient sqlMapClient;
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectBoardList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm401.selectBoardList", param);
    }
    
    public DataMap selectBoard(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("ztadm401.selectBoard", param);
    }
    
    public void insertBoard(DataMap param) throws Exception {        
    	sqlTemplate.insert("ztadm401.insertBoard", param);
    }
    
    public int updateBoard(DataMap param) throws Exception {        
        return sqlTemplate.update("ztadm401.updateBoard", param);
    }
    
    public int deleteBoard(DataMap param) throws Exception {
        return sqlTemplate.delete("ztadm401.deleteBoard", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectCategoryList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm401.selectCategoryList", param);
    }
    
    public void insertCategory(DataMap param) throws Exception {        
    	sqlTemplate.insert("ztadm401.insertCategory", param);
    }
    
    public int updateCategory(DataMap param) throws Exception {        
        return sqlTemplate.update("ztadm401.updateCategory", param);
    }
    
    public void deleteCategory(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm401.deleteCategory", param);
    }
}

package com.share.themis.ztad.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class ZTADM301Dao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate;
    //private SqlMapClient sqlMapClient;
    
    public void insertMajorCode(DataMap param) throws Exception {
    	sqlTemplate.insert("ztadm301.insertMajorCode", param);
    }
    
    public void insertMinorCode(DataMap param) throws Exception {
    	sqlTemplate.insert("ztadm301.insertMinorCode", param);
    }
    
    public int updateMajorCode(DataMap param) throws Exception {
        return sqlTemplate.update("ztadm301.updateMajorCode", param);
    }
    
    public int updateMinorCode(DataMap param) throws Exception {
        return sqlTemplate.update("ztadm301.updateMinorCode", param);
    }
    
    public void deleteMajorCode(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm301.deleteMajorCode", param);
    	sqlTemplate.delete("ztadm301.deleteMinorCode", param);
    }
    
    public void deleteMinorCode(DataMap param) throws Exception {
    	sqlTemplate.delete("ztadm301.deleteMinorCode", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectMajorCodeList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm301.selectMajorCodeList", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectMinorCodeList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("ztadm301.selectMinorCodeList", param);
    }
}

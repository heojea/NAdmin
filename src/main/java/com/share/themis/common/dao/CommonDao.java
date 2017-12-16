package com.share.themis.common.dao;

import java.util.List;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.property.ConfigurationService;
import com.share.themis.common.util.ConfigUtils;
import com.share.themis.common.util.seedCrypt.AES;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDao {
    @Autowired
    private SqlMapClientTemplate sqlTemplate; 
    //private SqlMapClient sqlMapClient;
    
    @Autowired
    private ConfigurationService config;

    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectMenuList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("common.selectMenuList", param);
    }
    
    public DataMap selectDefaultMenu(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("common.selectMenuList", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectCodeList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("common.selectCodeList", param);
    }

    @SuppressWarnings("unchecked")
    public List<DataMap> selectHeraCodeList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("common.selectHeraCodeList", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<DataMap> selectSiteList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("common.selectSiteList", param);
    }
    
    public DataMap selectDate(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("common.selectDate", param);
    }
    
    /**
     * 시도리스트 조회
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<DataMap> selectSidoList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("common.selectSidoList", param);
    }
    
    /**
     * 구군리스트 조회
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<DataMap> selectGugunList(DataMap param) throws Exception {
        return (List<DataMap>)sqlTemplate.queryForList("common.selectGugunList", param);
    }
    
    public String selectTemplete(String temp_no) throws Exception {
        return (String)sqlTemplate.queryForObject("common.selectTemplete", temp_no);
    }
    
    /**
     * commonCode 
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<DataMap> selectCommonCode(DataMap param) throws Exception {
    	return (List<DataMap>)sqlTemplate.queryForList("common.selectCommonCodeList" , param);
    }
	
}

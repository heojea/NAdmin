package com.share.closeAccount.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.event.RowHandler;
import com.share.themis.common.map.DataMap;

@Repository
public class MobileCloseAccountDao {
	
	@Autowired
	SqlMapClientTemplate sqlTemplate_mcp;
	
	@SuppressWarnings("unchecked")
	public List<DataMap> selectMobileCloseDaoList(DataMap param) throws Exception{
	   	 return (List<DataMap>) sqlTemplate_mcp.queryForList("close.selectMobileCloseDaoList", param);
	}
	
	public DataMap selectMobileCloseDaoListCnt(DataMap param) throws Exception{
	   	 return (DataMap) sqlTemplate_mcp.queryForObject("close.selectMobileCloseDaoListCnt", param);
	}
	
	@SuppressWarnings("unchecked")
	public void selectMobileCloseDaoListBigData(DataMap param ,  RowHandler handler) throws Exception{
	    sqlTemplate_mcp.queryWithRowHandler("close.selectMobileCloseDaoList", param ,handler);
	}
	
}

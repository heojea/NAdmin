package com.share.closeAccount.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.event.RowHandler;
import com.share.themis.common.map.DataMap;

@Repository
public class CashCardDao {
	@Autowired
	SqlMapClientTemplate sqlTemplate_mcp;
	
	@SuppressWarnings("unchecked")
	public List<DataMap> selectCashCardDaoList(DataMap param) throws Exception{
	   	 return (List<DataMap>) sqlTemplate_mcp.queryForList("close.selectCashCardDaoList", param);
	}
	
	public DataMap selectCashCardDaoListCnt(DataMap param) throws Exception{
	   	 return (DataMap) sqlTemplate_mcp.queryForObject("close.selectCashCardDaoListCnt", param);
	}
	
	@SuppressWarnings("unchecked")
	public void selectCashCardDaoListBigData(DataMap param ,  RowHandler handler) throws Exception{
	    sqlTemplate_mcp.queryWithRowHandler("close.selectCashCardDaoList", param ,handler);
	}
	
}

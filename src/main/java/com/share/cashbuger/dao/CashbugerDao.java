package com.share.cashbuger.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;
import com.share.themis.common.map.DataMap;

@Repository
public class CashbugerDao {
	
	@Autowired
	SqlMapClientTemplate sqlTemplate_mcp;
	
	@SuppressWarnings("unchecked")
	public List<DataMap> selectpaymentAccountDaoList(DataMap param) throws Exception{
	   	 return (List<DataMap>) sqlTemplate_mcp.queryForList("account100.selectpaymentAccountDaoList", param);
	}
	
	public DataMap selectpaymentAccountDaoListCnt(DataMap param) throws Exception{
	   	 return (DataMap) sqlTemplate_mcp.queryForObject("account100.selectpaymentAccountDaoListCnt", param);
	}
	

	public List<DataMap>  selectAgentDaoList(DataMap param) throws Exception{
		return (List<DataMap>) sqlTemplate_mcp.queryForList("account100.selectAgentDaoList", param);
	}
	
	public DataMap selectAgentDaoListCnt(DataMap param) throws Exception{
	   	 return (DataMap) sqlTemplate_mcp.queryForObject("account100.selectAgentDaoListCnt", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<DataMap> selectGiftCardDaoList(DataMap param) throws Exception{
	   	 return (List<DataMap>) sqlTemplate_mcp.queryForList("account100.selectGiftCardDaoList", param);
	}
	
	public DataMap selectGiftCardDaoListCnt(DataMap param) throws Exception{
	   	 return (DataMap) sqlTemplate_mcp.queryForObject("account100.selectGiftCardDaoListCnt", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<DataMap> selectPayComCdAjaxCallJson(DataMap param) throws Exception{
	   	 return (List<DataMap>) sqlTemplate_mcp.queryForList("account100.selectPayComCdAjaxCallList", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<DataMap> selectProdNmAjaxCallJson(DataMap param) throws Exception{
	   	 return (List<DataMap>) sqlTemplate_mcp.queryForList("account100.selectProdNmAjaxCallList", param);
	}
	
	
}

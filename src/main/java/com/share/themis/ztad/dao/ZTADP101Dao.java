package com.share.themis.ztad.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.share.themis.common.map.DataMap;

@Repository
public class ZTADP101Dao {
	
	@Autowired
	private SqlMapClientTemplate sqlTemplate;
    //private SqlMapClient sqlMapClient;
	
	/**
	 * 현재 비밀번호 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public DataMap selectSadUserPwd(DataMap param) throws Exception {
        return (DataMap)sqlTemplate.queryForObject("ztadp101.selectSadUserPwd", param);
    }
	
	/**
	 * 비밀번호 변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void updateSadUserPwd(DataMap param) throws Exception {        
		sqlTemplate.update("ztadp101.updateSadUserPwd", param);
    }
	
}

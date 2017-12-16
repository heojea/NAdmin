package com.share.themis.ztad.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.share.themis.common.map.DataMap;
import com.share.themis.ztad.dao.ZTADP101Dao;

@Service
public class ZTADP101Service {
	
	@Autowired
    private ZTADP101Dao ztadp101Dao;
	
	/**
	 * 현재 비밀번호 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public DataMap selectSadUserPwd(DataMap param) throws Exception {
		return ztadp101Dao.selectSadUserPwd(param);
	}
	
	/**
	 * 비밀번호 변경
	 * @param param
	 * @throws Exception
	 */
	public void updateSadUserPwd(DataMap param) throws Exception {
		ztadp101Dao.updateSadUserPwd(param);
	}
	
}

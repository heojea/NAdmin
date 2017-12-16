package com.share.closeAccount.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ibatis.sqlmap.client.event.RowHandler;
import com.share.closeAccount.dao.CashCardDao;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;

@Service
public class CashCardService {
    @Autowired    private CashCardDao cashCardDao  ;

    /**
     * 신용카드 선불 정산 service
     * @param request
     * @return
     * @throws Exception
     */
	public DataMap selectCashCardJson(HttpServletRequest request) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		List<DataMap> list    = new ArrayList<DataMap>();
		DataMap       dataMap = new DataMap();
		
		
		int page = param.getInt("page");
		if (page == 0)	page = 1;
		
		int cpp = param.getInt("cpp");
		if (cpp == 0)cpp = 10;
		
		param.put("cpp", cpp);
		param.put("startNum", (page - 1) * cpp);
		param.put("endNum", ((page - 1) * cpp) + cpp );
		param.put("page", page);
		
		dataMap = cashCardDao.selectCashCardDaoListCnt(param);
		int totalCnt = dataMap.getInt("TOT_CNT");
		
		param.put("totalCnt",totalCnt);
		
        list.add(dataMap);
		list.addAll(cashCardDao.selectCashCardDaoList(param));
		
		param.put("list",list);
		
        return param;
    }
	
	/**
	 * hsm Excel process
	 * @param param
	 * @param handler
	 * @throws Exception
	 */
	public void selectCashCardBigData(DataMap param ,  RowHandler handler) throws Exception{
		cashCardDao.selectCashCardDaoListBigData(param, handler);
	}
	
	/**
	 * hsm Excel process
	 * @param param
	 * @param handler
	 * @throws Exception
	 */
	public DataMap selectCashCardBigDataCnt(HttpServletRequest request) throws Exception{
		DataMap param = RequestUtils.getStringParamDataMap(request);
		param = cashCardDao.selectCashCardDaoListCnt(param);
		return param;
	}
}


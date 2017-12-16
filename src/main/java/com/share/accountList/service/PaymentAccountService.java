package com.share.accountList.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.share.accountList.dao.PaymentAccountDao;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;

@Service
public class PaymentAccountService {
    @Autowired    private PaymentAccountDao paymentAccountDao  ;

    /**
     * corpTmoney service logic
     * @param request
     * @return
     * @throws Exception
     */
	public DataMap selectPaymentAccountJson(HttpServletRequest request) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		List<DataMap> list    = new ArrayList<DataMap>();
		DataMap       dataMap = new DataMap();
		
		System.out.println(param.toString() + "<<<<<<< parma");
		
		int page = param.getInt("page");
		if (page == 0)	page = 1;
		
		int cpp = param.getInt("cpp");
		if (cpp == 0)cpp = 10;
		
		param.put("cpp", cpp);
		param.put("startNum", (page - 1) * cpp);
		param.put("endNum", ((page - 1) * cpp) + cpp );
		param.put("page", page);
		
		dataMap = paymentAccountDao.selectpaymentAccountDaoListCnt(param);
		int totalCnt = dataMap.getInt("TOT_CNT");
		
		param.put("totalCnt",totalCnt);
		
        list.add(dataMap);
		list.addAll(paymentAccountDao.selectpaymentAccountDaoList(param));
		
		param.put("list",list);
		
        return param;
    }
	
	   /**
     * corpTmoney service logic
     * @param request
     * @return
     * @throws Exception
     */
	public DataMap selectAgent(HttpServletRequest request) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		List<DataMap> list    = new ArrayList<DataMap>();
		DataMap       dataMap = new DataMap();
		
		System.out.println(param.toString() + "<<<<<<< parma");
		
		int page = param.getInt("page");
		if (page == 0)	page = 1;
		
		int cpp = param.getInt("cpp");
		if (cpp == 0)cpp = 10;
		
		param.put("cpp", cpp);
		param.put("startNum", (page - 1) * cpp);
		param.put("endNum", ((page - 1) * cpp) + cpp );
		param.put("page", page);
		
		dataMap = paymentAccountDao.selectAgentDaoListCnt(param);
		int totalCnt = dataMap.getInt("TOT_CNT");
		
		param.put("totalCnt",totalCnt);
		
        list.add(dataMap);
		list.addAll(paymentAccountDao.selectAgentDaoList(param));
		
		param.put("list",list);
		
        return param;
    }
	
	/**
     * giftCard selectPayComCdAjaxCallJson logic
     * @param request
     * @return
     * @throws Exception
     */
	public DataMap selectPayComCdAjaxCallJson(HttpServletRequest request) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		List<DataMap> list    = new ArrayList<DataMap>();
		DataMap       dataMap = new DataMap();
		list.addAll(paymentAccountDao.selectPayComCdAjaxCallJson(param));
		param.put("list",list);
        return param;
    }
	
	/**
     * giftCard selectprodNmAjaxCallJson logic
     * @param request
     * @return
     * @throws Exception
     */
	public DataMap selectProdNmAjaxCallJson(HttpServletRequest request) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		List<DataMap> list    = new ArrayList<DataMap>();
		DataMap       dataMap = new DataMap();
		list.addAll(paymentAccountDao.selectProdNmAjaxCallJson(param));
		param.put("list",list);
        return param;
    }
	
	
	
	/**
     * giftCard service logic
     * @param request
     * @return
     * @throws Exception
     */
	public DataMap selectGiftCardJson(HttpServletRequest request) throws Exception {
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
		
		//dataMap = paymentAccountDao.selectGiftCardDaoListCnt(param);
		//int totalCnt = dataMap.getInt("TOT_CNT");
		//param.put("totalCnt",totalCnt);
		
        list.add(dataMap);
		list.addAll(paymentAccountDao.selectGiftCardDaoList(param));
		
		param.put("list",list);
		
        return param;
    }
	
	
}


package com.share.accountList.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.share.accountList.excelTemplete.GiftCardExcelTemple;
import com.share.accountList.excelTemplete.PaymentAccountExcelTemple;
import com.share.accountList.service.PaymentAccountService;

import com.share.common.excelUtil.ExcelUtil;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;

@Controller
@RequestMapping(value = "/account")
public class PaymentAccountController {

	@Autowired
	PaymentAccountService paymentAccountService;

	/**
	 * @desc : payment move
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "payment.do")
	public String payment(HttpServletRequest request, Model model)
			throws Exception {
		
		
		DataMap param = RequestUtils.getStringParamDataMap(request);
		return "account/payment";
	}

	/**
	 * @desc : payment data select 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "payment.json")
	public void paymentJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		DataMap returnMap = new DataMap();
		returnMap = paymentAccountService.selectPaymentAccountJson(request);
		
		ResponseUtils.jsonListPaging(response ,(List<DataMap>) returnMap.get("list") , (Integer)returnMap.getInt("page")  ,returnMap.getInt("cpp")  , returnMap.getInt("totalCnt") );
	}
	
	/**
	 * @desc : payment execl print
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "paymentExcel.do")
	public ModelAndView paymentExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		List<DataMap> list = new ArrayList<DataMap>();
		DataMap headMap = new DataMap();
		returnMap = paymentAccountService.selectPaymentAccountJson(request);
		headMap = ((List<DataMap>)returnMap.get("list")).get(0);
		((List<DataMap>)returnMap.get("list")).remove(0);
		
		list = (List<DataMap>) returnMap.get("list");
		
		//sheet1 make
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.executeOne(excelUtil, "sheet1", new PaymentAccountExcelTemple(), headMap, list);
		excelUtil.executeEnd();
		
        return new ModelAndView("excelTempleLoad/ExlDownLoad", "FILE_NAME", excelUtil._targetFile.getPath());
	}
	
	@RequestMapping(value = "agent.do")
	public String agent(HttpServletRequest request, Model model)
			throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		return "common/popup/commonAgent";
	}
	
	/**
	 * @desc : payment data select 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "agent.json")
	public void agentJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		returnMap = paymentAccountService.selectAgent(request);
		ResponseUtils.jsonListPaging(response ,(List<DataMap>) returnMap.get("list") , (Integer)returnMap.getInt("page")  ,returnMap.getInt("cpp")  , returnMap.getInt("totalCnt") );
	}
	
	/**
	 * @desc : giftCard payComCdAjaxCall select ajax 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "payComCdAjaxCall.json")
	public void payComCdAjaxCall(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		returnMap = paymentAccountService.selectPayComCdAjaxCallJson(request);
		ResponseUtils.jsonList(response ,(List<DataMap>) returnMap.get("list"));
	}

	/**
	 * @desc : giftCard prodNmAjaxCall select ajax 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "prodNmAjaxCall.json")
	public void prodNmAjaxCall(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		returnMap = paymentAccountService.selectProdNmAjaxCallJson(request);
		ResponseUtils.jsonList(response ,(List<DataMap>) returnMap.get("list"));
	}
	
	/**
	 * @desc : giftCard move
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value = "giftCard.do")
	public String giftCard(HttpServletRequest request, Model model)
			throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		return "account/giftCard";
	}
	
	/**
	 * @desc : giftCard data select 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "giftCard.json")
	public void giftCardJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		returnMap = paymentAccountService.selectGiftCardJson(request);
		ResponseUtils.jsonListPaging(response ,(List<DataMap>) returnMap.get("list") , (Integer)returnMap.getInt("page")  ,returnMap.getInt("cpp")  , returnMap.getInt("totalCnt") );
	}
	
	/**
	 * @desc : giftCard execl print
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "giftCardExcel.do")
	public ModelAndView giftCardExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		List<DataMap> list = new ArrayList<DataMap>();
		DataMap headMap = new DataMap();
		returnMap = paymentAccountService.selectGiftCardJson(request);
		headMap = ((List<DataMap>)returnMap.get("list")).get(0);
		((List<DataMap>)returnMap.get("list")).remove(0);
		
		list = (List<DataMap>) returnMap.get("list");
		
		//sheet1 make
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.executeOne(excelUtil, "sheet1",  new GiftCardExcelTemple() , headMap, list);
		excelUtil.executeEnd();
        
        return new ModelAndView("excelTempleLoad/ExlDownLoad", "FILE_NAME", excelUtil._targetFile.getPath());
	}
}

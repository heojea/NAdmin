package com.share.cashbuger.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.share.accountList.excelTemplete.PaymentAccountExcelTemple;
import com.share.common.excelUtil.ExcelUtil;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.cashbuger.service.CashbugerService;

@Controller
@RequestMapping(value = "/cash")
public class CashbugerController {
	@Autowired	CashbugerService cashbugerService;

	/**
	 * @desc : payment move
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "cashbuger.do")
	public String payment(HttpServletRequest request, Model model) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		return "cash/cashbuger";
	}
   
	/**
	 * @desc : payment data select 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "cashbuger.json")
	public void paymentJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		returnMap = cashbugerService.selectPaymentAccountJson(request);
		
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
	@RequestMapping(value = "cashbugerExcel.do")
	public ModelAndView paymentExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		List<DataMap> list = new ArrayList<DataMap>();
		DataMap headMap = new DataMap();
		returnMap = cashbugerService.selectPaymentAccountJson(request);
		headMap = ((List<DataMap>)returnMap.get("list")).get(0);
		((List<DataMap>)returnMap.get("list")).remove(0);
		
		list = (List<DataMap>) returnMap.get("list");
		
		//sheet1 make
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.executeOne(excelUtil, "sheet1", new PaymentAccountExcelTemple(), headMap, list);
		excelUtil.executeEnd();
		
        return new ModelAndView("excelTempleLoad/ExlDownLoad", "FILE_NAME", excelUtil._targetFile.getPath());
	}
}

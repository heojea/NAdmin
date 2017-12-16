package com.share.closeAccount.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.share.closeAccount.excelTemplete.CashCardExcelTemple;
import com.share.closeAccount.service.CashCardService;
import com.share.common.excelUtil.ExcelUtil;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;

@Controller
@RequestMapping(value = "/cash")
public class CashCardController {

	@Autowired
	CashCardService cashCardService; 

	/**
	 * @desc : mobile close page move
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "cashCard.do")
	public String cashCard(HttpServletRequest request, Model model)
			throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		return "close/cashCard";
	}

	/**
	 * @desc : payment data select 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "cashCard.json")
	public void cashCardJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		returnMap = cashCardService.selectCashCardJson(request);
		
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
	@RequestMapping(value = "cashCardExcel.do")
	public ModelAndView cashCardExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		DataMap returnMap = new DataMap();
		List<DataMap> list = new ArrayList<DataMap>();
		DataMap headMap = new DataMap();
		
		headMap = cashCardService.selectCashCardBigDataCnt(request);
		
		//sheet1 make
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.executeBigDataHeader(excelUtil, "sheet1",new CashCardExcelTemple() , headMap , "");
		cashCardService.selectCashCardBigData(param , excelUtil.excelInterface);
		excelUtil.executeBigDataFooter();
		excelUtil.executeEnd();
		
        return new ModelAndView("excelTempleLoad/ExlDownLoad", "FILE_NAME", excelUtil._targetFile.getPath());
	}
}

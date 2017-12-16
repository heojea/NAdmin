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

import com.share.accountList.excelTemplete.GiftCardExcelTemple;
import com.share.accountList.excelTemplete.PaymentAccountExcelTemple;
import com.share.accountList.service.PaymentAccountService;
import com.share.closeAccount.dao.MobileCloseAccountDao;
import com.share.closeAccount.excelTemplete.MobileCloseAccountExcelTemple;
import com.share.closeAccount.service.MobileCloseAccountService;
import com.share.common.excelUtil.ExcelInterface;
import com.share.common.excelUtil.ExcelUtil;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;

@Controller
@RequestMapping(value = "/close")
public class MobileCloseAccountController {

	@Autowired
	MobileCloseAccountService mobileCloseAccountService;

	@Autowired    private MobileCloseAccountDao mobileCloseAccountDao  ;
	/**
	 * @desc : mobile close page move
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mobileClose.do")
	public String mobileClose(HttpServletRequest request, Model model)
			throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		
		System.out.println("ddddddddddddddddddddddddd");
		return "close/mobileClose";
	}

	/**
	 * @desc : payment data select 
	 * @heojea
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mobileClose.json")
	public void mobileCloseJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap returnMap = new DataMap();
		returnMap = mobileCloseAccountService.selectMobileCloseJson(request);
		
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
	@RequestMapping(value = "mobileCloseExcel.do")
	public ModelAndView mobileCloseExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		DataMap returnMap = new DataMap();
		List<DataMap> list = new ArrayList<DataMap>();
		DataMap headMap = new DataMap();
		
		headMap = mobileCloseAccountDao.selectMobileCloseDaoListCnt(param);
		
		//sheet1 make
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.executeBigDataHeader(excelUtil, "sheet1",new MobileCloseAccountExcelTemple() , headMap , "");
		mobileCloseAccountService.selectMobileCloseBigData(param , excelUtil.excelInterface);
		excelUtil.executeBigDataFooter();
		excelUtil.executeEnd();
		
        return new ModelAndView("excelTempleLoad/ExlDownLoad", "FILE_NAME", excelUtil._targetFile.getPath());
	}
	
	@RequestMapping(value = "agent.do")
	public String agent(HttpServletRequest request, Model model)
			throws Exception {
		DataMap param = RequestUtils.getStringParamDataMap(request);
		return "common/popup/commonAgent";
	}
	

}

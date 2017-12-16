package com.share.themis.zsys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.zsys.service.ZSYSP201Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ZSYSP201Controller {
    private static final Logger logger = LoggerFactory.getLogger(ZSYSP201Controller.class);
    
    @Autowired
    private ZSYSP201Service zsysp201Service;
    
    /**
     * 우편번호 팝업 화면
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/zsys/zsysp201/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        // return obj name 을 파라미터로 받아서 처리.
        DataMap param = RequestUtils.getStringParamDataMap(request);
        String returnPostNo = param.getString("returnPostNo");
        String returnAddr = param.getString("returnAddr");
        String returnZipSeq = param.getString("returnZipSeq");
        
        model.addAttribute("returnPostNo", returnPostNo);
        model.addAttribute("returnAddr", returnAddr);
        model.addAttribute("returnZipSeq", returnZipSeq);
        
        List<DataMap> sidoList = zsysp201Service.selectSidoList();
        model.addAttribute("sidoList", sidoList);
        
        return "zsys/zsysp2/zsysp2010";
    }
    
    /**
     * 우편번호 조회 처리
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/zsys/zsysp201/selectZipList.json", method = RequestMethod.POST)
    public void selectZipList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);   
        List<DataMap> zipList = zsysp201Service.selectZipList(param); 
        ResponseUtils.jsonList(response, zipList);
    }
}

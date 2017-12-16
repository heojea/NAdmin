package com.share.themis.ztad.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.common.util.ConfigUtils;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.common.util.seedCrypt.AES;
import com.share.themis.common.util.seedCrypt.SeedCrypt;
import com.share.themis.ztad.service.ZTADP101Service;

@Controller
public class ZTADP101Controller {
	
	@Autowired
    private ZTADP101Service ztadp101Service;
    
	/**
	 * 비밀번호 변경 팝업 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ztad/ztadp101/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        return "ztad/ztadp1/ztadp1010";
    }
	
	/**
	 * 비밀번호 변경
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/ztad/ztadp101/updateSadUserPwd.json")
    public void updateSadUserPwd(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        
        LoginSession loginSession = LoginSession.getLoginSession(request);
        param.put("user_id", loginSession.getAdmin_id()); // 사용자아이디
        
        DataMap resultMap = new DataMap();
        resultMap.put("isSuccess", false);
        
        if(  StringUtils.isEmpty(param.getString("admin_id"))
           ||StringUtils.isEmpty(param.getString("org_pwd"))
           ||StringUtils.isEmpty(param.getString("new_pwd"))) {
        	resultMap.put("isSuccess", false);
        	resultMap.put("code", "errNotParam");
        	resultMap.put("msg", "비밀번호 변경 처리 중 오류가 발생하였습니다.");
        }else {
        	// 현재 비밀번호 조회
        	DataMap curPwd = ztadp101Service.selectSadUserPwd(param);
        	
        	// 암호화
            String paramOrgPwd = SeedCrypt.encryptSHA256(param.getString("org_pwd"));
            String paramNewPwd = SeedCrypt.encryptSHA256(param.getString("new_pwd"));
            
            // 현재 비밀번호 vs. 암호화된 파라미터 값 비교
            if(!(paramOrgPwd.equals(curPwd.getString("PWD")))) {
            	resultMap.put("isSuccess", false);
            	resultMap.put("code", "errCurPwd");
            	resultMap.put("msg", "현재 비밀번호가 일치하지 않습니다.");
            }else {
            	// 현재 비밀번호 중복 체크
            	if(paramNewPwd.equals(curPwd.getString("PWD"))) {
            		resultMap.put("isSuccess", false);
            		resultMap.put("code", "errCurPwdDupl");
            		resultMap.put("msg", "현재 비밀번호와 중복됩니다.");
            	}else {
            		param.put("pwd", paramNewPwd);
            		// 비밀번호 변경
            		ztadp101Service.updateSadUserPwd(param); 
                    resultMap.put("isSuccess", true);
                    resultMap.put("code", "success");
                    resultMap.put("msg", "정상적으로 처리 되었습니다.");
            	}
            }
        }
        
        ResponseUtils.jsonMap(response, resultMap);
    }
	
}

package com.share.themis.ztad.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.Constants;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.common.service.CommonService;
import com.share.themis.common.util.ConfigUtils;
import com.share.themis.common.util.RequestUtils;
import com.share.themis.common.util.ResponseUtils;
import com.share.themis.common.util.seedCrypt.AES;
import com.share.themis.ztad.service.ZTADM601Service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ZTADM601Controller {
    @Autowired
    private CommonService commonService;
    @Autowired
    private ZTADM601Service ztadm601Service;
    
    /**
     * 관리자 생성 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm601/main.do")
    public String main(HttpServletRequest request, Model model) throws Exception {
        DataMap param = new DataMap();
        param.put("major_cd", "ADM01");
        param.put("minor_cd", "30");
        List<DataMap> adminTpList = commonService.selectCodeList(param);
        model.addAttribute("adminTpList", adminTpList);
        return "ztad/ztadm6/ztadm6010";
    }
    
    /**
     * 관리자 목록 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm601/adminList.json")
    public void adminList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);

        LoginSession loginSession = (LoginSession)request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY);
        String biz_no = loginSession.getBiz_no();

        param.put("biz_no", biz_no);
        System.out.println("★★★★★★★★★★★★ param" + param);
        
        // 관리자 목록 조회
        List<DataMap> adminList = ztadm601Service.selectAdminList(param);
        
        // 복호화
        String masterKey = ConfigUtils.getString("encryption.masterKey");
        for(int i=0; i<adminList.size(); i++) {
        	String email   =   AES.aesDecode(adminList.get(i).getString("EMAIL"), masterKey);
            String cell_no = AES.aesDecode(adminList.get(i).getString("CELL_NO"), masterKey);
            
            cell_no = cell_no.substring(0, 4)+"-"+cell_no.substring(4, 8)+"-"+cell_no.substring(8);
            
            adminList.get(i).put("EMAIL", email);
            adminList.get(i).put("CELL_NO", cell_no);
        }
        
        ResponseUtils.jsonList(response, adminList);
    }
    
    /**
     * 관리자 조회
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm601/admin.json")
    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        // 관리자 정보 조회(단건)
        DataMap admin = ztadm601Service.selectAdmin(param);
        
        // 복호화
        String masterKey = ConfigUtils.getString("encryption.masterKey");
        String email   =   AES.aesDecode(admin.getString("EMAIL"), masterKey);
        String tel_no = admin.getString("TEL_NO");
        if(!(tel_no == null || tel_no.isEmpty())) {
        	tel_no = AES.aesDecode(tel_no, masterKey);
            
        	String tel1_no = tel_no.substring(0, 4);
            String tel2_no = tel_no.substring(4, 8);
            String tel3_no = tel_no.substring(8);
            
            admin.put("TEL1_NO", tel1_no);
            admin.put("TEL2_NO", tel2_no);
            admin.put("TEL3_NO", tel3_no);
        }
        String cell_no = AES.aesDecode(admin.getString("CELL_NO"), masterKey);
        
        String cell1_no = cell_no.substring(0, 4);
        String cell2_no = cell_no.substring(4, 8);
        String cell3_no = cell_no.substring(8);
        
        admin.put("CELL1_NO", cell1_no);
        admin.put("CELL2_NO", cell2_no);
        admin.put("CELL3_NO", cell3_no);
        
        admin.put("EMAIL", email);
        
        ResponseUtils.jsonMap(response, admin);
    }
    
    /**
     * 관리자 정보 갱신
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm601/updateAdmin.json")
    public void updateAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        
        LoginSession loginSession = LoginSession.getLoginSession(request);
        param.put("user_id", loginSession.getAdmin_id()); // 사용자아이디
        
        boolean result = true;
        if(StringUtils.isEmpty(param.getString("admin_id"))) {
            result = false;
        }else {
            result = ztadm601Service.updateAdmin(param) == 1;
        }
        
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 관리자 등록
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm601/insertAdmin.json")
    public void insertAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        
        LoginSession loginSession = LoginSession.getLoginSession(request);
        param.put("user_id", loginSession.getAdmin_id()); // 사용자아이디
        
        boolean result = true;
        if(  StringUtils.isEmpty(param.getString("admin_nm")) 
           ||StringUtils.isEmpty(param.getString("admin_tp_cd"))
           ||StringUtils.isEmpty(param.getString("login_id"))
           ||StringUtils.isEmpty(param.getString("pwd"))
           ||StringUtils.isEmpty(param.getString("active_yn"))) {
            result = false;
        }else {
            ztadm601Service.insertAdmin(param);
        }
        
        ResponseUtils.jsonBoolean(response, result);
    }
    
    /**
     * 관리자 삭제
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/ztad/ztadm601/deleteAdmin.json")
    public void deleteAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DataMap param = RequestUtils.getStringParamDataMap(request);
        
        boolean result = true;
        if(StringUtils.isEmpty(param.getString("admin_id"))) {
            result = false;
        }else {
            ztadm601Service.deleteAdmin(param);
        }
        
        ResponseUtils.jsonBoolean(response, result);
    }
}

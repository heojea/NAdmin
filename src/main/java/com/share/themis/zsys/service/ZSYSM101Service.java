package com.share.themis.zsys.service;

import javax.servlet.http.HttpServletRequest;

import com.share.themis.common.Constants;
import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.common.property.ConfigurationService;
import com.share.themis.common.util.seedCrypt.SeedCrypt;
import com.share.themis.zsys.dao.ZSYSM101Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZSYSM101Service {
    @Autowired
    private ZSYSM101Dao zsysm101Dao;
    @Autowired
    private ConfigurationService config;
    
    public DataMap selectAdminUser(DataMap dataMap) throws Exception {
        return zsysm101Dao.selectAdminUser(dataMap);
    }
    
    public boolean login(HttpServletRequest request, DataMap dataMap) throws Exception {
        boolean result = false;
        DataMap adminUser = zsysm101Dao.selectAdminUser(dataMap);
        
        dataMap.put("admin_ip", request.getRemoteAddr());
                
        if (adminUser == null)
            return false;        
        
        dataMap.put("admin_id", adminUser.getString("ADMIN_ID"));
        
        result = SeedCrypt.encryptSHA256(dataMap.getString("login_pw")).equals(adminUser.getString("PWD"));
        if (adminUser.getInt("PWD_ERROR_CNT") <= 5) {
            if (result) {
                zsysm101Dao.insertSadLoginHis(dataMap);         //로그인 이력 기록
                
                zsysm101Dao.updateAdminUserPwdErrorDy(dataMap); //비밀번호 횟수 초기화
                
                LoginSession loginSession = new LoginSession();
                loginSession.setAdmin_id(adminUser.getString("ADMIN_ID"));
                loginSession.setAdmin_nm(adminUser.getString("ADMIN_NM"));
                loginSession.setLogin_id(adminUser.getString("LOGIN_ID"));
                loginSession.setAdmin_tp_cd(adminUser.getString("ADMIN_TP_CD"));
                loginSession.setEmail(adminUser.getString("EMAIL"));
                loginSession.setEmp_no(adminUser.getString("EMP_NO"));
                loginSession.setEmp_no(adminUser.getString("EMP_NO"));
                loginSession.setLogin_id(adminUser.getString("LOGIN_ID"));
                loginSession.setCust_auth(adminUser.getString("CUST_AUTH"));
                loginSession.setLoca_auth(adminUser.getString("LOCA_AUTH"));
                loginSession.setSite_auth("N");
                loginSession.setSite_id(config.getString("system.site.id"));
                request.getSession().setAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY, loginSession);
                
                /**
                 * session 시간을 설정한다.
                 * 수정자 : @heojea
                 */
                request.getSession().setMaxInactiveInterval(60*60);
                
            }else{
                //에러건수 update
                zsysm101Dao.updateAdminUserPwdErrorCnt(dataMap);
            }
        }else{
            // 비밀번호 5회이상 틀리면 접속안됨
            result = false;
        }
        

        return result;
    }
    
    public DataMap selectCorpUser(DataMap dataMap) throws Exception {
    	return zsysm101Dao.selectCorpUser(dataMap);
    }
    
    public boolean corpLogin(HttpServletRequest request, DataMap dataMap) throws Exception {
    	boolean result = false;
    	DataMap corpUser = zsysm101Dao.selectCorpUser(dataMap);
    	
    	dataMap.put("admin_ip", request.getRemoteAddr());
    	
    	if(corpUser == null)
    		return false;
    	
    	dataMap.put("admin_id", corpUser.getString("ADMIN_ID"));
    	dataMap.put("biz_no", corpUser.getString("BIZ_NO"));
    	
    	result = SeedCrypt.encryptSHA256(dataMap.getString("login_pw")).equals(corpUser.getString("PWD"));
    	if(corpUser.getInt("PWD_ERROR_CNT") <= 5) {
    		if(result) {
    			// 로그인 이력 기록
    			zsysm101Dao.insertSadLoginHis(dataMap);
    			
    			// 비밀번호 횟수 초기화
    			zsysm101Dao.updateAdminUserPwdErrorDy(dataMap);
    			LoginSession loginSession = new LoginSession();
    			loginSession.setAdmin_id(corpUser.getString("ADMIN_ID"));
    			loginSession.setAdmin_nm(corpUser.getString("ADMIN_NM"));
    			loginSession.setAdmin_tp_cd(corpUser.getString("ADMIN_TP_CD"));
    			loginSession.setEmail(corpUser.getString("EMAIL"));
    			loginSession.setEmp_no(corpUser.getString("EMP_NO"));
    			loginSession.setEmp_no(corpUser.getString("EMP_NO"));
    			loginSession.setLogin_id(corpUser.getString("LOGIN_ID"));
    			loginSession.setBiz_no(corpUser.getString("BIZ_NO"));
    			System.out.println(">>>>>>>>>>>>>>>>>>>>>>1:"+corpUser.getString("BIZ_NO")); 
    			System.out.println(">>>>>>>>>>>>>>>>>>>>>>2:"+loginSession.getBiz_no());
    			loginSession.setCust_auth(corpUser.getString("CUST_AUTH"));
    			loginSession.setLoca_auth(corpUser.getString("LOCA_AUTH"));
    			loginSession.setSite_auth("N");
    			loginSession.setSite_id(config.getString("system.site.id"));
    			request.getSession().setAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY, loginSession);
    			
    			
    			
    			
    			
    		}else {
    			// 에러건수 update
    			zsysm101Dao.updateAdminUserPwdErrorCnt(dataMap);
    		}
    	}else{
    		// 비밀번호 5회 연속 틀릴 시 접속 안됨
    		result = false;
    	}
    	return result;
    }
    
}

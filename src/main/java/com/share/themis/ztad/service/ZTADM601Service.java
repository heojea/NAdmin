package com.share.themis.ztad.service;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.CommonUtils;
import com.share.themis.common.util.ConfigUtils;
import com.share.themis.common.util.seedCrypt.AES;
import com.share.themis.common.util.seedCrypt.SeedCrypt;
import com.share.themis.ztad.dao.ZTADM601Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM601Service {
    @Autowired
    private ZTADM601Dao ztadm601Dao;
    
    public List<DataMap> selectAdminList(DataMap param) throws Exception {
        return ztadm601Dao.selectAdminList(param);
    }
    
    public DataMap selectAdmin(DataMap param) throws Exception {
        return ztadm601Dao.selectAdmin(param);
    }
    
    @SuppressWarnings("rawtypes")
	public void insertAdmin(DataMap param) throws Exception {
    	// 관리자 아이디 생성
        long admin_id = System.currentTimeMillis();
    	
        Set keys = param.keySet();
        Iterator itor = keys.iterator();
        while(itor.hasNext()) {
            String key = (String)itor.next();
            if(key.indexOf("role_id_") > -1) {
                DataMap paramMap = new DataMap();
                paramMap.put("admin_id",                   admin_id); // 관리자아이디
                paramMap.put("role_id" ,       param.getString(key)); // 권한아이디
                paramMap.put("user_id" , param.getString("user_id")); // 수정자, 등록자
                
                // 관리자 권한 정보 등록
                ztadm601Dao.insertAdminRoleAssign(paramMap);
            }
        }
        
        // 관리자 아이디 파라미터 셋팅
        param.put("admin_id", admin_id);
        
        // 전화번호, 핸드폰번호 포멧
    	CommonUtils.getTelFormat(param, new String[]{"tel_no", "tel1_no", "tel2_no", "tel3_no"});
        CommonUtils.getTelFormat(param, new String[]{"cell_no", "cell1_no", "cell2_no", "cell3_no"});
        
        // 암호화 및 파라미터 셋팅
    	String masterKey = ConfigUtils.getString("encryption.masterKey");
    	param.put("pwd"  ,    SeedCrypt.encryptSHA256(param.getString("pwd"))); // 비밀번호
    	param.put("email", AES.aesEncode(param.getString("email"), masterKey)); // 이메일
    	String tel_no = param.getString("tel_no");
    	if(!(tel_no == null || tel_no.isEmpty())) {
    		param.put("tel_no", AES.aesEncode(param.getString("tel_no"), masterKey)); // 전화번호
    	}
    	param.put("cell_no", AES.aesEncode(param.getString("cell_no"), masterKey)); // 핸드폰번호
    	
        // 관리자 정보 등록
        ztadm601Dao.insertAdmin(param);
    }
    
    @SuppressWarnings("rawtypes")
	public int updateAdmin(DataMap param) throws Exception {
/*        // 관리자 권한 정보 삭제
        ztadm601Dao.deleteAdminRoleAssign(param);
        
        Set keys = param.keySet();
        Iterator itor = keys.iterator();
        while(itor.hasNext()) {
            String key = (String)itor.next();
            if(key.indexOf("role_id_") > -1) {
                DataMap paramMap = new DataMap();
                paramMap.put("admin_id", param.getString("admin_id")); // 관리자아이디
                paramMap.put("role_id" ,        param.getString(key)); // 권한아이디
                paramMap.put("user_id" ,  param.getString("user_id")); // 수정자, 등록자
                
                // 관리자 권한 정보 등록
                ztadm601Dao.insertAdminRoleAssign(paramMap);
            }
        }*/
        
        // 전화번호, 핸드폰번호 포멧
    	CommonUtils.getTelFormat(param, new String[]{"tel_no", "tel1_no", "tel2_no", "tel3_no"});
        CommonUtils.getTelFormat(param, new String[]{"cell_no", "cell1_no", "cell2_no", "cell3_no"});
        
        // 암호화 및 파라미터 셋팅
    	String masterKey = ConfigUtils.getString("encryption.masterKey");
    	param.put("pwd"  ,    SeedCrypt.encryptSHA256(param.getString("pwd"))); // 비밀번호
    	param.put("email", AES.aesEncode(param.getString("email"), masterKey)); // 이메일
    	String tel_no = param.getString("tel_no");
    	if(!(tel_no == null || tel_no.isEmpty())) {
    		param.put("tel_no", AES.aesEncode(param.getString("tel_no"), masterKey)); // 전화번호
    	}
    	param.put("cell_no", AES.aesEncode(param.getString("cell_no"), masterKey)); // 핸드폰번호
        
        return ztadm601Dao.updateAdmin(param);
    }
    
    public void deleteAdmin(DataMap param) throws Exception {
        ztadm601Dao.deleteAdmin(param);
    }
}

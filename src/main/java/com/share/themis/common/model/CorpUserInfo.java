package com.share.themis.common.model;

import KISINFO.VNO.VNOInterop;

import com.share.themis.common.util.ConfigUtils;
import com.share.themis.common.util.seedCrypt.AES;
import com.share.themis.common.util.seedCrypt.SeedCrypt;

public class CorpUserInfo {
	// TODO : 알맞게 변수면 수정 요함
	public String login_id;
	public String member_nm;
	public String pwd;
	public String birth_dy;  	  //생년월일 ex) 20130101
	public String lunar_cd;    	  //음력/양력 ex) 음력 : 10, 양력 20
	public String sex_cd; 		  //성별 ex) 남자 : 10, 여자 :20
	public String social_no; 	  //주민등록 번호 ex)8508111231234
	public String hp_no; 		  //핸드폰 ex)010 12341234
	public String email; 		  //이메일 ex)asdfaf@daum.net
	public String zip_cd; 		  //우편번호 ex)403090
	public String zip_seq;        //우편번호  seq
	public String addr1_nm;       //상세주소1 ex) 인천광역시 부평구 삼산동
	public String addr2_nm;       //상세주소2 ex)현대아파트 101동 101호
	public String license_tp_cd;  //운전면허 종류 ex) 1종 : 10, 2종 : 20
	public String license_area_cd;//면허증 지역 ex)서울, 부산, 경기
	public String license_no; 	  //면허증 번호 ex)1234567890
	public String license_dy; 	  //면허발급일자 ex)20130901
	public String apply_dy;       //적성기간만료일  ex)20141001
	public String member_no;	  //회원 번호
	public String member_card_no; //회원카드 번호
	public String mod_id;         //관리자 id
	public String dept_nm;        //부서명
	public String biz_no;		  //사업자 번호
	public String reg_id;         //관리자 id
	public String error_esc;      //에러코드
	public String email_yn;       //이메일 수신여부
	public String sms_yn;         //sms 수신여부
	public String user_ci;        //주민번호 연계정호 확인값
	
	public int resultCode;
	public String resultMessage;
	
	public static enum ERROR_CODE {
		OK(0),
		SOCIALNO(1), 
		ID_DUPLICATION(2), 
		EMAIL(3);
		
		final int code;
		
		private ERROR_CODE(int code) {
			this.code = code;
		}
		
		public int getCode() {
			return code;
		}
	};
	
	public static CorpUserInfo fromCsv(String str, String biz_no) {
		CorpUserInfo userInfo = new CorpUserInfo();
        String masterKey = ConfigUtils.getString("encryption.masterKey");//암호화 마스터 키

		try{
			String[] tokens = str.split(",");
			int idx = 0;
			
			String c_error_esc = "";
			
			userInfo.member_no  	= String.valueOf(System.currentTimeMillis());  //회원번호
			userInfo.mod_id     	= "0000000000000";                             //관리자 번호
			userInfo.reg_id     	= "0000000000000";                             //관리자 번호
			userInfo.zip_seq        = "135080001";                                 //우편번호 seq 강제로 박는다
			userInfo.biz_no         = biz_no;                                      //사업자번호
			
			//로그인아이디
			String c_login_id = tokens[idx++];                                    
			if(c_login_id.length() < 6){//로긴아이디 6글자 이상인지 체크
				c_error_esc = c_error_esc +", 아이디5글자이하";
				userInfo.resultMessage ="ERROR"; //에러
			}
			userInfo.login_id    	= c_login_id;                                  //로그인 아이디
			userInfo.member_nm   	= tokens[idx++];                               //회원명                        
			
			//패스워드
			String c_pwd = tokens[idx++];
			if(c_pwd.length() < 6){//패스워드 6글자 이상인지 체크
				c_error_esc = c_error_esc +", 비빌번호6글자이하";
				userInfo.resultMessage ="ERROR"; //에러
			}
			c_pwd = SeedCrypt.encryptSHA256(c_pwd); //패스워드 암호화
			userInfo.pwd        	= c_pwd;                                        //패스워드
			
			//생년월일
			String c_birth_dy = tokens[idx++];
			String s_birth_dy[] = c_birth_dy.split("\\.");
			c_birth_dy = "";
			for(int i=0; i<s_birth_dy.length; i++){
				c_birth_dy = c_birth_dy + s_birth_dy[i];
			}
			if(c_birth_dy.length() != 8){
				c_error_esc = c_error_esc +", 생년월일오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			c_birth_dy = AES.aesEncode(c_birth_dy, masterKey);
			userInfo.birth_dy    	= c_birth_dy;                                   //생년월일
			
			//음,양력
			String c_lunar_cd = tokens[idx++];
			if(c_lunar_cd.length() != 2){
				c_error_esc = c_error_esc +", 음력양력오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			userInfo.lunar_cd      	= c_lunar_cd;                                   //음/양력
			
			//성별
			String c_sex_cd = tokens[idx++];
			if(c_sex_cd.length() != 2){
				c_error_esc = c_error_esc +", 성별오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			userInfo.sex_cd      	= c_sex_cd;                                     //성별
			
			//주민등록번호
			String c_social_no = tokens[idx++];
			c_social_no = c_social_no.replace("-", "");
			if(c_social_no.length() != 13){
				c_error_esc = c_error_esc +", 주민등록오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			
			c_social_no = AES.aesEncode(c_social_no, masterKey);
			userInfo.social_no 		= c_social_no;									//주민등록번호
			
			//핸드폰번호
			String c_hp_no = tokens[idx++];
			c_hp_no = c_hp_no.replace("-", "");
			if(c_hp_no.length() < 11 || c_hp_no.length() > 12 ){
				c_error_esc = c_error_esc +", 핸드폰번호오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			c_hp_no = AES.aesEncode(c_hp_no, masterKey);
			userInfo.hp_no 			= c_hp_no;										//핸드폰
			
			//이메일
			String c_email = tokens[idx++];
			c_email = AES.aesEncode(c_email, masterKey);
			userInfo.email 			= c_email;								
			
			//우편번호
			String c_zip_cd = tokens[idx++];
			c_zip_cd = AES.aesEncode(c_zip_cd, masterKey);
			userInfo.zip_cd 		= c_zip_cd;								
			
			//우편주소 1
			String c_addr1_nm = tokens[idx++];
			c_addr1_nm = AES.aesEncode(c_addr1_nm, masterKey);
			userInfo.addr1_nm 		= c_addr1_nm;							
			
			//우편주소 2
			String c_addr2_nm = tokens[idx++];
			c_addr2_nm = AES.aesEncode(c_addr2_nm, masterKey);
			userInfo.addr2_nm 		= c_addr2_nm;								    
			
			userInfo.license_tp_cd 	= tokens[idx++]; 								
			userInfo.license_area_cd= tokens[idx++];								
			
			String c_license_no = tokens[idx++];
			c_license_no = c_license_no.replace("-", "");
			System.out.println("c_license_no = " + c_license_no);
			if(c_license_no.length() != 10){
				c_error_esc = c_error_esc +", 운전면허번호오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			c_license_no = AES.aesEncode(c_license_no, masterKey);					
			userInfo.license_no 		= c_license_no;								
			
			//면허 발급일자
			String c_license_dy = tokens[idx++];
			c_license_dy = c_license_dy.replace(".", "");
			if(c_license_dy.length() != 8){
				c_error_esc = c_error_esc +", 면허발급일자오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			userInfo.license_dy 		= c_license_dy;								//면허발급일자 오류
			
			//면허적성일자
			String c_apply_dy = tokens[idx++];
			c_apply_dy = c_apply_dy.replace(".", "");
			if(c_apply_dy.length() != 8){
				c_error_esc = c_error_esc +", 면허적성일자오류";
				userInfo.resultMessage ="ERROR"; //에러
			}
			
			// 첫 comma 제거
			if (c_error_esc.startsWith(",")) {
				c_error_esc = c_error_esc.substring(1);
			}
			
			userInfo.apply_dy 		= c_apply_dy;									//면허적성일자
			userInfo.error_esc      = c_error_esc;									//오류코드
			userInfo.resultMessage  = "ok";
			userInfo.email_yn       = tokens[idx++];								//email 수신여부
			userInfo.sms_yn         = tokens[idx++];								//sms 수신여부

		}catch(Exception e){
			e.printStackTrace();
		}
		return userInfo;
	}
	
	public String getEmail_yn() {
		return email_yn;
	}


	public void setEmail_yn(String email_yn) {
		this.email_yn = email_yn;
	}


	public String getSms_yn() {
		return sms_yn;
	}


	public void setSms_yn(String sms_yn) {
		this.sms_yn = sms_yn;
	}


	public String getUser_ci() {
		return user_ci;
	}

	public void setUser_ci(String user_ci) {
		this.user_ci = user_ci;
	}

	public String getError_esc() {
		return error_esc;
	}


	public void setError_esc(String error_esc) {
		this.error_esc = error_esc;
	}


	public String getLogin_id() {
		return login_id;
	}


	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}


	public String getMember_nm() {
		return member_nm;
	}


	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getBirth_dy() {
		return birth_dy;
	}


	public void setBirth_dy(String birth_dy) {
		this.birth_dy = birth_dy;
	}


	public String getLunar_cd() {
		return lunar_cd;
	}


	public void setLunar_cd(String lunar_cd) {
		this.lunar_cd = lunar_cd;
	}


	public String getSex_cd() {
		return sex_cd;
	}


	public void setSex_cd(String sex_cd) {
		this.sex_cd = sex_cd;
	}


	public String getSocial_no() {
		return social_no;
	}


	public void setSocial_no(String social_no) {
		this.social_no = social_no;
	}


	public String getHp_no() {
		return hp_no;
	}


	public void setHp_no(String hp_no) {
		this.hp_no = hp_no;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getZip_cd() {
		return zip_cd;
	}


	public void setZip_cd(String zip_cd) {
		this.zip_cd = zip_cd;
	}


	public String getZip_seq() {
		return zip_seq;
	}


	public void setZip_seq(String zip_seq) {
		this.zip_seq = zip_seq;
	}


	public String getAddr1_nm() {
		return addr1_nm;
	}


	public void setAddr1_nm(String addr1_nm) {
		this.addr1_nm = addr1_nm;
	}


	public String getAddr2_nm() {
		return addr2_nm;
	}


	public void setAddr2_nm(String addr2_nm) {
		this.addr2_nm = addr2_nm;
	}


	public String getLicense_tp_cd() {
		return license_tp_cd;
	}


	public void setLicense_tp_cd(String license_tp_cd) {
		this.license_tp_cd = license_tp_cd;
	}


	public String getLicense_area_cd() {
		return license_area_cd;
	}


	public void setLicense_area_cd(String license_area_cd) {
		this.license_area_cd = license_area_cd;
	}


	public String getLicense_no() {
		return license_no;
	}


	public void setLicense_no(String license_no) {
		this.license_no = license_no;
	}


	public String getLicense_dy() {
		return license_dy;
	}


	public void setLicense_dy(String license_dy) {
		this.license_dy = license_dy;
	}


	public String getApply_dy() {
		return apply_dy;
	}


	public void setApply_dy(String apply_dy) {
		this.apply_dy = apply_dy;
	}


	public String getMember_no() {
		return member_no;
	}


	public void setMember_no(String member_no) {
		this.member_no = member_no;
	}


	public String getMember_card_no() {
		return member_card_no;
	}


	public void setMember_card_no(String member_card_no) {
		this.member_card_no = member_card_no;
	}


	public String getMod_id() {
		return mod_id;
	}


	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}


	public String getDept_nm() {
		return dept_nm;
	}


	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}


	public String getBiz_no() {
		return biz_no;
	}


	public void setBiz_no(String biz_no) {
		this.biz_no = biz_no;
	}


	public String getReg_id() {
		return reg_id;
	}


	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}


	public int getResultCode() {
		return resultCode;
	}


	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
	}


	public String getResultMessage() {
		return resultMessage;
	}


	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}


	@Override
	public String toString() {
		return "CorpUserInfo [login_id=" + login_id + ", member_nm=" + member_nm
				+ ", pwd=" + pwd + ", birth_dy=" + birth_dy + ", lunar_cd=" + lunar_cd
				+ ", sex_cd=" + sex_cd + ", social_no=" + social_no + ", hp_no="
				+ hp_no + ", email=" + email + ", zip_cd=" + zip_cd + ", addr1_nm="
				+ addr1_nm + ", addr2_nm=" + addr2_nm + ", license_tp_cd="
				+ license_tp_cd + ", license_area_cd=" + license_area_cd
				+ ", license_no=" + license_no + ", license_dy=" + license_dy
				+ ", apply_dy=" + apply_dy + ", error_esc=" + error_esc
				+ ", resultMessage=" + resultMessage + "]";
	}
	
}
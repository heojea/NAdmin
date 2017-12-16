package com.share.themis.common.model;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

import com.share.themis.common.Constants;

public class LoginSession implements Serializable {
    private static final long serialVersionUID = -9003127277782284753L;
    
    public static LoginSession getLoginSession(HttpServletRequest request) {
        return (LoginSession) request.getSession().getAttribute(
                Constants.TANINE_BOS_LOGIN_SESSION_KEY);
    }
    
    private String admin_id;
    private String admin_nm;
    private String site_id;
    private String login_id;
    private String biz_no;
	private String admin_tp_cd;
    private String emp_no;
    private String email;
    private String site_nm;
    private String site_auth;
    private String cust_auth;
    private String loca_auth;
    
    public String getAdmin_id() {
        return admin_id;
    }
    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
    }
    public String getAdmin_nm() {
        return admin_nm;
    }
    public void setAdmin_nm(String admin_nm) {
        this.admin_nm = admin_nm;
    }
    public String getSite_id() {
        return site_id;
    }
    public void setSite_id(String site_id) {
        this.site_id = site_id;
    }
    public String getLogin_id() {
        return login_id;
    }
    public void setLogin_id(String login_id) {
        this.login_id = login_id;
    }
    public String getBiz_no() {
		return biz_no;
	}
	public void setBiz_no(String biz_no) {
		this.biz_no = biz_no;
	}
    public String getAdmin_tp_cd() {
        return admin_tp_cd;
    }
    public void setAdmin_tp_cd(String admin_tp_cd) {
        this.admin_tp_cd = admin_tp_cd;
    }
    public String getEmp_no() {
        return emp_no;
    }
    public void setEmp_no(String emp_no) {
        this.emp_no = emp_no;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getSite_nm() {
        return site_nm;
    }
    public void setSite_nm(String site_nm) {
        this.site_nm = site_nm;
    }
    public String getSite_auth() {
        return site_auth;
    }
    public void setSite_auth(String site_auth) {
        this.site_auth = site_auth;
    }
    public String getCust_auth() {
        return cust_auth;
    }
    public void setCust_auth(String cust_auth) {
        this.cust_auth = cust_auth;
    }
    public String getLoca_auth() {
        return loca_auth;
    }
    public void setLoca_auth(String loca_auth) {
        this.loca_auth = loca_auth;
    }
    
}


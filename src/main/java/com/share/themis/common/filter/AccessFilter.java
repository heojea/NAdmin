package com.share.themis.common.filter;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.model.LoginSession;
import com.share.themis.zsys.dao.ZSYSM101Dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoader;

public class AccessFilter implements Filter {
    private static final Logger logger = LoggerFactory.getLogger(AccessFilter.class);
    // 로그인체크/권한체크 없이 접근가능 페이지
    public static final String[] loginFreeActions = {
        "/zsys/zsysm101/main.do"
        ,"/view.do"
        ,"/css.do"
        ,"/zsys/zsysm101/login.do"
        ,"/zsys/zsysm101/corpLogin.do"
    };
    // 권한체크 없이 접근가능 페이지
    public static final String[] accessFreeActions = {
        ""
    };
    
    public final static String parameterKey = "viewName";
    public final static String loginUri = "/view.do?viewName=login&layout=layout";

    public void init(FilterConfig arg0) throws ServletException {
        // Do nothing
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException  {
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse res = (HttpServletResponse)response;
        System.out.println("--------------------- parameter info ---------------------");
        Enumeration enums = request.getParameterNames();
        while (enums.hasMoreElements()) {
        	
            String k = (String)enums.nextElement();
          /*  System.out.println(k+" : "+request.getParameter(k));*/
        }
        System.out.println("----------------------------------------------------------");
        
        String servletPath = ((HttpServletRequest)request).getServletPath();        
        // 요청 uri 생성
        String uri = servletPath;
        // 로그인체크/권한체크 없이 접근가능 체크
        for (String action : loginFreeActions) {
            if (action.equals(uri)) {
                // 로그인체크/권한체크 없이 접근가능
                allowAccess(request, response, chain);
                return;
            }else if ((uri!=null)&&(uri.startsWith(action))) { /**운영 전환시 삭제 **/
                allowAccess(request, response, chain);
                return;
            }else if ((uri!=null)&&(uri.endsWith(action))) { /**운영 전환시 삭제 **/
                allowAccess(request, response, chain);
                return;
            }
        }
        
        LoginSession loginSession = LoginSession.getLoginSession((HttpServletRequest)request);
        if (loginSession == null) {
            if ("true".equals(req.getHeader("AJAX")))
                res.setStatus(406);
            else
                ((HttpServletResponse)response).sendRedirect(((HttpServletRequest)request).getContextPath() + loginUri);
            
            return;
        }
        else {
         // 권한체크 불필요한 페이지 체크(로그인은 필요함)
            for (String action : accessFreeActions) {
                if (action.equals(uri)) {
                    allowAccess(request, response, chain);
                    return;
                }
            }
          
            // 사이트 권한 설정
            if (!"Y".equals(loginSession.getSite_auth())) {
                request.setAttribute("site_id", loginSession.getSite_id());
            }
            
            // 모니터 관리자용 설정
            request.setAttribute("mon_site_id", loginSession.getSite_id());
            
            request.setAttribute("SITE_AUTH", loginSession.getSite_auth());
            request.setAttribute("CUST_AUTH", loginSession.getCust_auth());
            request.setAttribute("LOCA_AUTH", loginSession.getLoca_auth());
            request.setAttribute("ADMIN_ID", loginSession.getAdmin_id());
            
            try {
                ApplicationContext appContext = ContextLoader.getCurrentWebApplicationContext();
                ZSYSM101Dao zsysm101Dao = (ZSYSM101Dao)appContext.getBean("ZSYSM101Dao");
                
                DataMap param = new DataMap();
                param.put("admin_id", loginSession.getAdmin_id());
                param.put("site_id", loginSession.getSite_id());
                param.put("url", (uri.startsWith("/")? uri.substring(1):uri));
                
                DataMap result = zsysm101Dao.selectAuth(param);
                if (result != null) {
                    param.put("admin_ip", req.getRemoteAddr());
                    param.put("menu_id", result.getString("MENU_ID"));
                    
                    if ("N".equals(result.getString("AUTH"))) {    
                        if ("true".equals(req.getHeader("AJAX")))
                            res.setStatus(401);
                        else
                            ((HttpServletResponse)response).sendRedirect(((HttpServletRequest)request).getContextPath() + loginUri);
                        return;
                    }
                    request.setAttribute("DEPTH1_MENU_NM", result.getString("DEPTH1_MENU_NM"));
                    request.setAttribute("DEPTH1_MENU_ID", result.getString("DEPTH1_MENU_ID"));
                    request.setAttribute("DEPTH2_MENU_NM", result.getString("DEPTH2_MENU_NM"));
                    request.setAttribute("MENU_NM", result.getString("MENU_NM"));
                    
                    
                }
                else {
                    param.put("admin_ip", req.getLocalAddr());
                    param.put("menu_id", "NONE");
                }
            }
            catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
            // 로그인체크 및 실행권한 체크 성공 성공
            allowAccess(request, response, chain);
        }
    }
    
    public void destroy() {
        // Do nothing
    }
    
    // 접근허용
    private void allowAccess(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        ((HttpServletResponse)response).addHeader( "Pragma", "no-cache" );
        ((HttpServletResponse)response).addHeader( "Expires", "-1" );
        chain.doFilter( request, response );
    }
        
}

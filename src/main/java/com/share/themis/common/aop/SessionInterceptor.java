package com.share.themis.common.aop;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.share.themis.common.Constants;

public class SessionInterceptor implements HandlerInterceptor  {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	String reqUri = request.getRequestURI();
        // 로그인 요청이 아닌경우 세션을 체크한다.
        if( "XMLHttpRequest".equals(request.getHeader("x-requested-with")) ){
        	// json 요청인 경우.
        	// session checked logic
        	String loginUri = "/view.do?viewName=login&layout=layout";
        	if(request.getSession().getAttribute(Constants.TANINE_BOS_LOGIN_SESSION_KEY)==null){
        		response.setStatus(HttpServletResponse.SC_GATEWAY_TIMEOUT);
                response.getWriter().write("loginOut");
                response.flushBuffer();
                return false;
        	}
        }
        return true;
    }

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
 

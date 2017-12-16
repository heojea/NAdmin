package com.share.themis.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.JoinPoint.StaticPart;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BaseLogging {
    private static final Logger logger = LoggerFactory.getLogger(BaseLogging.class);
    
    public void beforeMethod(JoinPoint joinPoint) {
        String target = joinPoint.getTarget().toString();
        String methodName = joinPoint.getSignature().toShortString();
        String classPath = target.substring(0, target.lastIndexOf("@"));
        logger.info(classPath+"."+methodName+"() called.");
    }
    
    public void afterMethod(StaticPart staticPart, Object result) {
        String methodName = staticPart.getSignature().toLongString();
        logger.info(methodName + " returning:[ " + result + " ]");
    }
    
    public void afterThrowing(Exception ex) {
        logger.error(ex.getMessage(), ex);
    }
}

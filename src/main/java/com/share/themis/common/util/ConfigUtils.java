package com.share.themis.common.util;

import java.util.ArrayList;
import java.util.List;

import com.share.themis.common.property.ConfigurationService;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoader;

public class ConfigUtils {
    public static String getString(String key) {
        try {
            ApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
            ConfigurationService config = (ConfigurationService)ctx.getBean("configurationService");
            return config.getString(key);
        } catch (Exception e) {
            return "";
        }
    }
    
    public static int getInt(String key) {
        try {
            ApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
            ConfigurationService config = (ConfigurationService)ctx.getBean("configurationService");
            return config.getInt(key);
        } catch (Exception e) {
            return 0;
        }
    }
    
    public static List<String> getList(String key) {
        try {
            ApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
            ConfigurationService config = (ConfigurationService)ctx.getBean("configurationService");
            return config.getList(key);
        } catch (Exception e) {
            return new ArrayList<String>();
        }
    }
    
    public static String[] getStringArray(String key) {
        try {
            ApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
            ConfigurationService config = (ConfigurationService)ctx.getBean("configurationService");
            return config.getStringArray(key);
        } catch (Exception e) {
            return new String[0];
        }
    }
}

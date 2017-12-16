package com.share.themis.common.property;

import java.util.List;
import java.util.Properties;

public abstract interface ConfigurationService {
    public abstract String getString(String paramString);
    
    public abstract int getInt(String paramString);
    
    public abstract String[] getStringArray(String paramString);
    
    public abstract Properties getProperties(String paramString);
    
    public abstract List<String> getList(String paramString);
}
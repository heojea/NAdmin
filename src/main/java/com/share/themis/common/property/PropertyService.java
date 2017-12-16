package com.share.themis.common.property;

import java.util.Collection;
import java.util.Iterator;
import java.util.Vector;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public interface PropertyService {
    
    public static final Log LOGGER = LogFactory.getLog(PropertyService.class);
    
    public abstract boolean getBoolean(String paramString);
    
    public abstract boolean getBoolean(String paramString, boolean paramBoolean);
    
    public abstract double getDouble(String paramString);
    
    public abstract double getDouble(String paramString, double paramDouble);
    
    public abstract float getFloat(String paramString);
    
    public abstract float getFloat(String paramString, float paramFloat);
    
    public abstract int getInt(String paramString);
    
    public abstract int getInt(String paramString, int paramInt);
    
    public abstract Iterator getKeys();
    
    public abstract Iterator getKeys(String paramString);
    
    public abstract long getLong(String paramString);
    
    public abstract long getLong(String paramString, long paramLong);
    
    public abstract String getString(String paramString);
    
    public abstract String getString(String paramString1, String paramString2);
    
    public abstract String[] getStringArray(String paramString);
    
    public abstract Vector getVector(String paramString);
    
    public abstract Vector getVector(String paramString, Vector paramVector);
    
    public abstract void refreshPropertyFiles()
     throws Exception;
    
    public abstract Collection getAllKeyValue();
}

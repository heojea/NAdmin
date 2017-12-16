package com.share.themis.common.map;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DataMap extends HashMap<Object, Object> {
    private static final Logger logger = LoggerFactory.getLogger(DataMap.class);
    
    private static final long serialVersionUID = 1568324898795L;
    
    public DataMap(){
    }
    
    public DataMap(String JSONStr){
        try{
            JSONObject json = new JSONObject(new JSONTokener(JSONStr));
            Iterator<String> keys = json.keys();
            while(keys.hasNext()){
                String key = keys.next();
                if(json.get(key) instanceof JSONArray){
                    ArrayList<Object> list = new ArrayList<Object>();
                    for(int i=0;i<json.getJSONArray(key).length();i++){
                        list.add(json.getJSONArray(key).get(i));
                    }
                    this.put(key, list);
                }else
                    this.put(key, json.get(key));
            }
        }catch(Exception ex){
        }
    }

    public String getSafeString(String key) {
        return getString(key); // TODO
    }
    
    public String getSafeString(String key, int byteLength) {
        return getString(key, byteLength); // TODO
    }
    
    public String getString(String key){
        return getString(key, "");
    }
    
    public String[] getStringArr(String key){
        return getStringArr(key, "");
    }

    public String getString(String key, int byteLength){
        return getString(key, byteLength, "");
    }

    public String getString(String key, int byteLength, String nullValue){
        return byteCut(getString(key, nullValue), byteLength);
    }

    public int getInt(String key){
        Integer returnValue = getIntObject(key);

        if(returnValue == null) return 0;
        else return returnValue.intValue();
    }

    public long getLong(String key){
        Long returnValue = getLongObject(key);

        if(returnValue == null) return 0;
        else return returnValue.longValue();
    }

    public float getFloat(String key){
        Float returnValue = getFloatObject(key);

        if(returnValue == null) return 0;
        else return returnValue.floatValue();
    }

    public double getDouble(String key){
        Double returnValue = getDoubleObject(key);

        if(returnValue == null) return 0;
        else return returnValue.doubleValue();
    }
    
    public String getString(String key, String nullValue){
        Object value = (Object)this.get(key);
        
        try{
            return value.toString();
        }
        catch(Exception e){
            return nullValue;
        }
    }
    
    public String[] getStringArr(String key, String nullValue){
        String[] value = (String[])this.get(key);
        
        try{
            return value;
        }
        catch(Exception e){
            return null;
        }
    }

    public Integer getIntObject(String key){
        Object value = (Object)this.get(key);
    
        try{
            return Integer.valueOf(value.toString(), 10);
        }
        catch(Exception e){
            return null;
        }
    }

    public Long getLongObject(String key){
        Object value = (Object)this.get(key);
        
        try{
            return Long.valueOf(value.toString(), 10);
        }
        catch(Exception e){
            return null;
        }
    }

    public Float getFloatObject(String key){
        Object value = (Object)this.get(key);
        
        try{
            return Float.valueOf(value.toString());
        }
        catch(Exception e){
            return null;
        }
    }

    public Double getDoubleObject(String key){
        Object value = (Object)this.get(key);
        
        try{
            return Double.valueOf(value.toString());
        }
        catch(Exception e){
            return null;
        }
    }

    public static String byteCut(String str, int bytelen){
        int i, lenCount=0;
        int strLen=str.length();
        
        for(i=0; i<strLen && lenCount<=bytelen ;i++){
            try{
                lenCount+=String.valueOf(str.charAt(i)).getBytes("UTF-8").length;
            }
            catch(UnsupportedEncodingException e){
                return str.substring(0, bytelen);
            }
        }
        
        if(lenCount>bytelen)
            return str.substring(0,i-1);
        else
            return str;
    }

}

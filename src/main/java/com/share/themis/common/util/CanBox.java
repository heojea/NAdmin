package com.share.themis.common.util;



import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;

import com.share.themis.common.exception.CanException;



/**
 * <pre>
 * </pre>
 * 
 * @author Park sang-heon
 * 
 */
public class CanBox extends HashMap<String, Object> {
	// private HashMap<String, Object> map;

	
	public CanBox() {
		// map = new HashMap<String, Object>();
	} // CanBox()

	public CanBox(Map<String, Object> map) {
		if(map != null){
			Iterator iter = map.keySet().iterator();
			while (iter.hasNext()) {
				String key = (String) iter.next();
				this.set(key, map.get(key));
			} // while
		}
	} // CanBox()

	public <E> void set(String name, E obj) {
		super.put(name, obj);
	} // set
	
	public void pushMap(Map map){
		Iterator<String> iter = map.keySet().iterator();
		while(iter.hasNext()){
			String key = (String)iter.next();
			set(key, map.get(key));
		} // while 
	} // pushMap()

	@SuppressWarnings("unchecked")
	public <E> E get(String name) {
		Object obj = super.get(name);
		if(obj == null){
			obj = "";
		}
		return (E) obj; //super.get(name);
	} // get()
	
	public Long getLong(String name){
		long result = 0L;
		Object obj = super.get(name);
		try{
			if(obj != null){
				if(obj instanceof String)
					result = Long.parseLong((String)obj);
				else if(obj instanceof Number)
					result = ((Number)obj).longValue();
			} // if
		} catch(Exception e){
			result = 0L;
		} // try
		return result;
	} // getLong()
	
	
	public Integer getInt(String name){
		Integer result = 0;
		Object obj = super.get(name);
		try{
			if(obj != null){
				if(obj instanceof String)
					result = Integer.parseInt((String)obj);
				else if(obj instanceof Number)
					result = ((Number)obj).intValue();
			}
		} catch(Exception e){
			result = 0;
		} // try
		return result;
	} // getInt()
	
	public Short getShort(String name){
		Short result = 0;
		Object obj = super.get(name);
		try{
			if(obj != null){
				if(obj instanceof String)
					result = Short.parseShort((String)obj);
				else if(obj instanceof Number)
					result = ((Number)obj).shortValue();
			} // if
		} catch(Exception e){
			result = 0;
		} // try
		return result;
	} // getShort()

	public Double getDouble(String name){
		Double result = 0.0D;
		Object obj = super.get(name);
		try{
			if(obj != null){
				if(obj instanceof String)
					result = Double.parseDouble((String)obj);
				else if(obj instanceof Number)
					result = ((Number)obj).doubleValue();
			} // if
		} catch(Exception e){
			result = 0.0D;
		} // try
		return result;
	} // getDouble()
	
	
	public Float getFloat(String name){
		Float result = 0.0f;
		Object obj = super.get(name);
		try{
			if(obj != null){
				if(obj instanceof String)
					result = Float.parseFloat((String)obj);
				else if(obj instanceof Number)
					result = ((Number)obj).floatValue();
			} // if
		} catch(Exception e){
			result = 0.0f; 
		} // try
		return result;
	} // getFloat()
	
	
	public Boolean getBoolean(String name){
		Boolean result = false;
		Object obj = super.get(name);
		try{
			if(obj != null){
				if(obj instanceof String)
					result = Boolean.parseBoolean((String)obj);
				else if(obj instanceof Boolean)
					result = (Boolean)obj;
			} // if
		} catch(Exception e){
			result = false;
		} // try
		return result;
	} // getBoolean()
	
	
	public String getString(String name){
		String result = "";
		Object obj = super.get(name);
		try{
			if(obj != null){
				if(obj instanceof String){
					result = (String)obj;
				} else if(obj instanceof Double){
					result = String.valueOf((Double)obj);
				} else if(obj instanceof Float){
					result = String.valueOf((Float)obj);
				} else if(obj instanceof Long){
					result = String.valueOf((Long)obj);
				} else if(obj instanceof Integer){
					result = String.valueOf((Integer)obj);
				} else if(obj instanceof Short){
					result = String.valueOf((Short)obj);
				} else if(obj instanceof Character){
					result = String.valueOf((Character)obj);
				} else if(obj instanceof Boolean){
					result = String.valueOf((Boolean)obj);
				} else if(obj instanceof BigDecimal){
					result = ((BigDecimal)obj).toString();
				} else {
					result = obj.toString();
				} // if					
			} // if
		} catch(Exception e){
			result = "";
		} // try
		return result;
	} // getString()
	
	public String[] getNames() throws CanException {
		Iterator<String> iter = this.keySet().iterator();
		String[] names = new String[this.keySet().size()];
		for (int i = 0; iter.hasNext(); i++) {
			names[i] = iter.next();
		} // for
		return names;
	} // getNames()

	
	public CanBox clone() {
		CanBox box = new CanBox();
		// TODO : 占싱깍옙占쏙옙 占쏙옙占쏙옙

		return box;
	} // clone()

	public String toString() {
		StringBuffer str = new StringBuffer();
		Iterator<String> iter = super.keySet().iterator();
		
		while (iter.hasNext()) {
			try{
				String name = iter.next();
				Object value = super.get(name);
				if(value == null){
					str.append("[()" + name + " : " + super.get(name) + "]\n");
				} else {
					str.append("[(" + super.get(name).getClass().getName() + ")" + name + " : " + super.get(name) + "]\n");
				} // if
			} catch(Exception e){
			} //
		} // while
		return str.toString();
	} // toString()

	
	public String getJSON(int depth) {
		StringBuffer body = new StringBuffer();
		String[] keys;
		try {
			appendTab("{\n", body, depth);

			keys = this.getNames();
			for (int i = 0; i < keys.length; i++) {
				Object obj = this.get(keys[i]);
				if (obj instanceof CanBox) {
					String key = keys[i];
					appendTab("\"" + key.trim() + "\" : [\n", body, depth);
					appendTab(((CanBox) obj).getJSON(depth + 1), body, depth);
					appendTab("]", body, depth);
				} else {
					String key = keys[i];
					Object value = this.get(key);
					appendTab("\"" + key.trim() + "\" : \"" + value.toString()
							+ "\"", body, depth);
				} // if
				if (i < (keys.length - 1))
					body.append(",");
				body.append("\n");
			} // for
			appendTab("}", body, depth);
		} catch (CanException e) {
			e.printStackTrace();
		} // try

		return body.toString();
	} // getJSON()

	public String getJSON() {
		return getJSON(0);
	} // getJSON()

	protected void appendTab(String str, StringBuffer buf, int depth) {
		for (int i = 0; i < depth; i++)
			buf.append("\t");
		buf.append(str);
	} // appendTab
	
	
	public String queryString(){
		StringBuffer buffer = new StringBuffer();
		try{
			String[] names = this.getNames();
			int index = 0;
			for(String name : names){
				if(index != 0) buffer.append("&");
				String value = this.getString(name);
				buffer.append(URLEncoder.encode(name, "EUC-KR"));
				buffer.append("=");
				buffer.append(URLEncoder.encode(value, "EUC-KR"));
				index++;
			} // for
		} catch(Exception e){
		} // if
		
		return buffer.toString();
	} // queryString()
} // class CanBox
package com.share.themis.common.util;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.map.DataMap;

import org.json.JSONArray;
import org.json.JSONObject;

public class ResponseUtils {
    public static void jsonString(HttpServletResponse response, String string) throws IOException {
        response.setContentType("application/json");          
        response.setCharacterEncoding("utf-8");  
        System.out.println("################### JSON OBJECT ####################");
        System.out.println(string);
        System.out.println("################### JSON OBJECT ####################");
        response.getWriter().write(string);
    }
    
    public static void jsonBoolean(HttpServletResponse response, boolean bul) throws IOException {
        jsonString(response, bul?"true":"false");
    }
    
    public static void jsonMap(HttpServletResponse response, DataMap dataMap) throws Exception {
        String data = (new JSONObject(dataMap)).toString();
        jsonString(response, data);
    }
    
    public static void jsonList(HttpServletResponse response, List<DataMap> list) throws Exception {
        String data = (new JSONArray(list.toArray())).toString();
        jsonString(response, data);
    }
    
    public static void jsonListPaging(HttpServletResponse response, List<DataMap> list, int page, int cpp, int totalCnt) throws Exception {
        String data = (new JSONArray(list.toArray())).toString();
        data = "{\"page\":" + page + ", \"cpp\":" + cpp + ", \"totalCnt\":" + totalCnt + ", \"list\":" + data + "}";
        jsonString(response, data);
    }
}

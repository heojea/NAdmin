package com.share.themis.common.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.seedCrypt.SeedCrypt;


/**
 * vo값을 바인딩해준다
 */
public class BindingUtils {

    /**
     * VO에 담겨있는 내용을 DataMap로 담는다
     * @param obj (vo)
     * @return
     */
    public static DataMap voToDataMap(Object obj) {
        DataMap dataMap = new DataMap();
        // 사이트 아이디, 지점아이디 , 자동차 아이디에 한해 String으로 변환해주고 복호화를 한다
        for (Field field: obj.getClass().getDeclaredFields()) {
            try {
                field.setAccessible(true);
                if("siteId".equals(field.getName())
                        || "storeCd".equals(field.getName())
                        || "carId".equals(field.getName())
                ) {
                    dataMap.put(field.getName(), SeedCrypt.decrypt(field.get(obj).toString()));
                } else {
                    dataMap.put(field.getName(), field.get(obj));
                }
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }

        return dataMap;
    }

}

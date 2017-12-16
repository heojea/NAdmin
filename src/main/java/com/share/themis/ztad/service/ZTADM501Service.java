package com.share.themis.ztad.service;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.CommonUtils;
import com.share.themis.ztad.dao.ZTADM501Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM501Service {
    @Autowired
    private ZTADM501Dao ztadm501Dao;
    
    public List<DataMap> selectTempleteList(DataMap param) throws Exception {
        return ztadm501Dao.selectTempleteList(param);
    }
    
    public DataMap selectTemplete(DataMap param) throws Exception {
        return ztadm501Dao.selectTemplete(param);
    }
    
    public void insertTemplete(DataMap param) throws Exception {
        param.put("temp_no", System.currentTimeMillis());
        ztadm501Dao.insertTemplete(param);
    }
    
    public int updateTemplete(DataMap param) throws Exception {
        return ztadm501Dao.updateTemplete(param);
    }
    
    public void deleteTemplete(DataMap param) throws Exception {
        ztadm501Dao.deleteTemplete(param);
    }
}

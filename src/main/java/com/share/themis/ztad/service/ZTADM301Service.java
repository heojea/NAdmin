package com.share.themis.ztad.service;

import java.util.List;

import com.share.themis.common.map.DataMap;
import com.share.themis.ztad.dao.ZTADM301Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM301Service {
    @Autowired
    private ZTADM301Dao ztadm301Dao;
    
    public void insertMajorCode(DataMap param) throws Exception {
        ztadm301Dao.insertMajorCode(param);
    }
    
    public void insertMinorCode(DataMap param) throws Exception {
        ztadm301Dao.insertMinorCode(param);
    }
    
    public int updateMajorCode(DataMap param) throws Exception {
        return ztadm301Dao.updateMajorCode(param);
    }
    
    public int updateMinorCode(DataMap param) throws Exception {
        return ztadm301Dao.updateMinorCode(param);
    }
    
    public void deleteMajorCode(DataMap param) throws Exception {
        ztadm301Dao.deleteMajorCode(param);
    }
    
    public void deleteMinorCode(DataMap param) throws Exception {
        ztadm301Dao.deleteMinorCode(param);
    }
    
    public List<DataMap> selectMajorCodeList(DataMap param) throws Exception {
        return ztadm301Dao.selectMajorCodeList(param);
    }
    
    public List<DataMap> selectMinorCodeList(DataMap param) throws Exception {
        return ztadm301Dao.selectMinorCodeList(param);
    }
    
    public DataMap selectMajorCode(DataMap param) throws Exception {
        List<DataMap> list = ztadm301Dao.selectMajorCodeList(param);
        if (list.size() == 1)
            return list.get(0);
        else
            return new DataMap();
    }
    
    public DataMap selectMinorCode(DataMap param) throws Exception {
        List<DataMap> list = ztadm301Dao.selectMinorCodeList(param);
        if (list.size() == 1)
            return list.get(0);
        else
            return new DataMap();
    }
}

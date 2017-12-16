package com.share.themis.zsys.service;

import java.util.List;

import com.share.themis.common.map.DataMap;
import com.share.themis.zsys.dao.ZSYSP201Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZSYSP201Service {
    @Autowired
    private ZSYSP201Dao zsysp201Dao;
    
    public List<DataMap> selectZipList(DataMap param) throws Exception {
        return zsysp201Dao.selectZipList(param);
    }

    public List<DataMap> selectSidoList() throws Exception {
        return zsysp201Dao.selectSidoList();
    }

    public List<DataMap> selectGugunList(DataMap param) throws Exception {
        return zsysp201Dao.selectGugunList(param);
    }
}

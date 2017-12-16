package com.share.themis.ztad.service;

import java.util.List;

import com.share.themis.common.map.DataMap;
import com.share.themis.ztad.dao.ZTADM401Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZTADM401Service {
    @Autowired
    private ZTADM401Dao ztadm401Dao;
    
    public List<DataMap> selectBoardList(DataMap param) throws Exception {
        return ztadm401Dao.selectBoardList(param);
    }
    
    public List<DataMap> selectCategoryList(DataMap param) throws Exception {
        return ztadm401Dao.selectCategoryList(param);
    }
    
    public DataMap selectBoard(DataMap param) throws Exception {
        return ztadm401Dao.selectBoard(param);
    }
    
    public void insertCategory(DataMap param) throws Exception {
        param.put("category_no", System.currentTimeMillis());
        ztadm401Dao.insertCategory(param);
    }
    
    public void deleteCategory(DataMap param) throws Exception {
        ztadm401Dao.deleteCategory(param);
    }
    
    public int updateCategory(DataMap param) throws Exception {
        return ztadm401Dao.updateCategory(param);
    }
    
    public void insertBoard(DataMap param) throws Exception {
        param.put("board_no", System.currentTimeMillis());
        ztadm401Dao.insertBoard(param);
        
        /*
        String[] categoryNos = (String[])param.get("category_no");
        String[] categoryNms = (String[])param.get("category_nm");
        String[] categorySeqs = (String[])param.get("order_seq");
        if(categoryNos != null){
            for(int i=0;i<categoryNos.length;i++){
                DataMap pmap = new DataMap();
                
                pmap.put("board_no", param.get("board_no"));
                pmap.put("category_nm", categoryNms[i]);
                pmap.put("order_seq", categorySeqs[i]);
                pmap.put("reg_id", param.get("reg_id"));
                pmap.put("mod_id", param.get("mod_id"));
    
                pmap.put("category_no", System.currentTimeMillis());
                ztadm401Dao.insertCategory(pmap);
            }
        }*/
    }
    
    public int updateBoard(DataMap param) throws Exception {
        /*
        String[] categoryNos = (String[])param.get("category_no");
        String[] categoryNms = (String[])param.get("category_nm");
        String[] categorySeqs = (String[])param.get("order_seq");
        if(categoryNos != null){
            for(int i=0;i<categoryNos.length;i++){
                DataMap pmap = new DataMap();
                
                pmap.put("board_no", param.get("board_no"));
                pmap.put("category_no", categoryNos[i]);
                pmap.put("category_nm", categoryNms[i]);
                pmap.put("order_seq", categorySeqs[i]);
                pmap.put("reg_id", param.get("reg_id"));
                pmap.put("mod_id", param.get("mod_id"));
                
                if(StringUtils.isEmpty(pmap.getString("category_no"))){
                    pmap.put("category_no", System.currentTimeMillis());
                    ztadm401Dao.insertCategory(pmap);
                }else{
                    ztadm401Dao.updateCategory(pmap);
                }
            }
        }
        
        String[] delCategoryNos = (String[])param.get("del_category_no");
        if(delCategoryNos != null){
            for(int i=0;i<delCategoryNos.length;i++){
                DataMap pmap = new DataMap();
                
                pmap.put("board_no", param.get("board_no"));
                pmap.put("category_no", delCategoryNos[i]);
                
                ztadm401Dao.deleteCategory(pmap);
            }
        }
        */
        return ztadm401Dao.updateBoard(param);
    }

    public int deleteBoard(DataMap param) throws Exception {
        return ztadm401Dao.deleteBoard(param);
    }
}

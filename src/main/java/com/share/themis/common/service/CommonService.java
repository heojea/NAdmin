package com.share.themis.common.service;

import java.io.File;
import java.util.List;

import com.share.themis.common.dao.CommonDao;
import com.share.themis.common.map.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonService {
    @Autowired
    private CommonDao commonDao;
    
    /**
     * 1뎁스 메뉴 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectDepth1MenuList(DataMap param) throws Exception {
        param.put("menu_depth", "1");
        return commonDao.selectMenuList(param);
    }
    
    /**
     * 2뎁스 메뉴 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectDepth2MenuList(DataMap param) throws Exception {
        param.put("menu_depth", "2");
        return commonDao.selectMenuList(param);
    }
    
    /**
     * 3뎁스 메뉴 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectDepth3MenuList(DataMap param) throws Exception {
        param.put("menu_depth", "3");
        return commonDao.selectMenuList(param);
    }
    
    /**
     * 디폴트 1뎁스 메뉴 조회
     * @param param
     * @return
     * @throws Exception
     */
    public DataMap selectDefaultDepth1Menu(DataMap param) throws Exception {
        param.put("menu_depth", "1");
        param.put("limit", 1);
        return commonDao.selectDefaultMenu(param);
    }
    
    /**
     * 공통코드 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectCodeList(DataMap param) throws Exception {
        return commonDao.selectCodeList(param);
    }
    
    /**
     * 공통코드 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectCodeListByMajor(String major_cd) throws Exception {
        DataMap param = new DataMap();
        param.put("major_cd", major_cd);
        return commonDao.selectCodeList(param);
    }
    
    /**
     * 운영관제 공통코드 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectHeraCodeList(DataMap param) throws Exception {
        return commonDao.selectHeraCodeList(param);
    }
    
    /**
     * 운영관제 공통코드 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectHeraCodeListByMajor(String major_cd) throws Exception {
        DataMap param = new DataMap();
        param.put("major_cd", major_cd);
        return commonDao.selectHeraCodeList(param);
    }
    
    /**
     * 사이트 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectSiteList(DataMap param) throws Exception {
        return commonDao.selectSiteList(param);
    }
    
    /**
     * 시간가져오기
     * @param param
     * @return
     * @throws Exception
     */
    public DataMap selectDate(DataMap param) throws Exception {
        return commonDao.selectDate(param);
    }
    
    /**
     * 시도구분 조회
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectSidoList(DataMap param) throws Exception {
        return commonDao.selectSidoList(param);
    }
    
    /**
     * 구군구분 조회  #sido_cd#
     * @param param
     * @return
     * @throws Exception
     */
    public List<DataMap> selectGugunList(DataMap param) throws Exception {
        return commonDao.selectGugunList(param);
    }
    
    /**
     * 파일 존재유무 체크
     * @param param
     * @return
     * @throws Exception
     */
    public boolean isExistFile(DataMap param) throws Exception {
        String FILE_SEP = System.getProperty("file.separator");
        String fileName = param.getString("file");
        String fileDir = param.getString("dir");
        String filePath = param.getString("filePath");
        File file = new File(filePath+FILE_SEP+fileDir+FILE_SEP+fileName.substring(0, 8)+FILE_SEP+fileName);
        return file.exists();
    }
  
	public List<DataMap>  selectCommonCode(DataMap param) throws Exception{
        return commonDao.selectCommonCode(param);
    }
	
}

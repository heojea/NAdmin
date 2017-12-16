package com.share.themis.common.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.share.themis.common.map.DataMap;
import com.share.themis.common.property.ConfigurationService;
import com.share.themis.common.util.CommonUtils;
import com.share.themis.common.util.DateUtils;
import com.share.themis.common.util.ResponseUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileUploadController {

    private static final String FILE_SEP = System.getProperty("file.separator");
    private static final int BUFF_SIZE = 2048;
    private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);
    
    @Autowired
    private ConfigurationService config;
    
    /**
     * 파일 업로드
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = {"/zcom/uploadFile.do", "/pcom/uploadFile.do"})
    public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        List<DataMap> uploadFileList = new ArrayList<DataMap>();
        
        MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)request;
        Map<String, MultipartFile> files = mptRequest.getFileMap();
        
        String root = config.getString("file.upload.path");//  request.getSession().getServletContext().getRealPath("");
        String webroot = config.getString("file.upload.url");
        
        String yyyyMMdd = DateUtils.getCurrentDate("yyyyMMdd");
        
        Iterator fileIterator = files.values().iterator();
        MultipartFile file = null;        
        while (fileIterator.hasNext()) {
            file = (MultipartFile)fileIterator.next();
            
            System.out.println("origin file name : "+file.getOriginalFilename());
            String originFileName = file.getOriginalFilename();
            if (originFileName != null) {                
                
                String ext = originFileName.substring(originFileName.lastIndexOf(".")+1);
                String fileName = yyyyMMdd+CommonUtils.generateKey()+"_"+ext;
                String dir = root + FILE_SEP + mptRequest.getParameter("dir") + FILE_SEP + yyyyMMdd + FILE_SEP;
                String webdir = webroot + "/" + mptRequest.getParameter("dir") + "/" + yyyyMMdd + "/";
                long fileSize = 0;
                System.out.println(dir);
                
                File subdir = new File(dir);
                if (!subdir.exists()) {
                    subdir.mkdirs();
                }
                System.out.println(file.getSize());
                if (file.getSize() > 0) {
                    fileSize = file.getSize();
                    
                    InputStream istream = null;
                    OutputStream ostream = null;
                    try {
                        istream = file.getInputStream();
                        ostream = new FileOutputStream(dir + FILE_SEP + fileName);
                        
                        int bytesRead = 0;
                        byte[] buffer = new byte[BUFF_SIZE];
                        
                        while ((bytesRead = istream.read(buffer, 0, BUFF_SIZE)) != -1) {
                            ostream.write(buffer, 0, bytesRead);
                        }
                    }
                    catch (Exception e) {
                        logger.error(e.getMessage(), e);
                        result = false;
                    }
                    finally {
                        if (istream != null) try { istream.close(); } catch (Exception i) {}
                        if (ostream != null) try { ostream.close(); } catch (Exception o) {}
                    }
                }
                DataMap data = new DataMap();
                data.put("originFileName", originFileName);
                data.put("fileName", fileName);
                data.put("filePath", webdir);
                data.put("fileSize", fileSize);
                data.put("result", String.valueOf(result));
                uploadFileList.add(data);
            }
        }        
        ResponseUtils.jsonList(response, uploadFileList);
    }
    
}

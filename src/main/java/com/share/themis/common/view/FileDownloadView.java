package com.share.themis.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView {
    
    public FileDownloadView() {
        setContentType("application/octet-stream; charset=utf-8");
    }

    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("############## FILE INFO ###############");
        System.out.println(model);
        System.out.println("############## FILE INFO ###############");
        if (model == null || model.get("fileFullPath") == null || ((String)model.get("fileFullPath")).length() == 0) return;
        File file = new File((String)model.get("fileFullPath"));
        if (!file.exists()) return; 
        String fileName = (String)model.get("fileName");
        
        response.setContentType(getContentType());
        response.setContentLength((int)file.length());
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20") + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");

        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
        } finally {
            if (fis != null) {
                fis.close();
            }
        }
        out.flush();        
    }
}

package com.share.themis.common.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="car")
public class SmsDispatch {
    
    private int requestId;       //request 아이디
    private String context;      
    private String carReceiveNo;    
    private String Receiver;        
    private String result;          
    private String mod_id;
    
    public int getRequestId() {
        return requestId;
    }
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
    public String getContext() {
        return context;
    }
    public void setContext(String context) {
        this.context = context;
    }
    public String getCarReceiveNo() {
        return carReceiveNo;
    }
    public void setCarReceiveNo(String carReceiveNo) {
        this.carReceiveNo = carReceiveNo;
    }
    public String getResult() {
        return result;
    }
    public void setResult(String result) {
        this.result = result;
    }
    public String getReceiver() {
        return Receiver;
    }
    public void setReceiver(String receiver) {
        Receiver = receiver;
    }
    public String getMod_id() {
        return mod_id;
    }
    public void setMod_id(String mod_id) {
        this.mod_id = mod_id;
    }
}

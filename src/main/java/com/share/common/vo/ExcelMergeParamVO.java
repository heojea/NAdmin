package com.share.common.vo;

/**
 * @author  ZZ04717
 */
public class ExcelMergeParamVO {
	
	/**
	 * @uml.property  name="fROM"
	 */
	private String FROM;
	/**
	 * @uml.property  name="tO"
	 */
	private String TO;
	
	public ExcelMergeParamVO(String from, String to){
		this.FROM = from;
		this.TO = to;
	}
	
	/**
	 * @return
	 * @uml.property  name="fROM"
	 */
	public String getFROM() {
		return FROM;
	}
	/**
	 * @param fROM
	 * @uml.property  name="fROM"
	 */
	public void setFROM(String fROM) {
		FROM = fROM;
	}
	/**
	 * @return
	 * @uml.property  name="tO"
	 */
	public String getTO() {
		return TO;
	}
	/**
	 * @param tO
	 * @uml.property  name="tO"
	 */
	public void setTO(String tO) {
		TO = tO;
	}
}

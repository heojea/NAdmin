package com.share.themis.common.exception;



import java.io.StringWriter;
import java.io.PrintWriter;


public class CanException extends Exception {

	private static final long serialVersionUID = -1857606101933665372L;

	private String msg;

	private String errCode;
	private Throwable rootCause;

	public CanException() {
	} // CanException()

	public CanException(String msg) {
		super(msg);
	}

	public CanException(Throwable rootCause) {
		this("", rootCause);
	}

	public CanException(String msg, Throwable rootCause) {
		super(msg);
		this.msg = msg;
		this.rootCause = rootCause;
	}

	public String getStackTraceString() {
		StringWriter writer = new StringWriter();
		this.printStackTrace(new PrintWriter(writer));
		return writer.toString();
	}
	
	public Throwable getCause(){
		return this.rootCause;
	}
	
	public String getMessage(){
		if(rootCause != null){
			return this.rootCause.getMessage();
		} else {
			return super.getMessage();
		}
	}
	
} // class CanException
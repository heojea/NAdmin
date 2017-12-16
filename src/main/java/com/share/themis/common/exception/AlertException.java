package com.share.themis.common.exception;

public class AlertException extends Exception {
	private static final long serialVersionUID = 6234733708104436469L;

	public AlertException(String message) {
		super(message);
	}
	
	public AlertException(String message, Throwable cause) {
		super(message, cause);
	}
}

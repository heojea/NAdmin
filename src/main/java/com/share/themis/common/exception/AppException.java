package com.share.themis.common.exception;

public class AppException extends Exception {
	private static final long serialVersionUID = -2859864058136050568L;

	public AppException(String message) {
		super(message);
	}
	
	public AppException(String message, Throwable cause) {
		super(message, cause);
	}
}

package com.breeze2017.breezer.exception;

public class UserDaoException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public UserDaoException() {
		super( "UserDao Exception occurs" );
	}

	public UserDaoException( String message ) {
		super(message);
	}
	
}

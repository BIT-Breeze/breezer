package com.breeze2017.breezer.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.user.UserMainDao;
import com.breeze2017.breezer.vo.UserVo;

@Service
public class UserMainService {
	
	@Autowired
	private UserMainDao userMainDao;
	
	public UserVo getUserInfo(String id) {
		
		UserVo result = userMainDao.getUserInfo(id);
		System.out.println("UserMainService" 
							+ result.toString() 
							+ result.getTours());
		return result;
		
	}
}

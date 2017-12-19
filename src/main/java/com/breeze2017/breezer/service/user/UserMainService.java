package com.breeze2017.breezer.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMainDao;
import com.breeze2017.breezer.repository.user.UserMainDao;
import com.breeze2017.breezer.vo.TourVo;
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
	
	
	/* test code for country button */
	@Autowired
	TourMainDao tourMainDao;
	
	public List<TourVo> getTours(String id){
		System.out.println("TourMainService");
		System.out.println(id);
		List<TourVo> result = userMainDao.getTours(id);
		
		return result;
	}
	/* End : test code for country button */
}

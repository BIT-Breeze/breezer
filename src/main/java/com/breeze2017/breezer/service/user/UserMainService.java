package com.breeze2017.breezer.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMainDao;
import com.breeze2017.breezer.repository.user.UserMainDao;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.breezer.vo.UserVo;

@Service
public class UserMainService {
	
	//private static final int LIST_SIZE = 6;
	//private static final int PAGE_SIZE = 5;	
	
	@Autowired
	private UserMainDao userMainDao;
	
	public UserVo getUserInfo(String id) {
		System.out.println("==UserMainService getUserInfo()==");
		UserVo result = userMainDao.getUserInfo(id);		

		return result;		
	}	
	
	/* test code for country button */
	@Autowired
	TourMainDao tourMainDao;
	
	public List<TourVo> getTours(String id){
		System.out.println("==UserMainService getTours()==");
		List<TourVo> result = userMainDao.getTours(id);
		
		return result;
	}
	
	public List<TourVo> getTours(String id, Long startNo){
		System.out.println("UserMainService - with 2 params");
		//System.out.println(id);
		//System.out.println(startNo);
		List<TourVo> result = userMainDao.getTours(id, startNo);
		
		return result;
	}
	
	
	

}

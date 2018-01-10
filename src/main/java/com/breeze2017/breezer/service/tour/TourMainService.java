package com.breeze2017.breezer.service.tour;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMainDao;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.TourVo;

@Service
public class TourMainService {
	
	@Autowired
	private TourMainDao tourMainDao;
	
	public List<PostVo> getPostList(String userId, int tourIdx){
		return tourMainDao.getPostList(userId, tourIdx);
	}
	
	public TourVo getTour(String userId, int tourIdx){
		return tourMainDao.getTour(userId, tourIdx);
	}
}

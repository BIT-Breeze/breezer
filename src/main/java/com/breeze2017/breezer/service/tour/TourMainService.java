package com.breeze2017.breezer.service.tour;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMainDao;
import com.breeze2017.breezer.vo.PostVo;

@Service
public class TourMainService {
	
	@Autowired
	private TourMainDao tourMainDao;
	
	public List<PostVo> getTour(String userId, int tourIdx){
		return tourMainDao.getTour(userId, tourIdx);
	}
}

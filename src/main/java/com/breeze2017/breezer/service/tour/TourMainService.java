package com.breeze2017.breezer.service.tour;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMainDao;
import com.breeze2017.breezer.vo.TourVo;

@Service
public class TourMainService {
	
	@Autowired
	TourMainDao tourMainDao;
	
	public List<TourVo> getTours(String id){
		System.out.println("TourMainService");
		List<TourVo> result = tourMainDao.getTours(id);
		
		return result;
	}

}

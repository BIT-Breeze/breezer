package com.breeze2017.breezer.service.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMainHeaderDao;
import com.breeze2017.breezer.vo.TourVo;

@Service
public class TourMainHeaderService {
	
	@Autowired
	private TourMainHeaderDao tourMainHeaderDao;
	
	public TourVo getTourInfo(long tourIdx) {
		return tourMainHeaderDao.getTourInfo(tourIdx);
	}
	
	public boolean modify(TourVo vo) {
		System.out.println("modify service!!!");
		return tourMainHeaderDao.modify(vo) == 1;
	}
}

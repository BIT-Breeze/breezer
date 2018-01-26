package com.breeze2017.breezer.service.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourAddDao;
import com.breeze2017.breezer.vo.TourVo;

@Service
public class TourAddService {
	
	@Autowired
	private TourAddDao tourAddDao;
	
	public boolean insertMessage(TourVo vo) {
		return tourAddDao.insert(vo) == 1;
	}
	
	
}

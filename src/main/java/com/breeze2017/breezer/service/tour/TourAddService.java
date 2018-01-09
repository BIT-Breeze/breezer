package com.breeze2017.breezer.service.tour;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourAddDao;
import com.breeze2017.breezer.vo.TourVo;

@Service
public class TourAddService {
	
	@Autowired
	private TourAddDao tourAddDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	public boolean insertMessage(TourVo vo) {
		System.out.println("TourAddService vo >> " + vo);
		
		return tourAddDao.insert(vo) == 1;
		
	}
	
}

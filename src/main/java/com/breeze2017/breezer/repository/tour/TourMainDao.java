package com.breeze2017.breezer.repository.tour;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.TourVo;

@Repository
public class TourMainDao {
	
	@Autowired
	private SqlSession sqlSession;

	public List<TourVo> getTours(String id) {
		
		System.out.println("TourMainDao");
		List<TourVo> result = sqlSession.selectList("tourget.gettours", id);
		
		
		return result;
	}

}

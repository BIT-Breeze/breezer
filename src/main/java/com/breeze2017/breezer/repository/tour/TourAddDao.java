package com.breeze2017.breezer.repository.tour;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.TourVo;

@Repository
public class TourAddDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insert(TourVo vo) {
		return sqlSession.insert("tour.insert", vo);
		
	}
	
	public int modify(TourVo vo) {
		System.out.println("update DAO DAO DAO!!!!!!!!!!");
		return sqlSession.update("tour.modify", vo);
	}
	
}

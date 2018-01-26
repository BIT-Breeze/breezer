package com.breeze2017.breezer.repository.tour;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.TourVo;

@Repository
public class TourMainHeaderDao {

	@Autowired
	private SqlSession sqlSesstion;

	public TourVo getTourInfo(long tourIdx) {
		TourVo vo = sqlSesstion.selectOne("tourMainInfo.getTourInfo", tourIdx);
		return vo;
	}
	
	
	public int modify(TourVo vo) {
		System.out.println("modify DAO DAO DAO!!!!");
		return sqlSesstion.update("tour.modify", vo);
	}

}

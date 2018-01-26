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
		System.out.println("DAO 호출 : " + tourIdx);
		TourVo vo = sqlSesstion.selectOne("tourMainInfo.getTourInfo", tourIdx);
		return vo;
	}
	

}

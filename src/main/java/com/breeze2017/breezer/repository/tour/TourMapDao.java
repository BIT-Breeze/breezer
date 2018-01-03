package com.breeze2017.breezer.repository.tour;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.MapVo;

@Repository
public class TourMapDao {
	
	@Autowired
	private SqlSession sqlsession;
	
	public List<MapVo> selectList(){
		return sqlsession.selectList("maptest.select");
	}
}

package com.breeze2017.breezer.repository.tour;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.MapVo;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.TourVo;

@Repository
public class TourMapDao {
	
	@Autowired
	private SqlSession sqlsession;
	
	public List<MapVo> selectList(){
		return sqlsession.selectList("tourmap.select");
	}
	
	public List<TourVo> getTourData(TourVo tourVo){
		return sqlsession.selectList("tourmap.gettourdata", tourVo);
	}
	
	public List<PostVo> getMapInfo(PostVo postVo){
		return sqlsession.selectList("tourmap.getmapinfo", postVo);
	}

}

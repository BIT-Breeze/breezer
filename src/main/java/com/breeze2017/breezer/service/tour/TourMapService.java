package com.breeze2017.breezer.service.tour;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMapDao;
import com.breeze2017.breezer.vo.MapVo;
import com.breeze2017.breezer.vo.PostVo;

@Service
public class TourMapService {
	
	@Autowired
	private TourMapDao tourMapDao;
	
	public List<MapVo> getData(){
		return tourMapDao.selectList();
	}
	
	public List<PostVo> getMapInfo(PostVo postVo){
		return tourMapDao.getMapInfo(postVo);
	}

}

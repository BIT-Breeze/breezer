package com.breeze2017.breezer.service.sns;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.sns.SnsMainDao;
import com.breeze2017.breezer.vo.SNSVo;

@Service
public class SnsMainService {

	@Autowired
	private SnsMainDao snsMainDao;
	
	public List<SNSVo> getListMessage(Map<String, Object> map) {
		List<SNSVo> list = snsMainDao.getList(map);
		return list;
	}
	
	
	public void doLikeMessage(String id, String flag, String type, long idx) {
		
		
		if (flag.equals("up")) {
			if (type.equals("tour")) {
				snsMainDao.insertFavorite( id, idx, null);
			} else {
				snsMainDao.insertFavorite( id, null, idx);
			}
		} else {
			if (type.equals("tour")) {
				snsMainDao.deleteTourFavorite( id, idx);
			} else {
				snsMainDao.deletePostFavorite( id, idx);
			}
		}
		
		
		// 갯수 refresh 
		if (type.equals("tour")) {
			snsMainDao.refreshTourFavorite(idx);
		} else {
			snsMainDao.refreshPostFavorite(idx);
		}

			
	
	
		
		
		
		
	}
}

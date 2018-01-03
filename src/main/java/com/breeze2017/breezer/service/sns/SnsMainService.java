package com.breeze2017.breezer.service.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.sns.SnsMainDao;
import com.breeze2017.breezer.vo.SNSVo;

@Service
public class SnsMainService {

	@Autowired
	private SnsMainDao snsMainDao;
	
	public List<SNSVo> getListMessage(long idx) {
		List<SNSVo> list = snsMainDao.getList(idx);
		return list;
	}
}

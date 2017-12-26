package com.breeze2017.breezer.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.user.UserRegisterIdDao;
import com.breeze2017.breezer.vo.UserVo;

@Service
public class UserRegisterIdService {
	
	@Autowired
	private UserRegisterIdDao userRegisterIdDao;

	
	// fbid 로 id 설정하기 
	public boolean setIdByFbIdMessage(UserVo vo) {
		return userRegisterIdDao.setIdByFbId(vo) == 1;
	}
	
	public boolean checkIdMessage(UserVo vo) {
		return userRegisterIdDao.checkId(vo) == 0; //0개 여야지 성공 
	}

}

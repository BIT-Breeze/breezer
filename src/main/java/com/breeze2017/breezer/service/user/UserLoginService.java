package com.breeze2017.breezer.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.user.UserLoginDao;
import com.breeze2017.breezer.vo.UserVo;

@Service
public class UserLoginService {
	@Autowired
	private UserLoginDao userLoginDao;

	// 전체적인 로그인
	public UserVo loginMessage(UserVo vo) {
		// fbId 로 유저가 존재하는지 채크
		UserVo getVo = userLoginDao.getUserByFbId(vo);
		
		if ( getVo != null) {
			// 있으면 token, expiresIn 을 업데이트
			System.out.println("userService id is already exist");
			userLoginDao.resetByFbId(getVo);
			return getVo;
		} else {
			// 없으면 joinMessage
			System.out.println("userService id is not exist - join");
			userLoginDao.joinUser(vo);
			return vo;
		}
	}
	
	// Id로 유저정보 가져오기 
	public UserVo getUserByIdMessage(UserVo vo) {
		return userLoginDao.getUserById(vo);
	}
	
	// fbid 로 id 설정하기 
	public boolean setIdByFbIdMessage(UserVo vo) {
		return userLoginDao.setIdByFbId(vo) == 1;
	}
	
	
}

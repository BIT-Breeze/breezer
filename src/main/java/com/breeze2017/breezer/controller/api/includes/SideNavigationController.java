package com.breeze2017.breezer.controller.api.includes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.user.UserMainService;
import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.AuthUser;

@Controller
@RequestMapping("/{id}/sideNavi")
public class SideNavigationController {
	
	@Autowired
	private UserMainService userMainService;
	
	@ResponseBody
	@RequestMapping( "" )
	public JSONResult getUserinfo(@AuthUser UserVo authUser,
								  @PathVariable String id) {
		System.out.println("SideNaviController - gerUserInfo");
		UserVo uservo = userMainService.getUserInfo(id);
		if(uservo == null ) {			
			return JSONResult.fail("존재하는 유저가 없습니다.");
		}
				
		return JSONResult.success(uservo);
	}

}

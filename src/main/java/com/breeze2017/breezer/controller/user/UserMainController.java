package com.breeze2017.breezer.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.user.UserMainService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.AuthUser;

@Controller
@RequestMapping("/{id}")
public class UserMainController {
	
	@Autowired
	private UserMainService userMainService;
	
	
	
	@RequestMapping( "" )
	public String getUser(@AuthUser UserVo authUser, Model model) {
		System.out.println("UserMainController");			
		// 파라미터는 유저객체가 와도 메소드는 string 파라미터를 받으니까 아래 처럼 사용하면 됨. 

		UserVo uservo = userMainService.getUserInfo(authUser.getId());
		System.out.println(uservo.getTours());
		model.addAttribute("uservo", uservo);
		return "user/user_main";
	}
	
	@RequestMapping( "/tourlist" )
	@ResponseBody
	public JSONResult getTours(@AuthUser UserVo authUser) {
		//System.out.println("JSON REQUEST CONTROLLER");
		List<TourVo> tours = userMainService.getTours(authUser.getId());		
		//System.out.println("JSON REQUEST CONTROLLER2");
		//System.out.println(tours);
		return JSONResult.success(tours);
	}
		
}

package com.breeze2017.breezer.controller.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		System.out.println(uservo);
		System.out.println(uservo.getTours());
		model.addAttribute("uservo", uservo);
		return "user/user_main";
	}
	
	@RequestMapping( "/tourlist1" )
	public String getTours1(
			//@AuthUser UserVo authUser, 
			Model model,
			@RequestParam( value="p", required=true, defaultValue="1")Integer page,
			@RequestParam( value="kwd", required=true, defaultValue="")String keyword
			
			) {
		System.out.println("Test paging");			
		// 파라미터는 유저객체가 와도 메소드는 string 파라미터를 받으니까 아래 처럼 사용하면 됨. 
		Map<String, Object> map = 
				userMainService.getTours1(page, keyword);
		
		model.addAttribute("map", map);
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

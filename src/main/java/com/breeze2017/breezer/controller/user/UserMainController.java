package com.breeze2017.breezer.controller.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.tour.TourMainService;
import com.breeze2017.breezer.service.user.UserMainService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.breezer.vo.UserVo;

@Controller
@RequestMapping("/{id}")
public class UserMainController {
	
	@Autowired
	private UserMainService userMainService;
	@Autowired
	private TourMainService	tourMainService;
	
	@RequestMapping( "" )
	public String getUser(Model model) {
				
		UserVo vo = new UserVo();
		vo = userMainService.getUserInfo("hongseok5@gmail.com");	
		
		model.addAttribute("uservo", vo);
		
		return "user/user_main";
	}
	
	@RequestMapping( "/tourlist" )
	@ResponseBody
	public JSONResult getTours(String id) {
		System.out.println("JSON REQUEST CONTROLLER");
		List<TourVo> tours = tourMainService.getTours("hongseok5@gmail.com");		
		System.out.println("JSON REQUEST CONTROLLER2");
		System.out.println(tours);
		return JSONResult.success(tours);
	}
		
}

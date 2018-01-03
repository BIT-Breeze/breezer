package com.breeze2017.breezer.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("UserMyInfo")
@RequestMapping("/{id}")
public class UserMyInfoController {
	
	@RequestMapping("/myinfo")
	public String myinfo() {
		
		return "user/user_myInfo";
	}
}

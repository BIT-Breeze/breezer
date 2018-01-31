package com.breeze2017.breezer.controller.sns;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.AuthUser;

@Controller("SnsMain")
@RequestMapping("/sns")
public class SnsMainController {
	@RequestMapping("")
	public String main(
			@AuthUser UserVo authUser,
			Model model) {
		
		System.out.println("====== SnsMainController : /sns ======");

		// 세션 확인
		if (authUser == null) {
			return "user/user_login";
		}
		
		model.addAttribute("userid", authUser.getId());
		
		return "sns/sns_main";
	}
}

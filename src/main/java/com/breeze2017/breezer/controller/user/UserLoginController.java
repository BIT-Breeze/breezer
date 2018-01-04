package com.breeze2017.breezer.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.AuthUser;

@Controller("UserLogin")
public class UserLoginController {

	// 로그인 화면
	@RequestMapping({ "/", "/login" })
	public String index(
			@AuthUser UserVo authUser,
			Model model) {
		System.out.println("====== UserLoginController : {'/', '/login} ======");

		// 세션이 없다면
		if (authUser == null) {
			System.out.println("authUser is null");
			return "user/user_login";
		}
		// 세션이 있지만 id가 없다면
		else if (authUser.getId() == null) {
			System.out.println("authUser.id is null");
			
			//return "user/user_register_id";
			model.addAttribute("authUser", authUser);
			return "user/user_login";
		}
		// 세션이 있다면
		else {
			System.out.println("authUser is exist");
			System.out.println("authUser : " + authUser);

			model.addAttribute("authUser", authUser);
			//return "user/user_main";
			return "redirect:/"+authUser.getId();
		}
	}

}

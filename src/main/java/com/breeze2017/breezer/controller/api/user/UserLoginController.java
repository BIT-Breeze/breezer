package com.breeze2017.breezer.controller.api.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breeze2017.breezer.vo.UserVo;

@Controller("UserLoginController")
public class UserLoginController {

	@Autowired
	private HttpServletRequest request;

	// 로그인 화면
	@RequestMapping({ "/", "/login" })
	public String index(Model model) {
		System.out.println("====== UserLoginController : {'/', '/login} ======");

		// 세션의 authUser 가져오기
		HttpSession session = request.getSession();
		UserVo authUser = (UserVo) session.getAttribute("authUser");

		// 세션이 없다면
		if (authUser == null) {
			System.out.println("/ : authUser is null");
			return "user/user_login";
		}
		// 세션이 있지만 id가 없다면
		else if (authUser.getId() == null) {
			return "user/join";
		}
		// 세션이 있다면
		else {
			System.out.println("/ : authUser is exist");
			System.out.println("authUser : " + authUser);

			model.addAttribute("id", authUser.getId());
			return "user/user_main";

			// RedirectView redirectView = new RedirectView("/"+vo.getId());
			// redirectView.setContextRelative(true);
			//
			// ModelAndView mav = new ModelAndView(redirectView);
			// return mav;

		}
	}
}

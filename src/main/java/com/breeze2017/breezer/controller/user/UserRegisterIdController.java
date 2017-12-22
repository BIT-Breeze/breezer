package com.breeze2017.breezer.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breeze2017.breezer.service.user.UserRegisterIdService;
import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.AuthUser;

@Controller("UserRegisterId")
public class UserRegisterIdController {
	
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private UserRegisterIdService userRegisterIdService;
	
	
	
	// id 설정 페이지로 이동
//	@RequestMapping("/join")
//	public String join() {
//		System.out.println("====== UserRegisterIdController : '/join' ======");
//		return "user/user_register_id";
//	}
	
	
	
	// id 를 저장시키기
	@RequestMapping("/setid")
	public String setId(
			//HttpServletRequest request, 
			@ModelAttribute UserVo vo, 
			@AuthUser UserVo authUser, 
			Model model) {

		System.out.println("====== UserRegisterIdController : '/setid' ======");
	
		
		// fbid 를 가져와 그곳에 id를 저장하고 authUser에 id 셋팅
		vo.setFbId(authUser.getFbId());
		userRegisterIdService.setIdByFbIdMessage(vo);
		authUser.setId(vo.getId());

		// 세션에 id가 들어간 authUser로 변경
		HttpSession session = request.getSession(true);
		session.setAttribute("authUser", authUser);
		
		// id와 nickName 을 jsp 로 전송
		model.addAttribute("authUser", authUser);

		return "user/user_main";
	}
}

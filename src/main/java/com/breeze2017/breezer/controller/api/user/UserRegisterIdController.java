package com.breeze2017.breezer.controller.api.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.user.UserRegisterIdService;
import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.AuthUser;

@Controller("UserRegisterIdApi")
@RequestMapping("/api/user")
public class UserRegisterIdController {

	@Autowired
	private UserRegisterIdService userRegisterIdService;

	@Autowired
	private HttpServletRequest request;

	// id 를 저장시키기
	@RequestMapping("/setid")
	@ResponseBody
	public JSONResult setId(
			@ModelAttribute UserVo vo, 
			@AuthUser UserVo authUser) {

		System.out.println("====== UserRegisterIdApiController : '/setid' ======");
		
		// fbid 를 가져와 그곳에 id를 저장하고 authUser에 id 셋팅
		vo.setFbId(authUser.getFbId());
		userRegisterIdService.setIdByFbIdMessage(vo);
		authUser.setId(vo.getId());
		authUser.setNickName(vo.getId());

		// 세션에 id가 들어간 authUser로 변경
		HttpSession session = request.getSession(true);
		session.setAttribute("authUser", authUser);
		
		return JSONResult.success(authUser.getId());
	}

	// id 중복확인 
	@RequestMapping("/checkid")
	@ResponseBody
	public JSONResult checkid(
			// HttpServletRequest request,
			@ModelAttribute UserVo vo, 
			@AuthUser UserVo authUser) {

		System.out.println("====== UserRegisterIdApiController : '/checkid' ======");

		// id 조회
		return JSONResult.success(userRegisterIdService.checkIdMessage(vo));
	}

}

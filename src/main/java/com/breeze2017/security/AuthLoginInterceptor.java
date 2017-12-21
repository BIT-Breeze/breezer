package com.breeze2017.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.user.UserLoginService;
import com.breeze2017.breezer.vo.UserVo;
import com.fasterxml.jackson.databind.ObjectMapper;

public class AuthLoginInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private UserLoginService userLoginService;
	
	@Override
	public boolean preHandle( 
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler
		)
		throws Exception {
		

		// 요청 url로 부터 변수 데이터를 받는다 
		UserVo vo = new UserVo();
		vo.setFbId(request.getParameter( "fbId" ));
		vo.setNickName(request.getParameter( "nickName"));
		vo.setToken(request.getParameter( "token" ));
		vo.setSignedRequest(request.getParameter("signedRequest"));
		vo.setExpiresIn(request.getParameter( "expiresIn" ));
		vo.setEmail(request.getParameter( "email" ));
		vo.setGender(request.getParameter( "gender" ));
		vo.setAgeRange(request.getParameter( "ageRange" ));
		vo.setLocale(request.getParameter( "locale" ));

		// pictureUrl 에 &oe= 때문에 뒤에가 짤리므로 이것을 pictureUrl 에 붙여준다 
		String pictureUrl = request.getParameter( "pictureUrl" ) +"&oe="+ request.getParameter( "oe" ); 
		vo.setPictureUrl(pictureUrl);
		
		// 받은 데이터로부터 user 정보를 가져온다 
		System.out.println("auth/user/login vo = " + vo );
		UserVo userVo = userLoginService.loginMessage(vo);
		
		// userVo 가 null 이면 id가 존재하지 않으므로 다시 로그인 페이지로 보낸다 
		if( userVo == null ) {
			System.out.println("authLogin : get user info fail");
			//response.sendRedirect( request.getContextPath() + "/" );
			
			JSONResult jsonResult = JSONResult.success("login");
			String json = new ObjectMapper().writeValueAsString( jsonResult );
		
			response.setContentType( "application/json; charset=utf-8" );
			response.getWriter().print( json );
			return false;
		}
		
		
		// userVo가 존재는 하지만 id가 설정되어 있지 않은경우 id설정 페이지로 보낸다 
		if( userVo.getId() == null ) {
			//id 가 설정 안되면~ 입력하게 해야되 
			System.out.println("authLogin : id is null");
			
			HttpSession session = request.getSession( true );
			session.setAttribute( "authUser", userVo );
			
			JSONResult jsonResult = JSONResult.success("join");
			String json = new ObjectMapper().writeValueAsString( jsonResult );
		
			response.setContentType( "application/json; charset=utf-8" );
			response.getWriter().print( json );
		
			return false;
		}
		
		
		// userVo, id 둘다 존재하므로 세션을 저장하고 mytour 페이지로 이동한다 
		
		System.out.println("authLogin : login success");
		//System.out.println("login id : " + userVo.getId());
		
		// session 처리
		HttpSession session = request.getSession( true );
		session.setAttribute( "authUser", userVo );
		
		//response.sendRedirect( request.getContextPath() +"/tour/mytour" );
		JSONResult jsonResult = JSONResult.success(userVo.getId());
		String json = new ObjectMapper().writeValueAsString( jsonResult );
	
		response.setContentType( "application/json; charset=utf-8" );
		response.getWriter().print( json );
		
		
		
		return false;
	}

}

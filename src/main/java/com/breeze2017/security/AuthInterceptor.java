package com.breeze2017.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.breeze2017.breezer.vo.UserVo;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
		throws Exception {
		
		//1. hanlder 종류 확인
		if( handler instanceof HandlerMethod == false ) {
			return true;
		}
		
		//2. casting
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		
		//3. Method @Auth 받아오기
		Auth auth = 
			handlerMethod.getMethodAnnotation( Auth.class );
		
		//4. Method에 @Auth 가 없다면,
		//   Class(Type)에 붙에 있는 @Auth 받아오기
		if( auth == null ) {
			auth = handlerMethod.
				   getMethod().
			       getDeclaringClass().
			       getAnnotation(Auth.class);
		}
		
		//5. @Auth가 안붙어 있는 경우
		if( auth == null ) {
			return true;
		}
		
		//5. @Auth가 붙어 있기 인증여부 체크
		HttpSession session = request.getSession();
		
		if( session == null ) { // 인증이 안되어 있음
			response.sendRedirect( request.getContextPath() + "/login" );
			return false;
		}
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		if( authUser == null ) { // 인증이 안되어 있음
			response.sendRedirect( request.getContextPath() + "/login" );
			return false;
		}

		// 로그인이 정상적으로 되어있는경우 이지점까지 넘어온다.
		// request.getContextPath()
		
		//현재 주소를 가져온다 
		String url = request.getRequestURL().toString();
		System.out.println("url : "+url);

		// '/' 로 주소를 분리한다 
		String[] array;
		array = url.split("/");

		// 현재 세션의 id와 입력된 주소창의 id를 가져온다 
		System.out.println("array[4] : "+array[4]);
		System.out.println(authUser.getId());
		String urlId = array[4];

		// 현재 세션의 id와 입력된 주소창의 id가 같으면 true, 다르면 false 
		if (urlId.equals(authUser.getId())) {
			return true;
		} else {
			response.sendRedirect(request.getContextPath() + "/" + array[4]);
			return false;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
//		//6. Role 가져오기
//		Auth.Role role = auth.role();
//		
//		//7. User Role 접근이면 인증되어 있기 때문에
//		//   허용
//		if( role == Auth.Role.USER ) {
//			return true;
//		}
//		
//		// 8. Admin Role 접근 체크
//		// 'ADMIN' 권한이 없는 사용자면
//		// main 화면으로 리다이렉트
//		if( authUser.getRole().equals( "ADMIN" ) == false ) {
//			response.sendRedirect( request.getContextPath() );
//			return false;
//		}
//		
//		//9. Admin Role 접근 허용
//		return true;
	}
}

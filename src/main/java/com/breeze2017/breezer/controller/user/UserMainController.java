package com.breeze2017.breezer.controller.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	public String getUser(@AuthUser UserVo authUser,
						  @PathVariable String id,
							Model model) {
		System.out.println("====== UserMainController : /{id} ======");
		System.out.println("UserMainController");					


		
		if(authUser.getId() == id) {
		UserVo uservo = userMainService.getUserInfo(authUser.getId());
		model.addAttribute("uservo",uservo);
		model.addAttribute("uservo2",uservo);
		
		} else {

		UserVo uservo = userMainService.getUserInfo(authUser.getId());
		UserVo uservo2 = userMainService.getUserInfo(id);
		
			if(uservo2.getId() != null) {
			model.addAttribute("uservo", uservo);
			model.addAttribute("uservo2", uservo2);
			} else {
				model.addAttribute("uservo",uservo);
				model.addAttribute("uservo2",uservo);				
			}
		}
		return "user/user_main";
	}
	
	@RequestMapping( "/tourlist" )
	@ResponseBody
	public JSONResult getTours(
			@AuthUser UserVo authUser,
			@PathVariable String id,
			@RequestParam( value="no", required=true)Long no
			) {	
		System.out.println("======JSON REQUEST CONTROLLER======"+ no);		
		List<TourVo> tours = userMainService.getTours(id,no);		
		
		if(tours.isEmpty()) {
			return JSONResult.fail("더 이상 데이터가 존재하지 않습니다.");
		}

		//System.out.println("JSON REQUEST CONTROLLER2");
		
		return JSONResult.success(tours);
	}
		
}

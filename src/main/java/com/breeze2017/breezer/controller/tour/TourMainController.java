package com.breeze2017.breezer.controller.tour;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.breeze2017.breezer.service.tour.TourMainService;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.UserVo;

@Controller
@RequestMapping("/{id}/tour")
public class TourMainController {

	@Autowired
	private TourMainService tourMainService;

	@RequestMapping("")
	public String mytour(
			HttpSession session,
			@PathVariable String id,
			@RequestParam(value="idx", required=false) int tourIdx,
			Model model) {
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		if(authUser == null) {
			return "redirect:/";
		}
		String userId = id;
		
		List<PostVo> postList = tourMainService.getTour(userId, tourIdx);
		
		model.addAttribute("postList", postList);
		model.addAttribute("tourIdx", tourIdx);
		
		return "tour/tour_main";
	}

	@RequestMapping("1")
	public String test(){
		return "tour/test";
	}
}

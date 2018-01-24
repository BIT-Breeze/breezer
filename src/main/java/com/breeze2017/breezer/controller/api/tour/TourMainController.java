package com.breeze2017.breezer.controller.api.tour;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.tour.TourMainService;
import com.breeze2017.breezer.vo.PostVo;

@Controller("tourMainAPIController")
@RequestMapping("/{id}/api/tour")
public class TourMainController {
	
	@Autowired
	private TourMainService tourMainService;
	
	@ResponseBody
	@RequestMapping("")
	public JSONResult mytour(
			@PathVariable String id,
			@RequestParam(value="idx", required=false) long tourIdx) {
		
		System.out.println("tourMainAPIController");
		
		String userId = id;
		
		List<PostVo> postList = tourMainService.getPostList(userId, tourIdx);
		Iterator<PostVo> it = postList.iterator();
		while(it.hasNext()) {
			PostVo vo = it.next();
			String[] locationArr = vo.getLocation().split(":");
			vo.setPlaceName(locationArr[0]);
			vo.setLocation(locationArr[1]);
		}
		
		return JSONResult.success(postList);
	}
}

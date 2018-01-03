package com.breeze2017.breezer.controller.api.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.recommend.RecommendAttractionService;
import com.breeze2017.breezer.vo.PostVo;


@Controller("recommendAPIController")
@RequestMapping("/api/recommend")
public class RecommendAttractionController {

	@Autowired
	private RecommendAttractionService recommendAttractionService;
	
	@ResponseBody
	@RequestMapping("/nearby")
	public JSONResult search(@RequestParam(value="location", required=true, defaultValue="null") List<String> searchPlaces) {
		
		for (int i = 0; i < searchPlaces.size(); i++) {
			System.out.println(searchPlaces.get(i));
		}
		
		List<PostVo> info = recommendAttractionService.getPostInfo(searchPlaces);
		System.out.println(info);

		return JSONResult.success(info);
	}
}

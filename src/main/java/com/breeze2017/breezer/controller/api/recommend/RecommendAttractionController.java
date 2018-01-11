package com.breeze2017.breezer.controller.api.recommend;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.recommend.RecommendAttractionService;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.RecommendVo;


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
	
	@ResponseBody
	@RequestMapping("/recommend")
	public JSONResult recommend(@RequestParam(value="location", required=true, defaultValue="null") List<String> searchPlaces) {
		List<String> searchRecommend = new ArrayList<String>(); 
		
		for (int i = 0; i < searchPlaces.size(); i++) {
			String[] s_address = searchPlaces.get(i).split(" ");
			String searchAddress = s_address[0] + " " + s_address[1] + " " + s_address[2];
			
			searchRecommend.add(searchAddress);
		}
		
		List<RecommendVo> recommend = recommendAttractionService.getRecommends(searchRecommend);
		System.out.println(recommend);
		
		return JSONResult.success(recommend);
	}
	
	/*@ResponseBody
	@RequestMapping("/nearby")
	public JSONResult nearby(@RequestParam(value="location", required=true, defaultValue="null") String place,
							 @RequestParam(value="address", required=true, defaultValue="null") String address) {
		System.out.println("parameter : " + address + " " + place);
		
		// Recommend Data
		// String[] s_address = address.split(" ");
		// String searchAddress = s_address[0] + " " + s_address[1] + " " + s_address[2] + " " + s_address[3];
		// System.out.println(searchAddress);
		
		// Nearby Data
		List<PostVo> nearbyInfo = postService.getNearbyInfo(address + " " + place);
		System.out.println(nearbyInfo);
		
		return JSONResult.success("");
	}*/
}

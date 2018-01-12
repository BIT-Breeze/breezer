package com.breeze2017.breezer.controller.api.recommend;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.post.PostInfoService;
import com.breeze2017.breezer.service.recommend.RecommendAttractionService;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.RecommendVo;


@Controller("recommendAPIController")
@RequestMapping("/api")
public class RecommendAttractionController {

	@Autowired
	private RecommendAttractionService recommendAttractionService;
	
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
	
	@ResponseBody
	@RequestMapping("/nearby")
	public JSONResult nearby(@RequestParam(value="lat", required=true, defaultValue="null") String lat,
							 @RequestParam(value="lot", required=true, defaultValue="null") String lot,
							 @RequestParam(value="address", required=true, defaultValue="null") String address) {
		
		// Split Address
		String[] sAddress = address.split(" ");
		
		PostVo vo = new PostVo();
		vo.setLat(Float.parseFloat(lat));
		vo.setLot(Float.parseFloat(lot));
		vo.setLocation(sAddress[2]);
		
		// Nearby Data
		List<PostVo> nearbyInfo = recommendAttractionService.getNearbyInfo(vo);
		System.out.println("nearbyInfo : " + nearbyInfo);
		
		return JSONResult.success(nearbyInfo);
	}
}

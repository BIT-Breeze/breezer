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
import com.breeze2017.breezer.vo.LocationVo;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.RecommendVo;


@Controller("recommendAPIController")
@RequestMapping("/api")
public class RecommendAttractionController {

	@Autowired
	private RecommendAttractionService recommendAttractionService;
	
	@ResponseBody
	@RequestMapping("/recommend")
	public JSONResult recommend(@RequestParam(value="address", required=true, defaultValue="null") List<String> searchPlaces,
								@RequestParam(value="lat", required=true, defaultValue="null") List<String> lat,
								@RequestParam(value="lot", required=true, defaultValue="null") List<String> lot) {
		List<LocationVo> location = new ArrayList<LocationVo>();
		List<RecommendVo> recommend = new ArrayList<RecommendVo>();
		
		// 나라검사 값이 넘어올 때 ',' 있으면 배열로 취급하는거 같다.
		// ex) 일본 〒814-0001 Fukuoka Prefecture, Fukuoka, Sawara Ward, Momochihama, 2 Chome−３番26号 -> 5개
		for (int i = 0; i < searchPlaces.size(); i++) {
			String name = recommendAttractionService.countryDic(searchPlaces.get(i).split(" "));
			
			if (!"대한민국".equals(name)) {
				return JSONResult.fail("점검중입니다.");
			}
			
			location.add(new LocationVo(Double.parseDouble(lat.get(i)), Double.parseDouble(lot.get(i))));
		}
		
		recommend = recommendAttractionService.getRecommendsByLocation(location);
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
		System.out.println(sAddress[2]);
		
		PostVo vo = new PostVo();
		vo.setLat(Double.parseDouble(lat));
		vo.setLot(Double.parseDouble(lot));
		vo.setLocation(sAddress[2]);
		
		// Nearby Data
		List<PostVo> nearbyInfo = recommendAttractionService.getNearbyInfo(vo);
		System.out.println("nearbyInfo : " + nearbyInfo);
		
		return JSONResult.success(nearbyInfo);
	}
}

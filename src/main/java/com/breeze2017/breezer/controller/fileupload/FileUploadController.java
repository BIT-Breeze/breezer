package com.breeze2017.breezer.controller.fileupload;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.fileupload.FileUploadService;
import com.breeze2017.breezer.service.fileupload.MultiFileUploadService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.security.Auth;


@Controller
@RequestMapping("upload")
public class FileUploadController {
	
	@Autowired
	private FileUploadService fileUploadService;
	
	@Autowired
	private MultiFileUploadService multiFileUploadService;

	
	// Single Upload
	@ResponseBody
	@RequestMapping(value="/echofile", method=RequestMethod.POST)
	public String upload( 
			@RequestParam("file") MultipartFile file, 
			Model model, 
			@ModelAttribute TourVo vo ) {
		System.out.println(" >> fileupload controller");

		String url = fileUploadService.restore(file, vo.getUserId());
		model.addAttribute("url", url);
		
		//System.out.println("id 조회 > " + id);
		System.out.println(" [ model >> " + model + " / url >> " + url + " ]");
		
		return url;
	
	}
	

	// Multi Upload
	@ResponseBody
	@RequestMapping(value="/multiechofile", method=RequestMethod.POST)
	public JSONResult multiUpload(MultipartHttpServletRequest multi) {
		System.out.println(">> multifileupload controller");
		
		List<MultipartFile> mf = multi.getFiles("multiFile");
		
		for (int i=0; i<mf.size(); i++ ) {
			System.out.println( mf.get(i).getOriginalFilename() );
		}

		Map<Integer, String> result = multiFileUploadService.restore(mf);
		System.out.println("result >> " + result);
		
		return JSONResult.success(result);
		
	}
	
	
	// 포스트 페이지에서 mainPhoto 가져오기
		@ResponseBody
		@RequestMapping(value="/getimage", method=RequestMethod.POST)
		public String getMainPhoto() {
			System.out.println(" >> getImage controller");
			
			return "post/addpost";
		}
	
	
	
	
}	

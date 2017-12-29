package com.breeze2017.breezer.controller.fileupload;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.breeze2017.breezer.service.fileupload.FileUploadService;

@Controller
@RequestMapping("/upload")
public class FileUploadController {
	
	@Autowired
	private FileUploadService fileUploadService;

	// Single Upload
	@ResponseBody
	@RequestMapping(value="/echofile", method=RequestMethod.POST)
	public String upload( @RequestParam("file") MultipartFile file, Model model ) {
		System.out.println(" >> fileupload controller");
		
		String url = fileUploadService.restore(file);
		model.addAttribute("url", url);
		
		System.out.println("=============================");
		System.out.println(" file >> " + file);
		System.out.println(" model >> " + model);
		System.out.println(" url >> " + url);
		System.out.println("=============================");
		
		return url;
	
	}
	
	// Multi Upload
	@ResponseBody
	@RequestMapping(value="/multiechofile", method=RequestMethod.POST)
	public String multiUpload( @RequestParam("multiFile[]") MultipartFile file, Model model ) {
		fileUploadService.restore(file);
		return "";
	
	}
	
	
	// 포스트 페이지에서 mainPhoto 가져오기
		@ResponseBody
		@RequestMapping(value="/getimage", method=RequestMethod.POST)
		public String getMainPhoto() {
			System.out.println(" >> getImage controller");
			
			return "post/addpost";
		}
	
	
	
	
}	

package com.breeze2017.breezer.service.fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.breeze2017.security.Auth;

@Service
public class FileUploadService {
	
	private static String SAVE_PATH = "/uploads";
	private static String PREFIX_URL = "/uploads/images/";

	public String restore(MultipartFile multipartFile) {
		
		System.out.println();
		String url = "";
		String path = "D://uploads";
		
		File file = new File(path);
		if(!file.exists()) {
			file.mkdirs();
			System.out.println("create a folder - success !");
		}


		try {
			String originalFileName = multipartFile.getOriginalFilename();
			/* 파일 확장자 */
			String extName = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());
			Long size = multipartFile.getSize();
			/* 파일이름을 변경해서 서버에 저장할 때, 이름이 중복되면 안됨 */
			String saveFileName = genSaveFileName(extName);
			
			System.out.println("## Photo Information >> " + originalFileName +" / "+ saveFileName +" / "+  size);
			

			writeFile(multipartFile, saveFileName);

			url = PREFIX_URL + saveFileName;
			System.out.println("## URL >> " + url);

		} catch (IOException ex) {
			throw new RuntimeException(ex);
		}
		return url;
	}
	
	
	private void writeFile(MultipartFile multipartFile, String saveFileName) throws IOException {
		byte[] fileData = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(fileData);
		fos.close();
	}
	

	private String genSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);

		fileName += extName;

		return fileName;
	}
}


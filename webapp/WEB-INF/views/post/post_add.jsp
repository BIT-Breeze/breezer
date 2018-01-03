<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/breezer/assets/js/jquery/jquery-1.9.0.js" type="text/javascript"></script>


<script type="text/javascript">

var imagePath; // 이미지 경로 저장 변수
var file = $('[name="file"]');
var sel_files = []; // 파일 저장되는 변수 [배열]

// #fileUpload를 했을때 실행
$(document).ready(function() {
	$('#fileUpload').on('change', ImgFileSelect);
	
});


// 파일 업로더 했을 때 실행되는 함수
function ImgFileSelect(e) {
 	console.log("====== ImgFileSelect ======")
	var files = e.target.files; // 넘어 오는 파일들을 files에 담고
	var filesArr = Array.prototype.slice.call(files); // 제목을 분할하여 filesArr에 저장
	
	var index = 0; // 순서를 위해 index를 선언
	filesArr.forEach(function(f) { // 반복문으로
		index++; // 인덱스를 한순차씩 올려주며
		sel_files.push(f); // 배열로 선언했던 파일저장변수에 하나씩 push
		console.log(f); // 로그 출력
		
	});
	
	//console.log("sel_files = "+sel_files)
	
	var formData = new FormData($('#MultifileForm')[0]);
	$.ajax({
		url: '/breezer/upload/multiechofile',
		type: "POST",
		dataType : "json",
		data: formData,
		enctype: 'multipart/form-data',
		processData: false,
		contentType: false
	}).success(function(response) {
		
		console.log("response.data[0] : " + response.data[0])
		var multiImgContainer = $('#multiImgContainer');
		var index = 0
		multiImgContainer.html('');
		for( data in response.data) {
			
			console.log("data" + index + " : " + response.data[index])
			var img = '<img src="${pageContext.request.contextPath }'+ response.data[index] +'"/>';
			
			multiImgContainer.append(img);
			index++;
		}

		
		
		
	}).fail(function(jqXHRm, textStatus) {
		alert('File upload failed ... >> ' + jqXHRm + ', ' + textStatus); 
	});

}
	
</script>

<title>Breezer</title>
</head>

<body>
	<div id="top-section">
	
	</div>
	
	<!-- 메인 포토 -->
	<div id=imgContainer>
	</div>
	
	<form method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/post/add">
		<div>
			<input type="text" value="location" name="location"><br>
			<input type="text" value="category" name="category"><br>
			<input type="text" value="price" name="price"><br>
			<input type="text" value="score" name="score"><br>
			<input type="text" value="content" name="content"><br>
			<br>
			<input type="submit" value="add">
		</div>
	</form>
	
	<!-- 다중 파일 업로더 -->
	<form id="MultifileForm">
		<input type="file" multiple="multiple" name="multiFile" id="fileUpload"><br><br>
		
	</form>
	
	
	<div id=multiImgContainer>
	</div>
</body>

</html>

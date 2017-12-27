<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/breezer_moose/assets/js/jquery/jquery-1.9.0.js" type="text/javascript"></script>

<script type="text/javascript">
/*
$(document).ready(function() {
	var imgContainer = $('#imgContainer');
	
	$.ajax({
		url: '/breezer_moose/upload/getimage?=id',
	
	** 디비에서 메인 이미지를 가져올 기준이 있어야됨. id같은
	get 방식으로 id를 보내고 id가 일치한 DB table에서 mainPhoto를 select 해서  가져온다
	그리고 여기에 뿌려준다.

	});
	
	//var img = '<img src="${pageContext.request.contextPath }/uploads/images/20171120027512.jpg"/>';
	//imgContainer.append(img);
});
*/

</script>
<script type="text/javascript">

var isJpg = function(name) {
	return name.match(/jpg$/i)
}

var isPng = function(name) {
	return name.match(/png$/i)
}

var imagePath;

$(document).ready(function() {
	var file = $('[name="file"]');
	var multiImgContainer = $('#multiImgContainer');

	$('#fileUpload').on('change', function() {
		
		console.log("response from btnUpload Button")

		var filename = $.trim(file.val());
		
		if(!(isJpg(filename) || isPng(filename))) {
			alert('Please browse a JPG/PNG file to upload...');
			return;
		}
		
		$.ajax({
			url: '/breezer_moose/upload/multiechofile',
			type: "POST",
			data: new FormData($('#fileForm')[0]),
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
		}).done(function(data) {
			multiImgContainer.html('');
			/* var img = '<img src="data:' + data.contenttype + ';base64,' + data.base64 + '"/>'; */
			var img = '<img src="${pageContext.request.contextPath }'+data+'"/>';
			imagePath = data;
			console.log(data);
			console.log(img);
			multiImgContainer.append(img);
			
		}).fail(function(jqXHRm, textStatus) {
			alert('File upload failed ... >> ' + jqXHRm + ', ' + textStatus);
			
		});
	});
});
	
</script>

<title>Breezer</title>
</head>

<body>
	<div id="top-section">
	
	</div>
	
	<!-- 메인 포토 -->
	<div id=imgContainer></div>
	
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
		<input type="file" name="multiFile[]" id="fileUpload"><br><br>
	</form>
	<div id=multiImgContainer></div>
</body>

</html>
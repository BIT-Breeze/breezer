<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- <Link href="/breezer/assets/css/addtour.css" rel="stylesheet"> -->

<!-- jQuery 기본 js파일 -->
<script src="/breezer/assets/js/jquery/jquery-1.9.0.js" type="text/javascript"></script>  

<!-- jQuery datepicker를 사용하기 위한 라이브러리 추가 -->
<!-- jQuery UI CSS파일 , jQuery UI 라이브러리 js파일, jQuery form 라이브러리 js파일 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css">
<script src="/breezer/assets/js/jquery/jquery-ui.js" type="text/javascript"></script>
<script src="/breezer/assets/js/jquery/jquery-ui.min.js" type="text/javascript"></script>
<script src="/breezer/assets/js/jquery/jquery.form.js" type="text/javascript"></script>

<!-- 달력 js -->
<script type="text/javascript">
$(function() {
	$("#start-datepicker").datepicker({
		showOn: "both", 
        buttonImage: "/breezer/assets/images/tour/calendar_button.png", 
        buttonImageOnly: true,
        changeMonth: true,
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달',
        showButtonPanel: true,
        closeText: '닫기',
        dateFormat: "yy-mm-dd"
 
	});
});

$(function() {
	$("#end-datepicker").datepicker({
		showOn: "both", 
        buttonImage: "/breezer/assets/images/tour/calendar_button.png",
        buttonImageOnly: true,
        changeMonth: true,
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달',
        showButtonPanel: true,
        closeText: '닫기', 
        dateFormat: "yy-mm-dd"
	});
});

</script>

<!-- 파일 업로더 onchange -->

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
	var imgContainer = $('#imgContainer');

	$('#fileUpload').on('change', function() {
		
		console.log("response from btnUpload Button")
		
		var filename = $.trim(file.val());
		
		if(!(isJpg(filename) || isPng(filename))) {
			alert('Please browse a JPG/PNG file to upload...');
			return;
		}
		
		var formData = new FormData($('#fileForm')[0]);
		$.ajax({
			url: '/breezer/upload/echofile',
			type: "POST",
			data: formData,
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
		}).done(function(data) {
			imgContainer.html('');
			
			var img = '<img src="${pageContext.request.contextPath }'+data+'" width="480" height="320"/>';
			
			imagePath = data;
			console.log(data);
			console.log(img);
			imgContainer.append(img);
			
		}).fail(function(jqXHRm, textStatus) {
			alert('File upload failed ... >> ' + jqXHRm + ', ' + textStatus);
			
		});
	});
});

/* controller 로 submit 하는 부분 */
var add = function() {
	$("#imagePath").val(imagePath);
	document.getElementById("addform").submit();
}


</script>

<title>Breezer</title>
</head>
<body>

	<!-- 파일업로더 -->
	<form id="fileForm">
		<a href="/breezer">Cancel</a><br>
		<input type="file" name="file" id="fileUpload"><br><br>
		
	</form>
	
 	<form id="addform" method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/tour/add">
		<div id=imgContainer></div>
		
		<div class="title-section">
			<input type="text" value="title" name="title">
		</div>
		
		<div class="calendar-section">
			<input type="text" id="start-datepicker" value="start date" name="startDate">
			<input type="text" id="end-datepicker" value="end date" name="endDate"><br><br>
			<input type="hidden"  id="imagePath" value="imagePath" name="mainPhoto">
			<input type="radio" name="secret" value="0" checked="checked" /> public
			<input type="radio" name="secret" value="1" /> private
			
			<input type="button" value="add" onclick="add()">
		</div>
		
	</form>

	<div class="bottom-section">
		<p></p>
	</div>
	
</body>
</html>
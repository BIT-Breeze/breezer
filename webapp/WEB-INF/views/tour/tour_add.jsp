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
        buttonImage: "/breezer/assets/images/ss.png", 
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
        buttonImage: "/breezer/assets/images/ss.png",
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
<script>

$("#fileUpload").on("change", function() {
	console.log("what?")
});
	

function fileUpload() {
	console.log("fileUpload onchange func()");

		var FormData = new FormData();
		formData.append("file", files[0]);
		
		console.log("form data :" + formData)
		
		$.ajax({
			url: "/breezer/upload",
			type: "post",
			data: formData,
			processData: false,
			contentType: false,
			contentType: "multipart/form-data",
			success: function( response ) {
				console.log("success! : " + response.data);
			}, error : function (err) {
				console.log("error : " + err)
			}
		});
	}


</script>


<title>Breezer</title>
</head>
<body>
	<div class="top-section">
		
	</div>

<!-- 	 비동기 이미지 업로드 html
	<form id="uploadForm" name="uploadForm" action="#" method="post" enctype="multipart/form-data">
		<input type="file" id="fileInput" name="fileInput" />
	</form> -->
	
	<!-- 등록을 클릭하면 title, date(s,e), image(url) 값을 controller로  -->
 	<form id="add-form" method="post" action="${pageContext.servletContext.contextPath }/tour/addtour" enctype="multipart/form-data">
		
		<a href="/breezer">Cancel</a>
		<input type="file" name="file" id="file" onchange="fileUpload(this)">
		
		<h2>Ajax Post Result</h2>
		<span id="result"></span>
		
		<h2>Main Photo</h2>
		path : ${pageContext.request.contextPath }${url }
		<img src="${pageContext.request.contextPath }${url }" style="width:250px"><br>
		
		<div class="title-section">
			<input type="text" value="title" name="title">
		</div>
		
		<div class="calendar-section">
			<input type="text" id="start-datepicker" value="start date" name="startDate">
			<input type="text" id="end-datepicker" value="end date" name="endDate"><br><br>
			<input type="submit" value="add">
		</div>

	</form>

	<div class="bottom-section">
		
	</div>
	
</body>
</html>
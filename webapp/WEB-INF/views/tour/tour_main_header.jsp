<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- css --> 
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css"> --%>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_add.css"> --%>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main_header.css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- jQuery 기본 js파일 -->
<script src="/breezer/assets/js/jquery/jquery-1.9.0.js" type="text/javascript"></script>  

<!-- jQuery datepicker를 사용하기 위한 라이브러리 추가 -->
<!-- jQuery UI CSS파일 , jQuery UI 라이브러리 js파일, jQuery form 라이브러리 js파일 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css">
<script src="/breezer/assets/js/jquery/jquery-ui.js" type="text/javascript"></script>
<script src="/breezer/assets/js/jquery/jquery-ui.min.js" type="text/javascript"></script>
<script src="/breezer/assets/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/breezer/assets/js/bootstrap.js" type="text/javascript"></script>
<script src="/breezer/assets/js/bootstrap.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(function() {
	$("#tour_main_header_bg").css('background-image',"url(${pageContext.request.contextPath }"+"${tour.mainPhoto }");
});

</script>

<script type="text/javascript">
function editForm() {
	console.log("edit form clicked")
	
	$.ajax({
		
	
	})
}
</script>

<title>Breezer</title>
</head>
<body data-spy="scroll" data-target="#tour_navigation" data-offset="20">
	
	<div id="tour_main_header_bg">
		<div id="tour_main_header">
		
			<form id="fileForm" class="editForm" >
				
				<!-- 오른쪽 구간 -->
				<div class="tourAdd_right">
					<input type="button" id="edit" value="EDIT" onclick="editForm()"><br><br><br>
				</div>
				
				<!-- 센터 구간 -->
				<div class="tourAdd_center">
					<input type="text" id="title_area" value="${tour.title }" name="title"><br><br><br>
						<%-- <strong id="title_area" class="tourModify">${tour.title } </strong> --%>
				
					<div class="tourDate">
						<input type="text" id="startDate" value="${tour.startDate }" name="startDate">
						<input type="text" id="endDate" value="${tour.endDate }" name="endDate">
					</div>
				</div>
				
			</form>
			
		</div>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<title>Breezer</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- css -->

<link
	href="${pageContext.servletContext.contextPath }/assets/css/login.css"
	rel="stylesheet" type="text/css">
<!-- bootstrap -->
<link
	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"
	rel="stylesheet" type="text/css">

<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script> --%>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.min.js"></script>


<meta name="viewport" content="width=device-width, initial-scale=1">

</head>

<script
	src="${pageContext.servletContext.contextPath }/assets/js/facebook_api.js"
	type="text/javascript">
</script>


<script>
	$(function() {
		btnFunctionInit();
	})
</script>



<body>


	<div id="container">
		<!-- header -->
		<c:import url="/WEB-INF/views/includes/header.jsp" />

		<!-- main wrapper -->
		<div id="main-wrapper" style="height: 700px;">
			<!-- left -->
			<div id="left-wrapper">
				<img id="main"
					src="${pageContext.servletContext.contextPath }/assets/images/userlogin/main.jpg">
			</div>

			<!-- right -->
			<div id="login-wrapper">
				<!-- account -->
				<div id="login-area">
					<br>
					<h2 id='title' style="margin-left: 25px; width: 300px;">브리저
						시작하기</h2>


					<br> <br>

					<div id='status'>
						<c:choose>
							<c:when test="${empty authUser }">
								<!-- 페이스북 로그인 버튼  -->
								<fb:login-button id='fb_button' scope="public_profile,email"
									onlogin="checkLoginState();" class="join-button"> 페이스북 로그인 
								</fb:login-button>
							</c:when>
						</c:choose>
					</div>


					<form id='id-input' style="margin-left: 25px;">
						<!-- <div id='id-input' style="margin-left: 25px;"> -->
						<%-- method="post" action="${pageContext.servletContext.contextPath }/setid"> --%>

						<c:choose>
							<c:when test="${empty authUser.id }">
								<!--  id 입력 창  -->
								<!-- 
								<label class="block-label" for="id">ID</label>
								<input class="input-box" id="id" name="id" type="text" value="">


								<button id="check-id" style="margin-left: 25x; width: 250px;">check	id</button>
								<br>
								<button type="submit" id="save"	style="margin-left: 0px; width: 250px;">save</button>
								 -->
								<c:choose>
									<c:when test="${not empty authUser }">
										<c:choose>
											<c:when test="${empty authUser.id }">
												<label class="block-label" for="id">ID</label>
												<input class="input-id" id="input-id" name="id" type="text" value="">

												<input type="button" id="btn-check" style="margin-left: 25x; width: 250px;" value="check id"> <br>
												<input type="button" id="btn-save" style="margin-left: 0px; width: 250px;" value="save id">
												<!-- <button id="btn-check" style="margin-left: 25x; width: 250px;">checkid</button> <br>
												<button type="submit" id="btn-save" style="margin-left: 0px; width: 250px;">save</button> -->

											</c:when>
										</c:choose>
									</c:when>
								</c:choose>
							</c:when>
						</c:choose>
						<div></div>
					</form>
				</div>
			</div>

			<!-- footer -->
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
		</div>
	</div>
	

</body>


</html>








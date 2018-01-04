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
		<%-- <c:import url="/WEB-INF/views/includes/header.jsp" /> --%>

		<div id="header">
			<div id="title">
				<h1> B r e e z e r</h1>
			</div>



			<div id="login-wrapper">
				<!-- account -->
				<div id="login-area">
				
					<div id='status'>
						<c:choose>
							<c:when test="${empty authUser }">
								<!-- 페이스북 로그인 버튼  -->
								<fb:login-button id='fb_button' scope="public_profile,email"
									onlogin="checkLoginState();" class="join-button"
									 > Facebook 로그인으로 시작하기
								</fb:login-button>
							</c:when>
						</c:choose>
					</div>




					<form id='id-input' >
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
												<input class="input-id" id="input-id" name="id" type="text"
													value="" placeholder="아이디를 입력하세요">
												<br>

												<label class="message-label" for="message"
													id="check-message">  </label>
												<!-- <input type="button" id="btn-check" class="btn btn-info"style="margin-left: 25x; width: 250px;" value="check id"> <br> -->
												<input type="button" id="btn-save" class="btn btn-save"
													 value="등록하기">
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
		</div>



		<!-- left -->
		<div id="img-wrapper">
			<img id="main"
				src="${pageContext.servletContext.contextPath }/assets/images/userlogin/main.jpg">
		</div>

		<!-- right -->


		<!-- footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>


</body>


</html>








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
	type="text/javascript"></script>

<script>
	$(function() {
		
		
		$("#test_button").click(function() {
			console.log("====== info ======")
			console.log("fb_token = "+ fb_token)
			console.log("fb_signedRequest = "+ fb_signedRequest)
			console.log("fb_expiresIn = " + fb_expiresIn)
			console.log("fb_userID = " + fb_userID)
			console.log("fb_name = " + fb_name)
		}) 
	})

	
</script>




<body>


	<div id="container">
		<!-- header -->
		<c:import url="/WEB-INF/views/includes/header.jsp" />

		<!-- main wrapper -->
		<div id="main-wrapper" style="height: 700px;">
			<!-- left -->
			<div id="left-wrapper">left</div>

			<!-- right -->
			<div id="right-wrapper">
				<!-- account -->
				<div id="account-wrapper">
					<form id="login-form" class="login-form" name="login-form"
						method="post"
						action="${pageContext.servletContext.contextPath }/user/login">
						<div id="login-left" style="float: left;">
							<label class="block-label" for="id">ID </label> <input
								class="input-box" id="ID" name="ID" type="text" value="">
							<br> <label class="block-label" for="pw">PW </label> <input
								class="input-box" id="PW" name="PW" type="password" value="">
							<br>
						</div>


						<div id="login-right" style="float: left;">
							<button type="submit" id="login-button">Login</button>
						</div>


					</form>
					<div id="join-form" class="join-form">
						<div style="height: 20px;"></div>

						<form id="breezer_login" name="breezer_login" method="post"
							action="${pageContext.servletContext.contextPath }/user/breezer_join_page">
							<button type="submit" class="join-button">breezer join</button>
						</form>

						<form id="facebook_login" name="facebook_login" method="post"
							action="${pageContext.servletContext.contextPath }/user/facebook_login">
							<button type="submit" class="join-button">
								facebook_login</button>
						</form>

						<div id='status'>
							<fb:login-button id='fb_button' scope="public_profile,email"
								onlogin="checkLoginState();" class="join-button">
							</fb:login-button>
						</div>
						
						<button id="test_button" > test
							
						</button>


						<form id="google_login" name="google_login" method="post"
							action="${pageContext.servletContext.contextPath }/user/google_login">
							<button type="submit" class="join-button">google_login</button>
						</form>



					</div>
				</div>
			</div>
		</div>


		<!-- footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>





</body>


</html>








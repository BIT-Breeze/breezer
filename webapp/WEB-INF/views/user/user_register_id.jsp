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



<script>
	
	
	
	

	
</script>




<body>


	<div id="container">
		<!-- header -->
		<c:import url="/WEB-INF/views/includes/header.jsp" />

		<!-- main wrapper -->
		<div id="main-wrapper" style="height: 700px;">
			<form id="set-id" class="set-id" name="set-id" method="post" action="${pageContext.servletContext.contextPath }/user/setid">
				<label class="block-label" for="id">ID </label> 
				<input class="input-box" id="id" name="id" type="text" value=""> 
				<br>
				
				

				<button  id="check-id">check id</button>
				
				<button type="submit" id="set-id">save</button>


			</form>
		</div>


		<!-- footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>





</body>


</html>








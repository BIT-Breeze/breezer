<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC  '-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'>
<html>
	<head>
		<title>Breezer</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">
  		
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
		<script type="text/javascript">
		</script>
	</head>
	
<body data-spy="scroll" data-target="#myScrollspy" data-offset="20">

	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="wrapper">
			<div id="content">
				<div class="row">
					<a style="float: right;" href="${pageContext.servletContext.contextPath }/${authUser.id}/tour/edit?idx=${tourIdx}">여행기 수정</a>
				</div>
				<c:forEach var="post" items="${postList }">
					<div style="clear: both;">
						<dl>
							<dd>${post.content }</dd>
						</dl>
					</div>
				</c:forEach>
			</div>
		</div>
		<c:import url="/WEB-INF/views/tour/tour_navigation.jsp" />
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>

</body>
</html>








<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/breezer/assets/js/jquery/jquery-1.9.0.js" type="text/javascript"></script>

<title>Breezer</title>
</head>

<body>
	<div id="top-section">
	
	</div>
	
	<form method="post" action="${pageContext.servletContext.contextPath }/post/addpost">
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
</body>

</html>
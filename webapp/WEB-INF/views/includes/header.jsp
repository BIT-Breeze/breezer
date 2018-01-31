<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<script>
	 function goUserMain() {
		 console.log("goUserMain")
		 window.location.href = "/breezer/";	 
	 }
</script>


<style>
#header {
	height: 70px;
	width: 100%;
	top: 0px;
	left: 0px;
	position: fixed;
	z-index: 10;
	background-color: #454545;
}

#show_menu {
	height: 50px;
	font-size: 30px;
	margin-top: 20px;
	margin-left: 40px;
	color: #ececec;
}

#title {
	height: 50px;
	font-size: 30px;
	margin-top: 10px;
	margin-left: 20px;
	color: #ececec;
}
</style>


<div  id="header">
	<label id='show_menu'>☰</label> 
	<label id="title" onclick="goUserMain()"> Breezer </label>
</div>


















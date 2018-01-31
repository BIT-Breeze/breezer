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
	vertical-align: middle;
}

#show_menu {
	height: 50px;
	font-size: 40px;
	margin-left: 40px;
	color: #ececec;
	cursor:pointer;
	margin-top: 10px;
	vertical-align: middle;
}

#header_title {
	height: 50px;
	font-size: 40px;
	margin-left: 20px;
	color: #ececec;
	cursor:pointer;
	margin-top: 10px;
	vertical-align: middle;
}
</style>


<div  id="header">
	<label id='show_menu'>☰</label> 
	<label id="header_title" onclick="goUserMain()"> Breezer </label>
</div>


















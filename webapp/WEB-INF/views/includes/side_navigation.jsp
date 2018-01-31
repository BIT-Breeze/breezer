<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"	rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>

    #sidenav {      	 	

      margin: -15px;
      border: 0px;
      padding: 20px;
      position: fixed;
      display: none;
      z-index: 10;
	  opacity: 1.0;
      /* background-color: #F1F1F1; */

    }
    <!-- 내비가 위에 올라오게, 안 되면 z-index 속성 주기 -->
    #button_area{    
		padding-bottom:30px;    
    	padding-top:50px;
    }  
    
    #info{    
		padding-top:15px;
		padding-bottom:30px;
		font-family: "Karma", sans-serif        	
    }     
    
    #photoframe{    
		padding-top:15px;  
		padding-bottom:30px;      
    }
    
    #menu{    
		padding-top:45px; 
		padding-bottom:500px;
		font-family: "Karma", sans-serif       
    }
    

</style>
<script>
/*
var id;
var tours;
var countries;
var numOfcountries
*/
$(function(){
	
	$('#show_menu').click(function(event){
		event.preventDefault();
		$('#sidenav').toggle('slow');

	});  // 사이드 내비 토글 
	
	//console.log("${authUser.id}")	
	// 유저 인포 가져오기 
	$.ajax({
		
		url:"/breezer/"+ "${authUser.id}" +"/sideNavi",
		type:"get",
		dataType:"json",
		data:"",
		success: function( response ){
			if( response.result != "success" ){
				console.log( response.message );
				return;				
			}

			$("#tourlist").text("투어수 : " + response.data.tours);
			$("#countries").text("방문국가수 : "+ response.data.numOfcountries);
			$("#numOfcountries").html("국가 : <br>" + response.data.countries);
			
		} //success
	}); //ajax			
	
	
});
</script>

</head>

	<c:choose>
      
      	<c:when test="${param.menu == 'login' }">
		</c:when>
		
		<c:otherwise>
			<div class="col-sm-2 sidenav">
		</c:otherwise>
	</c:choose>
	<div id="sidenav">
    	<div class="row">
    		<div class="col-sm-6" id="photoframe" align='center'>
    		<img src="${authUser.pictureUrl}" width="100px" height="100px" class="img-circle">
			
    		</div>   	
    	
    		<div class="col-sm-6" id="info" align='left'>

    		<h4 id="tourlist">  </h4>
    		<h4 id="countries">  </h4>
    		<h4 id="numOfcountries">  </h4>
    		
    		</div>
    	
    	</div> 
    	<div class="row" id='button_area'>
    		<div class="col-sm-4" align="center">

      			<a href="${pageContext.servletContext.contextPath }/${ authUser.id }/myinfo" class="btn btn-primary" role="button">내 정보</a>

    		</div>    	
    	
    		<div class="col-sm-3" align="left">

      			<a href="${pageContext.servletContext.contextPath }/${ authUser.id }/analysis" class="btn btn-primary" role="button">성향</a>

    		</div>
    		
    		<div class="col-sm-5" align="center">

      			<a href="${pageContext.servletContext.contextPath }/user/logout" class="btn btn-primary" role="button">로그아웃</a>

    		</div>
    	
    	</div>
   	<div id='menu'>
    <hr>
      <h4>${ authUser.nickName }님 환영합니다!</h4> <!-- 값 가져오기 -->
      
      <ul class="nav nav-pills nav-stacked">
      <c:choose>
      
      	<c:when test="${param.menu == 'login' }">
        <li class="active"><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/recommend/">위치검색</a></li>        
        </c:when>
        
        <c:when test="${param.menu == 'sns' }">
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li class="active"><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/recommend/">위치검색</a></li>        
        </c:when>
        
        <c:when test="${param.menu == 'location' }">
        <li ><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li class="active"><a href="${pageContext.servletContext.contextPath }/${authUser.id}/recommend/">위치검색</a></li>        
        </c:when>
        
        <c:otherwise>
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/recommend/">위치검색</a></li>        
        </c:otherwise>
        
      </c:choose>
      </ul><br>
     </div> <!-- id menu -->
  	</div> <!-- id sidenav  -->
	</div> <!-- CLASS sidenav  -->

</html>
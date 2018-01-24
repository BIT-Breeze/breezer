<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"	rel="stylesheet" type="text/css">
<link	href="${pageContext.servletContext.contextPath }/assets/css/includes/side_navigation.css"	rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>

    #sidenav {      	 	
      height: 100%;
      position: fixed;     
    }
    
    #button_area{    
		padding-bottom:50px;    
    	padding-top:50px;
    }  
    
    #info{    
		padding-top:60px;        	
    }     
    
    #photoframe{    
		padding-top:60px;        
    }
    
    #menu{    
		padding-top:60px; 
		padding-bottom:900px;       
    }
    

</style>
<script>

var countries = stringFormat();

$(function(){
	
	$('h1').click(function(event){
		event.preventDefault();
		$('#sidenav').toggle('slow');

	});  // 사이드 내비 토글 
	
});

</script>
</head>


<body>	

    <div class="col-sm-2 sidenav">
	<div id="sidenav">
    	<div class="row">
    		<div class="col-sm-6" id="photoframe" align='center'>
    		<img src="${authUser.pictureUrl}" width="100px" height="100px" class="img-circle">
			
    		</div>   	
    	
    		<div class="col-sm-6" id="info" align='left'>

    		<h4>투어수 : ${ uservo.tours }</h4>
    		<h4>방문국가:  </h4>
    		<h4>${ uservo.countries } </h4>
    		<h4>방문국가수 : ${ uservo.numOfcountries }  </h4>
    		
    		</div>
    	
    	</div> 
    	<div class="row" id='button_area'>
    		<div class="col-sm-4" align="center">

      			<a href="${pageContext.servletContext.contextPath }/${ authUser.id }/myinfo" class="btn btn-primary" role="button">내 정보</a>

    		</div>    	
    	
    		<div class="col-sm-4" align="center">

      			<a href="${pageContext.servletContext.contextPath }/${ authUser.id }/analysis" class="btn btn-primary" role="button">성  향</a>

    		</div>
    		
    		<div class="col-sm-4" align="center">

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
        <li><a href="${pageContext.servletContext.contextPath }/recommend/">위치검색</a></li>        
        </c:when>
        
        <c:when test="${param.menu == 'sns' }">
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li class="active"><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/recommend/">위치검색</a></li>        
        </c:when>
        
        <c:when test="${param.menu == 'location' }">
        <li ><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li class="active"><a href="${pageContext.servletContext.contextPath }/recommend/">위치검색</a></li>        
        </c:when>
        
      </c:choose>
      </ul><br>
     </div> <!-- id menu -->
  	</div> <!-- id sidenav  -->
    </div> <!-- class sidenav -->	

</body>
</html>
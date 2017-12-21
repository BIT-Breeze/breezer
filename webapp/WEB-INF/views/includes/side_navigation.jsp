<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
    <div class="col-sm-3 sidenav">
    	<div class="row">
    		<div class="col-sm-6" id="info">
    		<img src="${ pageContext.servletContext.contextPath }/assests/image/anna.jpg" width="100px" height="100px" class="img-circle">
			투어수 : ${ uservo.tours }
    		</div>   	
    	
    		<div class="col-sm-6" id="info">
    		<h3 align="center">닉네임 : ${ authUser.nickName }</h3>
    		
    		</div>
    	
    	</div> 
    	<div class="row">
    		<div class="col-sm-4" id="info" align="center">

      			<a href="${pageContext.servletContext.contextPath }/user/myinfo" class="btn btn-success" role="button">내 정보</a>

    		</div>    	
    	
    		<div class="col-sm-4" id="info" align="center">

      			<a href="${pageContext.servletContext.contextPath }/user/analysis" class="btn btn-primary" role="button">성향</a>

    		</div>
    		
    		<div class="col-sm-4" id="info" align="center">

      			<a href="${pageContext.servletContext.contextPath }/user/logout" class="btn btn-primary" role="button">로그아웃</a>

    		</div>
    	
    	</div>
      
    <hr>
      <h4>${ authUser.id }님 환영합니다!</h4> <!-- 값 가져오기 -->
      <ul class="nav nav-pills nav-stacked">
      <c:choose>
      
      	<c:when test="${param.menu == 'login' }">
        <li class="active"><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/tour/map?idx=${1}">위치검색</a></li>        
        </c:when>
        
        <c:when test="${param.menu == 'sns' }">
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li class="active"><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/tour/map?idx=${1}">위치검색</a></li>        
        </c:when>
        
        <c:when test="${param.menu == 'location' }">
        <li ><a href="${pageContext.servletContext.contextPath }/${authUser.id}">Main</a></li>
        <li><a href="${pageContext.servletContext.contextPath }/sns">다른사람 이야기</a></li>
        <li class="active"><a href="${pageContext.servletContext.contextPath }/${authUser.id}/tour/map?idx=${1}">위치검색</a></li>        
        </c:when>
        
      </c:choose>
      </ul><br>
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Search Blog..">
        <span class="input-group-btn">
          <button class="btn btn-default" type="button">
            <span class="glyphicon glyphicon-search"></span>
          </button>
        </span>
      </div>
    </div>	<!-- sm-3 sidenave -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav id="tour_navigation">
	<ul>
		<%-- <c:forEach var="post" items="${postList }" varStatus="status">
			<c:if test="${post.dateGap != 0}">
				<li><p>${post.dateGap}일차</p></li>
			</c:if>
			<c:if test="${status.first }">
				<li>
					<a class="active" href="#post-${post.idx}">${post.placeName }</a>
				</li>
			</c:if>
			<c:if test="${!status.first }">
				<li>
					<a href="#post-${post.idx}">${post.placeName }</a>
				</li>
			</c:if>
		</c:forEach> --%>
	</ul>
</nav>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="tour_main_header">
	<div style="float: right;">
		<%-- <a id="" style="float: right;" href="${pageContext.servletContext.contextPath}/${userId}/tour/modify?idx=${tourIdx}">여행 정보 수정</a> --%>
		<a id="modifyTour" class="toModify"
			style="float: right; cursor: pointer;">여행 정보 수정</a> <a
			id="completeModifyTour" class="modified"
			style="float: right; cursor: pointer; display: none;">수정 완료</a>
	</div>
	<div class="tourInfo_left">
		<ul>
			<li>
				<button>
					<span class="ico_cover"></span>
				</button>
			</li>
		</ul>
	</div>
	<div class="tourInfo_right">
		<div class="toModify">
			<div>
				<strong id="tourTitle" class="toModify">${tour.title }</strong>
			</div>
			<div>
				<strong id="tourDate" class="toModify">${tour.startDate } ~
					${tour.endDate }</strong>
			</div>
		</div>
		<div class="modified">
			<div>
				<textarea id="tourTitle" class="modified" rows="3"
					placeholder="여행기 제목을 입력해주세요" style="display: none;"
					onclick="this.select()">${tour.title }</textarea>
			</div>
			<div>
				<textarea id="tourDate" class="modified" rows="1"
					style="display: none;" onclick="this.select()">${tour.startDate } ~ ${tour.endDate }</textarea>
			</div>
		</div>
	</div>
</div>
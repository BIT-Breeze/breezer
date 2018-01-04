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
		
		<script type="text/javascript">
		
		$(document).ready(function () {
		    $(document).on("scroll", onScroll);
		    
		    //smoothscroll
		    $('a[href^="#"]').on('click', function (e) {
		        e.preventDefault();
		        $(document).off("scroll");
		        
		        $('a').each(function () {
		            $(this).removeClass('active');
		        })
		        $(this).addClass('active');
		      
		        var target = this.hash,
		            menu = target;
		        $target = $(target);
		        $('html, body').stop().animate({
		            'scrollTop': $target.offset().top+2
		        }, 500, 'swing', function () {
		            window.location.hash = target;
		            $(document).on("scroll", onScroll);
		        });
		    });
		});

		function onScroll(event){
		    var scrollPos = $(document).scrollTop();
		    $('#tour_navigation a').each(function () {
		        var currLink = $(this);
		        var refElement = $(currLink.attr("href"));
		        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
		            $('#tour_navigation ul li a').removeClass("active");
		            currLink.addClass("active");
		        }
		        else{
		            currLink.removeClass("active");
		        }
		    });
		}
		
		</script>
	</head>
	
<body data-spy="scroll" data-target="#tour_navigation" data-offset="20">

	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="wrapper">
			<c:import url="/WEB-INF/views/tour/tour_navigation.jsp" />
			<div id="content">
				<div class="row">
					<a style="float: right;" href="${pageContext.servletContext.contextPath }/${authUser.id}/tour/edit?idx=${tourIdx}">여행기 수정</a>
				</div>
				<c:forEach var="post" items="${postList }">
					<div class="post" id="post-${post.idx}">
						<dl>
							<dd>${post.tripDate }</dd>
							<dd>${post.content }</dd>
							<dd>${post.location }</dd>
							<dd>${post.locale }</dd>
							<dd>${post.lat }</dd>
							<dd>${post.lot }</dd>
							<dd>${post.category }</dd>
							<dd>${post.price }</dd>
							<dd>${post.score }</dd>
							<dd>${post.hit }</dd>
						</dl>
					</div>
				</c:forEach>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>

</body>
</html>








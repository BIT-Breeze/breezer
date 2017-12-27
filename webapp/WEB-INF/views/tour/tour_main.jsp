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
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
				<div id="content_tourMain">
					<div class="row">
						<nav class="col-sm-3" id="myScrollspy">
							<ul class="nav nav-pills nav-stacked">
								<li class="active">
									<a href="#section1">Section 1</a>
								</li>
								<li>
									<a href="#section2">Section 2</a>
								</li>
								<li>
									<a href="#section3">Section 3</a>
								</li>
								<li class="dropdown">
									<a class="dropdown-toggle" data-toggle="dropdown" href="#">Section 4
									<span class="caret"></span></a>
										<ul class="dropdown-menu">
											<li>
												<a href="#section41">Section 4-1</a>
											</li>
											<li>
												<a href="#section42">Section 4-2</a>
											</li>                     
										</ul>
				        		</li>
				      		</ul>
				    	</nav>
						<div class="col-sm-9">
							<div id="section1">    
								<h1>Section 1</h1>
								<p>Try to scroll this section and look at the navigation list while scrolling!</p>
							</div>
							<div id="section2"> 
								<h1>Section 2</h1>
								<p>Try to scroll this section and look at the navigation list while scrolling!</p>
							</div>        
							<div id="section3">         
								<h1>Section 3</h1>
								<p>Try to scroll this section and look at the navigation list while scrolling!</p>
							</div>
							<div id="section41">         
								<h1>Section 4-1</h1>
								<p>Try to scroll this section and look at the navigation list while scrolling!</p>
							</div>      
							<div id="section42">         
								<h1>Section 4-2</h1>
								<p>Try to scroll this section and look at the navigation list while scrolling!</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>

</body>
</html>








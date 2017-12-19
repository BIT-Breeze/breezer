<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"	rel="stylesheet" type="text/css">
<link	href="${pageContext.servletContext.contextPath }/assets/css/breezer.css"	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script>
 <style>
    /* Set height of the grid so .sidenav can be 100% (adjust if needed) */
    .row.content {height: 1500px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding #555 */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height: auto;} 
    }
    
    #secondrow {
      background-color: #C0E0FF;
      color: black;
      padding: 15px;
    }
    #otherbreezer {
      background-color: #FFFFE0;
      color: gray;
      padding: 15px;
    }
  </style>
<script>

var render = function( tourvo, mode ){
	
	var html = "<li data-no='" + tourvo.idx + "'>'" +
	"<strong>" + tourvo.title + "</strong>" +
	"<p>" + tourvo.startDate + "</p>" + "</li>";
	
	if( mode == true ){
		$( "#list-tour" ).prepend(html);
		
	} else {
		$( "#list-tour" ).append(html);
	}
}


var fetchList = function(){
	
	//var startNo = $( "#list-tour li" ).last().data("no") || 0;
	
	$.ajax({
		url:"/breezer/" + "hongseok5@gmail.com" + "/tourlist?no=",
		type:"get",
		dataType:"json",
		data:"",
		success: function( response ){
			if( response.result != "success" ){
				console.log( response.message );
				return;
				
			}
			
			$.each( response.data, function(index, tourvo){
				console.log(response.data);
				render( tourvo, false );
			}); //each
		} //success
	}); //ajax
	
} // fetchList

fetchList();

</script>



<title>Breezer Main</title>

</head>
<body>

<div class="container-fluid">
  <div class="row content">
	<c:import url="/WEB-INF/views/includes/side_navigation.jsp">
		<c:param name="menu" value="login" />
	</c:import>

    <div class="col-sm-9">
		<div class="row">
			<div class="col-sm-3" id="userprofile" align="center">
			
			<img src="${pageContext.servletContext.contextPath }/assets/image/anna.jpg" 
				 width="150px" height="150px" class="img-circle">
			
			</div> 
			
			<div class="col-sm-6" id="firstrow" align="center">

			${uservo.nickName }<br>
			${uservo.tours }<br>

			</div>
			
			<div class="col-sm-3" id="firstrow" align="right">
			
      			<a href="${pageContext.servletContext.contextPath }/tour/${ authUser.id}/add" class="btn btn-info" role="button">NEW TOUR</a>
			
			</div>
		
		</div>	<!-- 윗줄, 사진, 닉네임, 새 투어 -->
		
		<div class="row"  id="album" align="center">
		
			<div class="col-sm-12">
			
			<ul id="list-tour">
			</ul>
			
			
			
			<!--  
			<c:forEach items="${myTours }"	var="vo" varStatus="status">
				<c:choose>
					<c:when test="${ status.index % 3 == 0}">
						<div class="row" align="center" >
						
							<div class="col-sm-4">
								
								${vo.title } <br>
								<a href="${pageContext.servletContext.contextPath }/tour/${ authUser.id}/info/${ vo.idx }"><h3>${ vo.idx }</h3></a>
								${vo.startDate } <br>
	
					
					</c:when>
					
					<c:when test="${ status.index % 3 == 1}">
				
							<div class="col-sm-4">
								${vo.title } <br>								
								<a href="${pageContext.servletContext.contextPath }/tour/${ authUser.id}/info/${ vo.idx }"><h3>${ vo.idx }</h3></a>
								${vo.startDate } 
												
							</div>

					</c:when>
					
					<c:when test="${ status.index % 3 == 2}">
				
							<div class="col-sm-4">
								${vo.title } <br>
								<a href="${pageContext.servletContext.contextPath }/tour/${ authUser.id}/info/${ vo.idx }"><h3>${ vo.idx }</h3></a>
								${vo.startDate } <br>	
											
							</div>
					</div>	
					</c:when>
					
				</c:choose>

					

			</c:forEach>   
			-->
			</div> <!-- sm-12 -->
			
      </div> <!-- album -->
      
    </div>	<!-- col sm-9 -->

  </div>	<!-- row content -->
    
</div>	<!-- container -->


  <c:import url="/WEB-INF/views/includes/footer.jsp" />

</body>
</html>
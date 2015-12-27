<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="mock02.model.Course"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="stylesheet" href="./css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="./css/teacher/teacher_layout.css">
<link rel="stylesheet" href="./css/teacher/teacher_home.css">
<link rel="stylesheet" href="./css/teacher/teacher_student.css">
<link rel="stylesheet" href="./css/check_error.css">
<script src="./js/jquery/jquery.min.js"></script>
<script src="./js/bootstrap/bootstrap.min.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/js_upload_file.js"></script>
<title>Home-Student</title>
<script>
	$(document).ready(function() {
		$('[data-toggle="popover"]').popover({
			html : true
		});
		$(document).on('mouseleave', '.changeMode', function() {
			$('#imgEye').popover('hide');
		});
		$(document).on('mouseover', '#imgEye', function() {
			$('#imgEye').popover('show');
		});
		$(document).on('click', '#item_course_a', function() {
			var id = $(this).attr('rel');

			location.assign("./student_course.html?id=" + id + "");
		});
	});
</script>
</head>
<%! List<Course> listcourse;%>
<%
    listcourse = (List<Course>) request.getAttribute("List_Course");
%>
<body style="padding-top: 80px;">
	<%@include file="./common/header.jsp"%>
	<%
	    for (Course c : listcourse) {
	%>
	<div class="col-md-3 item_grid_course" rel="<%=c.getIdCourse()%>"
		id="item_course_a">
		<p><%=c.getCourseName()%></p>
	</div>
	<%
	    }
	%>


	<!-- Modal -->

	<!--   end modal -->
	<div class="footer" style="background: #fff;">
		<div class="changeMode">
			<img id="imgEye" src="images/eye-icon.png" data-toggle="popover"
				data-placement="top"
				data-content="<a href='student_list_home.html'>List view</a><br/><a href='student_grid_home.html'>Grid view</a>">
		</div>
	</div>
</body>
</html>
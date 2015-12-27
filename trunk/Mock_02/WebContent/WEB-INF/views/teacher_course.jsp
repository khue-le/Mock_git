<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="./css/bootstrap/bootstrap.css" />
<link rel="stylesheet" href="./css/teacher/teacher_layout.css">
<link rel="stylesheet" href="./css/teacher/teacher_home.css">
<link rel="stylesheet" type="text/css" href="./css/zabuto_calendar.min.css">
<script src="./js/jquery/jquery-1.10.2.js"></script>
<script src="./js/bootstrap/bootstrap.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/calendar/zabuto_calendar.min.js"></script>
<script src="./js/calendar/customcalendar.js"></script>
<title>Course-Teacher</title>
</head>
<body>
	<%@include file="./common/header.jsp" %>
	<div class="row">
		<%@include file="./common/menuleft.jsp" %>
		<div class="col-md-9 list_course">
			<div class="title_list_course">
				<span>${course.courseName}</span>
			</div>
			<div class="row">
				<div class="center-block" style="margin-top: 10px" id="my-calendar"></div>
			</div>
			<div id="myModal"></div>
		</div>
	</div>
</body>
</html>
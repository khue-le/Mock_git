<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="./css/teacher/teacher_layout.css">
<link rel="stylesheet" href="./css/teacher/materials_teacher.css">
<script src="./js/jquery/jquery.min.js"></script>
<script src="./js/bootstrap/bootstrap.min.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/materials_teacher.js"></script>
<title>Student-Assignments</title>
</head>

<body>
	<%@include file="./common/header.jsp"%>
	<div class="row content_body">
		<%@include file="./common/student_menuleft.jsp"%>
		<div class="col-md-9 list_course">
			<div class="title_list_course">
				<span>${course.courseName }</span>
			</div>
			<div style="margin-top: 20px;">
				<!--here is body content-->

				<table class="table table_students">
					<thead>
						<tr>
							<th>Assignments</th>
							<th>Redo time</th>
							<th>Time open</th>
							<th>Deadline</th>
							<th>Score</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="assignment" items="${listAssignment}">
							<tr class="success">
								<td><a
									href="student_assignment.html?idAssignment=${assignment.idAssignment}">${assignment.assignmentName}</a></td>
								<td>${assignment.redoTime}</td>
								<td>${assignment.openTime}</td>
								<td>${assignment.deadline}</td>
								<td>...</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!--end-->
			</div>
		</div>
	</div>
	<div class="user_online">
		<div class="dropup pull-right">
			<button id="btnChat" class="btn btn-default dropdown-toggle"
				type="button" data-toggle="dropdown">
				<img src="./images/chat.png" />(4)
			</button>
			<ul class="dropdown-menu list_user_online">
				<li>Tran Thi Bich Tram</li>
				<li>Nguyen Thai Ha</li>
				<li>Trinh Hong Nhan</li>
				<li>Le Nguyen Khue</li>
			</ul>
		</div>
	</div>
</body>
</html>
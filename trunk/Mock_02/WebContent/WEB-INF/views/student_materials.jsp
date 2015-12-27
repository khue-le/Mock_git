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
<title>Student-Materials</title>
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
				<c:forEach var="subject" items="${listsubject}">
					<div class="item_materials">
						<p>${subject.subjectName}</p>
					</div>
					<div class="list_lecture">
						<table class="table">
							<thead>
								<tr>
									<th>Lecture</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="lecture" items="${subject.lectures}">
									<tr>
										<td>${lecture.lectureName}</td>
										<td><a
											href="./student_resources.html?idlecture=${lecture.idLecture}"
											class="btn btn-success">Resources</a>
											</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
					</div>
				</c:forEach>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<title>Teacher-Materials</title>
</head>

<body>
	<%@include file="./common/header.jsp" %>
	<div class="row content_body">
		<%@include file="./common/menuleft.jsp" %>
		<div class="col-md-9 list_course">
			<div class="title_list_course">
				<span>${course.courseName}</span>
			</div>
			<div style="margin-top: 20px;">
				<!--here is body content-->
				<c:forEach var="subject" items="${listsubject}">
				<div class="item_materials" style=" position: relative;">
					<p>${subject.subjectName}</p>
					<div style="position: absolute; top: -8px; right: -7px; display: none;" class="dropdown">
						<span style="color: green;" class="dropdown-toggle glyphicon glyphicon-collapse-down" data-toggle="dropdown"></span>
						<ul style="margin-left: -70px;" class="dropdown-menu">
							<li class="dpredit"><a style="color: green;" href="#">Edit</a></li>
							<li class="dpremove"><a style="color: red;">Remove</a></li>
							<li hidden="hidden" value="${subject.idSubject}"></li>
						</ul>
					</div>
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
								<td>
									<a href="./teacher_resources.html?idlecture=${lecture.idLecture}" class="btn btn-success">Resources</a>
									<button class="btnremovelecture btn btn-danger" type="button">Remove</button>
									<input hidden="hidden" value="${lecture.idLecture}" />
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="div_add_lecture">
						<img src="./images/add.png" />
						<span style="cursor: pointer;" class="item_course_add">Add new Lecture</span>
					</div>
					<div class="form_add_lecture">
						<form role="form">
							<div class="form-group">
								<label>Name:</label> <input required type="text" class="ipaddsubject form-control">
								<input class="ipidsubject" hidden="hidden" value="${subject.idSubject}" name="id" />
							</div>
							<div class="form-group">
								<label>Description:</label>
								<textarea style="resize: none;" class="form-control"></textarea>
							</div>
							<div class="col-md-12" style="text-align: center; padding-top: 15px;">
								<button style="margin-right: 20px; padding: 10px 20px 10px 20px;" type="button"
									class="btnaddlecture btn btn-default btn-success">Create</button>
								<button style="padding: 10px 20px 10px 20px;" type="reset" id="btn_clear"
									class="btn btn-default btn-warning">Clear</button>
							</div>
						</form>
					</div>
				</div>
				<div id="form_create_course" class="row form_create_course" style="display: none; margin-top: 12px;">
					<form action="editsubject.html" role="form">
						<div class="form-group">
							<label>Name:</label> <input required name="name" value="${subject.subjectName}" type="text" class="form-control" id="name_course">
							<input hidden="hidden" value="${subject.idSubject}" name="id" />
						</div>
						<div class="form-group">
							<label>Description:</label>
							<textarea name="description" class="form-control" id="description_course" style="resize: none;"></textarea>
						</div>
						<div class="col-md-12" style="text-align: center; padding-top: 15px;">
							<button style="margin-right: 20px; padding: 10px 20px 10px 20px;" type="submit"
								class="btn btn-default btn-success">Edit</button>
							<button style="padding: 10px 20px 10px 20px;" type="button" id="btn_clear"
								class="btn btn-default btn-warning btncancel">Cancel</button>
						</div>
					</form>
				</div>
				</c:forEach>
				<div class="item_materials">
					<button id="student_add" class="custom_button" type="button">
						<img src="./images/add.png" />
					</button>
					<span>Add new subject</span>
				</div>
				<div id="form_create_course" class="row form_create_course" style="display: none; margin-top: 12px;">
					<form action="createsubject.html" role="form">
						<div class="form-group">
							<label>Name:</label> <input required name="name" type="text" class="form-control" id="name_course">
						</div>
						<div class="form-group">
							<label>Description:</label>
							<textarea name="description" class="form-control" id="description_course" style="resize: none;"></textarea>
						</div>
						<div class="col-md-12" style="text-align: center; padding-top: 15px;">
							<button style="margin-right: 20px; padding: 10px 20px 10px 20px;" type="submit"
								class="btn btn-default btn-success">Create</button>
							<button style="padding: 10px 20px 10px 20px;" type="reset" id="btn_clear"
								class="btn btn-default btn-warning">Clear</button>
						</div>
					</form>
				</div>
				<!--end-->
			</div>
		</div>
	</div>
	<div class="user_online">
		<div class="dropup pull-right">
			<button id="btnChat" class="btn btn-default dropdown-toggle" type="button"
				data-toggle="dropdown">
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
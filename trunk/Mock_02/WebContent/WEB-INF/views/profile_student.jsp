<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="./css/teacher/teacher_layout.css">
<link rel="stylesheet" href="./css/teacher/teacher_home.css">
<link rel="stylesheet" href="./css/teacher/teacher_student.css">
<link rel="stylesheet" href="./css/check_error.css">

<link rel="stylesheet" href="./css/profile_student.css">
<link rel="stylesheet" href="./css/neon-forms.css" />
<link rel="stylesheet" href="./css/entypo/entypo.css" />

<script src="./js/jquery/jquery.min.js"></script>
<script src="./js/bootstrap/bootstrap.min.js"></script>
<script src="./js/js_layout.js"></script>
<title>Profile Student</title>
</head>
<body>
	<jsp:include page="./common/header.jsp"></jsp:include>
	<div class="row">
		<jsp:include page="./common/menuleft.jsp"></jsp:include>

		<!-- body content -->
		<div class="col-md-9 list_course">
			<div class="title_list_course">
				<span>Profile's Student</span>
			</div>
			<div class="div_path" style="padding-top: 20px; font-size: 13px;">
				
					<html:choose>
						<html:when test="${empty Error_Profile}">
							<a href="./teacher_list_home.html">Home</a> ><a
					href="./list_student.html">Students</a> >${Profile_Student.getUserName()}
						</html:when>
						<html:otherwise>
							<a href="./teacher_list_home.html">Home</a> ><a
					href="./list_student.html">Students</a> >Profile
						</html:otherwise>
					</html:choose>
			</div>

			<div style="margin-top: 30px;">

				<html:choose>
					<html:when test="${not empty Error_Profile}">
						<p>${Error_Profile }</p>
					</html:when>
					<html:otherwise>
						<table class="profile_student">
							<tbody>
								<tr>
									<td class="label_td"><label>User Name:</label></td>
									<td class="content_td">${Profile_Student.getUserName()}</td>
								</tr>
								<tr>
									<td class="label_td"><label>Full Name:</label></td>
									<td class="content_td">${Profile_Student.getFullName()}</td>
								</tr>
								<tr>
									<td class="label_td"><label>Email:</label></td>
									<td class="content_td">${Profile_Student.getEmail()}</td>
								</tr>
								<tr>
									<td class="label_td"><label>BirthDay:</label></td>
									<td class="content_td">${Profile_Student.getBirthDay()}</td>
								</tr>
								<tr>
									<td class="label_td"><label>Assignments:</label></td>
								</tr>
							</tbody>
						</table>

						<!-- list assignment of Student -->
						<html:choose>
							<html:when test="${not empty List_Score }">
							<table class="table table_students">
								<thead>
									<tr>
										<th>NO</th>
										<th>Assignment</th>
										<th>Point</th>
									</tr>
								</thead>
								<tbody>
								<html:forEach items="${List_Score}" var="s">
									<tr class="success">
										<td>${s.getIdScore() }</td>
										<td>${s.getAssignment().getAssignmentName() }</td>
										<td>${s.getScore() }</td>
	
									</tr>
								</html:forEach>
									
									
								</tbody>
						</table>
							</html:when>
							<html:otherwise>
								<p>List assignments empty.</p>
							</html:otherwise>
						</html:choose>
					
						<!--end-->

					</html:otherwise>
				</html:choose>

			</div>
		</div>

	</div>
	<jsp:include page="./common/footer.jsp"></jsp:include>
</body>
</html>
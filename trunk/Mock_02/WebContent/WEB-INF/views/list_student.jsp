<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="mock02.model.Course"%>
<%@page import="mock02.model.User"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<!-- <meta charset="UTF-8"> -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="./css/teacher/teacher_layout.css">
<link rel="stylesheet" href="./css/teacher/teacher_home.css">
<link rel="stylesheet" href="./css/teacher/teacher_student.css">

<link rel="stylesheet" href="./css/check_error.css">
<link rel="stylesheet" href="./css/neon-forms.css" />
<link rel="stylesheet" href="./css/entypo/entypo.css" />

<script src="./js/jquery/jquery.min.js"></script>
<script src="./js/bootstrap/bootstrap.min.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/ajax_insert_student.js"></script>
<script src="./js/ajax_edit_delete_student.js"></script>
<title>List Student</title>
</head>

<%!List<User> listStudent;
	HttpSession session;
	Course course;%>
<%
    session = request.getSession();
	course = (Course) session.getAttribute("Course");
	listStudent = (List<User>) session.getAttribute("List_Student");
	int size = 0;
	if (listStudent != null) {
		size = listStudent.size();
	}
			
%>

<body>
	<jsp:include page="./common/header.jsp"></jsp:include>
	<div class="row">
		<jsp:include page="./common/menuleft.jsp"></jsp:include>
		<!-- body content -->
		<html:choose>
			<html:when test="${not empty Error_Course }">
				<p>${Error_Course}</p>
			</html:when>
			<html:otherwise>
				<div class="col-md-9 list_course">
					<!-- title -->
					<div class="title_list_course">
						<span><%=course.getCourseName()%></span>
					</div>
					<!-- path -->
					<div class="div_path" style="padding-top: 20px; font-size: 13px;">
						<a href="./teacher_list_home.html">Home</a> >Students
					</div>
					<!-- search -->
					<div style="float: right;" class="search_student">

						<input id="input_search_student" name="UserName"
							style="height: 25px;" placeholder="Search..." />
						<button style="padding: 14px;"
							class="btn btn-default btn-sm btn-icon icon-left">
							<i style="font-size: 16px;" class="entypo-search"></i>
						</button>


					</div>
					<!-- body content -->
					<div style="margin-top: 30px;">
						<%
						    if (listStudent.size() > 0) {
						%>
						<table id="table_students" class="table table_students">
							<thead>
								<tr>
									<th>Username</th>
									<th>Fullname</th>
									<th>Email</th>
									<th>Birthday</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								    for (User u : listStudent) {
								%>
								<tr id="tr_<%=u.getUserID()%>" class="success">
									<td rel="<%=u.getUserName()%>"><%=u.getUserName()%></td>
									<td rel="<%=u.getFullName()%>"><%=u.getFullName()%></td>
									<td rel="<%=u.getEmail()%>"><%=u.getEmail()%></td>
									<td rel="<%=u.getBirthDay()%>"><%=u.getBirthDay()%></td>
									<td><a id="profile_st"
										href="./profile_student.html?userID=<%=u.getUserID()%>"
										class="btn btn-info btn-sm btn-icon icon-left"> <i
											class="entypo-info"></i> Profile
									</a> <a id="edit_st" rel="<%=u.getUserID()%>" href="#"
										class="btn btn-default btn-sm btn-icon icon-left"> <i
											class="entypo-pencil"></i> Edit
									</a> <a id="delete_st" rel="<%=u.getUserID()%>" href="#"
										class="btn btn-danger btn-sm btn-icon icon-left"> <i
											class="entypo-cancel"></i> Delete
									</a></td>
								</tr>
								<%
								    }
								%>
							</tbody>
						</table>
						<%
						    } else {
						%>
						<p>List Student empty.</p>
						<%
						    }
						%>
						<div id="div_add_student"
							style="cursor: pointer; margin-bottom: 40px;"
							class="div_add_student">
							<button id="student_add" class="custom_button custom_button"
								type="button">
								<img src="./images/add.png" />
							</button>
							<span class="item_course_add">Add new student</span>
						</div>
						<div id="form_create_student" class="form_create_course"
							style="display: none;">
							<form role="form">
								<div class="form-group">
									<label>Username:<emp>*</emp></label> <input id="userName"
										name="userName" type="text" class="form-control">
									<div class="validation-advice" id="advice-required-entry-email"
										style="display: none;">This is a required field.</div>
								</div>
								<div class="form-group">
									<label>Email:<emp>*</emp></label> <input id="email"
										name="email" class="form-control" />
									<div class="validation-advice" id="advice-required-entry-email"
										style="display: none;">This is a required field.</div>
								</div>
								<div class="form-group">
									<label>Fullname:<emp>*</emp></label> <input id="fullName"
										name="fullName" class="form-control" />
									<div class="validation-advice" id="advice-required-entry-email"
										style="display: none;">This is a required field.</div>
								</div>
								<div class="form-group" style="overflow: hidden;">
									<div class="col-md-3" style="padding-left: 0px;">
										<label>DateBirth:</label> <input name="birthDay"
											class="form-control" type="date" />
									</div>
									<div class="col-md-3">
										<label>Status:<emp>*</emp></label> <select name="status"
											class="form-control" disabled>
											<option value="Enable">Enable</option>
											<option value="Disable">Disable</option>
										</select>
									</div>
								</div>
								<p class="error_form" style="float: right;">* Required
									Fields</p>
								<div class="col-md-12" style="text-align: center; padding-top: 15px;">
									<button id="btn_submit_student"
										style="margin-right: 20px; padding: 10px 20px 10px 20px;"
										type="submit" class="btn btn-default btn-info">Create</button>
									<button style="margin-right: 150px;padding: 10px 20px 10px 20px;" type="reset"
										id="btn_clear" class="btn btn-default btn-warning">Clear</button>
									<a style="padding-top:10px;padding-bottom:10px;"  href="#" id="btn_add" class="btn btn-default btn-success btn-icon icon-left" >
										<i class="entypo-plus"></i>
										     Import
									</a>
									
								</div>
								
							</form>
							
						</div>
						<!-- update form -->
						<div id="form_update_student" class="form_create_course"
							style="display: none;">
							<form role="form">
								<div class="form-group">
									<label>Username:<emp>*</emp></label> <input id="username"
										name="userName" type="text" class="form-control">
									<div class="validation-advice" id="advice-required-entry-email"
										style="display: none;">This is a required field.</div>
								</div>
								<div class="form-group">
									<label>Email:<emp>*</emp></label> <input id="Email"
										name="email" class="form-control" />
									<div class="validation-advice" id="advice-required-entry-email"
										style="display: none;">This is a required field.</div>
								</div>
								<div class="form-group">
									<label>Fullname:<emp>*</emp></label> <input id="fullname"
										name="fullName" class="form-control" />
									<div class="validation-advice" id="advice-required-entry-email"
										style="display: none;">This is a required field.</div>
								</div>
								<div class="form-group" style="overflow: hidden;">
									<div class="col-md-3" style="padding-left: 0px;">
										<label>DateBirth:</label> <input name="birthDay"
											class="form-control" type="date" />
									</div>
									<div class="col-md-3">
										<label>Status:<emp>*</emp></label> <select disabled name="status"
											class="form-control">
											<option value="Enable">Enable</option>
											<option value="Disable">Disable</option>
										</select>
									</div>
								</div>
								<p class="error_form" style="float: right;">* Required
									Fields</p>
								<div class="col-md-12"
									style="text-align: center; padding-top: 15px;">
									<button id="btn_update_student"
										style="margin-right: 20px; padding: 10px 20px 10px 20px;"
										type="submit" class="btn btn-default btn-success">Update</button>
									<button style="padding: 10px 20px 10px 20px;" type="reset"
										id="btn_cancel" class="btn btn-default btn-warning">Cancel</button>
								</div>
							</form>
						</div>
						<!-- end -->
						<!-- list student của teacher quản lí -->
						
							<div id="list_student_teacher" style="margin-bottom:40px;border:1px solid #ccc;padding:10px;display:none;">
								<div style="float:left;margin-right:20px;">
									<button id="list_close" style="color:white;background-color:#cc2424;border-color:#cc2424;">
										Close
									</button>
								</div>
								<html:choose>
										<html:when test="${not empty students_teacher_error }">
											<p >${students_teacher_error}</p>
										</html:when>
										<html:otherwise>
																<!-- search -->
											<div style="float: right;" class="search_student">
						
												<input id="input_search_student2" name="UserName"
													style="height: 25px;" placeholder="Search..." />
												<button style="padding: 14px;"
													class="btn btn-default btn-sm btn-icon icon-left">
													<i style="font-size: 16px;" class="entypo-search"></i>
												</button>
											</div>
								
											<table id="table_student2" class="table table_students">
											<thead>
												<tr>
													<th>Username</th>
													<th>Fullname</th>
													<th>Email</th>
													<th>Add</th>
												</tr>
											</thead>
											<tbody>
											<html:forEach items="${students_teacher }" var="s">
														
												<tr id="tr_${s.getUserID()}" class="danger">
													<td rel="${s.getUserName()}" >${s.getUserName() }</td>
													<td rel="${s.getFullName()}" >${s.getFullName() }</td>
													<td rel="${s.getEmail()}" >${s.getEmail() }</td>
													
													<td><a rel="${s.getUserID()}" id="a_add_student" href="#" class="btn btn-success btn-sm btn-icon icon-left"> <i class="entypo-plus"></i> Add
													</a></td>
													</tr>
											</html:forEach>
											
											</tbody>
										</table>	
											
									</html:otherwise>
								</html:choose>
								
							</div>
						<!-- end -->
					</div>
				</div>
			</html:otherwise>
		</html:choose>
		<!-- end -->
	</div>
	<jsp:include page="./common/footer.jsp"></jsp:include>
</body>
	<!-- search -->
	<script type="text/javascript">
		$(document).ready(function(e) {
			var $this = $("#input_search_student");
			var $table = $("#table_students");
			$this.keydown(function(e) {
				$table.find("tbody").find("tr").hide();
			});
			$(document).on("keyup","#input_search_student",function(e) {
				//alert($table.size());
				var textSearch = $this.val();
				var size =<%=size%>;
				if (textSearch.trim() == 0) {
					$table.find("tr").show();
				} 
				else {
					for (i = 1; i <= size; i++) {
						var id = $table.find("tbody").children("tr:nth-child("+ i+ ")").attr("id");
						for (j = 1; j <= 4; j++) {
							var textCell = $("#"+ id+ " td:nth-child("+j+ ")").attr("rel");
							if (textCell.indexOf(textSearch) != -1) {
								$("#" + id).show();
							}
						}
					}
				}
			});
	});
	</script>
	<!-- search -->
	<script type="text/javascript">
		$(document).ready(function(e) {
			var $this = $("#input_search_student2");
			var $table = $("#table_student2");
			$this.keydown(function(e) {
				$table.find("tbody").find("tr").hide();
			});
			$(document).on("keyup","#input_search_student2",function(e) {
				//alert($table.size());
				var textSearch = $this.val();
				var size = '${students_teacher.size()}';
				if (textSearch.trim() == 0) {
					$table.find("tr").show();
				} 
				else {
					for (i = 1; i <= size; i++) {
						var id = $table.find("tbody").children("tr:nth-child("+ i+ ")").attr("id");
						for (j = 1; j <= 3; j++) {
							var textCell = $("#"+ id+ " td:nth-child("+j+ ")").attr("rel");
							if (textCell.indexOf(textSearch) != -1) {
								$("#" + id).show();
							}
						}
					}
				}
			});
	});
	</script>
</html>
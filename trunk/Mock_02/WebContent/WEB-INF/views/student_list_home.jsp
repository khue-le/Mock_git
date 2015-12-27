<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<link rel="stylesheet" href="./css/neon-forms.css" />
<link rel="stylesheet" href="./css/entypo/entypo.css" />
<script src="./js/jquery/jquery.min.js"></script>
<script src="./js/bootstrap/bootstrap.min.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/js_upload_file.js"></script>
<link rel="stylesheet" href="./css/check_error.css">
<title>Course-Student</title>
<style type="text/css">
li:HOVER {
	cursor: pointer;
}
</style>
<script>
var clickBtnAdd;
var clickLi;
$(document).ready(function() {
	/* Hiển thị change mode khi hover */
	$('[data-toggle="popover"]').popover({
		html : true
	});
	$(document).on('mouseleave', '.changeMode', function() {
		$('#imgEye').popover('hide');
	});
	$(document).on('mouseover', '#imgEye', function() {
		$('#imgEye').popover('show');
	});
	/* Kết thúc chức năng */
	
	/* Hiển thị hoặc che phần thêm course khi click vào add course */
	var count = 0;
	clickBtnAdd = function(){
		count = count + 1;
		if (count % 2 == 1) {
			$("#form_create_course").slideDown("slow");
		} else {
			$("#form_create_course").slideUp("slow");
		}
	}
	/* Kết thúc chức năng */
	
	/* 
	 *  Xử lý chuyển đến course khi click vào tên course.
	 *  Sửa thông tin course khi click icon sửa.
	 *  Xử lý xóa course khi click icon xóa trên 1 course. 
	 */
	$('.btnEdit').on('click', function() {
		$('.btnEdit').data('clicked', 'yes');
	});

	$('.btnRemove').on('click', function() {
		$('.btnRemove').data('clicked', 'yes');
	});
	
	clickLi = function(id){
		if($(".btnEdit").data('clicked') == 'yes'){
			$(".btnEdit").data('clicked', 'no');
			window.alert("edit" +' '+ id);
		}else if($(".btnRemove").data('clicked') == 'yes'){
			$(".btnRemove").data('clicked', 'no');
			window.alert("remove" +' '+ id);
		}
		else{
			window.location.assign("student_course.html?id="+id+"&mode=list");
		}
	}
	/* Kết thúc chức năng */

	
});
</script>
</head>
<%!List<Course> listcourse;%>
<%
    listcourse = (List<Course>) request.getAttribute("List_Course");
%>
<body>
	<%@include file="./common/header.jsp"%>
	<div class="container" style="margin-top: 15px;">
		<p class="title_list_course">List Course</p>

		<%
		    if (request.getParameter("create_course") != null) {
		%>
		<p style="color: red;"><%=request.getParameter("create_course")%></p>
		<%
		    }
		%>
		<ul style="margin-top: 20px;" class="list-group list_courses">
			<%
			    for (Course c : listcourse) {
			%>
			<li onclick="clickLi(<%=c.getIdCourse()%>)"
				class="list-group-item course_item" rel="<%=c.getIdCourse()%>"
				rel1="<%=c.getCourseName()%>" rel2="<%=c.getDescription()%>"
				id="item_course_a"><span style="float: left;"><%=c.getCourseName()%></span>
			</li>
			<%
			    }
			%>

		</ul>
	</div>

	<div class="changeMode"
		style="width: 100px; padding: 0 0 5px 10px; position: fixed; bottom: 0; left: 0;">
		<img id="imgEye" src="images/eye-icon.png" data-toggle="popover"
			data-placement="top"
			data-content="<a href='student_list_home.html'>List view</a><br/><a href='student_grid_home.html'>Grid view</a>">
	</div>
</body>
</html>
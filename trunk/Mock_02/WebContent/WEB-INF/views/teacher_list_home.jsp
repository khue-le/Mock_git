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

<script src="./js/ajax_delete_edit_course.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/js_upload_file.js"></script>
<link rel="stylesheet" href="./css/check_error.css">
<title>Course-Teacher</title>
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
		$("#form_create_course").find('form').find("#btn_clear").text("Clear");
		$("#form_create_course").find('form')[0].reset();
		$("#form_create_course").find('form').attr("action","create_course.html");
		$("#lbUpload").text("Select file");
		$("#advice-required-entry-email").css("display","none");
		count = count + 1;
		if (count % 2 == 1) {
			$("#form_create_course").slideDown("slow");
		} else {
			$("#form_create_course").slideUp("slow");
		}
	}
	/* Kết thúc chức năng */
	//thông báo lỗi
	<%if(request.getParameter("create_course")!=null) {%>
		$("#modal_error").modal();
	<%} %>
	$('#modal_error').on('hide.bs.modal', function (e) {
		if($("#text_modal").text()!="You not upload file yet!"){
			 location.assign("./teacher_list_home.html");
		}
	});
});
</script>
</head>
<%!List<Course> listcourse;%>
<%
    listcourse = (List<Course>) request.getAttribute("List_Course");
%>
<body>
	<%@include file="./common/header.jsp"%>
	<div class="container">
		<p class="title_list_course">List Course</p>
		 <!-- Modal  thông báo lỗi-->
		  <div class="modal fade" id="modal_error" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-body">
		          <p id="text_modal" style="color:red;"><%= request.getParameter("create_course")%></p>
		        </div>
		      </div>
		      
		    </div>
		  </div>
		  <!-- end -->
		<ul style="margin-top: 20px;" class="list-group list_courses">
			<%for (Course c : listcourse) {	%>
			<li id="li_<%=c.getIdCourse()%>" class="list-group-item course_item course_item1"
				rel1="<%=c.getCourseName()%>" rel2="<%=c.getDescription()%>"
				id="item_course_a"><a href="./teacher_course.html?id=<%=c.getIdCourse()%>&mode=list" style="float: left;"><%=c.getCourseName()%></a>
				<button rel="<%=c.getIdCourse()%>" id="btn_edit_course" class="custom_button btnEdit" style="float: right;">
					<img src="./images/edit.png" />
				</button>
				<button rel="<%=c.getIdCourse()%>" id="btn_remove_course" class="custom_button btnRemove" style="float: right;">
					<img src="./images/remove.png" />
				</button>
			</li>
			<%
			    }
			%>

			<li style="cursor: pointer;" class="list-group-item course_item" onclick="clickBtnAdd()">
				<button class="custom_button">
					<img src="./images/add.png" />
				</button> <span class="item_course_add">Add new course</span>
			</li>
		</ul>
		<div id="form_create_course" class="row form_create_course"
			style="display: none;">
			<form name = "form_create_course" role="form" action="create_course.html" method="POST" onsubmit="return validateForm()">
				<input name="id_course" hidden/>
				<input name="type" value="list" hidden/>
				<div class="form-group">
					<label>Name:</label> <input name="name_course" type="text" class="form-control"
						id="name_course">
				</div>
				<div class="validation-advice" id="advice-required-entry-email"
										style="display: none;">This is a required field.</div>
				<div class="form-group">
					<label>Description:</label>
					<textarea name = "description_course" class="form-control" id="description_course"
						style="resize: none;"></textarea>
				</div>
				<div class="form-group">
					<div class="fileUpload btn btn-primary">
						<span>Upload</span> <input id="uploadBtn" name="uploadBtn"
							type="file" class="upload" />
					</div>
					<label id="lbUpload">Select file</label>
					
				</div>
				<input type="hidden" name="_csrf" value="${_csrf.token}" />
				<input type="hidden" name="_csrf_header" value="${_csrf.headerName}" />

				<div class="col-md-12"
					style="text-align: center; padding-top: 15px;">
					<button style="margin-right: 20px; padding: 10px 20px 10px 20px;"
						type="submit" class="btn btn-default btn-success">Submit</button>
					<button style="padding: 10px 20px 10px 20px;" type="reset"
						id="btn_clear" class="btn btn-default btn-warning">Clear</button>
				</div>
			</form>


		</div>
	</div>

	<div class="changeMode"
		style="width: 100px; padding: 0 0 5px 10px; position: fixed; bottom: 0; left: 0;">
		<img id="imgEye" src="images/eye-icon.png" data-toggle="popover"
			data-placement="top"
			data-content="<a href='teacher_list_home.html'>List view</a><br/><a href='teacher_grid_home.html'>Grid view</a>">
	</div>
<script>

	function validateForm() {
	    var x = document.forms["form_create_course"]["name_course"].value;
	    if (x == null || x == "") {
	    	document.getElementById('advice-required-entry-email').style.display = "block";
	        return false;
	    }
	    if(document.forms["form_create_course"].action =="http://localhost:8080/Mock_02/create_course.html"){
	    	if($("#lbUpload").text()=="Select file"){
	    		$("#text_modal").text("You not upload file yet!");
	    		$("#modal_error").modal();
	    		return false;
	    	}
	    	
	    }
	}

</script>
</body>
</html>
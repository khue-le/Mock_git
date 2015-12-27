<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="./css/neon-forms.css" />
	<link rel="stylesheet" href="./css/entypo/entypo.css" />	
	<script src="./js/jquery/jquery.min.js"></script>
	<script src="./js/bootstrap/bootstrap.min.js"></script>
	<script src="./js/js_layout.js"></script>
	<script src="./js/js_upload_file.js"></script>
<title>Home-Teacher</title>
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
		$(document).on('click','#item_course_a',function(){
			var id = $(this).attr('rel');
			
			location.assign("./teacher_course.html?id="+id+"");
		});
		//thông báo lỗi
		<%if(request.getParameter("create_course")!=null) {%>
			$("#modal_error").modal();
		<%} %>
		$('#modal_error').on('hide.bs.modal', function (e) {
			if($("#text_modal").text()!="You not upload file yet!"){
				 location.assign("./teacher_grid_home.html");
			}
		   
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
	<div  class="col-md-3 item_grid_course" rel="<%=c.getIdCourse()%>" id="item_course_a">
		<span><%=c.getCourseName()%> </span>
	</div>
	<%
	    }
	%>

	<div class="col-md-3 item_grid_course imgadd" style="padding: 0px;" data-toggle="modal" data-target="#modal_upload">
		<img src="./images/addNewCourse.png">
	</div>
	
		  <!-- Modal upload -->
	  <div class="modal fade" id="modal_upload" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">Create course</h4>
	        </div>
	        <div class="modal-body">
	          <form name = "form_create_course" role="form" action="create_course.html" method="POST" onsubmit="return validateForm()">
	        	  <input name="type" value="grid" hidden/>
	        	  <input name="id_course" hidden/>
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
						type="submit" class="btn btn-default btn-success">Create</button>
					<button style="padding: 10px 20px 10px 20px;" type="reset"
						id="btn_clear" class="btn btn-default btn-warning">Clear</button>
				</div>
			</form>
	        </div>
	      </div>
	      
	    </div>
	  </div>
<!--   end modal -->
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
	<div class="footer" style="background: #fff;">
		<div class="changeMode">
			<img id="imgEye" src="images/eye-icon.png" data-toggle="popover"
				data-placement="top" 
				data-content="<a href='teacher_list_home.html'>List view</a><br/><a href='teacher_grid_home.html'>Grid view</a>">
		</div>
	</div>
<script>

	function validateForm() {
	    var x = document.forms["form_create_course"]["name_course"].value;
	    if (x == null || x == "") {
	    	document.getElementById("advice-required-entry-email").style.display = "block";
	        return false;
	    }
	    if($("#lbUpload").text()=="Select file"){
    		$("#text_modal").text("You not upload file yet!");
    		$("#modal_error").modal();
    		return false;
    	}
    	
	}

</script>
</body>
</html>
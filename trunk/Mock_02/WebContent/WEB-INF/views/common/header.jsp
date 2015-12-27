 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@page import="mock02.model.User"%>
 <%@ taglib prefix="html" uri="http://java.sun.com/jsp/jstl/core"%>
<%!
User user;
HttpSession session;
%>
<%
	session = request.getSession();
	user = (User)session.getAttribute("teacher_cur");
%>
  <div class="navbar navbar-inverse navbar-fixed-top row header_title">
	<div class="col-md-2 left_leaning">
		<span class="p_leaning">E-Leaning</span>
	</div>
	<div class="col-md-10 right_leaning">
		<div class="dropdown icon_user">
			<button class="custom_button dropdown-toggle" type="button" id="user_profile" data-toggle="dropdown"><img src="./images/users.png"/></button>
			<form action="j_spring_security_logout.html" method="POST" id="fmLogout">
				<ul class="dropdown-menu dropdown_note pull-right" id="dropdown_user" role="menu"
					aria-labelledby="user_profile">
					<li role="presentation"><a role="menuitem" href="#"  data-toggle="modal" data-target="#modal_profile"><%=user.getFullName() %></a></li>
					<li role="presentation">
						<a onclick="$('#fmLogout').submit()" role="menuitem" tabindex="-1" href="#">Logout</a>
					</li>
					<li role="presentation"><a role="menuitem" tabindex="-1" href="#">Help</a></li>
				</ul>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
		</div>
		
		<div class="dropdown icon_bell">
			<button class="custom_button  dropdown-toggle" type="button" id="note_bell"  data-toggle="dropdown"><img src="./images/bell.png"/></button>
			<ul class="dropdown-menu dropdown_note pull-right" id="dropdown_bell" role="menu" aria-labelledby="note_bell">
				  <li role="presentation"><a role="menuitem" href="#">Empty</a></li>
			</ul>
		</div>
	</div>
  </div>
  	
		  <!-- Modal -->
	  <div class="modal fade" id="modal_profile" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <p id="title_profile"style="font-family: cursive;color:#4C9E31;font-size:18px;">Profile</p>
	        </div>
	        <div class="modal-body">  
	        	<div class="info_profile">
	        		<table style="font-family: cursive;color:#4C9E31;font-size:18px;" class="profile_student">
							<tbody>
								<tr>
									<td class="label_td"><label>User Name:</label></td>
									<td class="content_td"><%=user.getUserName() %></td>
								</tr>
								<tr>
									<td class="label_td"><label>Full Name:</label></td>
									<td class="content_td"><%=user.getFullName()%></td>
								</tr>
								<tr>
									<td class="label_td"><label>Email:</label></td>
									<td class="content_td"><%=user.getEmail()%></td>
								</tr>
								<tr>
									<td class="label_td"><label>BirthDay:</label></td>
									<td class="content_td"><%=user.getBirthDay() %></td>
								</tr>
							</tbody>
						</table>
	        	</div>
	        	<div style = "display:none;" class="update_profile">
	        				<form role="form" action="update_profile.html" method="POST" novalidate>
	        					<div class="change_info"  style="border:1px solid #ccc; padding:10px;margin-bottom:10px;">
	        						<%-- <input hidden value="<%=user.getUserID() %>" name="userID"> --%>
	        						<div class="form-group">
										<label>Username:<emp>*</emp></label> 
										<input required id="username" readonly="true" name="userName" type="text" class="form-control" value="<%=user.getUserName() %>">
									</div>
									<div class="form-group">
										<label>Email:<emp>*</emp></label> 
										<input type="email" readonly="true" required id="Email" name="email" class="form-control" value="<%=user.getEmail()%>">
									</div>
									<div class="form-group">
										<label>Fullname:<emp>*</emp></label>
										 <input required id="fullname" name="fullName" class="form-control" value="<%=user.getFullName() %>">
										
									</div>
									<div class="form-group" style="overflow: hidden;">
										<div class="col-md-6" style="padding-left: 0px;">
											<label>DateBirth:</label>
											 <input required name="birthDay" class="form-control" type="date" value="<%=user.getBirthDay()%>">
										</div>
									</div>
	        					</div>
								
								<a id="a_change_pass" style="font-family: cursive;color:#4C9E31;" href="#"> Change password</a>
								<div class="change_pass" style="display:none;border:1px solid #ccc; padding:10px;margin-top:10px;">
									<div class="form-group">
										<label>Password:<emp>*</emp></label>
									 <input required type="password" name="password" class="form-control">
									</div>
									<div class="form-group">
										<label>New password:<emp>*</emp></label>
									 	<input required type="password"  name="new_pass" class="form-control">
									</div>
									<div class="form-group">
										<label>Confirm pass:<emp>*</emp></label>
									 	<input required type="password" name="conf_pass" class="form-control">
									</div>
									<div class="validation-advice" id="advice-required"
										style="display: none;">Confirm password not match.
									</div>
								</div>
								<p style="color:red;" id="text_msg"style="float: right;"></p>
								<div>
									<p class="error_form" style="float: right;">* Required Fields</p>
								</div>
								<div class="col-md-12" style="text-align: center; padding-top: 15px;">
									<button style="margin-right: 20px; padding: 10px 20px 10px 20px;" type="submit" class="btn btn-success">
										Update
									</button>
									<button style="padding: 10px 20px 10px 20px;" type="reset" class="btn btn-warning" data-dismiss="modal">
										Cancel
									</button>
								</div>
							</form>
	        	</div>
	        </div>
	        <div class="modal-footer">
	        	<a style="float:left;font-family: cursive;color:#4C9E31;" href="#" id = "update_profile"> Update </a>
	        </div>
	      </div>
	      
	    </div>
	</div>
<!--   end modal -->
 <script>
 $(document).ready(function(e){
	 $("#update_profile").click(function(e){
		 e.preventDefault();
		 if($(this).text()=='Update'){
			 $('.update_profile').css("display","block");
			 $('.info_profile').css("display",'none');
			 $(this).text('<<Profile');
			 $("#title_profile").text('Update');
		 }
		 else{
			 $('.update_profile').css("display","none");
			 $('.info_profile').css("display",'block');
			 $(this).text('Update');
			 $("#title_profile").text('Profile');
		 }
	 });
	 var count=0;
	 $("#a_change_pass").click(function(e){
		e.preventDefault(); 
		count = count+1;
		if($(".change_pass").css('display')=='none'){
			$(".change_pass").slideDown();
		}
		else{
			$(".change_pass").slideUp();
		}
	 });
	 //update profile
	 var $form = $(".update_profile").find("form");
	 $form.submit(function(e){
		 e.preventDefault();
		 //kiem tra password trung khop
		 var token = $("meta[name='_csrf']").attr("content");
		 var header = $("meta[name='_csrf_header']").attr("content");
		 
		 var newPass=null;
		 var confPass=null;
		 var pass=null;
		if(count%2==1){
			 newPass = $form.find("input[name='new_pass']").val();
			 confPass = $form.find("input[name='conf_pass']").val();
			 pass = $form.find("input[name='password']").val();
		 }
		 
		// var userid = $form.find("input[name='userID']").val();
		 var fullname = $form.find("input[name='fullName']").val();
		 var birthday = $form.find("input[name='birthDay']").val();
		 
		 if(confPass != newPass){
				$("#advice-required").css("display","block");
			}
		 else{
			 //gui ajax
			 $.ajax({
		            url: "./update_profile.html",
		            data: {
		            	fullName:fullname,
		            	new_pass:newPass,
		            	password:pass,
		            	birthDay:birthday
		            },
		            type: "POST",
		            beforeSend: function (xhr) {
		            	xhr.setRequestHeader(header, token);
		            },
		            success: function (data) {
		            	if(data=="1"){
		            		location.reload();
		            	}
		            	else{
		            		$("#text_msg").text(data);
		            	}
		            },
		            error: function (xhr, status) {
		               alert("Error: "+xhr.responseText);
		            },
		            complete: function () {
		            	
		            }
		        });
			 //end
			 
		 }
		 
	 });
 });

 </script>
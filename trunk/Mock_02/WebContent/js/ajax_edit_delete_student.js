
$(document).ready(function(e) {
		//delete user
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
		$(document).on("click","#delete_st",function(e){
			e.preventDefault();
			$("#form_update_student").css("display","none");
			$("#form_create_student").css("display","none");
			$("#list_student_teacher").css("display","none");
			
			var userID = $(this).attr("rel");
			var userName = $("#tr_"+userID+" td:nth-child(1)").attr("rel");
			
			if(confirm("Are you sure to delete "+userName +"?")){
				
        		$.ajax({
		            url: "./delete_user.html",
		            data: {
		            	userID: userID
		            },
		            type: "POST",
		            beforeSend: function (xhr) {
		            	xhr.setRequestHeader(header, token);
		            },
		            success: function (data) {
		            	if(data == "1"){
		            		location.reload();		            	
		            	}
		            	else{
		            		alert("Delete user not success!");
		            	}		            	
		            },
		            error: function (xhr, status) {
		               alert("Error: "+xhr.responseText);
		            },
		            complete: function () {
		            	
		            }
		        });
        		//
			}
		});
		
		//edit user	
		$(document).on("click","#edit_st",function(e){
			e.preventDefault();
			$("#form_create_student").css("display","none");
			$("#list_student_teacher").css("display","none");
			/*$(".validation-advice").css("display", "none");*/
			/*update student*/
			var $this = $(this);
			var userID = $this.attr("rel");
			var username = $("#tr_"+userID+" td:nth-child(1)").attr("rel");
			var email = $("#tr_"+userID+" td:nth-child(3)").attr("rel");
			var birthday =  $("#tr_"+userID+" td:nth-child(4)").attr("rel");
			var fullname =  $("#tr_"+userID+" td:nth-child(2)").attr("rel");
			
			var $form = $("#form_update_student").find("form");
			$form.find("input[name='userName']").val(username);
			$form.find("input[name='email']").val(email);
			$form.find("input[name='fullName']").val(fullname);
			$form.find("input[name='birthDay']").val(birthday);
		
			if($("#form_update_student").css("display")=="none"){
				$("#form_update_student").slideDown("slow");
			}		
			$form.find("#btn_cancel").click(function(){
					$("#form_update_student").slideUp("slow");				
			});		
			//
		
			$("#form_update_student").find("form").submit(function(e){
				e.preventDefault();
				
				var temp = 0;
				var userName = $(this).find("input[name='userName']").val();
				var Email = $(this).find("input[name='email']").val();
				var fullName = $(this).find("input[name='fullName']").val();
				var birthDate = $(this).find("input[name='birthDay']").val();
				var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
				
				if(userName == ""){
					temp = 1;
					$("#username").next().css("display","block");
				}
				else{$("#username").next().css("display","none");}
				
				if(Email==""){
					temp =  1;
					$("#Email").next().css("display","block");
				}
				else if(!regex.test(Email)){	
					temp = 1;
					$("#Email").next().text("Please enter a valid email address.").css("display","block");
				}
				else{$("#Email").next().css("display","none");}
				
				if(fullName == ""){
					temp = 1;
					$("#fullname").next().css("display","block");
				}
				else{$("#fullname").next().css("display","none");}
				
				if(temp == 0){
					//alert("fdsfs");
					//upate user
					if(userName != username){
						$.ajax({
				            url: "./check_username.html",
				            data: {
				            	userName: userName,
				            },
				            type: "POST",
				            beforeSend: function (xhr) {
				            	xhr.setRequestHeader(header, token);
				            },
				            success: function (data) {
				            	//alert(data);
				            	if(data == "1"){
				            		alert("Username exist!");
				            	}
				            	else{
				            		$.ajax({
							            url: "./update_user.html",
							            data: {
							            	userID:userID,
							            	fullName: fullName,
							            	userName: userName,
							            	email: Email,
							            	birthDate:birthDate
							            },
							            type: "POST",
							            beforeSend: function (xhr) {
							            	xhr.setRequestHeader(header, token);
							            },
							            success: function (data) {
							            	if(data == "1"){
							            		alert("Update success!");
							            		location.reload();
							            	}
							            	else{
							            		alert("Update user not success!");
							            	}							            	
							            },
							            error: function (xhr, status) {
							               alert("Error: "+xhr.responseText);
							            },
							            complete: function () {

							            }
							        });
				            	}
				            },
				            error: function (xhr, status) {
					               alert("Error: "+xhr.responseText);
					            },
					            complete: function () {

					            }
					        });
					}
					else{
						$.ajax({
				            url: "./update_user.html",
				            data: {
				            	userID:userID,
				            	fullName: fullName,
				            	userName: userName,
				            	email: Email,
				            	birthDate:birthDate
				            },
				            type: "POST",
				            beforeSend: function (xhr) {
				            	xhr.setRequestHeader(header, token);
				            },
				            success: function (data) {
				            	if(data == "1"){
				            		alert("Update success!");
				            		location.reload();	            	
				            	}
				            	else{
				            		alert("Update user not success!");
				            	}     	
				            },
				            error: function (xhr, status) {
				               alert("Error: "+xhr.responseText);
				            },
				            complete: function () {

				            }
				        });
					}
				}		
			});		
		});
	});

		
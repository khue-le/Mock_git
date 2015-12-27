	$(document).ready(function(e){
		$("#div_add_student").click(function(){
			$("#form_update_student").css("display","none");
			if($("#form_create_student").css("display")=="none"){
				$("#form_create_student").slideDown("slow");
			}
			else{
				$("#form_create_student").slideUp("slow");
			}
			$("#form_create_student").find("form")[0].reset();
			$(".validation-advice").css("display", "none");
			
		});
		
		$("#form_create_student").find("form").find("#btn_clear").click(function(){
			$(".validation-advice").css("display", "none");
		});
		
		/*check error form and send ajax insert user*/
		$("#form_create_student").find("form").submit(function(e){
			e.preventDefault();
			var temp = 0;
			var username = $(this).find("input[name='userName']").val();
			var email = $(this).find("input[name='email']").val();
			var fullname = $(this).find("input[name='fullName']").val();
			var birthDay = $(this).find("input[name='birthDay']").val();
			var status = $(this).find( "select option:selected" ).val();
			var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			if(username == ""){
				temp = 1
				$("#userName").next().css("display","block");
			}
			else{$("#userName").next().css("display","none");}
			if(email==""){
				temp = 1;
				$("#email").next().css("display","block");
			}
			else if(!regex.test(email)){	
				temp = 1;
				$("#email").next().text("Please enter a valid email address.").css("display","block");
			}
			else{$("#email").next().css("display","none");}
			
			if(fullname == ""){
				temp =1;
				$("#fullName").next().css("display","block");
			}
			else{$("#fullName").next().css("display","none");}
			
			// check username exist!
			if(temp==0){
				$.ajax({
		            url: "./check_username.html",
		            data: {
		            	/*userName: username,*/
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
		            		//insert Username
		            		$.ajax({
		    		            url: "./insert_student.html",
		    		            data: {
		    		            	fullName: fullname,
		    		            	userName: username,
		    		            	email: email,
		    		            	status:status,
		    		            	birthDate:birthDay
		    		            },
		    		            type: "POST",
		    		            beforeSend: function (xhr) {
		    		            	xhr.setRequestHeader(header, token);
		    		            },
		    		            success: function (data) {
		    		            	if(data == "1"){
		    		            		alert("Insert success!");
		    		            		location.reload();
		    		            	}
		    		            	else{
		    		            		alert("Insert user not success!");
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
		            },
		            error: function (xhr, status) {
		               alert("Error: "+xhr.responseText);
		            },
		            complete: function () {

		            }
		        });
			}
		});
	});
		
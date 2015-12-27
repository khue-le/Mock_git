$(document).ready(function(e) {
	//khi nut clear o form create course dc clicked
	$("#form_create_course").find('form').find("#btn_clear").click(function(e){
		
		
		if($(this).text()=="Cancel"){
			$("#form_create_course").slideUp("slow");
			$("#form_create_course").find('form')[0].reset();
			$("#advice-required-entry-email").css("display","none");
			$("#lbUpload").text("Select file");
		}
			
	});
	/* 
	 *  Xử lý chuyển đến course khi click vào tên course.
	 */

	$(document).on("click",".course_item1",function(e){
		id = $(this).attr('rel');
		courseName = $(this).attr('rel1');
		des = $(this).attr('rel2');
		
	});
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).on("click","#btn_edit_course",function(e) { 
		$("#form_create_course").slideDown("slow");
		$("#advice-required-entry-email").css("display","none");
		$("#form_create_course").find('form').attr("action","update_course.html");
		$("#lbUpload").text("Select file");
		
		var $form = $("#form_create_course").find("form");
		var id = $(this).attr("rel");
		var courseName = $("#li_"+id+"").attr("rel1");
		var des = $("#li_"+id+"").attr("rel2");
		
		$form.find("input[name='id_course']").val(id);
		$form.find("input[name='name_course']").val(courseName);
		if(des!= 'null'){
			$form.find("textarea[name='description_course']").val(des);
		}
		$form.find("#btn_clear").text("Cancel");
	});

	$(document).on("click","#btn_remove_course",function(e) {
		$("#form_create_course").css("display","none");
		$("#advice-required-entry-email").css("display","none");
		
		var id = $(this).attr("rel");
		var courseName = $("#li_"+id+"").attr("rel1");
		
		if(confirm("Are you sure to delete "+courseName +"? Your action can not be undo, all data will be lost!")){
		$.ajax({
            url: "./delete_course.html",
            data: {
            	courseID: id
            },
            type: "POST",
            beforeSend: function (xhr) {
            	xhr.setRequestHeader(header, token);
            },
            success: function (data) {
            	if(data == "1"){
            		location.assign("./teacher_list_home.html")		            	
            	}
            	else{
            		alert("Delete course not success!");
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


});
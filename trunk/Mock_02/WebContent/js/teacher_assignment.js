$(document).ready(function(){
	var cw;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$('input[type=file]').on('change', function(event) {
		file = event.target.files[0];
		$in = $(this);
		var $label = $in.parent().next();
		if ($in.val().length == 0)
			$label.html('Select a document');
		else
			if($in.val().substring(12).length > 50)
				$label.html($in.val().substring(12, 59) + "...");
			else
				$label.html($in.val().substring(12));
	});
	
	$('.btnUpload').click(function(){
		var $this = $(this);
		var file = $this.parent().prev().find('input[type=file]')[0].files[0];
		if(file != undefined && file.size > 200000){
			alert('Dung lượng phải nhỏ hơn 200kb để có thể upload!');
		}else{
			var formData = new FormData();
			var id = $this.parent().prev().find(".idassignment").val();
			var name = $this.parent().prev().find(".name").val();
			var opentime = $this.parent().prev().find(".opentime").val();
			var deadline = $this.parent().prev().find(".deadline").val();
			var content = $this.parent().prev().find(".content").val();
			var redo = $this.parent().prev().find(".redo").val();
			if(deadline == '' || redo == '' || content == '' || name == ''){
				alert("Lỗi: tên, ngày kết thúc, nội dung, số lần làm lại không được để trống");
				return;
			}
			if(file != undefined){
				formData.append("file", file);
				formData.append("attachFileName", file.name);
			}
			formData.append("idAssignment", id);
			formData.append("assignmentName", name);
			if(opentime != '')
				formData.append("openTime", opentime);
			formData.append("deadline", deadline);
			formData.append("contentAssignment", content);
			formData.append("redoTime", redo);
		    $('#img-loading').show();
		    $.ajax({
		        url: 'addassignment.html',
		        data: formData,
		        processData: false,
		        contentType: false,
		        type: 'POST',
		        beforeSend: function (xhr) {
	            	xhr.setRequestHeader(header, token);
	            },
		        success: function(data){
		        	$('#img-loading').hide();
		        	location.reload();
		        },
		        error: function(err){
		        	alert("Lỗi: không thể thêm assignment");
		        	$('#img-loading').hide();
		        },
	            complete: function(){
		        	
		        }
		    });
		}
	});
	
	//--------------------Get resource document(download file)----------------------//
	
	$(document).on('click', '.adoc', function(){		
	    var $divDoc = $("#divDoc");
	    var idRes = $(this).prev().val();
	    console.log(idRes);
	    $.ajax({
	        url: 'downloadfileassignment.html',
	        data: {id : idRes},
	 		dataType: 'json',
	        type: 'POST',
	        beforeSend: function (xhr) {
            	xhr.setRequestHeader(header, token);
            },
	        success: function(data){
	        	
	        },
	        error: function(err){
	        	alert("Lỗi: không thể download document");
	        }
	    });
	});
	
	//--------------------Delete resource document----------------------//
	
	$(document).on('click', '.glyphicon-remove', function(){		
	    var $pRemove = $(this);
	    var idRes = $pRemove.prevAll().slice(1, 2).val();
	    var result = confirm('Bạn có chắc muốn xóa document này?');
		if(result == true){
		    $.ajax({
		        url: 'deleteresource.html',
		        data: {id : idRes},
		 		dataType: 'json',
		        type: 'get',
		        complete: function(){
		        	console.log($("#divDoc div").length);
		        	if($("#divDoc div").length == 1){
		        		$("#divDoc").css("margin-bottom", "0px");
		        		$("#divDoc").next().css("margin-bottom", "0px");
		        	}
		        	$pRemove.parent().remove();
		        }
		    });
		}
	});
	
	//----------------Show modal for update assignment-----------------//
	
	$(".btnUpdate").click(function(){
		$(this).nextAll().slice(1,2).modal('show');
	});
});

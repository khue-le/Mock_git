$(document).ready(function(){
	var cw;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	function getIframe(value, iframe){
		var begin = value.indexOf("?v=");
		var end = value.indexOf("&");
		if(value.trim().length == 0){
			
		}else if(begin != -1){
			if(end != -1){
				var result = value.substring(begin + 3, end);
				iframe = "<iframe allowfullscreen style='width: 100%; margin-top: 5px;' " +
				"src='http://www.youtube.com/embed/"+result+"'></iframe>";
			}else{
				var result = value.substring(begin + 3);
				iframe = "<iframe allowfullscreen style='width: 100%; margin-top: 5px;' " +
				"src='http://www.youtube.com/embed/"+result+"'></iframe>";
			}
		}else{
			var lastindexof = value.lastIndexOf('/');
			if(lastindexof != -1 && lastindexof < value.length - 1){
				var result = value.substring(lastindexof + 1);
				iframe = "<iframe allowfullscreen style='width: 100%; margin-top: 5px;' " +
				"src='http://www.youtube.com/embed/"+result+"'></iframe>";
			}else{
				iframe = "<iframe style='width: 100%; margin-top: 5px;' " +
				"src='http://www.youtube.com/embed/'></iframe>";
			}
		}
		return iframe;
	}
	
	//render iframe(from resource video) on load
	$('.ipvideo').each(function(){
		var value = $(this).val();
		var iframe;
		var result = getIframe(value, iframe);
		$(this).nextAll().slice(1, 2).html(result);
	});
	
	//xóa hoặc sửa resource video
	$(document).on('click', '.btnvideo', function(){
		var value = $(this).text();
		var $ipbefore = $(this).prev();
		if(value === 'Sửa'){
			$ipbefore.removeAttr('disabled');
			$(this).text('Nhập');
			$(this).blur();
		}else if(value === 'Nhập'){
			if($ipbefore.val().trim().length == 0){
				var result = confirm('Bạn có chắc muốn xóa video này?');
				if(result == true){
					$.ajax({
			            url: "deleteresource.html",
			            data: {
			            	//select id tai ip hidden dau tien(prev two)
			            	id : $ipbefore.prevAll().slice(1, 2).val()
			            },
			            type: "get",
			            success: function (data) {
			            	$ipbefore.parent().remove(); 	
			            },
			            error: function (xhr, status) {
			               alert("Lỗi: không thể xóa video.");
			               $ipbefore.attr('disabled', 'disabled');
			               $ipbefore.next().text('Sửa');
			               $ipbefore.next().blur();
			               $ipbefore.val($ipbefore.prev().val());
			            }
			        });	
				}else{
					$ipbefore.attr('disabled', 'disabled');
					$(this).text('Sửa');
					$(this).blur();
					$ipbefore.val($ipbefore.prev().val());
				}
			}else{
				$.ajax({
		            url: "editresourcevideo.html",
		            data: {
		            	//select id tai ip hidden dau tien(prev two)
		            	id : $ipbefore.prevAll().slice(1, 2).val(),
		            	value : $ipbefore.val()
		            },
		            type: "get",
		            success: function (data) {
		            	$ipbefore.prev().val($ipbefore.val());
		            	var $iframe;
		            	var $divIframe = $ipbefore.nextAll(1,2);
		        		var result = getIframe($ipbefore.val(), $iframe);
		        		$divIframe.html('<div><div>');
		        		$divIframe.append(result);
		        		resizeIframe();
			            $ipbefore.next().text('Sửa');
			            $ipbefore.next().blur();
		            },
		            error: function (xhr, status) {
		            	$ipbefore.val($ipbefore.prev().val());
		            	$ipbefore.attr('disabled', 'disabled');
			            $ipbefore.next().text('Sửa');
			            $ipbefore.next().blur();
		            	alert("Lỗi: không thể sửa video.");  
		            }
		        });	
				$(this).prev().attr('disabled', 'disabled');
				$(this).text('Sửa');
				$(this).blur();
			}
		}
	});
	
	//thêm resource video
	$(document).on('click', '.btnvideo-fist', function(){
		var value = $(this).text();
		var btnthis = $(this);
		var ipValue = $(this).prev().val();
		var idLecture = $('#idlecture').val();
		console.log(idLecture);
		if(ipValue.trim().length != 0){
			$.ajax({
	            url: "addresourcevideo.html",
	            data: {
	            	idlecture : idLecture,
	            	value : ipValue
	            },
	            type: "get",
	            contentType: 'application/json; charset=UTF-8',
		 		dataType: 'json',
	            success: function (data) {
	            	var $iframe; 
	    			var $result = getIframe(ipValue, $iframe);
	    			var $iphf = $("<input hidden='hidden' value='"+data.id+"'/>");
	    			var $iphs = $("<input hidden='hidden' value='"+ipValue+"'/>");
	    			var $input = $("<input disabled style='width: 81%; float: left;' type='text'  class='ipvideo form-control' value='"+ipValue+"' />");
	    			var $button = $("<button class='btnvideo btn btn-success' style='width: 18%; float: right;'>Sửa</button>");
	    			var $div = $("<div></div>");
	    			var $divWrap = $("<div style='width: 80%; margin: 0 auto;'></div>");
	    			$iframe = $div.append($result);
	    			$divWrap.append($iphf);
	    			$divWrap.append($iphs);
	    			$divWrap.append($input);
	    			$divWrap.append($button);
	    			$divWrap.append($div);
	    			$('#video-fist').before($divWrap);
	    			btnthis.prev().val('');
	    			cw = $iframe.width();
	    			$('iframe').css({'height':cw - 200+'px'});
	            },
	            error: function (xhr, status) {
	               alert("Lỗi: không thể thêm video.");
	            }
	        });	

		}
		$(this).blur();
	});
	
	cw = $('iframe').width();
	$('iframe').css({'height':cw - 200+'px'});
	
	function resizeIframe() {
		$('iframe').css({'height':cw - 200+'px'});
	}
	
	//--------------------Add resource document(upload file)----------------------//
	
	var file;
	$('input[type=file]').on('change', function(event) {
		file = event.target.files[0];
		$in = $(this);
		if ($in.val().length == 0)
			$('#lbUpload').html('Select a document');
		else
			$('#lbUpload').html($in.val().substring(12));
	});
	
	$('#btnUpload').click(function(){
		console.log(file);
		if(file == null){
			alert('Phải chọn file trước khi upload!');
		}else if(file.size > 200000){
			alert('Dung lượng phải nhỏ hơn 200kb để có thể upload!');
		}else{
			var formData = new FormData();
			var idLecture = $('#idlecture').val();
			formData.append("file", file);
			formData.append("fileName", file.name);
			formData.append("idLecture", idLecture);
		    $('#img-loading').show();
		    var $divDoc = $("#divDoc");
		    $.ajax({
		        url: 'addresourcedoc.html',
		        data: formData,
		        processData: false,
		        contentType: false,
		 		dataType: 'json',
		        type: 'POST',
		        beforeSend: function (xhr) {
	            	xhr.setRequestHeader(header, token);
	            },
		        success: function(data){
		        	var fileName = data['name'];
		        	var idfile = data['id'];
		        	var $id = $("<input hidden='hidden' value='"+ idfile +"'/>");
		        	var $tag = $("<a class='adoc'>"+ fileName +"</a>");
		        	var $icon = $("<span style=' padding-left: 12px; color: #dd4a0a; cursor: pointer; font-size: 10px' class='glyphicon glyphicon-remove'></span>");
		        	var $div = $("<div></div>");
		        	$div.append($id);
		        	$div.append($tag);
		        	$div.append($icon);
		        	$divDoc.append($div);
		        	$divDoc.css("margin-bottom", "50px");
		        	$('#img-loading').hide();
		        	file = null;
		        	$('#lbUpload').html('Select a document');
		        	$('#ipfile').val("");
		        },
		        error: function(err){
		        	alert("Lỗi: không thể thêm document");
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
	        url: 'downloadresourcedoc.html',
	        data: {id : idRes},
	 		dataType: 'json',
	        type: 'POST',
	        beforeSend: function (xhr) {
            	xhr.setRequestHeader(header, token);
            },
	        success: function(data){
	        	var directory = data['dir'];
	        	window.location.href = directory;
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
});

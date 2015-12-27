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
	
	function myFunction(ipvideo) {
		var name = $(ipvideo).prev();
		var videoid = $(ipvideo).val();
		var matches = videoid
				.match(/^https:\/\/www\.youtube\.com\/.*[?&]v=([^&]+)/i)
				|| videoid.match(/^https:\/\/youtu\.be\/([^?]+)/i);
		if (matches) {
			videoid = matches[1];
		}
		if (videoid.match(/^[a-z0-9_-]{11}$/i) === null) {
			$("<p style='color: #F00;'>Không tìm thấy video.</p>")
					.appendTo(name);
			return;
		}
		$.getJSON(
			"https://www.googleapis.com/youtube/v3/videos",
			{
				key : "AIzaSyBfQnthtD5YZ2pCM3LUNlOz-SbNwbphe5c",
				part : "snippet,statistics",
				id : videoid
			},
			function(data) {
				if (data.items.length === 0) {
					$("<p style='color: #F00;'>Không tìm thấy video.</p>").appendTo(name);
					return;
				}
				$("<h3></h3>").text(data.items[0].snippet.title).appendTo(name);
			}).fail(
			function(jqXHR, textStatus, errorThrown) {
				$("<p style='color: #F00;'></p>").text(
						jqXHR.responseText || errorThrown).appendTo(name);
			});
	}
	
	//render iframe(from resource video) on load
	$('.ipvideo').each(function(){
		var value = $(this).val();
		var iframe;
		var result = getIframe(value, iframe);
		myFunction(this);
		$(this).next().html(result);
	});
	
	cw = $('iframe').width();
	$('iframe').css({'height':cw - 200+'px'});
	
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
});

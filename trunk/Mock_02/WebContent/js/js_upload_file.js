$(document).ready(function(e) {
	// khi button upload file change
	$("#uploadBtn").change(function(e) {

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		var oMyForm = new FormData();
		oMyForm.append("file", uploadBtn.files[0]);
		
		var fileName = $(this).val().replace(/C:\\fakepath\\/i, '');
		if(fileName.indexOf('.xlsx')==-1){
			$("#lbUpload").text("Invalid file Format.Only .xlsx are allowed!");
		}
		else{
			$.ajax({
				url : './upload_file.html',
				data : oMyForm,
				dataType : 'text',
				processData : false,
				contentType : false,
				type : 'POST',
				beforeSend : function(xhr) {

					xhr.setRequestHeader(header, token);

				},
				success : function(data) {
					$("#lbUpload").text(data);
				},
				error : function(xhr, status) {
					alert("Error: " + xhr.responseText);
				}
			});
		}
	
	});
	
	//btn clear click
	$("#btn_clear").click(function(){
		$("#advice-required-entry-email").css("display","none");
		$("#lbUpload").text("Select file");
	});
});

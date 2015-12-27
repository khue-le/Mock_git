$(document).ready(function(e) {

	$("#dropdown_user").mouseleave(function() {
		$("#dropdown_user").slideUp();
	});
	$("#user_profile").mouseover(function() {
		$("#dropdown_user").slideDown();
	});

	$("#note_bell").mouseover(function() {
		$("#dropdown_bell").slideDown();
	});
	$("#dropdown_bell").mouseleave(function() {
		$("#dropdown_bell").slideUp();
	});

	$("#btn_clear").click(function() {
		$("#uploadFile").text("Select file list student");
	});

	
});
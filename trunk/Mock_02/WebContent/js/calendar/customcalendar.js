function invokeCalendar() {
	$("#my-calendar").zabuto_calendar({
		nav_icon : {
			prev : '<img src="images/left.png">',
			next : '<img src="images/right.png">'
		},
		today : true,
		action : function() {
			return myDateFunction(this.id, true);
		},
		action_nav : function() {
			return myNavFunction(this.id);
		},
		ajax : {
			url : "schedule.html"
		},
		legend : [ {
			type : "text",
			label : "Special event",
			badge : "00"
		}, {
			type : "block",
			label : "Regular event"
		} ]
	});
}

function myDateFunction(id, fromModal) {
	$("#date-popover").hide();
	var date = $("#" + id).data("date");
	$("#myModal").html(createModal(id, date));
	$('#adjust_modal').modal('show');
	return true;
}

function myNavFunction(id) {
	$("#date-popover").hide();
	var nav = $("#" + id).data("navigation");
	var to = $("#" + id).data("to");
	console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
}
function createModal(id, date) {
	var $modalHeaderButton = $('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>');
	var $modalHeaderTitle = $('<h4 class="modal-title" id="header_modal_title">Title:</h4>');
	var $modalHeader = $('<div class="modal-header"></div>');
	var $modalHeaderInput = $('<input type="text" class="form-control" id="ipTitle" />');
	var $modalBodyInput = $('<textarea style="resize:none" class="form-control" rows="5" id="content" ></textarea>');
	var $modalBody = $('<div class="modal-body" id="modal_body"></div>');
	var $modalBodyTitleSelect = $('<h4 class="modal-title" id="modal_title_select">Important:</h4>');
	var $modalBodySelect = $('<select class="form-control" id="sel"><option value="0">No</option><option value="1">Yes</option></select>');
	var $modalBodyTitle = $('<h4 class="modal-title" id="modal_title_content">Content:</h4>');
	var $modalFooter = $('<div class="modal-footer" id="modal_footer"></div>');
	var $modalFooterButtonSave = $('<button type="submit" id="btnSave" class="btn btn-success" data-dismiss="modal">Save</button>');
	var $modalFooterButtonDelete = $('<button id="btnDelete" class="btn btn-danger" data-dismiss="modal">Delete</button>');
	var $modalDate = $('<button hidden id="modalDate" value="' + date
			+ '"></button>');
	var $modalFooterAddOn = $('<div></div>');
	var $modalContent = $('<div class="modal-content"></div>');
	var $modalDialog = $('<div class="modal-dialog"></div>');
	var $modalFade = $('<div class="modal fade" id="adjust_modal" tabindex="-1" role="dialog" aria-labelledby="modal_title" aria-hidden="true"></div>');
	var $modalForm = $('<form id="modalForm"></form>');
	$.ajax({
		type : 'GET',
		url : 'getschedule.html',
		dataType : 'json',
		data : {
			"date" : date
		},
		success : function(results) {
			$.each(results, function(k, v) {
				$("#ipTitle").val(v.title);
				$("#content").val(v.body);
				var important = v.badge;
				if (important) {
					$("#sel").val('1');
				}
			});
		}
	});
	$modalHeader.append($modalHeaderButton);
	$modalHeader.append($modalHeaderTitle);
	$modalHeader.append($modalHeaderInput);
	$modalFooter.append($modalFooterAddOn);
	$modalBody.append($modalBodyTitle);
	$modalBody.append($modalBodyInput);
	$modalBody.append($modalBodyTitleSelect);
	$modalBody.append($modalBodySelect);
	$modalFooter.append($modalFooterButtonSave);
	$modalFooter.append($modalFooterButtonDelete);
	$modalContent.append($modalHeader);
	$modalContent.append($modalBody);
	$modalContent.append($modalFooter);
	$modalDialog.append($modalContent);
	$modalFade.append($modalDialog);
	$modalFade.append($modalDate);
	$modalFade.data('dateId', id);
	$modalFade.attr("dateId", id);
	$modalForm.append($modalFade);
	return $modalForm;
}

$(document).ready(function() {
	$("#date-popover").hide();
	invokeCalendar();
	$(document).on('click', '#btnSave', function() {
		var date = $("#modalDate").val();
		var title = $("#ipTitle").val();
		var content = $("#content").val();
		var important = $("#sel").val();
		var badge = false;
		var data = {};
		if (important == '1') {
			badge = true;
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		data["date"] = date;
		data["title"] = title;
		data["badge"] = important;
		data["body"] = content;
		$.ajax({
			type : 'POST',
			url : 'saveschedule.html',
			data : data,
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function() {
				location.reload(true);
			}
		});
	});
	$(document).on('click', '#btnDelete', function() {
		var date = $("#modalDate").val();
		$.ajax({
			type : 'GET',
			url : 'deleteschedule.html',
			data : {
				"date" : date
			},
			success : function() {
				location.reload(true);
			}
		});
	});
});
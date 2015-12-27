$(document).ready(function() {
	$(".item_materials").click(function(event) {
		var $this = $(this);		
		if ($(event.target).is(".dropdown-toggle") || $(event.target).is("a")) {
			return;
		} else if ($this.next().css("display") == "none") {
			$(".item_materials").next().css("display", "none");
			$this.next().slideDown();
		} else {
			$this.next().slideUp();
		}
	});
	
	$(".item_materials").hover(function(event) {
		$(this).find("div").css("display", "block");
	});
	
	$(".item_materials").mouseleave(function(event) {
		$(this).find("div").css("display", "none");
	});
	
	$(".div_add_lecture").click(function(event) {
		if ($(".form_add_lecture").css("display") == "none") {
			$(".form_add_lecture").slideDown();
		} else {
			$(".form_add_lecture").slideUp();
		}
	});

	$(".dpremove").click(function(){
		var idSubject = $(this).next().val();
		var result = confirm("Bạn có chắc muốn xóa subject này?\nXóa sẽ không thể khôi phục, " +
				"toàn bộ dữ liệu sẽ mất!");
		if(result == true){
			window.location.href = "deletesubject.html?id="+idSubject;
		}
	});
	
	$(".dpredit").click(function(){
		var divItemSubject = $(this).closest(".item_materials");
		var divEditSubject = divItemSubject.nextAll().slice(1, 2);
		divEditSubject.slideDown();
	});
	
	$(".btncancel").click(function(){
		var divItemSubject = $(this).closest(".form_create_course").slideUp();
	});
	
	$(".btnaddlecture").click(function(){
		var divItemLecture = $(this).parent().prevAll().slice(1,2);
		var name = divItemLecture.find(".ipaddsubject").val();
		var id = divItemLecture.find(".ipidsubject").val();
		var $tableListLecture = divItemLecture.closest(".form_add_lecture").prevAll().slice(1,2);
		var $tbody = $tableListLecture.find("tbody");
		$.ajax({
            url: "addlecture.html",
            data: {
            	id : id,
            	name : name
            }, 
            contentType: 'application/json; charset=UTF-8',
	 		dataType: 'json',
            type: "get",
            success: function (data) {
            	var id = data["id"];
            	var $tr = $("<tr></tr>");
            	var $lectureName = $("<td>"+name+"</td>");
            	var $action = $("<td><a href='./teacher_resources.html?idlecture="+id+"' class='btn btn-success'>Resources</a>"
									+"  <button class='btnremovelecture btn btn-danger' type='button'>Remove</button>"
									+"  <input hidden='hidden' value='"+id+"'/></td>");
            	console.log(id);
            	$tr.append($lectureName);
            	$tr.append($action);
            	$tbody.append($tr);
            	divItemLecture.find(".ipaddsubject").val('');
            },
            error: function (xhr, status) {
               alert("Lỗi: không thể thêm lecture.");
            }
        });	
	});
	
	$(document).on("click", ".btnremovelecture", function(){
		var result = confirm("Bạn có chắc muốn xóa lecture này?\nXóa sẽ không thể khôi phục, " +
				"toàn bộ dữ liệu sẽ mất!");
		var $this = $(this);
		if(result == true){
			var id = $(this).next().val();
			$.ajax({
	            url: "deletelecture.html",
	            data: {
	            	id : id
	            },
	            type: "get",
	            success: function (data) {
	            	$this.closest("tr").remove();
	            },
	            error: function (xhr, status) {
	               alert("Lỗi: không thể xóa lecture.");
	            }
	        });	
		}
		$this.blur();
	});
});

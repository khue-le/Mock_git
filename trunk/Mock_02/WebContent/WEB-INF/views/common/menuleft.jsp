<script type="text/javascript">
$(document).ready(function(){
	var menu = <%=request.getAttribute("active")%>;
	$( "div.navbar_teacher div").removeClass("item_navbar_teacher_active");
	$( "div.navbar_teacher div:nth-child("+menu+")" ).attr("class","item_navbar_teacher item_navbar_teacher_active");
});
</script>
<div class="col-md-2 navbar_teacher">
	<div class="item_navbar_teacher">
		<a href="./teacher_list_home.html" class="custom_button">
			<img src="./images/home.png" />Home
		</a>
	</div>
	<div class="item_navbar_teacher">
	<%int id = (Integer) request.getSession().getAttribute("idcourse"); %>
		<a href="./teacher_course.html?id=<%=id %>&mode=list" class="custom_button">
			<img src="./images/course.png" />Schedule
		</a>
	</div>
	<div class="item_navbar_teacher">
		<a href="./list_student.html" class="custom_button ">
			<img src="./images/student.png" />Students
		</a>
	</div>
	<div class="item_navbar_teacher">
		<a href="teacher_materials.html" class="custom_button">
			<img src="./images/resources.png" />Materials
		</a>
	</div>
	<div class="item_navbar_teacher">
		<a href="./teacher_assignment.html" class="custom_button">
			<img src="./images/assignment.png" />Assignment
		</a>
	</div>
	<div class="item_navbar_teacher">
		<a href="./discussion_teacher.html" class="custom_button">
			<img src="./images/discussion.png" />Discussion
		</a>
	</div>
</div>
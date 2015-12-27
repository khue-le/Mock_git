<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="./css/bootstrap/bootstrap.css" />
<link rel="stylesheet" href="./css/bootstrap/bootstrap-datetimepicker.css" />
<link rel="stylesheet" href="./css/teacher/teacher_layout.css">
<link rel="stylesheet" href="./css/teacher/teacher_home.css">
<script src="./js/jquery/jquery-1.10.2.js"></script>
<script src="./js/bootstrap/moment.js"></script>
<script src="./js/bootstrap/bootstrap.js"></script>
<script src="./js/bootstrap/bootstrap-datetimepicker.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/teacher_assignment.js"></script>
<title>Course-Teacher</title>
<style type="text/css">
.tbLabel{
	width: 120px;
}
.tbInput{
	width: 450px;
	max-width: 450px;
}
td{
	padding-bottom: 13px;
}
</style>
<script type="text/javascript">
$(function () {
    $('.datetimepicker').datetimepicker({
    	 format: 'D/MM/YYYY HH:mm',
    	 showClear : true
    });
});
</script>
</head>
<body>
<%@include file="./common/header.jsp" %>
<div class="row">
<%@include file="./common/menuleft.jsp" %>
<div class="col-md-9 list_course">
<div class="title_list_course">
	<span>${course.courseName}</span>
</div>
<div style="margin-top: 30px;">
<table class="table">
	<thead>
		<tr>
			<th>Assignment</th>
			<th>Status</th>
			<th style="text-align: center;">Time Open</th>
			<th style="text-align: center;">Deadline</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="assignment" items="${listAssignment}">
		<tr>
			<td><a>${assignment.assignmentName}</a></td>
			<jsp:useBean id="now" class="java.util.Date" />
			<c:choose>
				<c:when test="${empty assignment.openTime}">
					<td style="color: #d8c720;">Close</td>
				</c:when>
				<c:when test="${now gt assignment.deadline}">
					<td style="color: red;">Expired</td>
				</c:when>
				<c:otherwise>
					<td style="color: green;">Open</td>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${empty assignment.openTime}">
					<td align="center"> --- </td>
				</c:when>
				<c:otherwise>
					<td align="center"><fmt:formatDate pattern="MMM dd yyyy hh:mm a" value="${assignment.openTime}" /></td>
				</c:otherwise>
			</c:choose>
			<td align="center"><fmt:formatDate pattern="MMM dd yyyy hh:mm a" value="${assignment.deadline}" /></td>
			<td>
				<button class="btnUpdate btn btn-info" type="button">Update</button>
				<button class="btn btn-danger" type="button">Remove</button>
				<div class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body" style="height: 100%">
								<input hidden="hidden" class="idassignment" value="${assignment.idAssignment}" />
								<table>
									<tr>
										<td class="tbLabel">Tên bài tập</td>
										<td class="tbInput">
											<div style="width: 100%;" class='input-group date'>
												<input required type='text' class="name form-control" value="${assignment.assignmentName}" />
							                </div>
										</td>
									</tr>
									<tr>
										<td class="tbLabel">Ngày bắt đầu</td>
										<td class="tbInput">
											<div style="width: 100%;" class='datetimepicker input-group date'>
												<input placeholder="--------- chưa bắt đầu ---------" onkeydown="return false" type='text' 
													class="opentime form-control" value="<fmt:formatDate pattern="d/MM/YYYY HH:mm" value="${assignment.openTime}" />" />
							                    <span class="input-group-addon">
							                        <span class="glyphicon glyphicon-calendar"></span>
							                    </span>
							                </div>
										</td>
									</tr>
									<tr>
										<td class="tbLabel">Ngày kết thúc</td>
										<td class="tbInput">
											<div style="width: 100%;" class='datetimepicker input-group date'>
												<input required placeholder="ngày / tháng / năm   giờ : phút" onkeydown="return false" 
													type='text' class="deadline form-control" value="<fmt:formatDate pattern="d/MM/YYYY HH:mm" value="${assignment.deadline}" />" />
							                    <span class="input-group-addon">
							                        <span class="glyphicon glyphicon-calendar"></span>
							                    </span>
							                </div>
										</td>
									</tr>
									<tr>
										<td class="tbLabel" valign="top">Nội dung</td>
										<td class="tbInput">
											<div style="width: 100%;" class='input-group date'>
												<textarea required rows="7" class="content form-control">${assignment.contentAssignment}</textarea>
							                </div>
										</td>
									</tr>
									<tr>
										<td class="tbLabel">Số lần làm lại</td>
										<td class="tbInput">
											<div style="width: 100%;">
												<input required type='number' class="redo form-control" value="${assignment.redoTime}" />
							                </div>
										</td>
									</tr>
									<c:choose>
										<c:when test="${empty assignment.attachFileName}">
									<tr>
										<td class="tbLabel">Đính kèm</td>
										<td>
										<form enctype="multipart/form-data">
											<div class="fileUploadDoc btn btn-primary">
												<span>Browser</span> <input id="ipfile" type="file" class="upload" />
											</div>
											<label id="lbUpload">Select a document</label>
										</form>
										</td>
									</tr>
										</c:when>
										<c:otherwise>
									<tr>
										<td class="tbLabel">Đính kèm</td>
										<td>
											<a>${assignment.attachFileName}</a>
										</td>
									</tr>
									<tr>
										<td></td>
										<td>
										<form enctype="multipart/form-data">
											<div class="fileUploadDoc btn btn-primary">
												<span>Browser</span> <input type="file" class="upload" />
											</div>
											<label>Select a document</label>
										</form>
										</td>
									</tr>
										</c:otherwise>
									</c:choose>	
								</table>
							</div>
							<div class="modal-footer" style="text-align: center;">
								<button class="btnUpDate btn-lg btn btn-success" data-dismiss="modal">Save</button>
								<button class="btn-lg btn btn-danger" data-dismiss="modal">Cancel</button>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<button class="btn-lg btn btn-success"  data-toggle="modal" 
	data-target="#myModal">Create Assignment</button>
<img id="img-loading" src="./images/loading.gif" hidden="hidden" />
<div id="myModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body" style="height: 100%">
				<input hidden="hidden" class="idassignment" value="${assignment.idAssignment}" />
				<table>
					<tr>
						<td class="tbLabel">Tên bài tập</td>
						<td class="tbInput">
							<div style="width: 100%;" class='input-group date'>
								<input required type='text' class="name form-control" />
			                </div>
						</td>
					</tr>
					<tr>
						<td class="tbLabel">Ngày bắt đầu</td>
						<td class="tbInput">
							<div style="width: 100%;" class='datetimepicker input-group date'>
								<input placeholder="--------- chưa bắt đầu ---------" onkeydown="return false" type='text' class="opentime form-control" />
			                    <span class="input-group-addon">
			                        <span class="glyphicon glyphicon-calendar"></span>
			                    </span>
			                </div>
						</td>
					</tr>
					<tr>
						<td class="tbLabel">Ngày kết thúc</td>
						<td class="tbInput">
							<div style="width: 100%;" class='datetimepicker input-group date'>
								<input required placeholder="ngày / tháng / năm   giờ : phút" onkeydown="return false" type='text' class="deadline form-control" />
			                    <span class="input-group-addon">
			                        <span class="glyphicon glyphicon-calendar"></span>
			                    </span>
			                </div>
						</td>
					</tr>
					<tr>
						<td class="tbLabel" valign="top">Nội dung</td>
						<td class="tbInput">
							<div style="width: 100%;" class='input-group date'>
								<textarea required rows="7" class="content form-control"></textarea>
			                </div>
						</td>
					</tr>
					<tr>
						<td class="tbLabel">Số lần làm lại</td>
						<td class="tbInput">
							<div style="width: 100%;">
								<input type='number' class="redo form-control" />
			                </div>
						</td>
					</tr>
					<tr>
						<td class="tbLabel">Đính kèm</td>
						<td>
							<div class="fileUploadDoc btn btn-primary">
								<span>Browser</span> <input type="file" class="upload" />
							</div>
							<label>Select a document</label>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer" style="text-align: center;">
				<button class="btnUpload btn-lg btn btn-success" data-dismiss="modal">Submit</button>
				<button class="btn-lg btn btn-danger" data-dismiss="modal">Cancel</button>
			</div>
		</div>
	</div>
</div>
</div>
</div>
</div>
</body>
</html>
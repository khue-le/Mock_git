<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="./css/teacher/teacher_layout.css">
<link rel="stylesheet" href="./css/teacher/materials_teacher.css">
<script src="./js/jquery/jquery.min.js"></script>
<script src="./js/bootstrap/bootstrap.min.js"></script>
<script src="./js/js_layout.js"></script>
<script src="./js/materials_teacher.js"></script>
<script src="./js/teacher_resources.js"></script>
<title>Teacher-Resources</title>
</head>
<body>
	<%@include file="./common/header.jsp" %>
	<div class="row content_body">
		<%@include file="./common/menuleft.jsp" %>
		<div class="col-md-9 list_course">
			<div class="title_list_course">
				<span>${lectureName}</span>
			</div>
			<div class="row" style="margin-top: 20px;">
				<!--here is body content-->
				<div class="col-md-7">
					<h3 style="margin-left: 5%">Videos:</h3>
					<div style="margin: 0 auto;">
						<hr style="height: 1px; border: none; background-color: #4f8116;" />
						<c:forEach var="resource" items="${listResource}">
							<c:if test="${resource.type == 'video'}">
							<div style="width: 80%; margin: 0 auto;">
								<input hidden="hidden" value="${resource.idResource}"/>
								<input hidden="hidden" value="${resource.resourceTitle}"/>
								<input disabled style="width: 81%; float: left;" type="text" 
									class="ipvideo form-control" value="${resource.resourceTitle}" />
									<button class="btnvideo btn btn-success" style="width: 18%; float: right;">Sửa</button>
								<div></div>
							</div>
							</c:if>
						</c:forEach>
						<div id="video-fist" style="width: 80%; margin: 0 auto;">
							<input style="width: 81%; float: left;" type="text" 
								class="ipvideo form-control" />
								<button class="btnvideo-fist btn btn-success" style="width: 18%; float: right;">Nhập</button>
							<div></div>
						</div>
					</div>
				</div>
				<div class="col-md-5">
					<h3 style="margin-left: 5%">Documents:</h3>
					<hr style="height: 1px; border: none; background-color: #4f8116;" />
					<div style="margin: 0 auto; width: 90%;">
						<div id="divDoc">
							<c:set var="i" value="0"></c:set>
							<c:forEach var="resource" items="${listResource}">
								<c:if test="${resource.type == 'document'}">
									<div>
										<input hidden="hidden" value="${resource.idResource}"/>
										<a class="adoc">${resource.resourceTitle}</a>&nbsp;&nbsp;
										<span style="color: #dd4a0a; cursor: pointer; font-size: 10px" 
											class="glyphicon glyphicon-remove"></span>
									</div>
									<c:set var="i" value="1"></c:set>
								</c:if>
							</c:forEach>
						</div>
						<c:if test="${i == 1}">
						<div style="margin-bottom: 50px;"></div>
						</c:if>
					</div>
					<form id="formfile" enctype="multipart/form-data">
					<div class="fileUploadDoc btn btn-primary">
						<span>Browser</span> <input id="ipfile" type="file" class="upload" />
					</div>
					<label id="lbUpload">Select a document</label>
					<button type="button" style="margin-left: 10px;" id="btnUpload" class="btn btn-success">Upload</button>
					<input name="idlecture" id="idlecture" value="${idlecture}" hidden="hidden" />
					</form>
					<img style="margin-top: 10px;" id="img-loading" src="./images/loading.gif" hidden="hidden" />
				</div>
				<!--end-->
			</div>
		</div>
	</div>
	<div class="user_online">
		<div class="dropup pull-right">
			<button id="btnChat" class="btn btn-default dropdown-toggle" type="button"
				data-toggle="dropdown">
				<img src="./images/chat.png" />(4)
			</button>
			<ul class="dropdown-menu list_user_online">
				<li>Tran Thi Bich Tram</li>
				<li>Nguyen Thai Ha</li>
				<li>Trinh Hong Nhan</li>
				<li>Le Nguyen Khue</li>
			</ul>
		</div>
	</div>
</body>
</html>
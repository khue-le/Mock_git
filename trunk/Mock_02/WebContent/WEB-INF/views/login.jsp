<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/bootstrap/bootstrap.min.css" />
<script src="./js/jquery/jquery.min.js"></script>
<title>Online Learning</title>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById("ipusername").onclick = removeError;
		document.getElementById("ippassword").onclick = removeError;
		
		function removeError() {
			$("#diverror").slideUp("1000");
		}
		
		var error = '${error}';
		if(error == null || error.trim() == 0){
			var divError = document.getElementById("diverror");
			divError.style.display = "none";	
		}
	}
</script>
</head>
<body>
	<div class="container" style="font-family: cursive;">
	    <div style="padding-top:100px;" class="row vertical-offset-100">
	    	<div class="col-md-4 col-md-offset-4">
	    		<div class="panel panel-default">
				  	<div class="panel-heading">
				    	<h3 style="font-family: cursive !important;" class="panel-title">Please sign in</h3>
				 	</div>
				  	<div class="panel-body">
				    	<form action="j_spring_security_check.html" accept-charset="UTF-8" role="form" method="POST">
	                    <fieldset>
	                    	<div id="diverror" class="alert alert-danger">
                    			<span class="glyphicon glyphicon-remove"></span><strong>&nbsp;&nbsp;${error}</strong>
                			</div>
				    	  	<div class="form-group">
				    		    <input id="ipusername" class="form-control" placeholder="E-mail" name="j_username" type="text">
				    		</div>
				    		<div class="form-group">
				    			<input id="ippassword" class="form-control" placeholder="Password" name="j_password" type="password" value="">
				    		</div>
				    		<div class="checkbox">
				    	    	<label>
				    	    		<input name="remember-me" type="checkbox"> Remember Me
				    	    	</label>
				    	    </div>
				    	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				    		<input class="btn btn-lg btn-success btn-block" type="submit" value="Login">
				    	</fieldset>
				      	</form>
				    </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
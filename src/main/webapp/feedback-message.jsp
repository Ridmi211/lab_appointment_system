<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Feedback</title>

<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
.header-text {
	width: 70%;
	height: 250px;
	background-color: #ffffff;
	color: #000000;
	text-align: center;
	position: relative;
	top: 160px;
	font-size: 30px;
	border-radius: 5px;
	box-shadow: 0px 10px 20px -10px rgba(0, 0, 0, 0.75);
}

body {
	display: flex;
	flex-direction: column;
	/* justify-content: center; */
	align-items: center;
	width: 100vw;
	height: 100vh;
	background-image: linear-gradient(-45deg, #e3eefe 0%, #efddfb 100%);
}

.ok-btn {
	position: absolute;
	border-color: #2db6e0;
	bottom: 20px;
	width: 10%;
	background-color: #2db6e0;
	padding: 10px;
}
</style>
</head>
<body class="d-flex align-items-center">
	<%-- <div class="container">
					
			<br/>
			<h2>feebackMessaget</h2>
			<p style='color:magenta, font-size:100px'>${feebackMessage}</p>
			<br/>
			
			
					
		</div>	 --%>

	<div
		class="container d-flex justify-content-center d-flex align-items-center p-0 m-0">

		<div
			class="header-text pt-2 d-flex align-items-center  d-flex justify-content-center">
			<p style='color: #529ece'>${feebackMessage}</p>


			<a id="backButton" class="btn btn-primary ok-btn">OK</a>
		</div>



	</div>

	<script>
		document.getElementById('backButton').addEventListener('click',
				function() {
					window.history.go(-2); // This will navigate back two pages in the browser's history.
				});
	</script>
</body>
</html>
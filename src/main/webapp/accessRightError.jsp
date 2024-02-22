<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
	bottom: 10px;
	width: 10%;
}
</style>
</head>
<body class="d-flex align-items-center">
	<div
		class="container d-flex justify-content-center d-flex align-items-center p-0 m-0">
		<div
			class="header-text pt-2 d-flex align-items-center  d-flex justify-content-center">
			<p style='color: magenta'>${errorMessage}</p>
			<a href="login.jsp" class="btn btn-primary ok-btn">OK</a>
		</div>
	</div>
</body>
</html>
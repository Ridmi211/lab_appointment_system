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
.modal-container {
	background-color: #ffffff;
	border-radius: 5px;
	box-shadow: 0px 10px 20px -10px rgba(0, 0, 0, 0.75);
	color: rgb(25, 31, 53);
	padding-top: 30px;
	position: relative;
	left: 20%;
	width: 60%;
	top: 25%;
	min-height: 400px;
	text-align: center;
}

.inner-modal-container {
	border-radius: 5px;
	color: rgb(25, 31, 53);
	padding: 30px;
	padding-top: 0px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin: 60px;
	position: relative;
	min-height: 350px;
	text-align: center;
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
	<div
		class="container d-flex justify-content-center d-flex align-items-center p-0 m-0">
		<div
			class="header-text pt-2 d-flex align-items-center  d-flex justify-content-center">
			<p style='color: #529ece'>${errorMessage}</p>
			<a href="login.jsp" class="btn btn-primary ok-btn">OK</a>
		</div>
	</div>
</body>
</html>
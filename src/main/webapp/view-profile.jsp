<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.model.AccessRight"%>
<%
User user = (User) session.getAttribute("user");
if (session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MC- My Profile</title>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<link rel="icon" type="image/x-icon"
	href="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/navbar-style.css">
<Style>
* {
	margin: 0;
	padding: 0;
	text-decoration: none;
}

body {
	background-image: linear-gradient(-45deg, rgb(214, 230, 254) 0%,
		rgb(233, 232, 253) 100%);
}

.form-inline {
	display: flex;
	align-items: center;
}

.form-control[type="search"] {
	width: 400px;
	margin-right: 10px;
}

.btn-outline-success {
	border-color: #1884a5;
	color: #1884a5;
}

.btn-outline-success:hover {
	background-color: #1884a5;
	color: #fff;
}

.btn-outline-success:focus, .btn-outline-success.focus {
	box-shadow: 0 0 0 0.2rem rgba(24, 132, 165, 0.5);
}

.card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	margin-bottom: 80px;
}

.card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

.card-img-top {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.card-body .card-title {
	font-size: 24px;
	color: #529ece;
	margin-top: 10px;
	margin-bottom: 20px;
}

.card-text {
	font-family: 'Source Sans Pro', sans-serif;
	font-size: 14px;
	color: rgb(25, 31, 53);
	letter-spacing: 1.5px;
	margin-top: 5px;
	margin-bottom: 10px;
}

.list-group-item {
	font-size: 14px;
	border: none;
	padding: 5px 0;
}

.btn {
	margin: 10px;
	padding: 10px;
	width: 400px;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
}

.btn-outline-success {
	width: 150px;
	margin: 5px;
	padding: 8px;
	border-radius: 8px;
	font-size: 14px;
	cursor: pointer;
}

.btn-primary {
	background-color: #2db6e0;
	color: #fff;
	border-color: #2db6e0;
}

.btn-primary:hover {
	background-color: #136d8f;
	border-color: #136d8f;
}

.btn-success {
	background-color: #63c45d;
	color: #fff;
	border-color: #63c45d;
}

.btn-success:hover {
	background-color: #449140;
	border-color: #4da249;
}

.btn-danger {
	background-color: #e74c3c;
	color: #fff;
	border-color: #e74c3c;
}

.btn-danger:hover {
	background-color: #bd2918;
	border-color: #c23c2d;
}

.page-title {
	text-align: center;
	font-size: 24px;
	color: #529ece;
	margin-top: 100px;
	margin-bottom: 20px;
	text-transform: uppercase;
}

h4 {
	font-family: 'Source Sans Pro', sans-serif;
	color: rgb(25, 31, 53);
	font-size: 22px;
	margin-top: 40px;
	position: relative;
	top: -3px;
	left: -450px;
}

h4 span {
	color: #91d7f4;
	font-weight: lighter;
}
</Style>

</head>
<body>
	<input type="checkbox" id="check">
	<label style="position: fixed; top: 60px; z-index: 1; left: -5px;"
		for="check"> <i class="fas fa-bars" id="btn"></i> <i
		class="fas fa-times" id="cancel"></i>
	</label>
	<div class="sidebar">
		<jsp:include page="sidebar.jsp" />
	</div>
	<div class="row m-0 p-0">
		<div class="col-12 m-0 p-0">
			<nav class="p-0 m-0 ">
				<img class="nav-logo p-0 m-0 pt-0 mt-0"
					src="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg"
					alt="logo">
				<h4>
					Medi<span>Check</span>
				</h4>
				<ul class="" id="sidemenu">
					<%
					if (user != null) {
					%>
					<li><a href="view-profile.jsp"><i
							class="fa fa-user-circle" aria-hidden="true"></i>&nbsp;&nbsp; <%=user.getName()%></a></li>
					<li><a href="logout.jsp"><i class="fa fa-sign-out"
							aria-hidden="true"></i>&nbsp;&nbsp;Logout</a></li>
					<%
					} else {
					%>
					<li><a href="login.jsp"><i class="fa fa-user-circle"
							aria-hidden="true"></i>&nbsp;&nbsp; Login</a></li>
					<%
					}
					%>
				</ul>
			</nav>
		</div>
	</div>
	<div class="container">
		<div class="row m-0 ">
			<div class="col-2 m-0"></div>
			<div class="col-8 m-0 d-flex justify-content-center">
				<div class="page-title ">MY PROFILE</div>
			</div>
			<div class="col-2 m-0"></div>
		</div>
		<div class="row mt-5">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="card" style="z-index: 1;">
					<img class="card-img-top"
						src="https://www.labtestingmatters.org/wp-content/uploads/2019/10/Medical-Affairs-cover-1-1200x520.jpg"
						alt="Card image cap">
					<div class="card-body">
						<div class="card-title"><%=user.getName()%></div>
						<ul class="list-group">
							<div class="card-text">User ID :</div>
							<li class="list-group-item"><%=user.getUserId()%></li>
							<div class="card-text">Gender :</div>
							<li class="list-group-item"><%=user.getGender()%></li>
							<div class="card-text">Birthdate :</div>
							<li class="list-group-item"><%=user.getBirthdate()%></li>
							<div class="card-text">Email :</div>
							<li class="list-group-item"><%=user.getEmail()%></li>
							<div class="card-text">Conatct Number :</div>
							<li class="list-group-item"><%=user.getPhoneNumber()%></li>
							<div class="card-text">You are registered as :</div>
							<li class="list-group-item"><%=user.getAccessRight().getDisplayName()%></li>
							<%
							if (user != null && user.getAccessRight() == AccessRight.ROLE_TECHNITIAN) {
							%>
							<li class="list-group-item"></li>
							<div class="card-text">Assigned Test Type :</div>
							<li class="list-group-item"><%=user.getSelectedTestType().getDisplayName()%></li>
							<div class="card-text">Specialized Jobs :</div>
							<li class="list-group-item"><%=user.getSpecializedJobs()%></li>
							<div class="card-text">Qualifications :</div>
							<li class="list-group-item"><%=user.getEducationalQualifications()%></li>
							<%
							}
							%>
						</ul>
						<div class="row">
							<div class="col-6">
								<a id="backButton" class="btn btn-primary">Back</a>
							</div>
							<div class="col-6">
								<a class="btn btn-success" href="update-profile.jsp">Edit</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
</body>
<script>
	document.getElementById('backButton').addEventListener('click', function() {
		window.history.back();
	});
</script>
</html>
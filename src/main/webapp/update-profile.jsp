<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.model.AccessRight"%>
<%@ page import="com.labSchedulerSystem.model.Test.TestType"%>
<%@ page import="com.labSchedulerSystem.model.Test"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
User user = (User) session.getAttribute("user");
boolean isTechnician = user != null && user.getAccessRight().equals(AccessRight.ROLE_TECHNITIAN);
boolean isAdmin = user != null && user.getAccessRight().equals(AccessRight.ROLE_ADMIN);
if (session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">
<meta charset="utf-8">
<title>Update Profile</title>
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

h4 {
	font-family: 'Source Sans Pro', sans-serif;
	color: rgb(25, 31, 53);
	font-size: 22px;
	margin-top: 40px;
	position: relative;
	top: -3px;
	left: -480px;
}

h4 span {
	color: #91d7f4;
	font-weight: lighter;
}

body {
	background-image: linear-gradient(-45deg, rgb(214, 230, 254) 0%,
		rgb(233, 232, 253) 100%);
}

.form-group {
	margin-bottom: 20px;
}

label {
	font-weight: bold;
	font-family: 'Source Sans Pro', sans-serif;
	font-size: 13px;
	color: rgb(25, 31, 53);
	letter-spacing: 1.5px;
	margin-top: 5px;
	margin-bottom: 10px;
}

input[type="text"], input[type="date"], select[name="selectedTestType"],
	textarea {
	width: 100%;
	border: 0;
	border-radius: 5px;
	padding: 6px 10px;
	outline: none;
	color: rgb(25, 31, 53);
	-webkit-transition: all .2s ease-out;
	-moz-transition: all .2s ease-out;
	-ms-transition: all .2s ease-out;
	-o-transition: all .2s ease-out;
	transition: all .2s ease-out;
}

select[name="selectedTestType"]:focus {
	width: 100%;
	border: 0;
	border-radius: 5px;
	padding: 6px 10px;
	outline: none;
	color: rgb(25, 31, 53);
	-webkit-transition: all .2s ease-out;
	-moz-transition: all .2s ease-out;
	-ms-transition: all .2s ease-out;
	-o-transition: all .2s ease-out;
	transition: all .2s ease-out;
}

.btn {
	margin: 10px;
	padding: 10px;
	width: 400px;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
}

.form-inline {
	display: flex;
	align-items: center;
}

.form-control[type="search"] {
	width: 400px;
	margin-right: 10px;
	background-color: #fff;
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

.btn-outline-success {
	width: auto;
	margin: 5px;
	padding: 7px;
	border-radius: 8px;
	font-size: 14px;
	cursor: pointer;
}
</Style>
</head>
<body class="m-0 p-0">
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
	<div class="row m-0 ">
		<div class="col-2 m-0"></div>
		<div class="col-8 m-0 d-flex justify-content-center">
			<div class="page-title">Update Profile</div>
		</div>
		<div class="col-2 m-0"></div>
	</div>
	<div class="row m-0 d-flex justify-content-center "></div>
	<div class="row m-0 mb-5">
		<div class="col-2 m-0"></div>
		<div class="col-8 m-0 d-flex justify-content-center">
			<form action="usermanager" method="post"
				onsubmit="return confirmUpdate();">
				<input class="form-control" type="hidden" id="accessRight"
					name="accessRight" readonly="readonly" value="${user.accessRight}" />
				<label for="userIdUpdate">User ID:</label> <input
					class="form-control" type="number" id="userIdUpdate" name="userId"
					readonly="readonly" value="${user.userId}" /> <label for="email">Email:</label>
				<input class="form-control" type="text" id="email" name="email"
					readonly="readonly" value="${user.email}" /> <label for="name">
					Name:</label> <input class="form-control" type="text" id="name" name="name"
					value="${user.name}" /> <label for="phoneNumber">Phone
					number:</label> <input class="form-control" type="text" id="phoneNumber"
					name="phoneNumber" value="${user.phoneNumber}" /> <label
					for="birthdate">Birth-date:</label> <input class="form-control"
					type="date" id="birthdate" name="birthdate"
					value="${user.birthdate}" /> <label for="gender">Gender:</label> <input
					class="form-control" type="text" id="gender" name="gender"
					value="${user.gender}" />
				<c:if test="${user.accessRight == 'ROLE_TECHNITIAN'}">
					<label for="selectedTestType">Assigned test type:</label>
					<select name="selectedTestType" id="selectedTestType">
						<option value="${user.selectedTestType}" selected>${user.selectedTestType.displayName}</option>
						<%
						for (TestType type : TestType.values()) {
						%>
						<option value="<%=type.name()%>"><%=type.getDisplayName()%></option>
						<%
						}
						%>
					</select>
					<label for="educationalQualifications">Educational
						Qualifications</label>
					<input class="form-control" type="text"
						id="educationalQualifications" name="educationalQualifications"
						value="${user.educationalQualifications}" />
					<label for="specializedJobs">Specialized Job
						qualifications:</label>
					<input class="form-control" type="text" id="specializedJobs"
						name="specializedJobs" value="${user.specializedJobs}" />
				</c:if>
				<input type="hidden" name="useractiontype" value="edit" />
				<button type="submit" class="btn btn-success">Update</button>
				<a id="backButton" class="btn btn-primary">Back</a>
				<script>
					document.getElementById('backButton').addEventListener(
							'click', function() {
								window.history.back();
							});
				</script>
			</form>
		</div>
		<div class="col-1"></div>
	</div>
	<script>
		function confirmUpdate() {
			return confirm("Are you sure you want to update this user?");
		}
	</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.model.AccessRight"%>
<!DOCTYPE html>
<html>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/1a4bb98cfa.js"
	crossorigin="anonymous"></script>
<meta charset="ISO-8859-1">
<title>Medicheck</title>
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
<link rel="stylesheet" type="text/css" href="css/sidebar.css">
</head>
<%
User user = (User) session.getAttribute("user");
%>
<header>Menu</header>
<div class="normal-content">
	<a href="home.jsp" class="active"> <i class="fa fa-home"
		aria-hidden="true"></i> <span>Home</span>
	</a>
</div>
<%
if (user != null && user.getAccessRight() == AccessRight.ROLE_TECHNITIAN) {
%>
<div class="normal-content">
	<a href="technician-dashboard.jsp"> <i class="fa fa-tachometer"
		aria-hidden="true"></i> <span>Dashboard</span>
	</a> <a href="getAppointment?appactiontype=appointmentByConsultantId">
		<i class="fa fa-calendar" aria-hidden="true"></i> <span>Appointments</span>
	</a>
</div>
<%
}
%>
<%
if (user != null && user.getAccessRight() == AccessRight.ROLE_USER) {
%>
<div class="normal-content">
	<a href="getAppointment?appactiontype=appointmentBySeekerId"> <i
		class="fa fa-calendar" aria-hidden="true"></i> <span>Appointments</span>
	</a>
</div>
<%
}
%>
<%
if (user != null && user.getAccessRight() == AccessRight.ROLE_ADMIN) {
%>
<div class="normal-content">
	<a href="admin-dashboard.jsp"> <i class="fa fa-tachometer"
		aria-hidden="true"></i> <span>Dashboard</span>
	</a>
</div>
<div class="dropdown">
	<a> <i class="fa fa-users" aria-hidden="true"></i> <span>User</span>
	</a>
	<div class="dropdown-content">
		<a href="getuser?useractiontype=all">view all</a> <a
			href="getuser?useractiontype=pending">view new</a>
	</div>
</div>
<div class="dropdown">
	<a> <i class="fa fa-calendar" aria-hidden="true"></i> <span>Appointments</span>
	</a>
	<div class="dropdown-content">
		<a href="getAppointment?appactiontype=all">View all</a> <a
			href="getAppointment?appactiontype=requested">View new</a> <a
			href="getAppointment?appactiontype=adminRequested">View pending</a>
	</div>
</div>
<div class="dropdown">
	<a> <i class="fa fa-bar-chart" aria-hidden="true"></i> <span>Reports</span>
	</a>
	<div class="dropdown-content">
		<a href="user-report.jsp">User</a> <a
			href="appointment-summary-report.jsp">Appointments</a> <a
			href="technician-performance-report.jsp"> Technicians</a>
	</div>
</div>
<%
}
%>
<div class="normal-content">
	<a href="getAppointment?appactiontype=allTests"> <i
		class="fa-regular fa-calendar-check"></i> <span>Book Tests</span>
	</a>
</div>
<div class="normal-content">
	<a href="getuser?useractiontype=technicians"> <i
		class="fa-solid fa-user-nurse"></i> <span>Technicians</span>
	</a>
</div>
<%
if (user != null
		&& (user.getAccessRight() == AccessRight.ROLE_USER || user.getAccessRight() == AccessRight.ROLE_TECHNITIAN)) {
%>
<div class="normal-content">
	<a href="view-profile.jsp"> <i class="fa fa-user"
		aria-hidden="true"></i> <span>Profile</span>
	</a>
</div>
<%
}
%>
<div class="normal-content">
	<a href="contact-us-page.jsp"> <i class="fa fa-phone-square"
		aria-hidden="true"></i> <span>Contact</span>
	</a>
</div>
<%
if (user != null) {
%>
<div class="normal-content">
	<a href="logout.jsp"> <i class="fa fa-sign-out" aria-hidden="true"></i>
		<span>Logout</span>
	</a>
</div>
<%
} else {
%>
<div class="normal-content">
	<a href="login.jsp"> <i class="fas fa-sign-in-alt"></i> <span>Login</span>
	</a>
</div>
<%
}
%>
<script>
	var sidemenu = document.getElementById("sidemenu");
	function openmenu() {
		sidemenu.style.right = "0"
	}
	function closemenu() {
		sidemenu.style.right = "-200px"
	}
</script>
</html>
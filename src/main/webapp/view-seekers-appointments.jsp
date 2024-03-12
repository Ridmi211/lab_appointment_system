<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.model.AccessRight"%>
<%@ page import="com.labSchedulerSystem.model.RegistrationStatus"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">
<title>My Appointments</title>
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
<link rel="stylesheet" type="text/css" href="css/view-list.css">
<Style>
h4 {
	font-family: 'Source Sans Pro', sans-serif;
	color: rgb(25, 31, 53);
	font-size: 22px;
	margin-top: 40px;
	position: relative;
	top: -3px;
	left: -450px;
}

.reference {
	color: rgb(25, 31, 53);
	font-size: 14px;
}

h4 span {
	color: #91d7f4;
	font-weight: lighter;
}

.btn {
	background-color: rgb(255, 128, 64);
	color: #fff;
	border-color: rgb(255, 128, 64);
	padding: 7px;
	padding-left: 15px;
	padding-right: 15px;
	border-radius: 15px;
	text-decoration: none;
	margin-top: 2px;
	margin: 0 5px;
	padding: 5px 10px;
	width: 70px;
	border-radius: 15px;
	font-size: 14px;
	cursor: pointer;
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
	<div class="row m-0 ">
		<div class="col-2 m-0"></div>
		<div class="col-8 m-0 d-flex justify-content-center">
			<div class="page-title">${pageTopic}</div>
		</div>
		<div class="col-2 m-0"></div>
	</div>
	<div class="row m-0 "></div>
	<div class="row m-0">
		<div class="col-1 m-0"></div>
		<div class="col-10 m-0">
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col" class="text-center">Count</th>
						<th scope="col" class="text-center">Appointment ID</th>
						<th scope="col" class="text-center">Technician</th>
						<th scope="col" class="text-center">Patient</th>
						<th scope="col" class="text-center">Date</th>
						<th scope="col" class="text-center">Time</th>
						<th scope="col" class="text-center">Status</th>
						<th scope="col">Report</th>
						<th scope="col">View</th>
						<th scope="col">Cancel</th>
					</tr>
				</thead>
				<tag:forEach var="appointment" items="${requestedAppointments}">
					<tr>
						<td scope="row"></td>
						<td class="text-center">${appointment.appointmentId}</td>
						<td class="text-center">${appointment.consultantName}</td>
						<td class="text-center">${appointment.seekerName}</td>
						<td class="text-center">${appointment.scheduledDate}</td>
						<td class="text-center">${appointment.startTime}</td>
						<td class="text-center status-cell">
							<div class=" status-cell">
								${appointment.status.displayName}</div>
						</td>
						<td class="btn-column">
							<button class="btn-accept"
								onclick="window.location.href='test-results-report.jsp?testId=${appointment.appointmentId}'"
								<c:if test="${appointment.status != 'COMPLETED'}">disabled</c:if>>
								<c:choose>
									<c:when test="${appointment.status != 'COMPLETED'}">Unavailable</c:when>
									<c:otherwise>Download</c:otherwise>
								</c:choose>
							</button>
						</td>
						<td class="btn-column">
							<form action="appointmentManager" method="post">
								<input type="hidden" name="appointmentId"
									value="${appointment.appointmentId}"> <input
									type="hidden" name="appactiontype" value="view">
								<button type="submit" class=" btn-view">View</button>
							</form>
						<td class="btn-column">
							<form action="appointmentManager" method="post">
								<input type="hidden" name="appointmentId"
									value="${appointment.appointmentId}"> <input
									type="hidden" name="appactiontype" value="cancel-by-seeker">
								<button type="submit" class="btn-delete">Cancel</button>
							</form>
						</td>
					</tr>
				</tag:forEach>
			</table>
		</div>
		<div class="col-1"></div>
	</div>
	<script>
		function confirmDelete() {
			return confirm("Are you sure you want to delete this user?");
		}
	</script>
</body>
</html>

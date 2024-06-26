<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.model.AccessRight"%>
<%@ page import="com.labSchedulerSystem.model.Test.TestType"%>
<%@ page import="com.labSchedulerSystem.model.Test"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.model.AccessRight"%>
<%@ page import="com.labSchedulerSystem.service.AppointmentService"%>
<%@ page import="com.labSchedulerSystem.service.UserService"%>
<%@ page import="com.labSchedulerSystem.service.MessageService"%>
<%@ page import="java.time.Year"%>
<%@ page import="java.util.List"%>
<%@ page import="com.labSchedulerSystem.dao.AppointmentManagerImpl"%>
<%@ page import="com.labSchedulerSystem.dao.UserManagerImpl"%>

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
<title>MC-Test Registration</title>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/1a4bb98cfa.js"
	crossorigin="anonymous"></script>
<meta charset="utf-8">
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
	font-family: 'Poppins', sans-serif;
	box-sizing: border-box;
}

html {
	scroll-behavior: smooth;
}

body {
	background-image: linear-gradient(-45deg, #e3eefe 0%, rgb(240, 247, 255)
		100%);
	color: #000000;
}

h2 {
	color: #855ba5;
}

#header {
	width: 100;
	height: 100vh;
	background-size: cover;
	background-position: center;
}

#about-us {
	width: 100;
	height: 100vh;
	background-size: cover;
	background-position: center;
}

.header-text {
	margin-top: 45%;
	font-size: 22px;
}

.header-text h1 {
	font-size: 20px;
	margin-top: 40px;
}

.header-text h2 {
	font-size: 60px;
	margin-top: 40px;
	color: #584674;
}

.header-text h1 span {
	color: #08d8ca;
}

#about {
	padding: 80px 0;
	color: #ababab;
}

.row {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
}

.about-col-1 {
	flex-basis: 35%;
}

.about-col-1 img {
	width: 100%;
	border-radius: 15px;
}

.about-col-2 {
	flex-basis: 60%;
	text-align: justify;
}

.sub-title {
	font-size: 50px;
	font-weight: 600;
	color: #000000;
}

.tab-titles {
	display: flex;
	margin: 20px 0 40px;
}

.tab-links {
	margin-right: 50px;
	font-size: 18px;
	font-weight: 500;
	cursor: pointer;
	position: relative;
}

.tab-links::after {
	content: '';
	width: 0;
	height: 3px;
	background: #08d8ca;
	position: absolute;
	left: 0;
	bottom: -8px;
	transition: 0.5s;
}

.tab-links.active-link::after {
	width: 50%;
}

.tab-contents ul li {
	list-style: none;
	margin: 10px 0px;
}

.tab-contents ul li span {
	color: #21dbcfe3;
	font-size: 14px;
}

.tab-contents {
	display: none;
}

.tab-contents.active-tab {
	display: block;
}

#services {
	padding: 30px 0;
	height: 90vh;
}

.services {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	grid-gap: 40px;
	margin-top: 50px;
}

.services div {
	padding: 40px;
	font-size: 13px;
	font-weight: 300;
	border-radius: 10px;
	transition: background 0.5s, transform 0.5s;
}

.services div i {
	font-size: 50px;
	margin-bottom: 30px;
}

.services div h2 {
	font-size: 30px;
	font-weight: 500;
	margin-bottom: 15px;
}

.services div a {
	text-decoration: none;
	color: #000000;
	font-size: 12px;
	margin-top: 20px;
	display: inline-block;
}

.services div:hover {
	transform: translateY(-10px);
}

.services-list {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	grid-gap: 40px;
	margin-top: 50px;
}

.services-list div {
	background: #262626;
	padding: 40px;
	font-size: 13px;
	font-weight: 300;
	border-radius: 10px;
	transition: background 0.5s, transform 0.5s;
}

.services-list div i {
	font-size: 50px;
	margin-bottom: 30px;
}

.services-list div h2 {
	font-size: 30px;
	font-weight: 500;
	margin-bottom: 15px;
}

.services-list div a {
	text-decoration: none;
	color: #000000;
	font-size: 12px;
	margin-top: 20px;
	display: inline-block;
}

.services-list div:hover {
	background: #d6adff;
	transform: translateY(-10px);
}

#portfolio {
	padding: 50px 0;
}

.work-list {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	grid-gap: 40px;
	margin-top: 50px;
}

.work {
	border-radius: 10px;
	position: relative;
	overflow: hidden;
}

.layer {
	width: 360px;
	height: 0;
	background: linear-gradient(rgba(187, 187, 187, 0.942), #3fcbe4);
	border-radius: 10px;
	position: absolute;
	left: 0;
	bottom: 0;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	font-size: 14px;
	transition: height 0.5s;
	color: rgb(77, 77, 77);
}

.layer h3 {
	font-weight: 500;
	margin-bottom: 20px;
}

.layer a {
	margin-top: 20px;
	color: #d6adff;
	text-decoration: none;
	font-size: 18px;
	line-height: 60px;
	background: #020202;
	width: 60px;
	height: 60px;
	border-radius: 50%;
	text-align: center;
	transition: background 8s;
}

.work:hover .layer {
	height: 100%
}

.btn {
	display: block;
	margin: 50px auto;
	width: fit-content;
	border: 1px solid #d6adff;
	padding: 14px 50px;
	border-radius: 6px;
	text-decoration: none;
	color: #070707;
	transition: background 0.5s;
}

.btn:hover {
	background: #d6adff;
}

.contact-left {
	flex-basis: 35%;
}

.contact-right {
	flex-basis: 60%;
}

.contact-left p {
	margin-top: 30px;
}

.contact-left p i {
	color: #d6adff;
	margin-right: 15px;
	font-size: 25px;
}

.social-icons {
	margin-top: 30px;
}

.social-icons a {
	text-decoration: none;
	font-size: 30px;
	margin-right: 15px;
	color: #ababab;
	display: inline-block;
	transition: transform 0.5s;
}

.social-icons a:hover {
	color: #d6adff;
	transform: translateY(-5px);
}

.btn.btn2 {
	display: inline-block;
	background: #d6adff;
}

.btn.btn2:hover {
	background: #5b4a6b;
	color: #ffffff;
}

.contact-right form {
	width: 100%;
}

form input, form textarea {
	width: 100%;
	border: 1px solid rgb(223, 179, 245);
	outline: none;
	background: #ffffff;
	padding: 15px;
	margin: 15px 0;
	color: #6c6c6c;
	font-size: 18px;
	border-radius: 6px;
}

form .btn2 {
	padding: 14px 60px;
	font-size: 18px;
	margin-top: 20px;
	cursor: pointer;
}

.copyright {
	width: 100%;
	text-align: center;
	padding-top: 20px;
	padding-bottom: 10px;
	background: #1a1a1add;
	font-weight: 100;
	margin-top: 20px;
	color: white;
}

.copyright i {
	color: #d6adff;
}

.tab-links {
	font-size: 16px;
	margin-right: 20px;
}

.contact-left, .contact-right {
	flex-basis: 100%;
}

.copyright {
	font-size: 14px;
}

}
.sub-title:hover {
	transform: translateY(-10px);
}

.sub-title {
	transition: background 0.5s, transform 0.5s;
}

#msg {
	color: #08d8ca;
	margin-top: -40px;
	display: block;
}

label #btn, label #cancel {
	position: absolute;
	left: 5px;
	cursor: pointer;
	color: #d6adff;
	border-radius: 5px;
	margin: 15px 30px;
	font-size: 29px;
	background-color: #e8d1ff;
	box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, .5), inset -7px
		-7px 10px 0px rgba(0, 0, 0, .1), 3.5px 3.5px 20px 0px
		rgba(0, 0, 0, .1), 2px 2px 5px 0px rgba(0, 0, 0, .1);
	height: 45px;
	width: 45px;
	text-align: center;
	text-shadow: 2px 2px 3px rgba(255, 255, 255, 0.5);
	line-height: 45px;
	transition: all .5s ease;
	z-index: 5px;
}

label #cancel {
	opacity: 0;
	visibility: hidden;
}

#check:checked ~.sidebar {
	left: 0;
}

#check:checked ~label #btn {
	margin-left: 245px;
	opacity: 0;
	visibility: hidden;
}

#check:checked ~label #cancel {
	margin-left: 245px;
	opacity: 1;
	visibility: visible;
}

@media ( max-width : 860px) {
	.sidebar {
		height: auto;
		width: 70px;
		left: 0;
		margin: 100px 0;
	}
	header, #btn, #cancel {
		display: none;
	}
	span {
		position: absolute;
		margin-left: 23px;
		opacity: 0;
		visibility: hidden;
	}
	.sidebar a {
		height: 60px;
	}
	.sidebar a i {
		margin-left: -10px;
	}
	a:hover {
		width: 200px;
		color: #9884e4;
		background: inherit;
		z-index: 5;
	}
	.sidebar a:hover span {
		opacity: 1;
		visibility: visible;
	}
}

.sidebar>a.active, .sidebar>a:hover:nth-child(even) {
	--accent-color: #52d6f4;
	--gradient-color: #c1b1f7;
}

.sidebar a.active, .sidebar>a:hover:nth-child(odd) {
	--accent-color: #c1b1f7;
	--gradient-color: #A890FE;
}

.frame {
	width: 50%;
	height: 30%;
	margin: auto;
	text-align: center;
}

@import url('https://fonts.googleapis.com/css?family=Montserrat');

.card-container {
	background-color: #91d7f4;
	border-radius: 5px;
	box-shadow: 0px 10px 20px -10px rgba(0, 0, 0, 0.75);
	color: #ffffff;
	padding-top: 30px;
	position: relative;
	width: 350px;
	max-width: 100%;
	text-align: center;
}

.card-container .pro {
	color: #231E39;
	background-color: #FEBB0B;
	border-radius: 3px;
	font-size: 14px;
	font-weight: bold;
	padding: 3px 7px;
	position: absolute;
	top: 30px;
	left: 30px;
}

.card-container .round {
	border: 1px solid #03BFCB;
	border-radius: 50%;
	padding: 7px;
	height: 120px;
	width: 120px;
}

button.primary {
	background-color: #905abd;
	border-radius: 3px;
	color: white;
	font-family: Montserrat, sans-serif;
	font-weight: 500;
	padding: 10px 5px;
}

button.primary.ghost {
	background-color: transparent;
	color: #02899C;
}

.skills {
	background-color: #529ece;
	text-align: left;
	padding: 15px;
	margin-top: 10px;
}

.skills ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.skills ul li {
	border: 1px solid #2D2747;
	border-radius: 2px;
	display: inline-block;
	font-size: 12px;
	margin: 0 7px 7px 0;
	padding: 7px;
}

.name {
	display: inline-block;
	font-size: 20px;
	margin: 0 7px 7px 0;
	padding: 7px;
	color: #2D2747;
	font-weight: 600;
}

.countries {
	text-align: center;
	padding: 15px;
	padding-bottom: 0px;
}

.countries ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.countries ul li {
	background-color: #03BFCB;
	border: 1px solid #03BFCB;
	border-radius: 3px;
	color: #231E39;
	display: inline-block;
	font-size: 12px;
	margin: 0 7px 7px 0;
	padding: 7px;
}

.qualifications {
	text-align: center;
	padding: 15px;
	padding-bottom: 0px;
}

.qualifications ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.qualifications ul li {
	border: 1px solid #00433f;
	border-radius: 3px;
	color: #231E39;
	display: inline-block;
	font-size: 12px;
	margin: 0 7px 7px 0;
	padding: 7px;
}

.days {
	text-align: left;
	padding: 5px;
	margin-top: 10px;
}

.days ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.days ul li {
	border: 1px solid #2D2747;
	border-radius: 2px;
	display: inline-block;
	font-size: 12px;
	margin: 0 4px 4px 0;
	padding: 5px;
}

.btn.btn3 {
	display: inline-block;
	margin: 5px auto;
	width: fit-content;
	border: 1px solid #91d7f4;
	padding: 5px 50px;
	border-radius: 6px;
	text-decoration: none;
	transition: background 0.5s;
	background: #91d7f4;
}

.btn.btn3:hover {
	background: #529ece;
	color: #ffffff;
}

form input, form textarea, form select {
	width: 100%;
	border: 1px solid #91d7f4;
	outline: none;
	background: #ffffff;
	padding: 10px;
	margin: 2px 0;
	color: #6c6c6c;
	font-size: 14px;
	border-radius: 6px;
}

.title-one {
	font-family: 'Source Sans Pro', sans-serif;
	color: #529ece;
	font-size: 35px;
}

.title-two {
	font-size: 30px;
	margin: 0 7px 7px 0;
	padding: 7px;
	color: #2D2747;
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

.reference {
	color: rgb(25, 31, 53);
	font-size: 14px;
}

h4 span {
	color: #91d7f4;
	font-weight: lighter;
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
	<div class="row p-5 pb-0 m-0 mt-5" style="text-align: center;">
		<div class="title-one">Check out our availability and book the
			date and time that works for you</div>
	</div>
	<div class="row p-0 p-5  " style="margin-left: 140px; margin-top: 0px;">
		<div class="container">
			<div class="row">
				<%
				String testIdString = request.getParameter("testId");
				int testId = Integer.parseInt(testIdString);
				AppointmentManagerImpl appointmentManager = new AppointmentManagerImpl();
				AppointmentService appointmentService = AppointmentService.getAppointmentService();
				Test test1 = appointmentManager.fetchSingleTest(testId);
				%>
				<div class="col-sm mb-5">
					<div class="work">
						<div class="card-container">
							<img class="round"
								src="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg"
								alt="user" /> <br>
							<div class="name">
								<%=test1.getType().getDisplayName()%>
							</div>
							<div class="qualifications">
								<ul>
									<li><p>Preparation instructions</p>
										<div class="reference"><%=test1.getPreparationInstructions()%></div>
									</li>
									<li>Report ready in : <%=test1.getReportReadyIn()%></li>
									<li>Measured in : <%=test1.getMeasurementUnit()%></li>
								</ul>
							</div>
							<div class="countries">
								<div class="reference">Reference range</div>
								<ul id="availableCountriesList">
									<li>Lower: <%=test1.getLowReferenceRange()%></li>
									<li>Higher: <%=test1.getHighReferenceRange()%></li>
								</ul>
							</div>
							<div class="skills">
								<h6>Cost</h6>
								<ul id="availableJobsList">
									<li><%=test1.getCost()%></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm mb-5 p-5 m-5 mt-0 pt-1">
					<div class="row">
						<form action="appointmentManager" method="post" id="bookingForm">
							<input type="hidden" name="seekerId"
								value="<%=user.getUserId()%>">
							<div class="row mb-1 mt-3"></div>
							<div class="row">
								<input type="hidden" name="test" id="test"
									value="<%=test1.getType()%>">
							</div>
							<div class="row mb-1">Select a Date</div>
							<div class="row">
								<input type="date" id="date" name="date" required>
							</div>
							<div class="row mb-1 mt-3">Recommended doctor</div>
							<div class="row">
								<input name="doctor" id="doctor" placeholder="Recomended Doctor"
									required>
							</div>
							<div class="row">
								<input type="hidden" name="cost" id="cost"
									value="<%=test1.getCost()%>">
							</div>
							<%
							UserManagerImpl userManager = new UserManagerImpl();
							List<User> technicians = userManager.fetchTechniciansForTest(testId);
							%>
							<div class="row mb-1 mt-3">Select Technician</div>
							<div class="row">
								<select name="technitianId" id="technitianId" required>
									<option value="">Select Technician</option>
									<%
									for (User technician : technicians) {
									%>
									<option value="<%=technician.getUserId()%>"><%=technician.getName()%></option>
									<%
									}
									%>
								</select>
							</div>

							<div class="row mb-1 mt-3">Additional Notes</div>
							<div class="row">
								<textarea name="notes" style="height: 200px" required></textarea>
							</div>
							<div>
								<input type="hidden" name="appactiontype" value="addAppointment" />
								<button style="position: relative; left: 0%;" class="btn btn3"
									type="submit">Book</button>
							</div>
						</form>
					</div>
				</div>
				<div class="col-sm mb-5 p-5 mt-0 pt-1" id="bookingDetailsCard">
					Your booking details are as follows
					<div class="card-container mt-2">
						<div
							style="padding-left: 30px; text-align: left; line-height: 2.5rem">
							<li>Name : <%=user.getName()%></li>
							<li>Email : <%=user.getEmail()%></li>
							<li>Test Type :<%=test1.getType().getDisplayName()%></li>
							<li>Recommended Doctor : -</li>
							<li>Selected Technician : -</li>
							<li>Date : -</li>
							<li>Additional Notes : -</li>
						</div>
						<div class="skills" style="padding-left: 30px;">
							<li class="pb-2">Your Payment</li>
							<ul style="padding-left: 30px;">
								<li>00.00</li>
							</ul>
						</div>
						<div class="countries"></div>
					</div>
				</div>
				<div id="paymentModal" class="modal">
					<div class="modal-container">
						<div class="inner-modal-container">
							<div class="title-two">Payment Details</div>
							<form id="paymentForm">
								<input type="text" placeholder="Credit Card Number" required>
								<input type="text" placeholder="Expiry Date" required> <input
									type="text" placeholder="CVV" required>
								<div class="name">
									Amount :<%=test1.getCost()%></div>
								<br>
								<button type="submit" class="btn btn3">Pay Now</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
  document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("bookingForm");
    const bookingDetailsCard = document.getElementById("bookingDetailsCard");
    const paymentModal = document.getElementById("paymentModal");
    const paymentForm = document.getElementById("paymentForm");
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      paymentModal.style.display = "block";
    });
    paymentForm.addEventListener("submit", function (e) {
      e.preventDefault();
      updateBookingDetails();
      paymentModal.style.display = "none";
    });
    function updateBookingDetails() {
      const date = form.querySelector('input[name="date"]').value;
      const testType = form.querySelector('input[name="test"]').value;
      const notes = form.querySelector('textarea[name="notes"]').value;
      const recomendedDoctor = form.querySelector('input[name="doctor"]').value;
      const costOfTest = form.querySelector('input[name="cost"]').value;
      const technitianId = form.querySelector('select[name="technitianId"]').value;
      const bookingDetailsHTML = `
        Your booking details are as follows
        <div class="card-container mt-2">
          <div style="padding-left: 30px; text-align: left; line-height: 2.5rem">
            <li>Name : <%=user.getName()%></li>
            <li>Email : <%=user.getEmail()%></li>           
            <li>Selected Test:<%=test1.getType().getDisplayName()%></li>
            <li>Recomended Doctor : ${recomendedDoctor}</li>
      
            <li>Date : ${date}</li>
            <li>Notes : ${notes}</li>
          </div>
          <div class="skills" style="padding-left: 30px;">
            <li class="pb-2">Payement Confirmed</li>
            <ul style="padding-left: 30px;">
            <li><%=test1.getCost()%></li></ul>
          </div>
          <div class="countries">
            <button id="confirmBookingButton" style="position: relative; left: 0%;" class="btn btn2">Proceed</button>
          </div>
        </div>
      `;
      bookingDetailsCard.innerHTML = bookingDetailsHTML;
      bookingDetailsCard.style.display = "block";
      const confirmBookingButton = document.getElementById("confirmBookingButton");
      confirmBookingButton.addEventListener("click", function () {
        form.submit();
      });
    }
  });
</script>
</body>
</html>
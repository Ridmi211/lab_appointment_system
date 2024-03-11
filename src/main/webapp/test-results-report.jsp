<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.model.RegistrationStatus"%>
<%@ page import="com.labSchedulerSystem.model.AccessRight"%>
<%@ page import="com.labSchedulerSystem.service.AppointmentService"%>
<%@ page import="com.labSchedulerSystem.service.UserService"%>
<%@ page import="com.labSchedulerSystem.service.MessageService"%>
<%@ page import="java.time.Year"%>
<%@ page import="java.util.List"%>
<%@ page import="com.labSchedulerSystem.dao.AppointmentManagerImpl"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page import="com.fasterxml.jackson.core.JsonProcessingException"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.labSchedulerSystem.dao.UserManagerImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.util.Random"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.util.stream.IntStream"%>
<%@ page import="java.time.Year"%>
<%@ page import="com.labSchedulerSystem.dao.UserManager"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
<%@ page import="com.labSchedulerSystem.dao.AppointmentManagerImpl"%>
<%@ page import="com.labSchedulerSystem.model.Appointment"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="com.labSchedulerSystem.model.Appointment.Status"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="css/reports.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
	<link rel="icon" type="image/x-icon"
	href="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg">
	
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
<title>Test Results</title>
<style>
.black-bottom{
 border-bottom: 2px solid black;
}
h4 {
	font-family: 'Source Sans Pro', sans-serif;
	color: rgb(25, 31, 53);
	font-size: 22px;
	/* margin-top: 40px;
	position: relative;
	top: -3px;
	left: -450px; */
}


h4 span {
	color: #91d7f4;
	font-weight: lighter;
}
</style>
</head>
<body style="margin: 0; padding: 0; background-color: #efdfff;">
	<input type="checkbox" id="check">
	<label style="position: fixed; top: 60px; z-index: 1; left: -5px;"
		for="check"> <i class="fas fa-bars" id="btn"></i> <i
		class="fas fa-times" id="cancel"></i>
	</label>
	<%
	User user = (User) session.getAttribute("user");
	%>
	<%
	String testIdString = request.getParameter("testId");
	int testId = Integer.parseInt(testIdString);
	AppointmentManagerImpl appointmentManager = new AppointmentManagerImpl();
	AppointmentService appointmentService = AppointmentService.getAppointmentService();
	Appointment test1 = appointmentManager.fetchSingleAppointment(testId);
	UserManagerImpl userManager = new UserManagerImpl();
	int userId = test1.getSeekerId();
	int technicianId = test1.getTechnitianId();
	User patient = userManager.fetchSingleUser(userId);
	User technician = userManager.fetchSingleUser(technicianId);
	%>
	<div class="sidebar">
		<jsp:include page="sidebar.jsp" />
	</div>
	<button id="print"
		style="background-color: #1da1f2; border: #1da1f2; margin-top: 20px; position: fixed; left: 85%; z-index: 80;"
		type="button" onclick="generatePDF()" class="btn btn-primary">Export
		as PDF</button>
	<script type="text/javascript">
		function generatePDF() {
			var element = document.getElementById('divToExport');
			element.style.width = '790px';
			var opt = {
				margin : 0,
				filename : 'Test Results.pdf',
				image : {
					type : 'jpeg',
					quality : 1
				},
				html2canvas : {
					scale : 2
				},
				jsPDF : {
					unit : 'in',
					format : 'A4',
					orientation : 'portrait',
					precision : '12'
				}
			};
			html2pdf().set(opt).from(element).save();
		}
	</script>

	<div id="divToExport" class="a4-container">
		<div class="">
			<div class="page-title d-flex align-items-center align-self-center"><%=test1.getAppointmentRefId()%></div>

		</div>
		
		
		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="d-flex justify-content-center ">
					<img class="nav-logo p-0 m-0 pt-0 mt-0"
					src="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg"
					alt="logo"></div>
				</div>
				<div class=" common-border d-flex justify-content-center">
				
					
				<h4>
					  &nbsp;&nbsp;<span>  MediCheck Laboratory Services</span>
				</h4>
				</div>
				<div class=" common-border">
					<div class="d-flex justify-content-center common-border"><h4> <%=test1.getTestType().getDisplayName()%> results	</h4></div>
				</div>
				
			</div>
		</div>
		
		
		
		<div class=" card-container">
			<div class="col">
				
				<div class="row common-border black-bottom m-0">
					<div class="col-sm col-8 common-border pb-2 ">
						<ul>
							<li>Patient Name:<%=patient.getName()%></li>
							<li>Gender:<%=patient.getGender()%></li>
							<li>Contact:<%=patient.getPhoneNumber()%>
							</li>
							</ul>
					</div>
					<div class="col-sm col-3 common-border pb-2 ">
						<ul>
							<li>Recommended by:<%=test1.getRecomendedDoctor()%></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
			<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<!-- <div class="card-title common-border">Patient details</div> -->
				</div>
				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>
				<div class="row common-border  m-0">
					<div class="col-sm col-12 common-border pb-2 ">
						<ul>
							<li>Test:<%=test1.getTestType().getDisplayName()%></li>
							<li>Results:<%=test1.getTestResults()%></li>
							<li>Description:<%=test1.getTestResultsDescription()%>
							</li>
							</ul>
					
					</div>
				</div>
				<div class="row common-border black-bottom m-0 mt-3 pb-3">
					<div class="col-sm col-8 common-border pb-2 ">
						
							Test done by :<%=technician.getName()%>
							
							
					</div>
					<div class="col-sm col-4 common-border pb-2 ">
						
							Documented on :<%=test1.getTestUpdatedOn()%>
						
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="pebble-footer">
			<div class="row page-footer">
				<div class="col-5 body-text"></div>
				<div class="col-4">Report Generated On:</div>
				<div class="col-3" id="currentDay"></div>
			</div>
		</div>
		<script>
			// Get the current date
			var currentDate = new Date();

			// Format the date as YYYY/MM/DD
			var formattedDate = currentDate.getFullYear() + '/'
					+ (currentDate.getMonth() + 1) + '/'
					+ currentDate.getDate();

			// Display the formatted date in the specified element
			document.getElementById('currentDay').innerHTML = formattedDate;
		</script>
		<!-- Card structure-->
	</div>

	<!-- footer template -->

</body>
</html>

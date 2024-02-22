<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
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

<%@ page import="com.labSchedulerSystem.service.AppointmentService"%>
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
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0-beta3/css/all.min.css"> -->
<link rel="stylesheet" type="text/css" href="css/reports.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- exportas pdf -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<!-- exportas pdf -->
<title>Consultant Summary Report</title>

<style>
</style>
<style>
/*  body {
            font-family: Arial, sans-serif;
            padding: 20px;
        } */
</style>


</head>
<body style="margin: 0; padding: 0; background-color: #efdfff;">
	<input type="checkbox" id="check">
	<label style="position: fixed; top: 60px; z-index: 1; left: -5px;"
		for="check"> <i class="fas fa-bars" id="btn"></i> <i
		class="fas fa-times" id="cancel"></i>
	</label>

	<%
	// Get the user object from the session
	User user = (User) session.getAttribute("user");
	%>

	<div class="sidebar">
		<jsp:include page="sidebar.jsp" />

	</div>
	<button id="print"
		style="background-color: #9884e4; border: #9884e4; margin-top: 20px; position: fixed; left: 85%; z-index: 80;"
		type="button" onclick="generatePDF()" class="btn btn-primary">Export
		as PDF</button>
	<script type="text/javascript">
		function generatePDF() {

			// Choose the element id which you want to export.
			var element = document.getElementById('divToExport');
			element.style.width = '790px';
			// element.style.height = '900px';
			var opt = {
				margin : 0,
				filename : 'Registered Job Consultants.pdf',
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

			// choose the element and pass it to html2pdf() function and call the save() on it to save as pdf.
			html2pdf().set(opt).from(element).save();
		}
	</script>

	<div id="divToExport" class="a4-container">
		<div class="">
			<div class="page-title d-flex align-items-center align-self-center">Consultant
				Performance Report</div>
		</div>
		<!-- Card 1  numbers -->

		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Number of Appointments
						per Consultant</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border">Description</div>
				</div>

				<%
				try {
					AppointmentService appointmentService = AppointmentService.getAppointmentService();

					AppointmentManagerImpl appointmentManager = new AppointmentManagerImpl();
					Map<String, Integer> appointmentsByConsultantData = appointmentManager.getAppointmentCountsByConsultant();

					// Sample consultant data (replace this with actual data)
				%>

				<%
				for (Map.Entry<String, Integer> entry : appointmentsByConsultantData.entrySet()) {
				%>
				<div class="row common-border m-0 p-0">
					<div class="col-sm col-3 common-border pb-2 m-0 p-0 progress-text">
						<span><%=entry.getKey()%></span>
					</div>
					<div class="col-sm col-9 common-border pb-2 m-0 p-0">
						<div class="progress m-0 p-0">
							<%
							// Calculate the percentage value
							int count = entry.getValue();
							int totalCount = appointmentService.getTotalAppointmentsCount();
							/*   int totalCount = getTotalAppointmentsCount(); */ // Replace with the total count if available
							int percentage = totalCount > 0 ? (count * 100) / totalCount : 0;
							%>
							<div class="progress-bar m-0 p-0"
								style="width: <%=percentage%>%;background-color: #9884e4;">
								<%=count%>
							</div>
						</div>


					</div>
				</div>
				<%
				}
				%>
				<%
				} catch (SQLException | ClassNotFoundException e) {
				// Handle exceptions
				e.printStackTrace();
				}
				%>



				<div class="pebble-footer">
					<div class="row page-footer">
						<div class="col-4 body-text"></div>
						<div class="col-5"></div>
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
		</div>
	</div>
	<!-- footer template -->

</body>
</html>



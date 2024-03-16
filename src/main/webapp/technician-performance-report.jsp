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
<%@ page import="java.util.LinkedHashMap"%>
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
<link rel="stylesheet" type="text/css" href="css/reports.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="icon" type="image/x-icon"
	href="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<title>Technician Performance Report</title>
<style>
</style>
<style>
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
if (user == null || !user.getAccessRight().equals(AccessRight.ROLE_ADMIN)) {
	session.setAttribute("errorMessage", "You do not have the required access to view this page.");
	response.sendRedirect("accessRightError.jsp");
	return;
}
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
				filename : 'Technician Performance Report.pdf',
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
			<div class="page-title d-flex align-items-center align-self-center">Technician
				Performance Report</div>
		</div>
		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Number of Appointments
						per Technician</div>
				</div>
				<div class=" common-border">
					<div class="card-comment common-border">Color codes for the
						appointment status is as follows</div>
				</div>
				<div class="progress" style="height: 20px; margin-bottom: 30px;">
					<div class="progress-bar" role="progressbar"
						style="width: 10%; background-color: #1E90FF;">Requested</div>
					<div class="progress-bar" role="progressbar"
						style="width: 20%; background-color: #4FFFB0;">Confirmed
						Admin</div>
					<div class="progress-bar" role="progressbar"
						style="width: 15%; background-color: #00CED1;">Confirmed
						Tech</div>
					<div class="progress-bar" role="progressbar"
						style="width: 15%; background-color: #6495ED;">Rejected Tech
					</div>
					<div class="progress-bar" role="progressbar"
						style="width: 10%; background-color: #00FFFF;">Completed</div>
					<div class="progress-bar" role="progressbar"
						style="width: 15%; background-color: #073980;">Cancelled
						Patient</div>
					<div class="progress-bar" role="progressbar"
						style="width: 15%; background-color: #73C2FB;">Cancelled
						Admin</div>
				</div>
				<div class="row mb-3">
					<div class="col-sm col-4 common-border pt-1 m-0 p-0 progress-text">
						Technician</div>
					<div class="col-sm col-2 common-border pt-1 m-0 p-0 progress-text">
						Total Appointments</div>
					<div class="col-sm col-6 common-border pt-1 m-0 p-0 progress-text">
						Appointment Status</div>
				</div>
				<%
				try {
					AppointmentService appointmentService = AppointmentService.getAppointmentService();
					AppointmentManagerImpl appointmentManager = new AppointmentManagerImpl();
					Map<String, Map<String, Integer>> appointmentsByTechnician = appointmentManager.getAppointmentCountsByConsultant();
					int maxAppointmentCount = 0;
					for (Map.Entry<String, Map<String, Integer>> entry : appointmentsByTechnician.entrySet()) {
						Map<String, Integer> appointmentCounts = entry.getValue();
						int totalCount = appointmentCounts.values().stream().mapToInt(Integer::intValue).sum();
						if (totalCount > maxAppointmentCount) {
					maxAppointmentCount = totalCount;
						}
					}
					Map<String, String> statusColors = new LinkedHashMap<>();
					statusColors.put("REQUESTED", "#1E90FF");
					statusColors.put("ADMIN_CONFIRMED", "#4FFFB0");
					statusColors.put("CON_CONFIRMED", "#00CED1");
					statusColors.put("CON_REJECTED", "#6495ED");
					statusColors.put("COMPLETED", "#00FFFF");
					statusColors.put("SEEKER_CANCELLED", "#073980");
					statusColors.put("ADMIN_CANCELLED", "#73C2FB");

					for (Map.Entry<String, Map<String, Integer>> entry : appointmentsByTechnician.entrySet()) {
						String technicianName = entry.getKey();
						Map<String, Integer> appointmentCounts = entry.getValue();
				%>
				<div class="row">
					<div class="col-sm col-3 common-border pt-1 m-0 p-0 progress-text">
						<%=technicianName%>
					</div>
					<div class="col-sm col-5 common-border  m-0 p-0 progress-text"
						style="text-align: center;">
						<div class="progress"
							style="height: 15px; margin-top: 8px; margin-bottom: 8px; margin-right: 12px;">
							<%
							int totalCount = appointmentCounts.values().stream().mapToInt(Integer::intValue).sum();
							int percentage = maxAppointmentCount > 0 ? (totalCount * 100) / maxAppointmentCount : 0;
							%>
							<div class="progress-bar m-0 p-0"
								style="width: <%=percentage%>%;background-color: #1CAC78">
								<%=totalCount%>
							</div>
						</div>
					</div>
					<div class="col-sm col-4 common-border  m-0 p-0">
						<div class="progress"
							style="height: 15px; margin-top: 8px; margin-bottom: 8px;">
							<%
							for (Map.Entry<String, String> statusEntry : statusColors.entrySet()) {
							%>
							<%
							String status = statusEntry.getKey();
							%>
							<%
							String color = statusEntry.getValue();
							%>
							<%
							int count = appointmentCounts.getOrDefault(status, 0);
							%>
							<%
							int width = totalCount > 0 ? (count * 100) / totalCount : 0;
							%>
							<div class="progress-bar" role="progressbar"
								style="font-size: 8px;padding-bottom: 5px; background-color: <%=color%>; color: white; width: <%=width%>%;"
								aria-valuemin="0" aria-valuemax="100">
								<%=count%>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
				<%
				}
				} catch (SQLException | ClassNotFoundException e) {
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
					var currentDate = new Date();
					var formattedDate = currentDate.getFullYear() + '/'
							+ (currentDate.getMonth() + 1) + '/'
							+ currentDate.getDate();
					document.getElementById('currentDay').innerHTML = formattedDate;
				</script>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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


<%
UserManagerImpl userManager = new UserManagerImpl();
%>

<%
Calendar calendar = Calendar.getInstance();
calendar.setTime(new Date());
int currentYear = calendar.get(Calendar.YEAR);
%>

<%
Map<String, List<Integer>> monthlyCountsMap = userManager.getMonthlyUserRegistrationCounts();
List<Integer> userCounts = monthlyCountsMap.get("userCounts");
List<Integer> consultantCounts = monthlyCountsMap.get("consultantCounts");
int totalClientsCounts = userCounts.stream().mapToInt(Integer::intValue).sum();
int totalConsultantCounts = consultantCounts.stream().mapToInt(Integer::intValue).sum();
%>

<%
AppointmentManagerImpl appointmentManager = new AppointmentManagerImpl();
List<Integer> monthlyCounts = appointmentManager.getMonthlyAppointmentCounts();
%>
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
<!-- exportas pdf -->

<!-- Add this in the head section of your HTML -->
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<title>Consultant availability Report</title>

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
				availability Report</div>
		</div>


		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Distribution of
						consultants by specialized jobs</div>
				</div>



				<div class="row common-border m-0 p-0">
					<div class="col-sm col-12 common-border pb-2 m-0 p-0 "
						style="height: 250px">
						<div class=" common-border m-0 p-0">
							<div class="card-comment common-border m-0 p-0">*
								Specialized consultant availability for different job types are
								depicted</div>
						</div>
						<canvas id="consultantJobTypeChart" width="200" height="200"></canvas>

					</div>
				</div>

			</div>
		</div>



	

		<%
		try {
			Map<String, Integer> consultantJobTypeDistribution = userManager.getConsultantJobTypeDistribution();

			// Convert the data into JavaScript arrays
			String labelsArray = "['" + String.join("', '", consultantJobTypeDistribution.keySet()) + "']";
			String dataValuesArray = "[" + String.join(", ",
			consultantJobTypeDistribution.values().stream().map(String::valueOf).toArray(String[]::new)) + "]";
		%>

		<script>
			// JavaScript function to generate colors dynamically
			function generateRandomColors(count) {
				var colors = [];
				for (var i = 0; i < count; i++) {
					var red = Math.floor(Math.random() * 256);
					var green = Math.floor(Math.random() * 256);
					var blue = Math.floor(Math.random() * 256);
					var alpha = 0.8; // Constant alpha value

					colors.push(`rgba(${red}, ${green}, ${blue}, ${alpha})`);
				}
				return colors;
			}

			// Parse JSON data in JavaScript
			var consultantJobTypeData = {
				labels :
		<%=labelsArray%>
			,
				datasets : [ {
					data :
		<%=dataValuesArray%>
			,
					backgroundColor : generateRandomColors(
		<%=consultantJobTypeDistribution.size()%>
			),
				} ]
			};

			var ctx8 = document.getElementById('consultantJobTypeChart')
					.getContext('2d');
			var consultantJobTypeChart = new Chart(ctx8, {
				type : 'pie',
				data : consultantJobTypeData,
				options : {
					responsive : true,
					maintainAspectRatio : false,
					title : {
						display : true,
						text : 'Consultant Specialized Job Type Distribution'
					}
				}
			});
		</script>

		<%
		} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace(); // Handle the exception appropriately in your application
		}
		%>



	<%-- 	<%
		try {
			Map<String, Integer> consultantCountByCountry = userManager.getConsultantCountByCountry();

			// Convert the data into JavaScript arrays
			String labelsArray = "['" + String.join("', '", consultantCountByCountry.keySet()) + "']";
			String dataValuesArray = "["
			+ String.join(", ", consultantCountByCountry.values().stream().map(String::valueOf).toArray(String[]::new))
			+ "]";
		%> --%>

	<%-- 	<script>
			// Parse JSON data in JavaScript
			var consultantCountByCountryData = {
				labels :
		<%=labelsArray%>
			,
				datasets : [ {
					data :
		<%=dataValuesArray%>
			,
					backgroundColor : generateRandomColors(
		<%=consultantCountByCountry.size()%>
			),

				} ]
			};

			var ctx7 = document.getElementById('countryJobDistributionChart')
					.getContext('2d');
			var countryJobDistributionChart = new Chart(ctx7, {
				type : 'pie',
				data : consultantCountByCountryData,
				options : {
					responsive : true,
					maintainAspectRatio : false,
					title : {
						display : true,
						text : 'Consultant Count by Countries'
					}
				}
			});
		</script> --%>

	<%-- 	<%
		} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace(); // Handle the exception appropriately in your application
		}
		%>
 --%>

		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Available days and time
					</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border">*Consultant
						availability in the specified days and time slots are depicted</div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 "
						style="height: 450px">
						<canvas id="availabilityRadarChart" width="40" height="40"></canvas>


					</div>
				</div>
			</div>
		</div>
	<%-- 	<%
		try {
			Map<String, Map<String, Integer>> consultantAvailabilityData = userManager.getConsultantAvailabilityData();

			// Convert the data into JavaScript arrays
			String[] daysArray = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
			String[] timeSlotsArray = {"09.00am", "10.00am", "11.00am", "12.00pm", "01.00pm", "02.00pm", "03.00pm", "04.00pm",
			"05.00pm"};

			String daysLabels = "['" + String.join("', '", daysArray) + "']";

			String datasets = "[";
			for (String timeSlot : timeSlotsArray) {
				String dataValuesList = Arrays.stream(daysArray)
				.map(day -> consultantAvailabilityData.containsKey(day)
						? consultantAvailabilityData.get(day).getOrDefault(timeSlot, 0).toString()
						: "0")
				.collect(Collectors.joining(", "));
				datasets += "{ label: '" + timeSlot + "', data: [" + dataValuesList + "], backgroundColor: "
				+ "['rgba(75, 192, 192, 0.5)', 'rgba(255, 99, 132, 0.5)', 'rgba(55, 99, 172, 0.5)', 'rgba(205, 99, 192, 0.5)', 'rgba(125, 192, 132, 0.5)', 'rgba(255, 192, 0, 0.5)', 'rgba(255, 140, 0, 0.5)', 'rgba(128, 0, 128, 0.5)', 'rgba(0, 128, 128, 0.5)'], borderWidth: 2 },";
			}
			datasets = datasets.substring(0, datasets.length() - 1) + "]";
		%> --%>

		<%-- <script>
			var consultantAvailabilityData = {
				labels :
		<%=daysLabels%>
			,
				datasets :
		<%=datasets%>
			};

			var ctx9 = document.getElementById('availabilityRadarChart')
					.getContext('2d');
			var consultantAvailabilityChart = new Chart(ctx9, {
				type : 'radar',
				data : consultantAvailabilityData,
				options : {
					responsive : true,
					maintainAspectRatio : false,
					scales : {
						r : {
							angleLines : {
								display : true
							},
							suggestedMin : 0,
							//   suggestedMax: 10, // Adjust based on your data range
							title : {
								display : true,
								text : 'Number of Consultants'
							}
						}
					},
					plugins : {
						legend : {
							display : true,
							position : 'top'
						}
					}
				}
			});
		</script>

		<%
		} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace(); // Handle the exception appropriately in your application
		}
		%>

 --%>

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

	<!-- footer template -->

</body>
</html>
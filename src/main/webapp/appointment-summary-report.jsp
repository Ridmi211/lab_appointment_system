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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
<title>Appointment Summary Report</title>
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
	%>
	<div class="sidebar">
		<jsp:include page="sidebar.jsp" />
	</div>
	<button id="print"
		style="background-color: #1da1f2; border: #1da1f2; margin-top: 20px; position: fixed; left: 85%; z-index: 80;"
		type="button" onclick="generatePDF()" class="btn btn-primary">Export
		as PDF</button>
	<script type="text/javascript">
  function generatePDF() 
  {        var element = document.getElementById('divToExport');
        element.style.width = '790px';
        var opt = {
            margin:       0,
            filename:     'Appointment and test summary.pdf',
            image:        { type: 'jpeg', quality: 1},
            html2canvas:  { scale: 2 },
            jsPDF:        { unit: 'in', format: 'A4', orientation: 'portrait',precision: '12' }
          };
                html2pdf().set(opt).from(element).save();
      }
</script>

	<div id="divToExport" class="a4-container">
		<div class="">
			<div class="page-title d-flex align-items-center align-self-center">Appointment
				Summary Report</div>
		</div>
		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Number of appointments
						over time</div>
				</div>
				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>
				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 ">
						<canvas id="myLineChart"></canvas>
					</div>
				</div>
			</div>
		</div>
		<%
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		int currentYear = calendar.get(Calendar.YEAR);
		%>
		<%
		UserManagerImpl userManager = new UserManagerImpl();
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
		<script>
    const data1 = {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        datasets: [{
            label: 'Monthly Appointments',
            data: [<%=monthlyCounts.get(0)%>, <%=monthlyCounts.get(1)%>, <%=monthlyCounts.get(2)%>, <%=monthlyCounts.get(3)%>, <%=monthlyCounts.get(4)%>, <%=monthlyCounts.get(5)%>, <%=monthlyCounts.get(6)%>, <%=monthlyCounts.get(7)%>, <%=monthlyCounts.get(8)%>, <%=monthlyCounts.get(9)%>, <%=monthlyCounts.get(10)%>, <%=monthlyCounts.get(11)%>],
            borderColor: 'rgb(91,74,107)',
            borderWidth: 2,
            fill: false,
        }]
    };

    const ctx1 = document.getElementById('myLineChart').getContext('2d');
    const myLineChart = new Chart(ctx1, {
        type: 'line',
        data: data1,
        options: {
            scales: {
                x: {
                    type: 'category',
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                },
                y: {
                    beginAtZero: true,
                }
            }
        }
    });
</script>
		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Distribution of
						Appointments by Status</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-9 common-border pb-2  "
						style="height: 250px">
						<canvas id="appointmentsChart" width="400" height="150"></canvas>
					</div>
					<div class="col-sm col-3 common-border pb-2 ">

						<div id="accessRightsCounts" class="mt-3 counts-div"></div>

					</div>
				</div>
			</div>
		</div>



		<%
		// Instantiate the AppointmentManagerImpl

		// Call the getAppointmentStatusCounts method to get the data
		Map<String, Integer> appointmentStatusCounts = appointmentManager.getAppointmentStatusCounts();
		%>

		<script>
    // Sample data for appointments by status
    const appointmentData = {
        labels: [
            <%-- Loop through the status counts and print the display names for each status --%>
            <%Set<Entry<String, Integer>> entrySet = appointmentStatusCounts.entrySet();
Iterator<Entry<String, Integer>> entryIterator = entrySet.iterator();

while (entryIterator.hasNext()) {
	Entry<String, Integer> entry = entryIterator.next();
	out.print("'" + entry.getKey() + "'");

	if (entryIterator.hasNext()) {
		out.print(", ");
	}
}%>
        ],
        datasets: [{
            data: [
                <%-- Loop through the status counts and print the counts for each status --%>
                <%Set<Entry<String, Integer>> entrySet2 = appointmentStatusCounts.entrySet();
Iterator<Entry<String, Integer>> entryIterator2 = entrySet2.iterator();

while (entryIterator2.hasNext()) {
	Entry<String, Integer> entry = entryIterator2.next();
	out.print(entry.getValue());

	if (entryIterator2.hasNext()) {
		out.print(", ");
	}
}%>
            ],
            backgroundColor: [
                'rgba(255, 99, 132, 0.7)',  // Requested - Red
                'rgba(75, 192, 192, 0.7)', // Admin-Confirmed - Green
                'rgba(255, 205, 86, 0.7)', // Consultant-Confirmed - Yellow
                'rgba(54, 162, 235, 0.7)', // Rejected - Blue
                'rgba(153, 102, 255, 0.7)', // Completed - Purple
                'rgba(255, 159, 64, 0.7)',  // Seeker-Cancelled - Orange
                'rgba(128, 128, 128, 0.7)'  // Admin-Cancelled - Gray
            ],
            borderWidth: 1
        }]
    };

    // Get the canvas element and render the pie chart
    const ctx = document.getElementById('appointmentsChart').getContext('2d');
    const myPieChart = new Chart(ctx, {
        type: 'pie',
        data: appointmentData,
        options: {
            title: {
                display: true,
                text: 'Distribution of Appointments by Status'
            }
        }
    });
    
    
</script>



		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Distribution of
						Appointments by Test type</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 "
						style="height: 250px">
						<canvas id="countryAppointmentsPieChart" width="40" height="40"></canvas>


					</div>
				</div>
			</div>
		</div>
		<%
		Map<String, Integer> countryAppointmentData = appointmentManager.getAppointmentCountsByTestType();
		%>

		<script>
// Replace the static data with the dynamic data from your Java backend
const dynamicCountryAppointmentData = {
    labels: <%=new ArrayList<>(countryAppointmentData.keySet()).stream().map(country -> "'" + country + "'")
		.collect(Collectors.joining(", ", "[", "]"))%>,
    datasets: [{
        data: <%=new ArrayList<>(countryAppointmentData.values()).toString()%>,
        backgroundColor: generateRandomColors(<%=countryAppointmentData.size()%>), // Use a function to generate colors
        borderWidth: 1
    }]
};

function generateRandomColors(count) {
    const colors = [];
    for (let i = 0; i < count; i++) {
        const color = '#' + Math.floor(Math.random()*16777215).toString(16); // Generate a random hex color
        colors.push(color);
    }
    return colors;
}

// Get the canvas element and render the pie chart
const ctxCountryPie = document.getElementById('countryAppointmentsPieChart').getContext('2d');
const myPieChartCountry = new Chart(ctxCountryPie, {
    type: 'pie',
    data: dynamicCountryAppointmentData,
    options: {
        title: {
            display: true,
            text: 'Distribution of Appointments by Country'
        }
    }
});
</script>

	

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
    var formattedDate = currentDate.getFullYear() + '/' + (currentDate.getMonth() + 1) + '/' + currentDate.getDate();

    // Display the formatted date in the specified element
    document.getElementById('currentDay').innerHTML = formattedDate;
</script>
		<!-- Card structure-->
	</div>

	<!-- footer template -->

</body>
</html>
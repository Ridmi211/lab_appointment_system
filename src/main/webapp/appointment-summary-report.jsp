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
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0-beta3/css/all.min.css"> -->
<link rel="stylesheet" type="text/css" href="css/reports.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- exportas pdf -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
<!-- exportas pdf -->
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
            margin:       0,
            filename:     'Appointment and test summary.pdf',
            image:        { type: 'jpeg', quality: 1},
            html2canvas:  { scale: 2 },
            jsPDF:        { unit: 'in', format: 'A4', orientation: 'portrait',precision: '12' }
          };
        
        // choose the element and pass it to html2pdf() function and call the save() on it to save as pdf.
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
		// Instantiate the UserManagerImpl or get it from your application context
		/*    UserManagerImpl userManager = new UserManagerImpl(); */
		Map<String, List<Integer>> monthlyCountsMap = userManager.getMonthlyUserRegistrationCounts();
		List<Integer> userCounts = monthlyCountsMap.get("userCounts");
		List<Integer> consultantCounts = monthlyCountsMap.get("consultantCounts");

		int totalClientsCounts = userCounts.stream().mapToInt(Integer::intValue).sum();
		int totalConsultantCounts = consultantCounts.stream().mapToInt(Integer::intValue).sum();

		// Get the monthly user registration counts
		%>

		<%
		// Instantiate the AppointmentManagerImpl or get it from your application context
		AppointmentManagerImpl appointmentManager = new AppointmentManagerImpl();

		// Get the monthly appointment counts for the current year
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
						Appointments by Country</div>
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
	<%-- 	<%
		Map<String, Integer> countryAppointmentData = appointmentManager.getAppointmentCountsByCountry();
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
</script> --%>



		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Distribution of
						Appointments by Job</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 "
						style="height: 250px">
						<canvas id="jobAppointmentsPieChart" width="400" height="400"></canvas>

					</div>
				</div>
			</div>
		</div>

<%-- 
		<%
		Map<String, Integer> jobAppointmentData = appointmentManager.getAppointmentCountsByJob();
		%>

		<script>
// Replace the static data with the dynamic data from your Java backend
const dynamicJobAppointmentData = {
    labels: <%=new ArrayList<>(jobAppointmentData.keySet()).stream().map(job -> "'" + job + "'")
		.collect(Collectors.joining(", ", "[", "]"))%>,
    datasets: [{
        data: <%=new ArrayList<>(jobAppointmentData.values()).toString()%>,
        backgroundColor: generateRandomColors(<%=jobAppointmentData.size()%>), // Use a function to generate colors
        borderWidth: 1
    }]
};

// Get the canvas element and render the pie chart
const ctxJobPie = document.getElementById('jobAppointmentsPieChart').getContext('2d');
const myPieChartJob = new Chart(ctxJobPie, {
    type: 'pie',
    data: dynamicJobAppointmentData,
    options: {
        title: {
            display: true,
            text: 'Distribution of Appointments by Job'
        }
    }
});
</script> --%>



		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Distribution of
						Appointments by Day of the Week</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 "
						style="height: 350px">
						<canvas id="appointmentsByDayChart" width="400" height="400"></canvas>

					</div>
				</div>
			</div>
		</div>
		<%-- <%
		Map<String, Integer> appointmentsByDayData = appointmentManager.getAppointmentCountsByDay();
		%>

		<script>
// Replace the static data with the dynamic data from your Java backend
const dynamicAppointmentsByDayData = {
    labels: <%=new ArrayList<>(appointmentsByDayData.keySet()).stream().map(day -> "'" + day + "'")
		.collect(Collectors.joining(", ", "[", "]"))%>,
    datasets: [{
        label: 'Appointments',
        data: <%=new ArrayList<>(appointmentsByDayData.values()).toString()%>,
        backgroundColor: 'rgba(75, 192, 192, 0.7)', // Green color for all bars
        borderWidth: 1
    }]
};

// Get the canvas element and render the bar chart
const ctxAppointmentsByDay = document.getElementById('appointmentsByDayChart').getContext('2d');
const myBarChartAppointmentsByDay = new Chart(ctxAppointmentsByDay, {
    type: 'bar',
    data: dynamicAppointmentsByDayData,
    options: {
        title: {
            display: true,
            text: 'Distribution of Appointments by Day of the Week'
        },
        scales: {
            y: {
                beginAtZero: true,
                title: {
                    display: true,
                    text: 'Number of Appointments'
                }
            },
            x: {
                title: {
                    display: true,
                    text: 'Day of the Week'
                }
            }
        }
    }
});
</script>
 --%>



		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Distribution of
						Appointments by Time Slot</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 "
						style="height: 350px">
						<canvas id="appointmentsByTimeSlotChart" width="600" height="400"></canvas>


					</div>
				</div>
			</div>
		</div>
	<%-- 	<%
		Map<String, Integer> appointmentsByTimeSlotData = appointmentManager.getAppointmentCountsByTimeSlot();
		%>

		<script>
// Replace the static data with the dynamic data from your Java backend
const dynamicAppointmentsByTimeSlotData = {
    labels: <%=new ArrayList<>(appointmentsByTimeSlotData.keySet()).stream().map(startTime -> "'" + startTime + "'")
		.collect(Collectors.joining(", ", "[", "]"))%>,
    datasets: [{
        label: 'Appointments',
        data: <%=new ArrayList<>(appointmentsByTimeSlotData.values()).toString()%>,
        backgroundColor: 'rgba(75, 192, 192, 0.7)', // Green color for all bars
        borderWidth: 1
    }]
};

// Get the canvas element and render the bar chart
const ctxAppointmentsByTimeSlot = document.getElementById('appointmentsByTimeSlotChart').getContext('2d');
const myBarChartAppointmentsByTimeSlot = new Chart(ctxAppointmentsByTimeSlot, {
    type: 'bar',
    data: dynamicAppointmentsByTimeSlotData,
    options: {
        title: {
            display: true,
            text: 'Distribution of Appointments by Time Slot'
        },
        scales: {
            y: {
                beginAtZero: true,
                title: {
                    display: true,
                    text: 'Number of Appointments'
                }
            },
            x: {
                title: {
                    display: true,
                    text: 'Time Slot'
                }
            }
        }
    }
});
</script> --%>

		<!--  
         <div class="">
            <div class="page-title d-flex align-items-center align-self-center">Consultant availability Report</div>
        </div> -->


		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Distribution of
						Appointments by day and time</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 "
						style="height: 450px">
						<canvas id="appointmentCountRadarChart" width="600" height="400"></canvas>

					</div>
				</div>
			</div>
		</div>
<%-- 
		<%
		try {
			Map<String, Map<String, Integer>> appointmentsByDayAndTimeSlotData = appointmentManager
			.getAppointmentCountsByDayAndTimeSlot();

			String[] daysArray = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
			String[] timeSlotsArray = {"09.00am", "10.00am", "11.00am", "12.00pm", "01.00pm", "02.00pm", "03.00pm", "04.00pm",
			"05.00pm"};

			String daysLabels = "['" + String.join("', '", daysArray) + "']";

			String datasets = "[";
			for (String timeSlot : timeSlotsArray) {
				String dataValuesList = Arrays.stream(daysArray)
				.map(day -> appointmentsByDayAndTimeSlotData.containsKey(day)
						? appointmentsByDayAndTimeSlotData.get(day).getOrDefault(timeSlot, 0).toString()
						: "0")
				.collect(Collectors.joining(", "));
				datasets += "{ label: '" + timeSlot + "', data: [" + dataValuesList + "], backgroundColor: "
				+ "['rgba(75, 192, 192, 0.5)', 'rgba(255, 99, 132, 0.5)', 'rgba(55, 99, 172, 0.5)', 'rgba(205, 99, 192, 0.5)', 'rgba(125, 192, 132, 0.5)', 'rgba(255, 192, 0, 0.5)', 'rgba(255, 140, 0, 0.5)', 'rgba(128, 0, 128, 0.5)', 'rgba(0, 128, 128, 0.5)'], borderWidth: 2 },";
			}
			datasets = datasets.substring(0, datasets.length() - 1) + "]";
		%>

		<script>
    var appointmentData4 = {
        labels: <%=daysLabels%>,
        datasets: <%=datasets%>
    };

    var ctxAppointment = document.getElementById('appointmentCountRadarChart').getContext('2d');
    var appointmentChart = new Chart(ctxAppointment, {
        type: 'radar',
        data: appointmentData4,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                r: {
                    angleLines: {
                        display: true
                    },
                    suggestedMin: 0,
                    //   suggestedMax: 10, // Adjust based on your data range
                    title: {
                        display: true,
                        text: 'Number of Appointments'
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        }
    });
</script>
		<%
		} catch (SQLException | ClassNotFoundException e) {
		// Handle exceptions
		e.printStackTrace();
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
    var formattedDate = currentDate.getFullYear() + '/' + (currentDate.getMonth() + 1) + '/' + currentDate.getDate();

    // Display the formatted date in the specified element
    document.getElementById('currentDay').innerHTML = formattedDate;
</script>
		<!-- Card structure-->
	</div>

	<!-- footer template -->

</body>
</html>
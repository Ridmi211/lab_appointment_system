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


<%UserManagerImpl userManager = new UserManagerImpl();%>

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
<link rel="icon" type="image/x-icon"
	href="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg">

<title>User Summary Report</title>

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
            filename:     'User Summary Report.pdf',
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
			<div class="page-title d-flex align-items-center align-self-center">User
				Summary Report</div>
		</div>
		<!-- Card 1  numbers -->


		<!--    accessright -->

		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">User Access Rights</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border">* Chart depicts the
						types of users available within the system</div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-9 common-border pb-2 ">
						<canvas id="accessRightsPieChart" width="400" height="200"></canvas>
					</div>
					<div class="col-sm col-3 common-border pb-2 ">

						<div id="accessRightsCounts" class="mt-3 counts-div"></div>

					</div>
				</div>
			</div>
		</div>

		<!--      /////////// -->
		<%


try {
    Map<String, Integer> accessRightsData = userManager.getAccessRightsData();

    // Convert the data into JavaScript arrays
/*  List<String> labelsList = accessRightsData.keySet().stream().map(String::valueOf).collect(Collectors.toList()); */

    String[] customLabels = {"Client", "Admin", "Consultant"};
    List<String> dataValuesList = accessRightsData.values().stream().map(String::valueOf).collect(Collectors.toList());

    String labelsArray = "['" + String.join("', '", customLabels) + "']";
    String dataValuesArray = "[" + String.join(", ", dataValuesList) + "]";
%>
		<script>
    var accessRightsData = {
        labels: <%= labelsArray %>,
        datasets: [{
            data: <%= dataValuesArray %>,
            backgroundColor: [
                'rgba(255, 99, 132, 0.8)', // Client color
                'rgba(54, 162, 235, 0.8)', // Consultant color
                'rgba(75, 192, 192, 0.8)'  // Admin color
            ],
            borderWidth: 1
        }]
    };

    var ctx3 = document.getElementById('accessRightsPieChart').getContext('2d');
    var accessRightsPieChart = new Chart(ctx3, {
        type: 'pie',
        data: accessRightsData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            title: {
                display: true,
                text: 'User Access Rights'
            },
            
        }
    });
   
    
    var countsElement = document.getElementById('accessRightsCounts');
    var countsText = "<strong>Counts:</strong><ul>";
    for (var i = 0; i < accessRightsData.labels.length; i++) {
        countsText += "<li>" + accessRightsData.labels[i] + ": " + accessRightsData.datasets[0].data[i] + "</li>";
    }
    countsText += "</ul>";
    countsElement.innerHTML = countsText;
</script>

		<%
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace(); // Handle the exception appropriately in your application
}
%>

		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">User and appointment
						growth</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border">*Chart provides a
						comparison between growth of users, consultants and number of
						scheduled appointments, within the current year.</div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 ">

						<canvas id="myLineChart"></canvas>


					</div>
				</div>
			</div>
		</div>

		<script>
    const data1 = {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        datasets: [{
            label: 'Monthly Appointments',
            data: [<%=monthlyCounts.get(0)%>, <%=monthlyCounts.get(1)%>, <%=monthlyCounts.get(2)%>, <%=monthlyCounts.get(3)%>, <%=monthlyCounts.get(4)%>, <%=monthlyCounts.get(5)%>, <%=monthlyCounts.get(6)%>, <%=monthlyCounts.get(7)%>, <%=monthlyCounts.get(8)%>, <%=monthlyCounts.get(9)%>, <%=monthlyCounts.get(10)%>, <%=monthlyCounts.get(11)%>],
            borderColor: 'rgb(91,74,107)',
            borderWidth: 2,
            fill: false,
        },
        {
            label: 'Client Registrations',
            data: [<%=userCounts.get(0)%>, <%=userCounts.get(1)%>, <%=userCounts.get(2)%>, <%=userCounts.get(3)%>, <%=userCounts.get(4)%>, <%=userCounts.get(5)%>, <%=userCounts.get(6)%>, <%=userCounts.get(7)%>, <%=userCounts.get(8)%>, <%=userCounts.get(9)%>, <%=userCounts.get(10)%>, <%=userCounts.get(11)%>],
            borderColor: 'rgb(255, 99, 132)',
            borderWidth: 2,
            fill: false,
        },
        {
            label: 'Consultant Registrations',
            data: [<%=consultantCounts.get(0)%>, <%=consultantCounts.get(1)%>, <%=consultantCounts.get(2)%>, <%=consultantCounts.get(3)%>, <%=consultantCounts.get(4)%>, <%=consultantCounts.get(5)%>, <%=consultantCounts.get(6)%>, <%=consultantCounts.get(7)%>, <%=consultantCounts.get(8)%>, <%=consultantCounts.get(9)%>, <%=consultantCounts.get(10)%>, <%=consultantCounts.get(11)%>],
            borderColor: 'rgb(75, 192, 192)',
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

		<!--    accessright -->

		<!-- <div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Job Type Distribution</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border">* User counts from
						different fields are depicted</div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 ">
						<canvas id="jobTypeDistributionChart" width="400" height="300"></canvas>

					</div>
				</div>
			</div>
		</div> -->

		<!--      /////////// -->
		<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->



	<%-- 	<%
 
    Map<String, Map<String, Object>> jobTypeDistributionData = userManager.getJobTypeDistributionData();

    // Convert Java Map to JSON string
    String jsonData = new ObjectMapper().writeValueAsString(jobTypeDistributionData);

    // You can use jsonData in your JavaScript code
%> --%>
<%-- 		<script>
    console.log('<%= jsonData %>');
</script>
		<script>
        // Parse JSON data in JavaScript
        var jobTypeDistributionData = JSON.parse('<%= jsonData %>');

        // Extract labels, data, and colors from the JSON data
        var labels = Object.keys(jobTypeDistributionData);
        var data = labels.map(function (label) {
            return jobTypeDistributionData[label].count;
        });

        // Extract dynamic colors from the JSON data
        var colors = labels.map(function (label) {
            return jobTypeDistributionData[label].color;
        });

        // Create a bar chart using Chart.js
        var ctx = document.getElementById('jobTypeDistributionChart').getContext('2d');
        var jobTypeDistributionChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: "#d6adff"
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                title: {
                    display: true,
                    text: 'Job Type Distribution'
                },  plugins: {
                    legend: {
                        display: false, 
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true
                    },
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script> --%>

		<!--    //////////////////////// -->

		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">Users age distribution
					</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>


				<div class="row common-border m-0">
					<div class="col-sm col-9 common-border pb-2 m-0 p-0">
						<canvas id="ageDistributionPieChart" width="400" height="200"></canvas>
					</div>
					<div class="col-sm col-3 common-border pb-2 m-0 p-0">

						<div id="ageDistributionCounts" class="mt-3 counts-div"></div>

					</div>
				</div>
			</div>
		</div>

		<%
   
    Map<String, Integer> ageDistributionData = userManager.getAgeDistributionData();

    // Convert Java Map to JSON string
    String jsonData2 = new ObjectMapper().writeValueAsString(ageDistributionData);
    
    

    // You can use jsonData in your JavaScript code
%>
		<script>
        // Parse JSON data in JavaScript
        var ageDistributionData = JSON.parse('<%= jsonData2 %>');

        // Extract labels, data, and colors from the JSON data
        var labels = Object.keys(ageDistributionData);
        var data = labels.map(function (label) {
            return ageDistributionData[label];
        });

      

        // Create a pie chart using Chart.js
        var ctx = document.getElementById('ageDistributionPieChart').getContext('2d');
        var ageDistributionPieChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: [
                    	 'rgba(255, 99, 132, 0.8)', // Client color
                         'rgba(54, 162, 235, 0.8)', // Consultant color
                         'rgba(75, 192, 192, 0.8)', // Additional color 1
                         'rgba(255, 205, 86, 0.8)', // Additional color 2
                         'rgba(255, 159, 64, 0.8)', // Additional color 3
                         'rgba(153, 102, 255, 0.8)', // Additional color 4
                         'rgba(192, 192, 192, 0.8)' 
                    ],
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                title: {
                    display: true,
                    text: 'User Age Distribution'
                }
            }
        });
        
        // Display labels and counts as a list beneath the chart
        var ageDistributionCountsElement = document.getElementById('ageDistributionCounts');
        var ageDistributionCountsText = "<strong>Counts:</strong><ul>";
        for (var i = 0; i < labels.length; i++) {
            ageDistributionCountsText += "<li>" + labels[i] + ": " + data[i] + "</li>";
        }
        ageDistributionCountsText += "</ul>";
        ageDistributionCountsElement.innerHTML = ageDistributionCountsText;

    </script>
		<!--         /////////// -->




		<!--     //////////////////////// -->

		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">User Demographics</div>
				</div>

				<div class=" common-border">
					<div class="card-comment common-border">* Distribution of
						users by gender and country</div>
				</div>

				<div class="row common-border m-0">
					<div class="col-sm col-12 common-border pb-2 "
						style="height: 250px">
						<!--               <canvas id="geographicalDistributionChart" width="40" height="40"></canvas>

 -->
						<canvas id="userDemographicsChart"></canvas>

					</div>
				</div>
			</div>
		</div>
		
		
		<%
    Map<String, Integer> userGenderDistribution = userManager.getUserGenderDistribution();

    // Convert Java Map to JSON string
    String jsonData = new ObjectMapper().writeValueAsString(userGenderDistribution);

    // You can use jsonData in your JavaScript code
%> 

<script>
    // Parse JSON data in JavaScript
    var userGenderDistribution = JSON.parse('<%= jsonData %>');

    // Extract genders and counts from the JSON data
    var genders = Object.keys(userGenderDistribution);
    var counts = Object.values(userGenderDistribution);

    // Create dataset for gender distribution
    var genderDataset = {
        label: 'Gender Distribution',
        data: counts,
        backgroundColor: ['rgba(54, 162, 235, 0.8)','rgba(255, 99, 132, 0.8)', 'rgba(75, 192, 192, 0.8)' ], // Add more colors if needed
        borderWidth: 1
    };

    // Create a bar chart using Chart.js
    var ctx = document.getElementById('userDemographicsChart').getContext('2d');
    var userDemographicsChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: genders,
            datasets: [genderDataset]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
</script>
		
		
<%-- 		<%
    Map<String, Map<String, Integer>> userDemographicsData = userManager.getUserDemographicsData();

    // Convert Java Map to JSON string
    String jsonData3 = new ObjectMapper().writeValueAsString(userDemographicsData);

    // You can use jsonData in your JavaScript code
%> --%>
<%-- 		<script>
    // Parse JSON data in JavaScript
    var userDemographicsData = JSON.parse('<%= jsonData3 %>');

    // Extract labels, data, and colors from the JSON data
    var countries = Object.keys(userDemographicsData);

    // Create datasets for Male and Female
    var maleDataset = {
        label: 'Male',
        data: countries.map(function (country) {
            return userDemographicsData[country] ? userDemographicsData[country].Male : 0;
        }),
        backgroundColor: 'rgba(75, 192, 192, 0.7)',
        borderWidth: 1
    };

    var femaleDataset = {
        label: 'Female',
        data: countries.map(function (country) {
            return userDemographicsData[country] ? userDemographicsData[country].Female : 0;
        }),
        backgroundColor: 'rgba(255, 99, 132, 0.7)',
        borderWidth: 1
    };

    // Create a bar chart using Chart.js
    var ctx14 = document.getElementById('userDemographicsChart').getContext('2d');
    var userDemographicsChart = new Chart(ctx14, {
        type: 'bar',
        data: {
            labels: countries,
            datasets: [maleDataset, femaleDataset]
        },
        options: {
            scales: {
                x: {
                    stacked: true,
                    beginAtZero: true
                },
                y: {
                    stacked: true,
                    beginAtZero: true
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        boxWidth: 15
                    }
                }
            }
        }
    });
</script> --%>

		<div class=" card-container">
			<div class="col">
				<div class=" common-border">
					<div class="card-title common-border">User registration
						status</div>
				</div>
				<div class=" common-border">
					<div class="card-comment common-border"></div>
				</div>
				<div class="row common-border m-0 p-0">
					<div class="col-sm col-12 common-border pb-0 m-0 p-0">
						<canvas id="registrationStatusDoughnutChart" width="400"
							height="200"></canvas>
					</div>
				</div>
			</div>
		</div>

		<!--      /////////// -->
		<%
try {
    Map<RegistrationStatus, Integer> registrationStatusData = userManager.getRegistrationStatusData();

    // Convert the data into JavaScript arrays
    String labelsArray = "['" + RegistrationStatus.PENDING.getDisplayName() + "', '" + RegistrationStatus.APPROVED.getDisplayName() + "', '" + RegistrationStatus.REJECTED.getDisplayName() + "']";
    String dataValuesArray = "[" + registrationStatusData.get(RegistrationStatus.PENDING) + ", " + registrationStatusData.get(RegistrationStatus.APPROVED) + ", " + registrationStatusData.get(RegistrationStatus.REJECTED) + "]";
%>

		<script>
    // Parse JSON data in JavaScript
    var registrationStatusData = {
        labels: <%= labelsArray %>,
        datasets: [{
            data: <%= dataValuesArray %>,
            backgroundColor: [
                'rgba(255, 206, 86, 0.8)', // Pending color
                'rgba(75, 192, 192, 0.8)', // Approved color
                'rgba(255, 99, 132, 0.8)'  // Rejected color
            ],
            borderWidth: 1
        }]
    };

   
			var ctx6 = document.getElementById(
					'registrationStatusDoughnutChart').getContext('2d');
			var registrationStatusDoughnutChart = new Chart(ctx6, {
				type : 'doughnut',
				data : registrationStatusData,
				options : {
					responsive : true,
					maintainAspectRatio : false,
					plugins : {
						legend : {
							position : 'bottom'
						}
					},
					title : {
						display : true,
						text : 'Consultant Registration Status'
					}
				}
			});
		</script>

		<%
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace(); 
}
%>
		<%--  <div class="">
            <div class="page-title d-flex align-items-center align-self-center">Consultant availability Report</div>
        </div>
        
        
        <div class=" card-container">
            <div class="col">
                <div class=" common-border">
                    <div class="card-title common-border">Distribution of consultants by specialized  jobs      </div>
                </div>
                
               
            
                <div class="row common-border m-0 p-0">
                    <div class="col-sm col-12 common-border pb-2 m-0 p-0 " style="height:250px">
                <div class=" common-border m-0 p-0">
                    <div class="card-comment common-border m-0 p-0">Description
                    </div>
                </div>
              <canvas id="consultantJobTypeChart" width="200" height="200"></canvas>
     
                    </div>
                     </div>
                 
            </div>
        </div>
        
        
          
        <div class=" card-container">
            <div class="col">
                <div class=" common-border">
                    <div class="card-title common-border">Distribution of consultants by specialized countries      </div>
                </div>
               
                     
                     
                     <div class="row common-border m-0 p-0">
                <div class="col-sm col-12 common-border pb-2 m-0 p-0" style="height:250px">
                   <div class=" common-border m-0 p-0">
                    <div class="card-comment common-border m-0 p-0">Description
                    </div>
                </div>
              <canvas id="countryJobDistributionChart" width="200" height="200"></canvas>
     
                    </div>
                </div>
            </div>
        </div>
        
        <%
try {
    Map<String, Integer> consultantJobTypeDistribution = userManager.getConsultantJobTypeDistribution();

    // Convert the data into JavaScript arrays
    String labelsArray = "['" + String.join("', '", consultantJobTypeDistribution.keySet()) + "']";
    String dataValuesArray = "[" + String.join(", ", consultantJobTypeDistribution.values().stream().map(String::valueOf).toArray(String[]::new)) + "]";
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
        labels: <%= labelsArray %>,
        datasets: [{
            data: <%= dataValuesArray %>,
            backgroundColor: generateRandomColors(<%= consultantJobTypeDistribution.size() %>),
        }]
    };

    var ctx8 = document.getElementById('consultantJobTypeChart').getContext('2d');
    var consultantJobTypeChart = new Chart(ctx8, {
        type: 'pie',
        data: consultantJobTypeData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            title: {
                display: true,
                text: 'Consultant Specialized Job Type Distribution'
            }
        }
    });
</script>

<%
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace(); // Handle the exception appropriately in your application
}
%>
 


<%
try {
    Map<String, Integer> consultantCountByCountry = userManager.getConsultantCountByCountry();

    // Convert the data into JavaScript arrays
    String labelsArray = "['" + String.join("', '", consultantCountByCountry.keySet()) + "']";
    String dataValuesArray = "[" + String.join(", ", consultantCountByCountry.values().stream().map(String::valueOf).toArray(String[]::new)) + "]";
%>

<script>
    // Parse JSON data in JavaScript
    var consultantCountByCountryData = {
        labels: <%= labelsArray %>,
        datasets: [{
            data: <%= dataValuesArray %>,
            backgroundColor: generateRandomColors(<%= consultantCountByCountry.size() %>),
            
        }]
    };

    var ctx7 = document.getElementById('countryJobDistributionChart').getContext('2d');
    var countryJobDistributionChart = new Chart(ctx7, {
        type: 'pie',
        data: consultantCountByCountryData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            title: {
                display: true,
                text: 'Consultant Count by Countries'
            }
        }
    });
</script>

<%
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace(); // Handle the exception appropriately in your application
}
%>


        <div class=" card-container">
            <div class="col">
                <div class=" common-border">
                    <div class="card-title common-border">Available days and time      </div>
                </div>
                
                <div class=" common-border">
                    <div class="card-comment common-border">Description
                    </div>
                </div>
            
                <div class="row common-border m-0">
                    <div class="col-sm col-12 common-border pb-2 " style="height:450px">
              <canvas id="availabilityRadarChart" width="40" height="40"></canvas>

                      
                    </div>
                </div>
            </div>
        </div>
            <%
    try {
        Map<String, Map<String, Integer>> consultantAvailabilityData = userManager.getConsultantAvailabilityData();

        // Convert the data into JavaScript arrays
        String[] daysArray = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        String[] timeSlotsArray = {"09.00am","10.00am", "11.00am","12.00pm","01.00pm","02.00pm","03.00pm", "04.00pm","05.00pm"};

        String daysLabels = "['" + String.join("', '", daysArray) + "']";

        String datasets = "[";
        for (String timeSlot : timeSlotsArray) {
            String dataValuesList = Arrays.stream(daysArray)
                    .map(day -> consultantAvailabilityData.containsKey(day)
                            ? consultantAvailabilityData.get(day).getOrDefault(timeSlot, 0).toString()
                            : "0")
                    .collect(Collectors.joining(", "));
            datasets += "{ label: '" + timeSlot + "', data: [" + dataValuesList + "], backgroundColor: " +
                    "['rgba(75, 192, 192, 0.5)', 'rgba(255, 99, 132, 0.5)', 'rgba(55, 99, 172, 0.5)', 'rgba(205, 99, 192, 0.5)', 'rgba(125, 192, 132, 0.5)', 'rgba(255, 192, 0, 0.5)', 'rgba(255, 140, 0, 0.5)', 'rgba(128, 0, 128, 0.5)', 'rgba(0, 128, 128, 0.5)'], borderWidth: 2 },";
        }
        datasets = datasets.substring(0, datasets.length() - 1) + "]";
%>

<script>
    var consultantAvailabilityData = {
        labels: <%= daysLabels %>,
        datasets: <%= datasets %>
    };

    var ctx9 = document.getElementById('availabilityRadarChart').getContext('2d');
    var consultantAvailabilityChart = new Chart(ctx9, {
        type: 'radar',
        data: consultantAvailabilityData,
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
                        text: 'Number of Consultants'
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
    var formattedDate = currentDate.getFullYear() + '/' + (currentDate.getMonth() + 1) + '/' + currentDate.getDate();

    // Display the formatted date in the specified element
    document.getElementById('currentDay').innerHTML = formattedDate;
</script>
		<!-- Card structure-->
	</div>

	<!-- footer template -->

</body>
</html>
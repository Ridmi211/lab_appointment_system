<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.User"%>
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

<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.util.stream.IntStream"%>
<%@ page import="java.time.Year"%>
<%@ page import="com.labSchedulerSystem.dao.UserManager"%>

<%
UserManagerImpl userManager = new UserManagerImpl();
%>

<%
Calendar calendar = Calendar.getInstance();
calendar.setTime(new Date());
int currentYear = calendar.get(Calendar.YEAR);
%>


<%
// Instantiate the UserManagerImpl or get it from your application context
/*    UserManagerImpl userManager = new UserManagerImpl(); */
Map<String, List<Integer>> monthlyCountsMap = userManager.getMonthlyUserRegistrationCounts();
List<Integer> userCounts = monthlyCountsMap.get("userCounts");
List<Integer> consultantCounts = monthlyCountsMap.get("consultantCounts");

/* int totalClientsCounts = userCounts.stream().mapToInt(Integer::intValue).sum();
int totalConsultantCounts = consultantCounts.stream().mapToInt(Integer::intValue).sum(); */

int totalClientsCounts = userManager.getCountOfClientUsers();
int totalConsultantCounts = userManager.getCountOfConsultantUsers();

// Get the monthly user registration counts
%>


<%
// Instantiate the AppointmentManagerImpl or get it from your application context
AppointmentManagerImpl appointmentManager = new AppointmentManagerImpl();

// Get the monthly appointment counts for the current year
List<Integer> monthlyCounts = appointmentManager.getMonthlyAppointmentCounts();
%>
<%
AppointmentService appointmentService = AppointmentService.getAppointmentService();
UserService userService = UserService.getUserService();

int totalAppointmentsCount = appointmentService.getTotalAppointmentsCount();
int completedAppointmentsCount = appointmentService.getCompletedAppointmentsCount();
int requestedAppointmentsCount = appointmentService.getRequestedAppointmentsCount();
int consultantConfirmedAppointmentsCount = appointmentService.getConsultantConfirmedAppointmentsCount();
int consultantRejectedAppointmentsCount = appointmentService.getConsultantRejectedAppointmentsCount();
int seekerCancelledAppointmentsCount = appointmentService.getSeekerCancelledAppointmentsCount();
int adminRequestedAllAppointmentsCount = appointmentService.getAdminRequestedAllAppointmentsCount();
int allUserCount = userService.getAllUsersCount();
int pendingUserCount = userService.getPendingUsersCount();

MessageService messageService = MessageService.getMessageService();
int newMessagesCount = messageService.getNewMessagesCount();
%>


<!DOCTYPE html>
<html lang="en">

<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/1a4bb98cfa.js"
	crossorigin="anonymous"></script>

<meta charset="ISO-8859-1">
<title>MediCheck</title>
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
<link rel="stylesheet" type="text/css" href="css/home-style.css">

<link rel="stylesheet" type="text/css" href="css/navbar-style.css">
<!-- Add this in the head section of your HTML -->
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>


<Style>
.main-title {
	color: #529ece;
	font-size: 65px;
}

.first-title {
	font-size: 20px;
}

/*  <!-- sidebar styling end here  --> */
</Style>

</head>
<body>
	<!-- sidebar start here  -->
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


	<!-- sidebar end here  -->


	<!--   nav -->
	<nav class="p-0 m-0 pt-0">
		<img class="nav-logo p-0 m-0 pt-0 mt-0" src="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg" alt="logo">
			<h4>
				Medi<span>Check</span>
			</h4>
		<ul class="" id="sidemenu">
			<li><a href="#header">Home</a></li>
			<li><a href="#about-us">About</a></li>
<!-- 			<li><a href="#experts">Our Experts</a></li> -->
			<li><a href="#growth">Growth</a></li>
			<li class="m-0"><a class="m-0" href="#contact">Contact</a></li>

			<%
			if (user != null) {
			%>

			<li><a href="view-profile.jsp"><i class="fa fa-user-circle"
					aria-hidden="true"></i>&nbsp;&nbsp; <%=user.getName()%></a></li>
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
	<!--   nav -->
	<div class="row p-0 m-0">
		<div
			class="p-0 m-0 d-flex align-items-end d-flex justify-content-center"
			id="header"
			style="background-image: url(https://wallpapers.com/images/hd/medical-background-cjge7e89adg6ub8x.jpg);">

			<div class="container d-flex justify-content-center p-0 m-0">

				<div class="header-text pt-2">
					<div class="mt-2 first-title">EMPOWER YOUR WELLNESS JOURNEY
						WITH</div>
					<div class="main-title">MediCheck</div>
					<a href="getAppointment?appactiontype=allTests" class="btn-purple"
						style="text-size: 12px;">Schedule Your Appointment</a>
				</div>

			</div>
		</div>
	</div>

	<!-- Services  -->


	<div id="home" class="mt-3 mb-0 pt-5">
		<div class="container pt-5" style="text-align: center; height: 90vh;">
			<!-- <h1>Extra-Curricular Activities</h1> -->
			<div class="services justify-content-center">


				<div class="m-2">
					<i class="fa-solid fa-hand-holding-hand purple-icon"></i>
					<!-- <i class="fa-sharp fa-solid fa-people-group"></i> -->
					<h2>Appointments</h2>
					<p style="text-align: justify;">At MediCheck, our modern online
						appointment scheduling system provides access to essential medical
						tests. With a hassle-free registration process, you can
						effortlessly book your test appointments, ensuring a user-friendly
						experience. Once registered, you'll have the convenience of
						monitoring your upcoming appointments, ensuring a seamless and
						organized approach to managing your health with MediCheck..</p>

					<!--   <a href="#" class="btn-purple">See more</a> -->
				</div>


				<div class="m-2">
					<!-- <i class="fa-solid fa-users"></i> -->
					<i class="fa-sharp fa-solid fa-people-group purple-icon"></i>
					<h2>Technicians</h2>
					<p style="text-align: justify;">We have a team of skilled
						technicians dedicated to ensuring the accuracy and efficiency of
						your medical tests at MediCheck. Our technicians possess extensive
						training and experience in conducting a wide range of tests,
						guaranteeing reliable results for your healthcare needs..</p>
					<!--  <a href="#" class="btn-purple">See more</a> -->
				</div>

				<div class="m-2">
					<i class="fa-solid fa-handshake purple-icon"></i>
					<h2>Wide range of testing</h2>
					<p style="text-align: justify;">Discover a comprehensive range
						of medical tests available at MediCheck, designed to cater to your
						diverse healthcare needs. From routine screenings to specialized
						diagnostics, our state-of-the-art facility offers an array of
						tests conducted by experienced professionals. Explore our test
						catalog, which includes blood tests, imaging scans, genetic
						screenings, and more, all aimed at providing you with accurate and
						timely insights into your health</p>
					<!--   <a href="#" class="btn-purple">See more</a> -->
				</div>

			</div>
		</div>
	</div>
	<!-- About us -->


	<div
		class="p-0 m-0 mb-5 d-flex align-items-center services justify-content-center"
		id="about-us"
		style="background-image: url(https://wallpapercave.com/wp/wp4085844.jpg); position: relative;">
		<div style="text-align: center; z-index: 1;">
			<h1>About Us</h1>
			<div class="row">
				<div class="col-2"></div>
				<div class="col-8">
					<div>"At MediCheck Laboratories, we are dedicated to
						providing accurate and reliable testing services to support your
						health journey. With a team of skilled technicians and
						state-of-the-art equipment, we offer a wide range of diagnostic
						tests to help you make informed decisions about your health. Our
						mission is to deliver precise results and personalized guidance
						that aligns with your healthcare needs. Whether you require
						routine screenings, specialized tests, or wellness evaluations, we
						are here to be your trusted partner in promoting your well-being.
						Experience the quality and convenience of laboratory services at
						MediCheck Laboratories, where your health is our priority."</div>
				</div>
				<div class="col-2"></div>
			</div>
		</div>
	</div>
	<!--  -->


	<!-- ////////////// -->
<%-- 
	<div class="row" id="experts">

		<div>
			<h1 class="mb-5 pt-0 sub-title "
				style="color: #5b4a6b; text-align: center;">Our Experts are the
				finest!</h1>
			<div class="container">
				<p>Dive into a vast network of consultants, each wielding
					specialized knowledge across different countries. Gain a
					competitive edge as you tap into this global expertise, shaping
					your international career strategy with precision. Our consultants
					not only provide insights into market trends but also offer
					cultural intelligence, helping you navigate the unique landscapes
					of diverse professional environments. With a commitment to
					personalized guidance, they collaborate with you to tailor
					strategies that align with your goals, ensuring a seamless
					transition and a flourishing global career.
			</div>


			<div class="row">
				<div class="col-2"></div>
				<div class="col-8">
					 <div id="map" style="height: 500px;"></div>
      <script>
  const map = L.map('map').setView([0, 0], 2); // Set the initial view

  // Add a tile layer (you can choose a different one)
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

  // Replace this with your actual data
  const countriesArray = <%= countriesArray %>;
  const countsArray = <%= countsArray %>;

  // Example coordinates for countries (replace with actual coordinates)
/*   const countryCoordinates = {
    'Canada': [56.1304, -106.3468],
    'Australia': [-25.2744, 133.7751],
    'USA': [37.0902, -95.7129],
    'Malaysia': [4.2105, 101.9758],
  }; */
  
  const countryCoordinates = {
		  'Canada': [56.1304, -106.3468],
		  'Australia': [-25.2744, 133.7751],
		  'USA': [37.0902, -95.7129],
		  'Malaysia': [4.2105, 101.9758],
		  'Germany': [51.1657, 10.4515],
		  'Singapore': [1.3521, 103.8198],
		  'Sweden': [60.1282, 18.6435],
		  'Norway': [60.4720, 8.4689],
		  'Switzerland': [46.8182, 8.2275],
		  'United Kingdom': [55.3781, -3.4360],
		  'Netherlands': [52.1326, 5.2913],
		  'Denmark': [56.2639, 9.5018],
		  'Ireland': [53.1424, -7.6921],
		  'Japan': [36.2048, 138.2529],
		  'South Korea': [35.9078, 127.7669],
		  'Hong Kong': [22.3193, 114.1694],
		  'Qatar': [25.2769, 51.5200],
		  'United Arab Emirates': [23.4241, 53.8478],
		  'Luxembourg': [49.8153, 6.1296],
		  'Chile': [-35.6751, -71.5430],
		};


  // Loop through each country and add a marker
  countriesArray.forEach((country, index) => {
    const count = countsArray[index];
    const coordinates = countryCoordinates[country];

    if (coordinates) {
      L.marker(coordinates).addTo(map)
        .bindPopup(`<b>${country}</b><br>Consultants: ${count}`);
    }
  });
</script>



				</div>
				<div class="col-2"></div>
			</div>
		</div>
	</div> --%>
	<!-------------------------------------------------- about  ----------------------------------------- -->

	<!-------------------------------------------------- about  ----------------------------------------- -->
	<div id="growth" style="background-color: rgb(139,209,232, 0.149);">
		<div class="container" style="height: 85vh;">
			<div class="row ">
				<div class="about-col-1 ">

					<h1 class="mt-5 pt-5 sub-title " style="color: #529ece;">
						Witness the vibrant growth of our community in
						<%=currentYear%>!
					</h1>
					<!-- <img src="https://images.inc.com/uploaded_files/image/1920x1080/getty_468868827_970566970450047_60099.jpg" alt="user image"> -->
				</div>
				<div class="about-col-2">
					<p>


					
					<div class="tab-titles"></div>
					<!-- skills -->
					<div class="tab-contents active-tab" id="Skills">

						<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
						<div>
							<canvas id="myLineChart"></canvas>
						</div>



						<script>
							const data1 = {
								labels : [ 'January', 'February', 'March',
										'April', 'May', 'June', 'July',
										'August', 'September', 'October',
										'November', 'December' ],
								datasets : [
										{
											label : 'Appointments',
											data : [
						<%=monthlyCounts.get(0)%>
							,
						<%=monthlyCounts.get(1)%>
							,
						<%=monthlyCounts.get(2)%>
							,
						<%=monthlyCounts.get(3)%>
							,
						<%=monthlyCounts.get(4)%>
							,
						<%=monthlyCounts.get(5)%>
							,
						<%=monthlyCounts.get(6)%>
							,
						<%=monthlyCounts.get(7)%>
							,
						<%=monthlyCounts.get(8)%>
							,
						<%=monthlyCounts.get(9)%>
							,
						<%=monthlyCounts.get(10)%>
							,
						<%=monthlyCounts.get(11)%>
							],
											borderColor : 'rgb(91,74,107)',
											borderWidth : 2,
											fill : false,
										},
										{
											label : 'Clients',
											data : [
						<%=userCounts.get(0)%>
							,
						<%=userCounts.get(1)%>
							,
						<%=userCounts.get(2)%>
							,
						<%=userCounts.get(3)%>
							,
						<%=userCounts.get(4)%>
							,
						<%=userCounts.get(5)%>
							,
						<%=userCounts.get(6)%>
							,
						<%=userCounts.get(7)%>
							,
						<%=userCounts.get(8)%>
							,
						<%=userCounts.get(9)%>
							,
						<%=userCounts.get(10)%>
							,
						<%=userCounts.get(11)%>
							],
											borderColor : 'rgb(255, 99, 132)',
											borderWidth : 2,
											fill : false,
										},
										{
											label : 'Technicians',
											data : [
						<%=consultantCounts.get(0)%>
							,
						<%=consultantCounts.get(1)%>
							,
						<%=consultantCounts.get(2)%>
							,
						<%=consultantCounts.get(3)%>
							,
						<%=consultantCounts.get(4)%>
							,
						<%=consultantCounts.get(5)%>
							,
						<%=consultantCounts.get(6)%>
							,
						<%=consultantCounts.get(7)%>
							,
						<%=consultantCounts.get(8)%>
							,
						<%=consultantCounts.get(9)%>
							,
						<%=consultantCounts.get(10)%>
							,
						<%=consultantCounts.get(11)%>
							],
											borderColor : 'rgb(75, 192, 192)',
											borderWidth : 2,
											fill : false,
										} ]
							};

							const ctx1 = document.getElementById('myLineChart')
									.getContext('2d');
							const myLineChart = new Chart(ctx1, {
								type : 'line',
								data : data1,
								options : {
									scales : {
										x : {
											type : 'category',
											labels : [ 'January', 'February',
													'March', 'April', 'May',
													'June', 'July', 'August',
													'September', 'October',
													'November', 'December' ],
										},
										y : {
											beginAtZero : true,
										}
									}
								}
							});
						</script>
					</div>
					<!-- Education -->
					<div class="tab-contents" id="Education">


						<!--       
          <div>
  <canvas id="myChart2"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
  const ctx = document.getElementById('myChart2');

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
      datasets: [{
        label: '# of Votes',
        data: [12, 19, 3, 5, 2, 3],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script> -->
					</div>

					<div class="tab-contents " id="Languages">

						<div style="width: 320px; height: 420px;">
							<canvas id="doughnutChart"></canvas>
						</div>
						<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
						<script>
							const data = {
								labels : [ 'Red', 'Blue', 'Yellow' ],
								datasets : [ {
									label : 'My First Dataset',
									data : [ 300, 50, 100 ],
									backgroundColor : [ 'rgb(255, 99, 132)',
											'rgb(54, 162, 235)',
											'rgb(255, 205, 86)' ],
									hoverOffset : 4
								} ]
							};

							const chartContext = document.getElementById(
									'doughnutChart').getContext('2d');
							const myChart = new Chart(chartContext, {
								type : 'doughnut',
								data : data
							});
						</script>


					</div>
				</div>
			</div>

		</div>
	</div>



	<!-- <!--   <div class="p-0 m-0 " style=" background-color: #ffffff; height: 40vh;color: #5b4a6b; font-size: 2.5rem;">
    <div class="container m-0 p-0 pt-2" style="text-align: center;height: 70vh; background-color: #5b4a6b; width: 100%;">
<div class="row pt-5  font-weight-bold" style="text-align: center;padding-top: 500px; "> <h1> <b> Our Partners</b> </h1></div>
    <div class="m-0 services justify-content-center" style="margin-top: 50px;">
      <div class="m-2 font-weight-bold" style="font-size: 2.5rem">
        <i class="fa-sharp fa-solid fa-people-group"></i>
        werewrer
      
      </div>
     
      <div class="m-2 font-weight-bold" style="font-size: 2.5rem">
        <i class="fa-sharp fa-solid fa-people-group"></i>
        werewrer
      
      </div>
      <div class="m-2 font-weight-bold" style="font-size: 2.5rem">
        <i class="fa-sharp fa-solid fa-people-group"></i>
        werewrer
      </div>
      <div class="m-2 font-weight-bold" style="font-size: 2.5rem">
        <i class="fa-sharp fa-solid fa-people-group"></i>
        werewrer
      
      </div>
    </div>
  </div>
</div> -->
	<!-- ---------------------------------------services--------------------------------------------------------------------- -->


	<div class="p-0 m-0 "
		style="background-color: #ffffff; height: 60vh; color: #529ece; font-size: 2.5rem;">
		<!-- <div class="container m-0 p-0 pt-2" style="text-align: center;height: 70vh; background-color: #5b4a6b; width: 100%;"> -->
		<div class="row p-0 m-0 pt-5 font-weight-bold"
			style="text-align: center; margin-top: 50px;">
			<h1>
				<b> We are good with numbers</b>
			</h1>
		</div>
		<div class="m-0 services justify-content-center">

			<div class="m-2 font-weight-bold" style="font-size: 4.5rem">
				<!-- <i class="fa-sharp fa-solid fa-people-group"></i> -->
				15+ <br> <span><h5>
						Years of Experience
						</h2></span>

			</div>

			<div class="m-2 font-weight-bold" style="font-size: 4.5rem">
				<!-- <i class="fa-sharp fa-solid fa-people-group"></i> -->
				<%=totalConsultantCounts%>+<br> <span><h5>
						Qualified Experts
						</h2></span>

			</div>
			<div class="m-2 font-weight-bold" style="font-size: 4.5rem">
				<!-- <i class="fa-sharp fa-solid fa-people-group"></i> -->
				<%=totalClientsCounts%>+<br> <span><h5>
						Happy Clients
						</h2></span>

			</div>
			<div class="m-2 font-weight-bold" style="font-size: 4.5rem">
				<!-- <i class="fa-sharp fa-solid fa-people-group"></i> -->
				<%=completedAppointmentsCount%>+<br> <span><h5>
						Success Stories
						</h2></span>

			</div>
		</div>

	</div>
	<!-- ----------------portfolio-------------------------------------------------- -->


	<div class="p-0 m-0 "
		style="background-color: #f9f2fc; height: 60vh; color: #529ece; font-size: 2.5rem;">
		<div class="row pt-5 font-weight-bold p-0 m-0"
			style="text-align: center; margin-top: 100px; font-size: 120px">
			<i class="fa-solid fa-earth-americas"></i>
			<h1 style="margin-top: 70px;">
				<b> Take Control of Your Health</b>
			</h1>
		</div>
		<div class="m-0 services justify-content-center">

			<a href="add-user.jsp" class="btn btn2">Register Now</a>
		</div>

	</div>


	<!-- ------------------------------contact-------------------------------- -->
	<div id="contact">
		<jsp:include page="contact.jsp" />


	</div>

	<!-- --------------------javascript-------------------------- -->
	<script>
		function resetForm() {
			document.getElementById("form1").reset();
		}
	</script>

	<!-- <script>

  var tablinks= document.getElementsByClassName("tab-links");
  var tabcontents= document.getElementsByClassName("tab-contents");
  function opentab(tabname){
    for(tablink of tablinks){
      tablink.classList.remove("active-link");
    }
    for(tabcontent of tabcontents){
      tabcontent.classList.remove("active-tab");
    }
    event.currentTarget.classList.add("active-link");
    document.getElementById(tabname).classList.add("active-tab");

  }
</script> -->

	<script>
		var sidemenu = document.getElementById("sidemenu");

		function openmenu() {
			sidemenu.style.right = "0"
		}

		function closemenu() {
			sidemenu.style.right = "-200px"
		}
	</script>



</body>
</html>


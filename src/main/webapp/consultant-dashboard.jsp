<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ page import="com.labSchedulerSystem.model.User" %>
    <%@ page import="com.labSchedulerSystem.model.AccessRight" %>
      <%@ page import="com.labSchedulerSystem.service.AppointmentService" %>
      

<%
// Check if the user is logged in and has the appropriate role
User user = (User) session.getAttribute("user");
if (user == null || !user.getAccessRight().equals(AccessRight.ROLE_TECHNITIAN)) {
    // Set an error message in the session
    session.setAttribute("errorMessage", "You do not have the required access to view this page.");
    // Redirect the user to the login page
    response.sendRedirect("accessRightError.jsp");
    return; // Stop processing the current page
}
%>

<%
        AppointmentService appointmentService = AppointmentService.getAppointmentService();
        int loggedInUserId = user.getUserId();
        int adminRequestedAppointmentsCount = appointmentService.getAdminRequestedAppointmentsCount(loggedInUserId);
        int appointmentsByConsultantIdCount = appointmentService.getAppointmentsByConsultantIdCount(loggedInUserId);
         int cancelledAppointmentsCount = appointmentService.getCancelledAppointmentsByConIdCount(loggedInUserId);
        int upcomingAppointmentsCountByConId = appointmentService.getUpcomingAppointmentsByConIdCount(loggedInUserId);
        int completedAppointmentsCountByConId = appointmentService.getCompletedAppointmentsByConIdCount(loggedInUserId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
  <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
  
  <title>Admin dashboard </title>
  <!-- <base href="/"> -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="icon" type="image/x-icon" href="https://static.vecteezy.com/system/resources/previews/010/430/526/non_2x/job-for-immigrants-app-icon-refugee-employment-construction-worker-finding-work-abroad-hard-hat-worker-handyman-uiux-user-interface-web-or-mobile-application-isolated-illustration-vector.jpg">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/navbar-style.css">
<!-- <link rel="stylesheet" type="text/css" href="css/adminDashboard.css">
 -->
<Style>

@charset "ISO-8859-1";
  
    *{
  margin: 0;
  padding: 0;
  text-decoration: none;
}

body{

  background-image: linear-gradient(-45deg, #e3eefe 0%, #efddfb 100%);
}

@import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@600;700&display=swap');

* {
  box-sizing: border-box;
}

.page-contain {

  border-radius: .6em;
    margin-top: 10px;
  display: flex;
  justify-content: center;
  background:#d6cdf1;
  padding: 2em;
  font-family: 'Open Sans', sans-serif;
}

.data-card {
  display: flex;
  flex-direction: column;
  max-width: 18.75em;
  min-height: 5.75em;
  overflow: hidden;
  border-radius: .5em;
  text-decoration: none;
  background: white;
  margin: 1em;
  margin-left: 3em;
  padding:  1.5em;
  padding-bottom: 5px;
  box-shadow: 0 1.5em 2.5em -.5em rgba(0, 0, 0, .1);
  transition: transform .45s ease, background .45s ease;
}

.data-card h3 {
  color: #2E3C40;
  font-size: 1.5em;
  font-weight: 600;
  line-height: 1;
  padding-bottom: 5px;
  margin: 0 0 0.142857143em;
  border-bottom: 2px solid #a759f5;
  transition: color .45s ease, border .45s ease;
  text-align:center;
}

.count {
  color: #2E3C40;
  font-size: 3.5em;
  font-weight: 600;
  line-height: 1;
  padding-bottom: 5px;
  margin: 0 0 0.142857143em;
  transition: color .45s ease, border .45s ease;
  text-align:center;
}

.data-card h4 {
  color: #627084;
  text-transform: uppercase;
  font-size: 12px;
  font-weight: 700;
  /* line-height: 1; */
  line-height: 1.2;
  letter-spacing: 0.1em;
  margin: 0 0 10px;
  transition: color .45s ease;
}

.data-card p {
  opacity: 0;
  color: #FFFFFF;
  font-weight: 600;
  line-height: 1.5;
  margin: 0 0 1.25em;
  font-size: 15px;
  transform: translateY(-1em);
  transition: opacity .45s ease, transform .5s ease;
}

.data-card .link-text {
  display: block;
  color: #18a0bf;
  font-size: 1em;
  font-weight: 600;
  line-height: 1.2;
  margin: auto 0 0;
  transition: color .45s ease;
}

.data-card .link-text svg {
  margin-left: .5em;
  transition: transform .6s ease;
}

.data-card .link-text svg path {
  transition: fill .45s ease;
}

.data-card:hover {
  background: #906bcf;
  transform: scale(1.02);
      border-color:  #c1b1f7;
}

.data-card:hover h3 {
  color: #FFFFFF;
  border-bottom-color: #52d6f4;
}

.data-card:hover h4 {
  color: #FFFFFF;
}

.data-card:hover p {
  opacity: 1;
  transform: none;
}

.data-card:hover .link-text {
  color: #FFFFFF;
}

.data-card:hover .link-text svg {
  animation: point 1.25s infinite alternate;
}

.data-card:hover .link-text svg path {
  fill: #52d6f4;
}

@keyframes point {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(.125em);
  }
}

    .page-title{
           text-align: center;
    font-size: 24px;
    color: #7c6694;
    margin-top: 100px;
    margin-bottom: 20px;
     text-transform: uppercase;
}

   .page-title-2{
           text-align: center;
    font-size: 24px;
    color: #7c6694;
    margin-top: 20px;
    margin-bottom: 20px;
     text-transform: uppercase;
}

    </Style>

</head>
<body >
 <!-- sidebar start here  -->
   <input type="checkbox" id="check">
      <label style="position: fixed; top: 60px; z-index: 1; left: -5px;" for="check">
        <i class="fas fa-bars" id="btn"></i>
        <i class="fas fa-times" id="cancel"></i>
      </label>

<div class="sidebar">
 <jsp:include page="sidebar.jsp" />  
</div>  <!-- sidebar end here  -->   

 <div class="row m-0 p-0">
 <div class="col-12 m-0 p-0">
   <nav class="p-0 m-0 ">
    <img class="logo-img" src="" alt="logo">
    <!-- images/navabar-logo.jpg -->
    <ul class="" id="sidemenu" >
       
        
          <% if (user != null) { %>
          
    <li ><a href="view-profile.jsp"><i class="fa fa-user-circle" aria-hidden="true" ></i>&nbsp;&nbsp; <%= user.getName() %></a></li> 
        <li ><a href="logout.jsp"><i class="fa fa-sign-out" aria-hidden="true" ></i>&nbsp;&nbsp;Logout</a></li> 
  <% } else { %>
    <li ><a href="login.jsp"><i class="fa fa-user-circle" aria-hidden="true" ></i>&nbsp;&nbsp; Login</a></li> 
  <% } %>
         
        
    </ul>
    
   
   
  </nav>
 </div>
  </div>

<div class="row m-0 ">
    <div class="col-2 m-0"></div>
    <div class="col-8 m-0 d-flex justify-content-center">
    <div class="page-title">Consultant - DASHBOARD</div>
</div>
    <div class="col-2 m-0"></div>
</div>  





  
    <% 
  /*   User user = (User) session.getAttribute("user"); */
    if (user != null) {
    %>
   <div class="row m-0 ">
    <div class="col-2 m-0"></div>
    <div class="col-8 m-0 d-flex justify-content-center">
    
    <h1>Welcome, <%= user.getName() %>!</h1>
   </div>
    <div class="col-2 m-0"></div>
</div> 

<div class="row m-0 ">
    <div class="col-2 m-0"></div>
    <div class="col-8 m-0 d-flex justify-content-center">
    
      <p>You're logged in as  <%= user.getAccessRight().getDisplayName() %></p>
     </div>
    <div class="col-2 m-0"></div>
</div> 
    <% } %>
 


  
 
 <div class="row m-0 ">
    <div class="col-1 m-0"></div>
    <div class="col-10 m-0 d-flex justify-content-center">
  

  <section class="page-contain">
    <a href="getAppointment?appactiontype=adminRequested" class="data-card">
    <h3> <i class="fa fa-calendar-plus-o" aria-hidden="true"></i></h3>
     <div class="count"><%= adminRequestedAppointmentsCount %></div>
      <h4> New<br> Appointments</h4>    
    
      <!-- <p>Manage registered patients</p> -->     
    </a>
      <a href="getAppointment?appactiontype=conUpcoming" class="data-card">
       <h3><i class="fa fa-clock-o" aria-hidden="true"></i></h3>
    <div class="count"><%= upcomingAppointmentsCountByConId %> </div>
      <h4> Upcoming <br>Appointments</h4>
      <!-- <p>Manage Registered Pharmacists</p> -->    
    
    </a>
    <a href="getAppointment?appactiontype=conComplete" class="data-card">
       <h3><i class="fa fa-calendar-check-o" aria-hidden="true"></i> </h3>
       <div class="count"><%= completedAppointmentsCountByConId %> </div>
      <h4> Completed <br>Appointments</h4>
      <!-- <p>Manage Registered Pharmacists</p> -->     
    
    </a>
      <a href="getAppointment?appactiontype=conCancelled" class="data-card">
      <h3> <i class="fa fa-calendar-times-o" aria-hidden="true"></i></h3>
      <div class="count"><%= cancelledAppointmentsCount %> </div>
      <h4> Cancelled <br>Appointments</h4>
      <!-- <p>Manage Registered Pharmacists</p> -->    
    
    </a>
   
    
   
   
   

  </section>
 
</div>
    <div class="col-1 m-0"></div>
</div>  
 
 <div class="row m-0 ">
    <div class="col-2 m-0"></div>
    <div class="col-8 m-0 d-flex justify-content-center">
    <div class="page-title-2 "> </div>
</div>
    <div class="col-2 m-0"></div>
    </div>
 
</body>
</html>

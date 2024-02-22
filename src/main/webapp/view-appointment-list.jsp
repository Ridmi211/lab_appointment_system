<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
    <%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>

    <%@ page import="com.labSchedulerSystem.model.User" %>
    <%@ page import="com.labSchedulerSystem.model.AccessRight" %>
        <%@ page import="com.labSchedulerSystem.model.RegistrationStatus" %>
    
    <%
User user = (User) session.getAttribute("user");
// Check if the user is logged in
/* if (session.getAttribute("user") == null) {
    // Redirect the user to a login page or display an error message
    response.sendRedirect("login.jsp");
    return; // Stop processing the current page
} */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
  <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
  
 
  <title>Job-Seekers

  </title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="icon" type="image/x-icon" href="https://pbs.twimg.com/profile_images/1486752160004018179/zpnSGdpM_400x400.jpg">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/navbar-style.css">
<link rel="stylesheet" type="text/css" href="css/view-list.css">
<Style>


    /*  <!-- sidebar end here  --> */
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
  
</div>

 
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
    <div class="page-title">All Appointments new </div>
</div>
    <div class="col-2 m-0"></div>
</div>

<div class="row m-0 ">
<p style='color:magenta'>${message}</p>	
</div>

<!-- table -->
    <!-- <div class="col-sm"> -->
       <div class="row m-0">
   <div class="col-1 m-0"></div>
   <div class="col-10 m-0">
      <table class="table table-hover">
        <thead>
          <tr >
            <th scope="col" class="text-center">Count </th>
            <th scope="col" class="text-center">Appointment ID</th>
            <th scope="col" class="text-center">Consultant Name</th>
            <th scope="col" class="text-center">Job Seeker</th>
           <th scope="col" class="text-center">Date</th>
             <th scope="col" class="text-center">Time</th>
            <th scope="col" class="text-center">Status</th>
           <!--  <th scope="col">Role</th> -->
            <th scope="col">View</th>
            <th  scope="col" >Delete</th>
          </tr>
        </thead>
       <!--  <tbody> -->
        <tag:forEach var="appointment" items="${appointmentList}">
          <tr >
            <td scope="row">
            </td>
            <td class="text-center">
           ${appointment.appointmentId}
            </td>
           <td class="text-center">
          ${appointment.consultantName}
            </td>
            <td class="text-center">
          ${appointment.seekerName}
            </td> 
              <td class="text-center">
          ${appointment.scheduledDate}
            </td> 
              <td class="text-center">
          ${appointment.startTime}
            </td> 
          <td class="text-center">
          <div class=" status-btn">
          ${appointment.status.displayName}
          </div>
            </td> 
              
             <%--     <td class="text-center">${user.accessRight.displayName}</td> --%>
            <td class="btn-column">
    <form action="appointmentManager" method="post">
    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
    <input type="hidden" name="appactiontype" value="view">
    <button type="submit" class="btn-view">View</button>
</form> 

</td>            
            <td class="btn-column">
  <form onsubmit="return confirmDelete();" action="appointmentManager" method="post">								
        <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
        <input type="hidden" name="appactiontype" value="deleteAppointment">
        <button type="submit" class="btn-delete">Delete</button>
    </form> 
</td>
            
          </tr>
        </tag:forEach>
      <!--   </tbody> -->
      </table>
      
        </div> 
     <div class="col-1"></div>
     </div>
  <script>
function confirmDelete() {
    return confirm("Are you sure you want to delete this user?");
}
</script>
  
</body>
</html>

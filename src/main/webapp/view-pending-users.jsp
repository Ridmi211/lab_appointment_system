<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>    
    <%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ page import="com.labSchedulerSystem.model.User" %>
    <%@ page import="com.labSchedulerSystem.model.AccessRight" %>
        <%@ page import="com.labSchedulerSystem.model.RegistrationStatus" %>
        <%
User user = (User) session.getAttribute("user");
if (session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return; 
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
  <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet"> 
   <title>Pending Users  </title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
 <link rel="icon" type="image/x-icon"
	href="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/navbar-style.css">
<link rel="stylesheet" type="text/css" href="css/view-list.css">
<Style>

   h4 {
	font-family: 'Source Sans Pro', sans-serif;
	color: rgb(25, 31, 53);
	font-size: 22px;
	margin-top: 40px;
	position: relative;
	top: -3px;
	left: -450px;
}

.reference {
	color: rgb(25, 31, 53);
	font-size: 14px;
}

h4 span {
	color: #91d7f4;
	font-weight: lighter;
}
    </Style>
</head>
<body >
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
    <img class="nav-logo p-0 m-0 pt-0 mt-0"
					src="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg"
					alt="logo">
				<h4>
					Medi<span>Check</span>
				</h4>
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
    <div class="page-title">Pending Users  </div>
</div>
    <div class="col-2 m-0"></div>
</div>
      <div class="row m-0">
   <div class="col-1 m-0"></div>
   <div class="col-10 m-0">
      <table class="table table-hover">
        <thead>
          <tr >
            <th scope="col" class="text-center">Count </th>
            <th scope="col" class="text-center">User ID</th>
            <th scope="col" class="text-center">Name</th>
            <th scope="col" class="text-center">Email</th>
           <th scope="col" class="text-center">Role</th>
            <th scope="col" class="text-center">Reg.Status</th>
            <th scope="col">View</th>
            <th  scope="col" >Approve</th>
            <th  scope="col" >Reject</th>
          </tr>
        </thead>
        <tag:forEach var="user" items="${pendingUsers}">
          <tr >
            <td scope="row">
            </td>
            <td class="text-center">
           ${user.userId}
            </td>
            <td class="text-center">
           ${user.name}
            </td>
            <td class="text-center">
          ${user.email}
            </td>
             <td class="text-center">
          ${user.accessRight.displayName}
            </td>
              <td class="text-center">
          ${user.registrationStatus.displayName}
            </td>
            <td class="btn-column">
    <form action="usermanager" method="post">
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="accessRight" value="${user.accessRight.displayName}">
    <input type="hidden" name="useractiontype" value="view">
    <button type="submit" class="btn btn-primary">View</button>
</form>
</td>
        <td class="btn-column">
       <form action="usermanager" method="post">
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="useractiontype" value="approve">
    <button type="submit" class="btn btn-success">Approve</button>
      </form></td>
 <td class="btn-column">
    <form action="usermanager" method="post">
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="useractiontype" value="reject"> 
    <button type="submit" class="btn btn-danger">Reject</button>
</form></td>  
          </tr>
        </tag:forEach>
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
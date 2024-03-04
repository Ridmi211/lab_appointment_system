<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ page import="com.labSchedulerSystem.model.User" %>
    <%@ page import="com.labSchedulerSystem.model.AccessRight" %>
<!DOCTYPE html>
<html>

    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
  <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
  <script src="https://kit.fontawesome.com/1a4bb98cfa.js" crossorigin="anonymous"></script>
  
	<meta charset="ISO-8859-1">
  <title>Contact Us

  </title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="icon" type="image/x-icon"
	href="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg">

  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/sidebar.css">

<link rel="stylesheet" type="text/css" href="css/navbar-style.css">

<head>
<Style>
h4 {
	font-family: 'Source Sans Pro', sans-serif;
	color: rgb(25, 31, 53);
	font-size: 22px;
	margin-top: 40px;
	position: relative;
	top:-3px;
	left: -450px;
}

h4 span {
	color: #91d7f4;
	font-weight: lighter;
}
 .sub-title {
	font-size: 50px;
	font-weight: 600;
	color: #529ece;
}
     
        .contact-left {
            flex-basis: 35%;
        }

        .contact-right {
            flex-basis: 60%;
        }

        .contact-left p {
            margin-top: 30px;
        }

       .contact-left p i {
	color: #529ece;
	margin-right: 15px;
	font-size: 25px;
}
        .social-icons {
            margin-top: 30px;
        }

        .social-icons a {
            text-decoration: none;
            font-size: 30px;
            margin-right: 15px;
            color: #ababab;
            display: inline-block;
            transition: transform 0.5s;
        }

        .social-icons a:hover {
            color: #529ece;
            transform: translateY(-5px);
        }
        
        
             .btn.btn2 {
            display: inline-block;
            background: #529ece;

        }

        .btn.btn2:hover {
            background: #5b4a6b;
            color: #ffffff;
        }

        .contact-right form {
            width: 100%;
        }

        form input,
        form textarea {
            width: 100%;
            border: 1px solid #91d7f4;
            outline: none;
            background: #ffffff;
            padding: 15px;
            margin: 15px 0;
            color: #6c6c6c;
            font-size: 18px;
            border-radius: 6px;
        }

        form .btn2 {
            padding: 14px 60px;
            font-size: 18px;
            margin-top: 20px;
            cursor: pointer;

        }

        .copyright {
            width: 100%;
            text-align: center;
            padding-top: 20px;
            padding-bottom: 10px;
            background: #1a1a1add;
            font-weight: 100;
            margin-top: 50px;
            color: white;

        }

        .copyright i {
            color: #529ece;
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

<%
// Get the user object from the session
User user = (User) session.getAttribute("user");
%>

<div class="sidebar">
 <jsp:include page="sidebar.jsp" />
  
</div>

 <div class="row m-0 p-0">
 <div class="col-12 m-0 p-0">
   <nav class="p-0 m-0 ">
  <img class="nav-logo p-0 m-0 pt-0 mt-0" src="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg" alt="logo">
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

<div id="contact" >
  <div class="container">
    <div class="row" style=" margin-top: 100px;">
      <div class="contact-left">
        <h1 class="sub-title margin-top: 50px;">Contact Us</h1>
        <p><i class="fa-solid fa-paper-plane"></i> mediCheck@gmail.com</p>
        <p><i class="fa-solid fa-square-phone"></i> (+94)81-954 3823</p>
        <div class="social-icons">
          <a href="#"><i class="fa-brands fa-linkedin"></i></a>
          <a href="#"><i class="fa-brands fa-github"></i></a>
         <a href="#"><i class="fa-brands fa-instagram"></i></a> 
        </div>
     <!--    <a href="images/Resume- Ridmi Yatigammana.pdf" download class="btn btn2">Download CV</a> -->
      </div>
      <div class="contact-right">
     <form name="form1" class="box" action="contactManager" method="post" onsubmit="resetForm()">
        <input type="text" name="messangerName" placeholder="Your Name" required >
        <input type="text" name="messangerEmail" placeholder="Your Email"  required>
        <textarea name="messageBody" rows="6" placeholder="Your Message"></textarea>
       <!--  <button type="submit" class="btn btn2">Submit</button> -->
         <div>
                 
          <input type="hidden" name="msgactiontype" value="addMessage"/>
          <button  class="btn btn2" type="submit">Send</button>
        </div>
      </form>
      <span id="msg"></span>
    </div>
    </div>
  </div>

  <div class="copyright">
    <p> Copyright © 2024</p>
  </div>
  
</div>

<!-- --------------------javascript-------------------------- -->



<script>
  const scriptURL = 'https://script.google.com/macros/s/AKfycbwjcx0iILVo5hybLY6R97WYDrv3PQ7RoVLotpwiMk7FAUS7EPA5Ajsnsw6sr7zWa1V6/exec'
  const form = document.forms['submit-to-google-sheet']
  const msg= document.getElementById("msg")

  form.addEventListener('submit', e => {
    e.preventDefault()
    fetch(scriptURL, { method: 'POST', body: new FormData(form)})
      .then(response => {
        msg.innerHTML="Message sent successfully"
        setTimeout(function(){
          msg.innerHTML=""
        },5000)
      form.reset()
      })


      .catch(error => console.error('Error!', error.message))
  })
</script>
<script>
  var sidemenu=document.getElementById("sidemenu");

  function openmenu(){
    sidemenu.style.right="0"
  }

  function closemenu(){
    sidemenu.style.right="-200px"
  }





</script>


<script>
    function resetForm() {
        document.getElementById("form1").reset();
    }
</script>
   


</body>

</html>


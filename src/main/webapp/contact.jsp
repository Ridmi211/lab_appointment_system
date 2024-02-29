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
  <title>Job-Seekers

  </title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="icon" type="image/x-icon" href="https://static.vecteezy.com/system/resources/previews/010/430/526/non_2x/job-for-immigrants-app-icon-refugee-employment-construction-worker-finding-work-abroad-hard-hat-worker-handyman-uiux-user-interface-web-or-mobile-application-isolated-illustration-vector.jpg">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/sidebar.css">
<Style>
body {
	background:rgb(255, 255, 255);
}
</Style>
</head>

 <!-- sidebar start here  -->
  <!--  <input type="checkbox" id="check">
      <label style="position: fixed; top: 60px; z-index: 1; left: -5px;" for="check">
        <i class="fas fa-bars" id="btn"></i>
        <i class="fas fa-times" id="cancel"></i>
      </label> -->

<%
// Get the user object from the session
User user = (User) session.getAttribute("user");
%>


<div id="contact" >
  <div class="container">
    <div class="row" style=" margin-top: 100px;">
      <div class="contact-left">
        <h1 class="sub-title margin-top: 50px;">Contact Us</h1>
        <p><i class="fa-solid fa-paper-plane"></i> mediCheck@gmail.com</p>
        <p><i class="fa-solid fa-square-phone"></i> (+94)81-954 3823</p>
        <div class="social-icons">
          <a href="#"><i class="fa-brands fa-linkedin"></i></a>
          <a href="#"><i class="fa-brands fa-facebook"></i></a>
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



   




</html>


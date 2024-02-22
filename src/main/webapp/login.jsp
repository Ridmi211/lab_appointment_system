<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%-- <title>Insert title here</title>
</head>
<body>
  <p>${loginError}</p>
<form method="post" action="usermanager">

   <!--  <input type="hidden" name="useractiontype" value="login"> -->
    Email: <input type="text" name="email"><br>
    Password: <input type="password" name="password"><br>
 <!--    <input type="submit" value="Login"> -->
   <div>
                 
          <input type="hidden" name="useractiontype" value="login"/>
          <button style="left: 21%; " class="btn1" type="submit">Create User</button>
        </div>
</form>

</body>
</html> --%>


		<title>Login</title>
 
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/x-icon" href="https://static.vecteezy.com/system/resources/previews/010/430/526/non_2x/job-for-immigrants-app-icon-refugee-employment-construction-worker-finding-work-abroad-hard-hat-worker-handyman-uiux-user-interface-web-or-mobile-application-isolated-illustration-vector.jpg">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
 
		
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>		
	  <style>
   @import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400');
    
    body, html {
      font-family: 'Source Sans Pro', sans-serif;
      background-color: #1d243d;
      padding: 0;
      margin: 0;
    }
    
    #particles-js {
      position: absolute;
      width: 100%;
      height: 100%;
    }
    
    .container{
      margin: 0;
      top: 50px;
      left: 50%;
      position: absolute;
      text-align: center;
      transform: translateX(-50%);
      background-color: rgb( 33, 41, 66 );
      border-radius: 9px;
      border-top: 10px solid #79a6fe;
      border-bottom: 10px solid #8BD17C;
      width: 400px;
      height: 500px;
      box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53);
    }
    
    .box h4 {
      font-family: 'Source Sans Pro', sans-serif;
      color: #5c6bc0; 
      font-size: 18px;
      margin-top:94px;;
    }
    
    .box h4 span {
      color: #dfdeee;
      font-weight: lighter;
    }
    
    .box h5 {
      font-family: 'Source Sans Pro', sans-serif;
      font-size: 13px;
      color: #a1a4ad;
      letter-spacing: 1.5px;
      margin-top: 5px;
      margin-bottom: 50px;
    }
    
    .box input[type = "text"],.box input[type = "password"] {
      display: block;
      margin: 20px auto;
      background: #262e49;
      border: 0;
      border-radius: 5px;
      padding: 14px 10px;
      width: 320px;
      outline: none;
      color: #d6d6d6;
          -webkit-transition: all .2s ease-out;
        -moz-transition: all .2s ease-out;
        -ms-transition: all .2s ease-out;
        -o-transition: all .2s ease-out;
        transition: all .2s ease-out;
      
    }
    ::-webkit-input-placeholder {
      color: #565f79;
    }
    
    .box input[type = "text"]:focus,.box input[type = "password"]:focus {
      border: 1px solid #79A6FE;
      
    }
    
    a{
      color: #5c7fda;
      text-decoration: none;
    }
    
    a:hover {
      text-decoration: underline;
    }
    
     label input[type = "checkbox"] {
      display: none; /* hide the default checkbox */
    }
    
    /* style the artificial checkbox */
    label span {
      height: 13px;
      width: 13px;
      border: 2px solid #464d64;
      border-radius: 2px;
      display: inline-block;
      position: relative;
      cursor: pointer;
      float: left;
      left: 7.5%;
    }
    
    .btn1 {
      border:0;
      background: #7f5feb;
      color: #dfdeee;
      border-radius: 100px;
      width: 340px;
      height: 49px;
      font-size: 16px;
      position: absolute;
      top: 75%;
      left: 8%;
      transition: 0.3s;
      cursor: pointer;
    }
    
    .btn1:hover {
      background: #5d33e6;
    }
    
    .rmb {
      position: absolute;
      margin-left: -24%;
      margin-top: 0px;
      color: #dfdeee;
      font-size: 13px;
    }
    
    .forgetpass {
      position: relative;
      float: right;
      right: 28px;
    }
    
    .dnthave{
        position: absolute;
        top: 90%;
        left: 24%;
    }
    
    [type=checkbox]:checked + span:before {/* <-- style its checked state */
        font-family: FontAwesome;
        font-size: 16px;
        content: "\f00c";
        position: absolute;
        top: -4px;
        color: #896cec;
        left: -1px;
        width: 13px;
    }
    
    .typcn {
      position: absolute;
      left: 339px;
      top: 282px;
      color: #3b476b;
      font-size: 22px;
      cursor: pointer;
    }      
    
    .typcn.active {
      color: #7f60eb;
    }
    
    .error {
      background: #ff3333;
      text-align: center;
      width: 337px;
      height: 20px;
      padding: 2px;
      border: 0;
      border-radius: 5px;
      margin: 10px auto 10px;
      position: absolute;
      top: 31%;
      left: 7.2%;
      color: white;
      display: none;
    }
    
    .footer {
        position: relative;
        left: 0;
        bottom: 0;
        top: 605px;
        width: 100%;
        color: #78797d;
        font-size: 14px;
        text-align: center;
    }
    
    .footer .fa {
      color: #7f5feb;;
    }
  

p{ color:white;
}

 #feedback-container {
    background-color: #4CAF50; 
    color: white; 
    padding: 10px; 
    position: fixed; 
    bottom: 20px; 
    right: 20px; 
    border-radius: 5px; 
    opacity: 1; 
    transition: opacity 0.5s; 
  }

  #feedback-container p {
    margin: 0; /* Remove default margin for the <p> element */
  }

  /* Styling for the message when it's about to disappear */
  #feedback-container.hidden {
    opacity: 0; /* Fade out the message */
  }
  
  </style>
	
	</head>
	
	<body>		
	
     <div class="container">
      <span class="error animated tada" id="msg"></span>
      

      <form name="form1" class="box" method="post" action="usermanager">
        <h4>Job<span>Consultancy</span></h4>
        
        <h5>Sign in to your account.</h5>
          
          <input type="text" name="email" placeholder="Email" autocomplete="off" required>
          <i class="typcn typcn-eye" id="eye"></i>
          <input type="password" name="password" placeholder="password" id="pwd" autocomplete="off" required>
         
         <div>
                 
          <input type="hidden" name="useractiontype" value="login"/>
          <button  class="btn1" type="submit">Sign In</button>
        </div>        
        
        </form>
        <p>${loginError}</p>
          <a href="add-user.jsp" class="dnthave">Don't have an account? Sign up</a>
           
    </div> 
      


</html>
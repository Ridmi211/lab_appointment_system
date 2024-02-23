<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.Test.TestType" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Register</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon"
	href="https://static.vecteezy.com/system/resources/previews/010/430/526/non_2x/job-for-immigrants-app-icon-refugee-employment-construction-worker-finding-work-abroad-hard-hat-worker-handyman-uiux-user-interface-web-or-mobile-application-isolated-illustration-vector.jpg">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">


<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/register-style.css">

<style>
</style>

</head>

<body>

	<div class="container">
		<form name="form1" class="box" action="usermanager" method="post">
			<h4>
				Job<span>Consultancy</span>
			</h4>
			<p>${feebackMessage}</p>
			<h5>Create a new account.</h5>
			<input type="text" name="name" placeholder="Name" id="name"
				autocomplete="off" required> <input type="tel"
				name="telephone" id="telephone" placeholder="Phone number" required>
			<input type="text" name="email" id="email" placeholder="Email"
				autocomplete="off" required> <i class="typcn typcn-eye"
				id="eye"></i> <input type="password" name="password"
				placeholder="Passsword" id="password" autocomplete="off" required>


			<label for="birthdate">Birthdate:</label> <input type="date"
				name="birthdate" id="birthdate" required> <label
				for="gender">Gender:</label>
			<div class="gender">
				<label for="male"> <input type="radio" name="gender"
					id="male" value="Male" required> Male
				</label> <label for="female"> <input type="radio" name="gender"
					id="female" value="Female" required> Female
				</label> <label for="other"> <input type="radio" name="gender"
					id="other" value="Other" required> Other
				</label>
			</div>

			  <label for="usertype">Tell us who you are?</label>
			<div class="usertype">
				<label for="seeker"> <input type="radio" name="usertype"
					id="seeker" value="ROLE_USER" required>A Job Seeker
				</label> <label for="consultant"> <input type="radio"
					name="usertype" id="consultant" value="ROLE_TECHNITIAN" required>
					A Job consultant
				</label> <label for="admin"> <input type="radio" name="usertype"
					id="admin" value="ROLE_ADMIN" required> Admin
				</label>

			</div>
			<div id="jobConsultantQuestions" style="display: none;">
				<!-- Add your additional questions here -->

				<p>Please fill following mandatory fields.</p>
				
				<select name="jobtype" id="jobtype" required>
    <option value="" disabled selected>Select Test Type</option>
    <% for (TestType type : TestType.values()) { %>
        <option value="<%= type.name() %>"><%= type.getDisplayName() %></option>
    <% } %>
</select>
				
           <!--  <select name="jobtype" id="jobtype" required>
                <option value="" disabled selected>Select Test Type</option>
                <option value="BLOOD_TEST">Blood Test</option>
                <option value="URINE_TEST">Urine Test</option>
                Add more test types as needed
            </select>
 -->
				<input type="text" name="educationalQualifications"
					placeholder="Mention your qualifications for this role"
					id="educationalQualifications" autocomplete="off" required>

				<input
					type="text" name="specializedJobs"
					placeholder="Mention your specialized Jobs" id="specializedJobs"
					autocomplete="off" required>
				

			
			</div>

			<div>

				<input type="hidden" name="useractiontype" value="add" />
				<button style="position: relative; left: 0%;" class="btn1"
					type="submit">Create User</button>
			</div>
			<a href="login.jsp" class="dnthave"
				style="position: relative; left: 0%; top: 1%;">Already have an
				account? Login</a>
		</form>

	</div>


	<script>
  const roleRadioButtons = document.querySelectorAll('input[name="usertype"]');
  const jobConsultantQuestions = document.getElementById('jobConsultantQuestions');
  const form = document.forms['form1'];

  // Function to show or hide additional questions based on the selected role
  function handleRoleSelection() {
    if (document.querySelector('input[name="usertype"]:checked').value === "ROLE_TECHNITIAN") {
      jobConsultantQuestions.style.display = 'block';
      // Make the additional questions required for job consultants
       document.querySelector('select[name="jobtype"]').setAttribute('required', 'required');
      document.querySelector('input[name="educationalQualifications"]').setAttribute('required', 'required');
      document.querySelector('input[name="specializedJobs"]').setAttribute('required', 'required');
    } else {
      jobConsultantQuestions.style.display = 'none';
      
      // Remove the required attribute for the additional questions
       document.querySelector('select[name="jobtype"]').setAttribute('required', 'required');
      document.querySelector('input[name="educationalQualifications"]').removeAttribute('required');
      document.querySelector('input[name="specializedJobs"]').removeAttribute('required');
    }
  }

  // Attach the handleRoleSelection function to the change event of the radio buttons
  roleRadioButtons.forEach((radio) => {
    radio.addEventListener('change', handleRoleSelection);
  });

  // Call handleRoleSelection initially to set the initial state
  handleRoleSelection();

  // Function to handle form submission
  form.addEventListener('submit', function (event) {
    if (document.querySelector('input[name="usertype"]:checked').value === "ROLE_TECHNITIAN") {
      // Check if additional questions are answered when "Job Consultant" is selected
      const testType = document.querySelector('select[name="jobtype"]').value;
      const educationalQualifications = document.querySelector('input[name="educationalQualifications"]').value;
      const specializedJobs = document.querySelector('input[name="specializedJobs"]').value;

      if (!educationalQualifications || !specializedCountries || !jobtype) {
        event.preventDefault(); // Prevent form submission if additional questions are not answered
        alert('Please answer the additional questions for Job Consultants.');
      }
    }
  });
</script></html>

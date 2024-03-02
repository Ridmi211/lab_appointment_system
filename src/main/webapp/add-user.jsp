<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="tag" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.labSchedulerSystem.model.Test.TestType" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>MediCheck - Register</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon"
	href="https://png.pngtree.com/template/20191029/ourmid/pngtree-logo-medical-laboratory-observer-vector-image_324823.jpg">

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
				Medi<span>Check</span>
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

		<!-- 	<label for="jobtype">Occupation:</label> <select name="jobtype"
				id="jobtype" required>
				<option value="Registered-Nurse">Registered Nurse</option>
				<option value="Software-Developer">Software Developer</option>
				<option value="Data-Scientist">Data Scientist</option>
				<option value="Cybersecurity-Analyst">Cybersecurity Analyst</option>
				<option value="Digital-Marketing-Manager">Digital Marketing
					Manager</option>
				<option value="Healthcare-Administrator">Healthcare
					Administrator</option>
				<option value="Electrician">Electrician</option>
				<option value="Mechanical-Engineer">Mechanical Engineer</option>
				<option value="School-Teacher">School Teacher</option>
				<option value="Lecturer">Lecturer</option>
				<option value="Pharmacist">Pharmacist</option>
				<option value="Project-Manager">Project Manager</option>
				<option value="Financial-Planner">Financial Planner</option>
				<option value="Data-Analyst">Data Analyst</option>
				<option value="Artificial-Intelligence-Specialist">Artificial
					Intelligence Specialist</option>
				<option value="Physical-Therapist">Physical Therapist</option>
				<option value="Environmental-Engineer">Environmental
					Engineer</option>
				<option value="UX-Designer">UX Designer</option>
				<option value="Employment-Consultant">Employment Consultant</option>
				<option value="Career-Advisor">Career Advisor</option>
				<option value="HR-Consultant">HR Consultant</option>
				<option value="Talent-Acquisition-Specialist">Talent
					Acquisition Specialist</option>
				<option value="Resume-Writer">Resume Writer</option>
				<option value="Interview-Coach">Interview Coach</option>
				<option value="Job-Placement-Specialist">Job Placement
					Specialist</option>
				<option value="Career-Development-Specialist">Career
					Development Specialist</option>
				<option value="Recruitment-Consultant">Recruitment
					Consultant</option>
				<option value="Executive-Search-Consultant">Executive
					Search Consultant</option>
				<option value="Job-Search-Strategist">Job Search Strategist</option>
				<option value="Human-Resources-Advisor">Human Resources
					Advisor</option>
				<option value="Career-Services-Coordinator">Career Services
					Coordinator</option>
				<option value="College-Career-Advisor">College Career
					Advisor</option>
				<option value="Outplacement-Consultant">Outplacement
					Consultant</option>
				<option value="Biomedical-Engineer">Biomedical Engineer</option>
				<option value="Content-Writer">Content Writer</option>
				<option value="Solar-Panel-Installer">Solar Panel Installer</option>
				<option value="Logistics-Manager">Logistics Manager</option>
				<option value="Aeronautical-Engineer">Aeronautical Engineer</option>
				<option value="Urban-Planner">Urban Planner</option>
				<option value="PhD-Researcher">PhD Researcher</option>
				<option value="Radiologic-Technologist">Radiologic
					Technologist</option>
				<option value="Petroleum-Engineer">Petroleum Engineer</option>
				<option value="Fashion-Designer">Fashion Designer</option>
				<option value="Robotics-Engineer">Robotics Engineer</option>
				<option value="Renewable-Energy-Technician">Renewable
					Energy Technician</option>
				<option value="Chemical-Engineer">Chemical Engineer</option>
				<option value="Market-Research-Analyst">Market Research
					Analyst</option>
				<option value="Phlebotomist">Phlebotomist</option>
				<option value="Diagnostic-Medical-Sonographer">Diagnostic
					Medical Sonographer</option>
				<option value="Physical-Therapist-Assistant">Physical
					Therapist Assistant</option>
				<option value="Radiation-Therapist">Radiation Therapist</option>
				<option value="Robotics-Technician">Robotics Technician</option>
				<option value="Forensic-Scientist">Forensic Scientist</option>
				<option value="Geographic-Information-Systems-Analyst">Geographic
					Information Systems Analyst</option>
				<option value="Air-Traffic-Controller">Air Traffic
					Controller</option>
				<option value="Marine-Engineer">Marine Engineer</option>
				<option value="Commercial-Pilot">Commercial Pilot</option>
				<option value="Other">Other</option>
			</select> --><!--  <label for="country">Residing Country:</label> --><!--  <select
				name="country" id="country" required>
				<option value="USA">USA</option>
				<option value="Canada">Canada</option>
				<option value="United Kingdom">United Kingdom</option>
				<option value="Australia">Australia</option>
				<option value="Germany">Germany</option>
				<option value="France">France</option>
				<option value="Sri Lanka">Sri Lanka</option>
				<option value="Spain">Spain</option>
				<option value="Italy">Italy</option>
				<option value="Netherlands">Netherlands</option>
				<option value="Sweden">Sweden</option>
				<option value="Switzerland">Switzerland</option>
				<option value="Japan">Japan</option>
				<option value="China">China</option>
				<option value="South Korea">South Korea</option>
				<option value="Brazil">Brazil</option>
				<option value="Mexico">Mexico</option>
				<option value="India">India</option>
				<option value="South Africa">South Africa</option>
				<option value="New Zealand">New Zealand</option>
				<option value="Singapore">Singapore</option>
				<option value="United Arab Emirates">United Arab Emirates</option>
				<option value="Saudi Arabia">Saudi Arabia</option>
				<option value="Qatar">Qatar</option>
				<option value="Ireland">Ireland</option>
				<option value="Norway">Norway</option>
				<option value="Denmark">Denmark</option>
				<option value="Finland">Finland</option>
				<option value="Austria">Austria</option>
				<option value="Belgium">Belgium</option>
				<option value="Greece">Greece</option>
				<option value="Portugal">Portugal</option>
				<option value="Russia">Russia</option>
				<option value="Argentina">Argentina</option>
				<option value="Chile">Chile</option>
				<option value="Peru">Peru</option>
				<option value="Colombia">Colombia</option>
				<option value="Egypt">Egypt</option>
				<option value="Kenya">Kenya</option>
				<option value="Nigeria">Nigeria</option>
				<option value="Afghanistan">Afghanistan</option>
				<option value="Bangladesh">Bangladesh</option>
				<option value="Cambodia">Cambodia</option>
				<option value="Democratic Republic of the Congo">Democratic
					Republic of the Congo</option>
				<option value="Ethiopia">Ethiopia</option>
				<option value="Haiti">Haiti</option>
				<option value="Honduras">Honduras</option>
				<option value="Iraq">Iraq</option>
				<option value="Laos">Laos</option>
				<option value="Mozambique">Mozambique</option>
				<option value="Nepal">Nepal</option>
				<option value="Nicaragua">Nicaragua</option>
				<option value="Pakistan">Pakistan</option>
				<option value="Rwanda">Rwanda</option>
				<option value="Sierra Leone">Sierra Leone</option>
				<option value="Somalia">Somalia</option>
				<option value="Sudan">Sudan</option>
				<option value="Syria">Syria</option>
				<option value="Yemen">Yemen</option>
				<option value="Zimbabwe">Zimbabwe</option>
				<option value="Other">Other</option>

			</select> --> <label for="usertype">Tell us who you are?</label>
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



				<input type="text" name="educationalQualifications"
					placeholder="Mention your qualifications for this role"
					id="educationalQualifications" autocomplete="off" required>

				<!--  <input type="text" name="specializedCountries"
					placeholder="Mention your specialized Countries"
					id="specializedCountries" autocomplete="off" required> -->
					
					 <input
					type="text" name="specializedJobs"
					placeholder="Mention your specialized Jobs" id="specializedJobs"
					autocomplete="off" required> 
					
				<!-- 	<label for="availableDays">Available
					Days:</label>
				<div class="availableDays">

					<input type="checkbox" name="availableDays" value="Monday">
					<label for="Monday"> Monday </label> <input type="checkbox"
						name="availableDays" value="Tuesday"> <label for="Tuesday">
						Tuesday </label> <input type="checkbox" name="availableDays"
						value="Wednesday"><label for="Wednesday">
						Wednesday </label> <input type="checkbox" name="availableDays"
						value="Thursday"> <label for="Thursday"> Thursday
					</label><br> <input type="checkbox" name="availableDays"
						value="Friday"> <label for="Friday"> Friday </label> <input
						type="checkbox" name="availableDays" value="Saturday"> <label
						for="Saturday"> Saturday </label> <input type="checkbox"
						name="availableDays" value="Sunday"> <label for="Sunday">
						Sunday </label>
				</div> -->

			<!-- 	<label for="availableTimeSlots">Available Time Slots:</label>
				<div class="availableTimeSlots">
					<input type="checkbox" name="availableTimeSlots" value="09.00am">
					<label for="Monday"> 09.00am </label> <input type="checkbox"
						name="availableTimeSlots" value="10.00am"><label
						for="Monday"> 10.00am </label> <input type="checkbox"
						name="availableTimeSlots" value="11.00am"> <label
						for="Monday"> 11.00am </label> <input type="checkbox"
						name="availableTimeSlots" value="01.00pm"> <label
						for="Monday"> 01.00pm </label><br> <input type="checkbox"
						name="availableTimeSlots" value="02.00pm"><label
						for="Monday"> 02.00pm </label> <input type="checkbox"
						name="availableTimeSlots" value="03.00pm"> <label
						for="Monday"> 03.00pm </label> <input type="checkbox"
						name="availableTimeSlots" value="04.00pm"> <label
						for="Monday"> 04.00pm </label> <input type="checkbox"
						name="availableTimeSlots" value="05.00pm"><label
						for="Monday"> 05.00pm </label>
				</div> -->
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
      document.querySelector('input[name="educationalQualifications"]').setAttribute('required', 'required');
  /*     document.querySelector('input[name="specializedCountries"]').setAttribute('required', 'required');
      */ document.querySelector('input[name="specializedJobs"]').setAttribute('required', 'required');
    } else {
      jobConsultantQuestions.style.display = 'none';
      // Remove the required attribute for the additional questions
      document.querySelector('input[name="educationalQualifications"]').removeAttribute('required');
/*       document.querySelector('input[name="specializedCountries"]').removeAttribute('required'); */
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
    if (document.querySelector('input[name="usertype"]:checked').value === "ROLE_CONSULTANT") {
      // Check if additional questions are answered when "Job Consultant" is selected
      const educationalQualifications = document.querySelector('input[name="educationalQualifications"]').value;
      const specializedCountries = document.querySelector('input[name="specializedCountries"]').value;
      const specializedJobs = document.querySelector('input[name="specializedJobs"]').value;

      if (!educationalQualifications || !specializedCountries || !specializedJobs) {
        event.preventDefault(); // Prevent form submission if additional questions are not answered
        alert('Please answer the additional questions for Job Consultants.');
      }
    }
  });
</script></html>

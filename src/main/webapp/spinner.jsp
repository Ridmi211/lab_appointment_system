<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style >* {
	box-sizing: border-box;
}

body {
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.spinner {
	--t: 2500ms;
	--animation: rotate var(--t) linear infinite;
	--animation2: scale var(--t) linear infinite alternate;
	position: relative;
	width: 10rem;
	height: 10rem;
	display: flex;
	justify-content: center;
	align-items: center;
	animation: var(--animation), var(--animation2);
}

.spinner::before,
.spinner::after {
	content: '';
	position: absolute;
}

.spinner::before {
	inset: 0;
	border: 3px solid #855ba5;
	border-radius: 50%;
	mask-image: conic-gradient(transparent 10%, black);
	animation: borderScale var(--t) linear infinite alternate;
}

.spinner::after {
	--r: 45deg;
	--scale: 2;
	width: 20%;
	height: 20%;
	background: 
		radial-gradient(circle at 30% 35%, white 3px, transparent 0),
		radial-gradient(circle at 70% 35%, white 3px, transparent 0),
		radial-gradient(circle at top center, white 6px, transparent 0),
		#855ba5;
	background-position: 0 0, 0 0, 0 1.25rem;
	top: 0;
	translate: 0 -50%;
	rotate: 45deg;
	animation: var(--animation) reverse, var(--animation2);
	border-radius: 20%;
}

@keyframes rotate {
	to {
		rotate: calc(360deg + var(--r, 0deg));
	}
}

@keyframes scale {
	to {
		scale: var(--scale, 0.5);
	}
}

@keyframes borderScale {
	to {
		border: 6px solid #855ba5;
	}
}</style>
</head>
<body>
<div class="spinner"></div>
</body>
</html>
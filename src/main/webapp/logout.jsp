<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
</head>
<body>
    <%
        // Get the current session
        HttpSession userSession = request.getSession(false);

        // Check if the user is logged in (session exists)
        if (userSession != null) {
            // Invalidate the session to log the user out
            userSession.invalidate();
        }

        // Redirect the user to a login page or any other desired page
        response.sendRedirect("home.jsp");
    %>
</body>
</html>

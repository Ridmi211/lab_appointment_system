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
        HttpSession userSession = request.getSession(false);
        if (userSession != null) {
            userSession.invalidate();
        }
        response.sendRedirect("home.jsp");
    %>
</body>
</html>
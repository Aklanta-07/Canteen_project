<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // Check if user session exists
    String username = (String) session.getAttribute("username");
    
    if(username != null && !username.isEmpty()) {
        // User is logged in - redirect to home page
        response.sendRedirect("home.jsp");
    }  else {
       // User is not logged in - redirect to login page
        response.sendRedirect("login.jsp");
   }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0;url=login.jsp">
    <title>Canteen Portal</title>
</head>
<body>
    <%-- Redirecting... --%>
    <p>Loading...</p>
</body>
</html>
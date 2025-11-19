<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="css/register.css">
</head>
<body>

<div class="register-box">
    <h2>Create Account</h2>

    <!-- Show error message if exists -->
    <% 
        String errorMsg = (String) request.getAttribute("error");
        if (errorMsg != null) { 
    %>
        <div class="error-box">
            <%= errorMsg %>
        </div>
    <% 
        } 
    %>

    <form action="register" method="post">

        <input type="text" name="username" placeholder="Username" 
               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" 
               required>

        <input type="email" name="email" placeholder="Email" 
               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" 
               required>

        <input type="password" name="password" placeholder="Password" required>

        <input type="text" name="address" placeholder="Address" 
               value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>" 
               required>

        <button type="submit">Register</button>
    </form>

    <p class="login-link">
        Already have an account? <a href="login.jsp">Login</a>
    </p>

</div>

</body>
</html>

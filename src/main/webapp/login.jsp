<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>

<div class="login-box">
    <h2>Welcome Back</h2>

    <form action="login" method="post">
        <input type="text" placeholder="Email" name="email" required>
        <input type="password" placeholder="Password" name="password" required>

        <button type="submit">Login</button>

        <p class="error">
            <%
                String msg = (String) request.getAttribute("error");
                if (msg != null) { out.print(msg); }
            %>
        </p>
    </form>

    <p class="register-link">
        Don't have an account? <a href="register.jsp">Register</a>
    </p>
</div>

</body>
</html>

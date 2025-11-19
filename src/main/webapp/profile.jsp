<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String address = (String) session.getAttribute("address");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Profile Settings</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: linear-gradient(to right, #ff3d72, #fe7b72, #9736bc, #6d3cdb, #5241f5);
        }

        .navbar {
            background: #0f172a;
            padding: 14px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
        }

        .navbar a {
            color: white;
            margin-left: 20px;
        }

        .container {
            width: 40%;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }

        input[type=text], input[type=email], input[type=password] {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            background: #0ea5e9;
            border: none;
            padding: 10px 18px;
            color: white;
            border-radius: 6px;
            cursor: pointer;
        }

        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
    </style>
</head>

<body>

<div class="navbar">
    <div>Food Delivery App</div>
    <div>
        <a href="restaurants">Restaurants</a>
        <a href="orders">Orders</a>
        <a href="cart">Cart</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">

    <h2>Profile Settings</h2>

    <% if (request.getParameter("success") != null) { %>
        <p class="success">Profile updated successfully ✔</p>
    <% } %>

    <% if (request.getParameter("pass_success") != null) { %>
        <p class="success">Password updated successfully ✔</p>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
        <p class="error"><%= request.getParameter("error") %></p>
    <% } %>

    <!-- Update Profile Form -->
    <form method="post" action="profile">

        <label>Full Name</label>
        <input type="text" name="username" value="<%= username %>" required>

        <label>Email</label>
        <input type="email" name="email" value="<%= email %>" required>

        <label>Address</label>
        <input type="text" name="address" value="<%= address %>" required>

        <button type="submit">Update Profile</button>
    </form>

    <hr><br>

    <!-- Change Password Form -->
    <h3>Change Password</h3>

    <form method="post" action="change-password">

        <label>Current Password</label>
        <input type="password" name="oldPassword" required>

        <label>New Password</label>
        <input type="password" name="newPassword" required>

        <label>Confirm New Password</label>
        <input type="password" name="confirmPassword" required>

        <button type="submit">Update Password</button>
    </form>

</div>

</body>
</html>

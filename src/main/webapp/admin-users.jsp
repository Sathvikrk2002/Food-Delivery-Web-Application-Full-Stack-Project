<%@ page language="java" import="java.util.*, com.sathvik.model.User" pageEncoding="UTF-8"%>

<%
    if (!"ADMIN".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Users</title>
<style>

body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(
        to right,
        #ff3d72,
        #ff3d72,
        #fe4670,
        #f42977,
        #bb2f9f,
        #9736bc,
        #6d3cdb,
        #5241f5
    );
    color: white;
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
    text-decoration: none;
}

.container {
    width: 85%;
    margin: 30px auto;
    background: rgba(255,255,255,0.1);
    padding: 20px;
    border-radius: 10px;
}

.success {
    background: green;
    color: white;
    padding: 10px;
    text-align: center;
    border-radius: 6px;
    width: 60%;
    margin: 10px auto;
}

.back-btn {
    background: #2563eb;
    padding: 8px 14px;
    border-radius: 6px;
    color: white;
    text-decoration: none;
    margin-left: 20px;
}

table {
    width: 90%;
    margin: 20px auto;
    border-collapse: collapse;
    background: white;
    color: black;
}

th, td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
}

th {
    background: #0f172a;
    color: white;
}

.action-btn {
    padding: 6px 10px;
    background: #3b82f6;
    color: white;
    border-radius: 6px;
    text-decoration: none;
    margin-right: 5px;
}

.delete-btn {
    background: #ef4444;
}

.make-admin {
    background: #10b981;
}

</style>
</head>

<body>

<div class="navbar">
    <div>Admin Panel</div>
    <div>
        <a href="admin-dashboard.jsp" class="back-btn">Back to Dashboard</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">

    <% if (request.getParameter("success") != null) { %>
        <div class="success">
            <%= request.getParameter("success") %>
        </div>
    <% } %>

    <h2 style="text-align:center;">User Management</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>

        <% for(User u : users) { %>
        <tr>
            <td><%= u.getUserId() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getRole() %></td>

            <td>
                <a class="action-btn delete-btn"
                   href="delete-user?id=<%= u.getUserId() %>">
                   Delete
                </a>

                <% if (!u.getRole().equals("ADMIN")) { %>
                    <a class="action-btn make-admin"
                       href="make-admin?id=<%= u.getUserId() %>">
                       Make Admin
                    </a>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>

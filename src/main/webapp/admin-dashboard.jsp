<%@ page language="java" %>

<%
    if (session.getAttribute("role") == null || 
        !session.getAttribute("role").equals("ADMIN")) {

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<style>
body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(
    to right,
    #ff3d72,
    #ff3d72,
    #fe7b72,
    #fe4670,
    #f42977,
    #bb2f9f,
    #9736bc,
    #6d3cdb,
    #5241f5
  );
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
.box {
	background: rgba(255, 255, 255, 0.1);	
    width: 50%;
    margin: 60px auto;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    border: 2px solid white;
    color: white;
    text-shadow: 1px 1px 2px black;
}
.link-btn {
    padding: 10px 20px;
    background: #3b82f6;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    display: inline-block;
    margin-top: 15px;
}
</style>
</head>

<body>

<div class="navbar">
    <div>Admin Panel</div>
    <div>
        
        <a href="logout">Logout</a>
    </div>
</div>

<div class="box">
    <h2>Welcome Admin, <%= session.getAttribute("username") %></h2>

    <a class="link-btn" href="admin-users">Manage Users</a><br><br>
</div>

</body>
</html>

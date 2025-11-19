<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Block direct access — redirect if session is NULL
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home - Food Delivery App</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(
    to bottom,
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
            min-height: 100vh;
        }

        /* --- NAVBAR --- */
        .navbar {
            background: #0f172a;
            padding: 14px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 16px;
        }

        .navbar-left {
            font-size: 18px;
            font-weight: bold;
        }

        .navbar-right a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
            font-size: 16px;
        }

        .navbar-right a.logout {
            color: #f87171;
        }

        /* --- DASHBOARD BOX --- */
        .dashboard {
        
            margin: 60px auto;
            width: 60%;
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.2);
            text-align: center;
            color: white;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            border: 2px solid white;
        }

        .dashboard h2 {
            margin-bottom: 10px;
        }

        .option-link {
            display: inline-block;
            padding: 8px 14px;
            margin: 8px;
            background: #0ea5e9;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="navbar-left">Food Delivery App</div>

    <div class="navbar-right">
        <a href="restaurants">Restaurants</a>
        <a href="cart">Cart</a>
        <a href="logout" class="logout">Logout</a>
    </div>
</div>

<!-- DASHBOARD BOX -->
<div class="dashboard">
    <h2>Welcome, <%= username %> 👋</h2>
    <p>You are successfully logged in!</p>

    <br><br>

    <h3>Quick Navigation</h3>

    <a href="restaurants" class="option-link">🍽 View Restaurants</a>
    <a href="orders" class="option-link">📄 Your Orders</a>
    <a href="profile" class="option-link">⚙ Profile Settings</a>
</div>

</body>
</html>

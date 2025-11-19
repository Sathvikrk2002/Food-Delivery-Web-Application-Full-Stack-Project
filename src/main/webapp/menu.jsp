<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>

    <style>
        body {
            background: linear-gradient(
                to left,
                #ff3d72, #ff3d72, #fe7b72, #fe4670,
                #f42977, #bb2f9f, #9736bc, #6d3cdb, #5241f5
            );
            margin: 0;
            font-family: Arial, sans-serif;
        }

        /* ------------ NAVBAR ------------ */
        .navbar {
            background: black;
            border: 1px solid white;
            backdrop-filter: blur(10px);
            color: white;
            width: fit-content;
            padding: 12px 25px;
            display: flex;
            gap: 25px;
            border-radius: 50px;
            margin: 25px auto;  /* centers navbar */
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .navbar a.logout {
            color: #ff9b9b !important;
            
        }

        /* ------------ MENU GRID ------------ */
        .menu-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
            justify-content: center;
            padding: 30px;
        }

        .menu-card {
            width: 300px;
            background: #fff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.12);
        }

        .menu-card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 8px;
        }

        .menu-card h3 {
            margin: 10px 0 5px;
            font-size: 18px;
            font-weight: bold;
        }

        .menu-card p {
            margin: 5px 0;
            color: #555;
        }

        .menu-card form {
            margin-top: 10px;
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .menu-card input[type="number"] {
            width: 70px;
            padding: 7px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .menu-card button {
            padding: 8px 12px;
            background: #06b6d4;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <a href="restaurants">← Back to Restaurants</a>
    <a href="home.jsp">Dashboard</a>
    <a href="cart">Cart</a>
    <a href="logout" class="logout">Logout</a>
</div>

<!-- MENU GRID -->
<div class="menu-grid">

    <%
        java.util.List items = (java.util.List) request.getAttribute("menuItems");
        Integer restaurantId = (Integer) request.getAttribute("restaurantId");

        if (items != null) {
            for (Object o : items) {
                com.sathvik.model.Menu m = (com.sathvik.model.Menu) o;
    %>

    <div class="menu-card">
        <img src="<%= (m.getImageUrl() != null ? m.getImageUrl() : "https://via.placeholder.com/300x160") %>" alt="item">

        <h3><%= m.getItemName() %></h3>
        <p><%= m.getDescription() %></p>
        <p><strong>₹ <%= String.format("%.2f", m.getPrice()) %></strong></p>

        <!-- ADD TO CART FORM -->
        <form action="cart" method="post">
            <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
            <input type="hidden" name="itemName" value="<%= m.getItemName() %>">
            <input type="hidden" name="price" value="<%= m.getPrice() %>">

            <input type="number" name="quantity" value="1" min="1">
            <button type="submit">Add to Cart</button>
        </form>
    </div>

    <%
            }
        }
    %>

</div>

</body>
</html>

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
    <title>Restaurants</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
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
            padding: 15px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a { color: white; text-decoration:none; margin-right: 20px; }
        .navbar a.logout { color: #f87171 !important; }

        h2 {
            text-align:center;
            color: white;
            margin-top: 20px;
        }

        .cards {
            display:flex;
            flex-wrap:wrap;
            justify-content:center;
            gap:20px;
            padding:30px;
        }

        .card {
            width:280px;
            background: white;
            padding:15px;
            border-radius:8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .card img {
            width:100%;
            height:150px;
            border-radius:8px;
            object-fit:cover;
        }

        .card h3 { margin:10px 0; }
        .card p { margin:5px 0; color:#555; }

        .card a {
            display:inline-block;
            margin-top:10px;
            padding:8px 12px;
            background:#2196F3;
            color:white;
            border-radius:6px;
            text-decoration:none;
        }
    </style>
</head>

<body>

<div class="navbar">
    <div>Food Delivery App</div>

    <div>
        <a href="home.jsp">Dashboard</a>
        <a href="cart">Cart</a>
        <a href="logout" class="logout">Logout</a>
    </div>
</div>

<h2>Restaurants</h2>

<div class="cards">

<%
    java.util.List list = (java.util.List) request.getAttribute("restaurants");

    if (list != null) {
        for (Object obj : list) {

            com.sathvik.model.Restaurant r = (com.sathvik.model.Restaurant) obj;

            String img = r.getImageUrl();
            if (img == null || img.trim().isEmpty()) {
                img = "https://via.placeholder.com/280x150";
            }
%>

    <div class="card">
        <img src="<%= img %>" alt="restaurant">

        <h3><%= r.getName() %></h3>
        <p><%= r.getCuisine() %> • <%= r.getDeliveryTime() %> mins</p>
        <p>Rating: <%= r.getRating() %></p>

        <a href="menu?restaurantId=<%= r.getRestaurantId() %>">View Menu</a>
    </div>

<%
        }
    }
%>

</div>

</body>
</html>

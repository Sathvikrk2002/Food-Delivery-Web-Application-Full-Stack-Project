<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <style>
        body {
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
            padding: 40px;
            text-align: center;
        }

        .card {
            width: 450px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 12px rgba(0,0,0,0.3);
        }

        a {
            display: inline-block;
            margin-top: 20px;
            background: #2563eb;
            padding: 12px 18px;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        a:hover { background: #1d4ed8; }
    </style>
</head>

<body>

<div class="card">
    <h2>🎉 Order Placed Successfully!</h2>

    <p>Your order ID: <b><%= request.getParameter("orderId") %></b></p>

    <a href="orders">View Your Orders</a>
</div>

</body>
</html>

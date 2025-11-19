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
    <title>Checkout - Food Delivery App</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #89f7fe, #66a6ff);
            padding: 40px;
        }

        .container {
            width: 450px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.2);
        }

        h2 { text-align: center; }

        input, select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #10b981;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover { background: #059669; }
    </style>

</head>
<body>

<div class="container">
    <h2>Checkout</h2>

    <form action="checkout" method="post">

        <label>Delivery Address</label>
        <input type="text" name="deliveryAddress" placeholder="Enter your delivery address" required>

        <label>Payment Method</label>
        <select name="paymentMethod" required>
            <option value="COD">Cash on Delivery</option>
            <option value="Card">Credit / Debit Card</option>
            <option value="UPI">UPI</option>
        </select>

        <button type="submit">Place Order</button>
    </form>

</div>

</body>
</html>

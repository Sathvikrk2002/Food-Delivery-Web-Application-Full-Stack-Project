<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sathvik.model.OrderItem" %>

<%
    List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <style>
        body { font-family: Arial; background: #f0f0f0; padding: 30px; }
        .container { background:white; padding:20px; border-radius:10px; width:70%; margin:auto; }
        table { width:100%; border-collapse:collapse; margin-top:20px; }
        th, td { padding:10px; border-bottom:1px solid #ddd; text-align:left; }
        th { background:#0f172a; color:white; }
        a { color:#007bff; text-decoration:none; }
    </style>
</head>

<body>
<div class="container">
    <h2>Order Details</h2>

    <table>
        <thead>
        <tr>
            <th>Item</th>
            <th>Price</th>
            <th>Qty</th>
            <th>Total</th>
        </tr>
        </thead>

        <tbody>
        <% for (OrderItem oi : items) { %>
        <tr>
            <td><%= oi.getMenuName() %></td>
            <td>₹ <%= oi.getMenuPrice() %></td>
            <td><%= oi.getQuantity() %></td>
            <td>₹ <%= oi.getItemTotal() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <br>
    <a href="orders">← Back to Orders</a>
</div>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.sathvik.model.Order, com.sathvik.model.OrderItem" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Orders</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(
    to left,
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
            padding: 15px 25px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .container {
            width: 80%;
            margin: 40px auto;
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #f1f5f9;
        }

        .view-items-btn {
            background: #3b82f6;
            color: white;
            padding: 5px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .items-box {
            background: #f9fafb;
            border-radius: 10px;
            padding: 10px 15px;
            display: none;
            margin-bottom: 20px;
        }

        .item-row {
            padding: 5px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .item-row:last-child {
            border-bottom: none;
        }

        .back {
            display: inline-block;
            margin-top: 15px;
            background: #10b981;
            color: white;
            padding: 8px 14px;
            border-radius: 5px;
            text-decoration: none;
        }
    </style>

    <script>
        function toggleItems(id) {
            var box = document.getElementById("items-" + id);
            box.style.display = (box.style.display === "block") ? "none" : "block";
        }
    </script>
</head>
<body>

<div class="navbar">
    <div>Food Delivery App</div>
    <div>
        <a href="restaurants">Restaurants</a>
        <a href="cart.jsp">Cart</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">

    <h2>Your Orders</h2>

    <% if (orders == null || orders.isEmpty()) { %>
        <p>No past orders found.</p>
    <% } else { %>

        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Total Amount (₹)</th>
                    <th>Payment</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Items</th>
                </tr>
            </thead>

            <tbody>
            <% for (Order o : orders) { %>
                <tr>
                    <td><%= o.getOrderId() %></td>
                    <td>₹ <%= o.getTotalAmount() %></td>
                    <td><%= o.getPaymentMethod() %></td>
                    <td><%= o.getOrderDate() %></td>
                    <td><%= o.getStatus() %></td>
                    <td>
                        <button class="view-items-btn" onclick="toggleItems(<%= o.getOrderId() %>)">
                            View Items
                        </button>
                    </td>
                </tr>

                <!-- Items box -->
                <tr>
                    <td colspan="6">
                        <div class="items-box" id="items-<%= o.getOrderId() %>">

                            <% for (OrderItem item : o.getOrderItems()) { %>
                                <div class="item-row">
                                    <strong><%= item.getMenuName() %></strong><br>
                                    Price: ₹ <%= item.getMenuPrice() %><br>
                                    Qty: <%= item.getQuantity() %><br>
                                    Total: ₹ <%= item.getItemTotal() %>
                                </div>
                            <% } %>

                        </div>
                    </td>
                </tr>

            <% } %>
            </tbody>

        </table>

    <% } %>

    <a class="back" href="restaurants">← Back to Restaurants</a>

</div>

</body>
</html>

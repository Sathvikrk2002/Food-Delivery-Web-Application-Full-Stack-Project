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
    <title>Your Cart</title>

    <style>
        body {
            margin: 0;
            padding: 0;
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
            padding: 14px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            margin-right: 20px;
            text-decoration: none;
            font-size: 16px;
        }

        .navbar a.logout { color: #f87171; }

        .cart-container {
            width: 70%;
            background: white;
            margin: 40px auto;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 0px 12px rgba(0,0,0,0.15);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        input[type="number"] {
            width: 70px;
            padding: 6px;
        }

        .btn-remove {
            padding: 8px 12px;
            background: #ef4444;
            color: white;
            border: none;
            border-radius: 6px;
        }

        .btn-update {
            margin-top: 15px;
            padding: 10px 14px;
            background: #0ea5e9;
            color: white;
            border: none;
            border-radius: 6px;
        }

        .btn-checkout {
            margin-top: 15px;
            padding: 10px 14px;
            background: #16a34a;
            color: white;
            border: none;
            border-radius: 6px;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div>
        <a href="restaurants">Back to Restaurants</a>
        <a href="home.jsp">Dashboard</a>
    </div>

    <div>
        <a href="cart">Cart</a>
        <a href="logout" class="logout">Logout</a>
    </div>
</div>

<div class="cart-container">
    <h2>Your Cart</h2>

    <%
        java.util.List list = (java.util.List) session.getAttribute("cart");

        if (list == null || list.isEmpty()) {
    %>
        <p>Your cart is empty.</p>
        <a href="restaurants">Browse Restaurants</a>

    <%
        } else {
    %>

    <form action="cart" method="post">
        <input type="hidden" name="action" value="update">

        <table>
            <tr>
                <th>Item</th><th>Price</th><th>Qty</th><th>Total</th><th>Action</th>
            </tr>

            <%
                double grand = 0;

                for (Object o : list) {
                    com.sathvik.model.CartItem ci = (com.sathvik.model.CartItem) o;
                    double total = ci.getTotal();
                    grand += total;
            %>

            <tr>
                <td><%= ci.getItemName() %></td>
                <td>₹ <%= ci.getPrice() %></td>

                <td>
                    <input type="number" name="quantity_<%= ci.getMenuId() %>" value="<%= ci.getQuantity() %>" min="1">
                </td>

                <td>₹ <%= total %></td>

                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="menuId" value="<%= ci.getMenuId() %>">
                        <button class="btn-remove">Remove</button>
                    </form>
                </td>
            </tr>

            <%
                }
            %>

            <tr>
                <td colspan="3" style="text-align:right;"><b>Grand Total:</b></td>
                <td colspan="2"><b>₹ <%= grand %></b></td>
            </tr>
        </table>

        <button type="submit" class="btn-update">Update Quantities</button>
    </form>

    <form action="checkout" method="post">
        <button type="submit" class="btn-checkout">Proceed to Checkout</button>
    </form>

    <%
        } // end else
    %>

</div>

</body>
</html>

package com.sathvik.servlet;

import com.sathvik.db.DBConnection;
import com.sathvik.model.Order;
import com.sathvik.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        List<Order> orders = new ArrayList<>();

        String ordersQuery =
                "SELECT order_id, user_id, restaurant_id, order_date, total_amount, status, payment_method, delivery_address " +
                "FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        String itemsQuery =
                "SELECT oi.order_item_id, oi.order_id, oi.menu_id, oi.quantity, oi.item_total, " +
                "m.item_name, m.price " +
                "FROM order_items oi " +
                "JOIN menu m ON oi.menu_id = m.menu_id " +
                "WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(ordersQuery)) {

            ps.setInt(1, userId);
            ResultSet rsOrders = ps.executeQuery();

            while (rsOrders.next()) {
                Order order = new Order();
                order.setOrderId(rsOrders.getInt("order_id"));
                order.setUserId(rsOrders.getInt("user_id"));
                order.setRestaurantId(rsOrders.getInt("restaurant_id"));
                order.setOrderDate(rsOrders.getTimestamp("order_date"));
                order.setTotalAmount(rsOrders.getDouble("total_amount"));
                order.setStatus(rsOrders.getString("status"));
                order.setPaymentMethod(rsOrders.getString("payment_method"));
                order.setDeliveryAddress(rsOrders.getString("delivery_address"));

                order.setOrderItems(new ArrayList<>());

                try (PreparedStatement psItems = conn.prepareStatement(itemsQuery)) {
                    psItems.setInt(1, order.getOrderId());
                    ResultSet rsItems = psItems.executeQuery();

                    while (rsItems.next()) {
                        OrderItem item = new OrderItem();
                        item.setOrderItemId(rsItems.getInt("order_item_id"));
                        item.setMenuId(rsItems.getInt("menu_id"));
                        item.setQuantity(rsItems.getInt("quantity"));
                        item.setItemTotal(rsItems.getDouble("item_total"));

                        item.setMenuName(rsItems.getString("item_name"));
                        item.setMenuPrice(rsItems.getDouble("price"));

                        order.getOrderItems().add(item);
                    }
                    rsItems.close();
                }

                orders.add(order);
            }
            rsOrders.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("orders.jsp").forward(request, response);
    }
}

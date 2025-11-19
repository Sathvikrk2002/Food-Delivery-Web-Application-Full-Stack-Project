package com.sathvik.servlet;

import com.sathvik.db.DBConnection;
import com.sathvik.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        List<OrderItem> items = new ArrayList<>();

        String sql =
                "SELECT oi.order_item_id, oi.order_id, oi.menu_id, oi.quantity, oi.item_total, " +
                "       m.item_name, m.price " +
                "FROM order_items oi " +
                "JOIN menu m ON oi.menu_id = m.menu_id " +
                "WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem oi = new OrderItem();

                oi.setOrderItemId(rs.getInt("order_item_id"));
                oi.setOrderId(rs.getInt("order_id"));
                oi.setMenuId(rs.getInt("menu_id"));
                oi.setQuantity(rs.getInt("quantity"));
                oi.setItemTotal(rs.getDouble("item_total"));

                // NEW FIELDS ADDED
                oi.setMenuName(rs.getString("item_name"));
                oi.setMenuPrice(rs.getDouble("price"));

                items.add(oi);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("items", items);
        request.getRequestDispatcher("order-details.jsp").forward(request, response);
    }
}

package com.sathvik.servlet;

import com.sathvik.db.DBConnection;
import com.sathvik.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Your cart is empty.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String paymentMethod = request.getParameter("paymentMethod");
        String deliveryAddress = request.getParameter("deliveryAddress");

        if (paymentMethod == null || paymentMethod.isEmpty())
            paymentMethod = "COD";

        if (deliveryAddress == null || deliveryAddress.isEmpty())
            deliveryAddress = "Not Provided";

        // Calculate grand total
        double grandTotal = cart.stream().mapToDouble(CartItem::getTotal).sum();

        Connection conn = null;
        PreparedStatement insertOrderStmt = null;
        PreparedStatement insertItemStmt = null;
        PreparedStatement menuLookupStmt = null;
        ResultSet rsKeys = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Determine restaurant_id from first cart item
            int restaurantId = -1;
            menuLookupStmt = conn.prepareStatement("SELECT restaurant_id FROM menu WHERE menu_id = ?");
            menuLookupStmt.setInt(1, cart.get(0).getMenuId());
            ResultSet rs = menuLookupStmt.executeQuery();
            if (rs.next()) restaurantId = rs.getInt("restaurant_id");
            rs.close();

            // 1) Insert order
            String orderSQL =
                    "INSERT INTO orders (user_id, restaurant_id, total_amount, status, payment_method, delivery_address) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            insertOrderStmt = conn.prepareStatement(orderSQL, Statement.RETURN_GENERATED_KEYS);
            insertOrderStmt.setInt(1, userId);

            if (restaurantId > 0) insertOrderStmt.setInt(2, restaurantId);
            else insertOrderStmt.setNull(2, Types.INTEGER);

            insertOrderStmt.setDouble(3, grandTotal);
            insertOrderStmt.setString(4, "PLACED");
            insertOrderStmt.setString(5, paymentMethod);
            insertOrderStmt.setString(6, deliveryAddress);

            int affected = insertOrderStmt.executeUpdate();
            if (affected == 0) throw new SQLException("Order insertion failed.");

            rsKeys = insertOrderStmt.getGeneratedKeys();
            int orderId;

            if (rsKeys.next()) orderId = rsKeys.getInt(1);
            else throw new SQLException("No order ID returned.");

            // 2) Insert order items
            String itemSQL =
                    "INSERT INTO order_items (order_id, menu_id, quantity, item_total) VALUES (?, ?, ?, ?)";

            insertItemStmt = conn.prepareStatement(itemSQL);

            for (CartItem ci : cart) {
                insertItemStmt.setInt(1, orderId);
                insertItemStmt.setInt(2, ci.getMenuId());
                insertItemStmt.setInt(3, ci.getQuantity());
                insertItemStmt.setDouble(4, ci.getTotal());
                insertItemStmt.addBatch();
            }

            insertItemStmt.executeBatch();

            conn.commit();

            // Clear cart
            session.removeAttribute("cart");

            // Redirect to success page
            response.sendRedirect("order-success.jsp?orderId=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();

            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ignored) {}
            }

            request.setAttribute("error", "Failed to place order. Please try again.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } finally {
            try { if (rsKeys != null) rsKeys.close(); } catch (Exception ignored) {}
            try { if (insertItemStmt != null) insertItemStmt.close(); } catch (Exception ignored) {}
            try { if (insertOrderStmt != null) insertOrderStmt.close(); } catch (Exception ignored) {}
            try { if (menuLookupStmt != null) menuLookupStmt.close(); } catch (Exception ignored) {}
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception ignored) {}
        }
    }

    // GET → show checkout page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
}

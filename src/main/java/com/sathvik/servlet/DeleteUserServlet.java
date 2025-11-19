package com.sathvik.servlet;

import com.sathvik.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Allow only ADMIN
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {

            // STEP 0 — Check if user is admin (optional, protect admin)
            String checkRoleQuery = "SELECT role FROM users WHERE user_id = ?";
            PreparedStatement psRole = conn.prepareStatement(checkRoleQuery);
            psRole.setInt(1, userId);
            ResultSet rsRole = psRole.executeQuery();

            if (rsRole.next() && "ADMIN".equals(rsRole.getString("role"))) {
                response.sendRedirect("admin-users?error=Cannot delete another admin account!");
                return;
            }

            // STEP 1 — Check if user has placed orders
            String checkOrders = "SELECT COUNT(*) FROM orders WHERE user_id = ?";
            PreparedStatement psCheck = conn.prepareStatement(checkOrders);
            psCheck.setInt(1, userId);
            ResultSet rs = psCheck.executeQuery();
            rs.next();

            if (rs.getInt(1) > 0) {
                // User has orders → cannot delete
                response.sendRedirect("admin-users?error=User has order history. Cannot delete!");
                return;
            }

            // STEP 2 — Delete user safely
            String deleteUser = "DELETE FROM users WHERE user_id = ?";
            PreparedStatement psDelete = conn.prepareStatement(deleteUser);
            psDelete.setInt(1, userId);
            psDelete.executeUpdate();

            response.sendRedirect("admin-users?success=User deleted successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-users?error=Something went wrong while deleting user!");
        }
    }
}

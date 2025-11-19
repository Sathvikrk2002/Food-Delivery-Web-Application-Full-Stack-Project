package com.sathvik.servlet;

import com.sathvik.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/make-admin")
public class MakeAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Only ADMIN can promote other users
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "UPDATE users SET role = 'ADMIN' WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to admin users list
        response.sendRedirect("admin-users");
    }
}

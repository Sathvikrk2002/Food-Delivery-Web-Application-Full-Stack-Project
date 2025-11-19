package com.sathvik.servlet;

import com.sathvik.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Form values
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "UPDATE users SET username=?, email=?, address=? WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, address);
            ps.setInt(4, userId);

            ps.executeUpdate();

            // Update session attributes
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("address", address);

            response.sendRedirect("profile.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=1");
        }
    }
}

package com.sathvik.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sathvik.db.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                // --- CREATE SESSION ---
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("address", rs.getString("address"));
                session.setAttribute("role", rs.getString("role")); // USER / ADMIN

                // --- UPDATE LAST LOGIN DATE ---
                try (PreparedStatement updateStmt = conn.prepareStatement(
                        "UPDATE users SET last_login_date = NOW() WHERE user_id = ?")) {

                    updateStmt.setInt(1, rs.getInt("user_id"));
                    updateStmt.executeUpdate();
                }

                // --- REDIRECT BASED ON ROLE ---
                if ("ADMIN".equalsIgnoreCase(rs.getString("role"))) {
                    response.sendRedirect("admin-dashboard.jsp");
                } else {
                    response.sendRedirect("home.jsp");
                }

            } else {
                request.setAttribute("error", "Invalid email or password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong! Try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

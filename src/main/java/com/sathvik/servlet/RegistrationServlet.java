package com.sathvik.servlet;

import com.sathvik.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        try (Connection conn = DBConnection.getConnection()) {

            // Check if username exists
            String checkUser = "SELECT * FROM users WHERE username=?";
            PreparedStatement ps1 = conn.prepareStatement(checkUser);
            ps1.setString(1, username);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                request.setAttribute("error", "Username already taken!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check if email exists
            String checkEmail = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps2 = conn.prepareStatement(checkEmail);
            ps2.setString(1, email);
            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                request.setAttribute("error", "Email already registered!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Insert new user
            String sql = "INSERT INTO users (username, password, email, address, role) VALUES (?, ?, ?, ?, 'USER')";
            PreparedStatement ps3 = conn.prepareStatement(sql);

            ps3.setString(1, username);
            ps3.setString(2, password);
            ps3.setString(3, email);
            ps3.setString(4, address);

            ps3.executeUpdate();

            // Redirect to login page with success message
            response.sendRedirect("login.jsp?registered=1");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}

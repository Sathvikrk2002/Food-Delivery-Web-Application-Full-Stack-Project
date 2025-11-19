package com.sathvik.servlet;

import com.sathvik.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("userId");

        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        if (!newPass.equals(confirmPass)) {
            response.sendRedirect("profile.jsp?error=New passwords do not match!");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String checkSql = "SELECT password FROM users WHERE user_id=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                String currentPassword = rs.getString("password");

                if (!currentPassword.equals(oldPass)) {
                    response.sendRedirect("profile.jsp?error=Incorrect current password!");
                    return;
                }
            }

            String updateSql = "UPDATE users SET password=? WHERE user_id=?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, newPass);
            updateStmt.setInt(2, userId);
            updateStmt.executeUpdate();

            response.sendRedirect("profile.jsp?pass_success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=Something went wrong.");
        }
    }
}

package com.sathvik.servlet;

import com.sathvik.db.DBConnection;
import com.sathvik.model.Menu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = request.getParameter("restaurantId");
        if (rid == null) { response.sendRedirect("restaurants.jsp"); return; }

        int restaurantId = Integer.parseInt(rid);
        List<Menu> items = new ArrayList<>();

        String sql = "SELECT menu_id, restaurant_id, item_name, description, price, is_available, image_url FROM menu WHERE restaurant_id = ? AND is_available = 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Menu m = new Menu();
                    m.setMenuId(rs.getInt("menu_id"));
                    m.setRestaurantId(rs.getInt("restaurant_id"));
                    m.setItemName(rs.getString("item_name"));
                    m.setDescription(rs.getString("description"));
                    m.setPrice(rs.getDouble("price"));
                    m.setAvailable(rs.getBoolean("is_available"));
                    m.setImageUrl(rs.getString("image_url"));
                    items.add(m);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("menuItems", items);
        request.setAttribute("restaurantId", restaurantId);
        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }
}

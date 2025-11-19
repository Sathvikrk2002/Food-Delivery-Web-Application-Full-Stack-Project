package com.sathvik.servlet;

import com.sathvik.db.DBConnection;
import com.sathvik.model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restaurants")
public class RestaurantListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT restaurant_id, name, cuisine, address, rating, image_url, delivery_time FROM restaurants WHERE is_active = 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setName(rs.getString("name"));
                r.setCuisine(rs.getString("cuisine"));
                r.setAddress(rs.getString("address"));
                r.setRating(rs.getDouble("rating"));
                r.setImageUrl(rs.getString("image_url"));
                r.setDeliveryTime(rs.getInt("delivery_time"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("restaurants", list);
        request.getRequestDispatcher("restaurants.jsp").forward(request, response);
    }
}

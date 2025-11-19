package com.sathvik.servlet;

import com.sathvik.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        request.setAttribute("cartItems", cart);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        // ---------------- ADD ----------------
        if ("add".equals(action)) {

            int menuId = Integer.parseInt(request.getParameter("menuId"));
            String itemName = request.getParameter("itemName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            boolean found = false;

            for (CartItem item : cart) {
                if (item.getMenuId() == menuId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                }
            }

            if (!found) {
                cart.add(new CartItem(menuId, itemName, price, quantity));
            }

            session.setAttribute("cart", cart);

            String rid = request.getParameter("restaurantId");
            if (rid != null && !rid.isEmpty()) {
                response.sendRedirect("menu?restaurantId=" + rid);
            } else {
                response.sendRedirect("cart");
            }
            return;
        }

        // ---------------- REMOVE ----------------
        else if ("remove".equals(action)) {

            int menuId = Integer.parseInt(request.getParameter("menuId"));
            cart.removeIf(item -> item.getMenuId() == menuId);

            session.setAttribute("cart", cart);

            response.sendRedirect("cart");
            return;
        }

        // ---------------- UPDATE ----------------
        else if ("update".equals(action)) {

            Enumeration<String> paramNames = request.getParameterNames();

            while (paramNames.hasMoreElements()) {
                String p = paramNames.nextElement();

                if (p.startsWith("quantity_")) {

                    int menuId = Integer.parseInt(p.substring(9));
                    int qty = Integer.parseInt(request.getParameter(p));

                    for (CartItem item : cart) {
                        if (item.getMenuId() == menuId) {
                            item.setQuantity(qty);
                            break;
                        }
                    }
                }
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("cart");
            return;
        }

        response.sendRedirect("cart");
    }
}

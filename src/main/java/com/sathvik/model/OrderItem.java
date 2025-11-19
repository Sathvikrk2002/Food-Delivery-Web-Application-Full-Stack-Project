package com.sathvik.model;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int menuId;
    private int quantity;
    private double itemTotal;

    // standardized field names used everywhere:
    private String menuName;
    private double menuPrice;

    public OrderItem() {}

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getItemTotal() { return itemTotal; }
    public void setItemTotal(double itemTotal) { this.itemTotal = itemTotal; }

    public String getMenuName() { return menuName; }
    public void setMenuName(String menuName) { this.menuName = menuName; }

    public double getMenuPrice() { return menuPrice; }
    public void setMenuPrice(double menuPrice) { this.menuPrice = menuPrice; }
}

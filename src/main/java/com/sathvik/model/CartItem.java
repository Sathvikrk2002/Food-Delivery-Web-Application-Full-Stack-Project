package com.sathvik.model;

public class CartItem {
    private int menuId;
    private String itemName;
    private double price;
    private int quantity;

    public CartItem() {}

    public CartItem(int menuId, String itemName, double price, int quantity) {
        this.menuId = menuId;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
    }

    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotal() { return price * quantity; }
}

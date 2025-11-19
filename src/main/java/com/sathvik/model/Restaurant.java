package com.sathvik.model;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String cuisine;
    private String address;
    private double rating;
    private String imageUrl;
    private int deliveryTime;
    private boolean isActive;
    private int adminUserId;

    public Restaurant() {}

    public Restaurant(int restaurantId, String name, String cuisine, String address,
                      double rating, String imageUrl, int deliveryTime, boolean isActive, int adminUserId) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.cuisine = cuisine;
        this.address = address;
        this.rating = rating;
        this.imageUrl = imageUrl;
        this.deliveryTime = deliveryTime;
        this.isActive = isActive;
        this.adminUserId = adminUserId;
    }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCuisine() { return cuisine; }
    public void setCuisine(String cuisine) { this.cuisine = cuisine; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(int deliveryTime) { this.deliveryTime = deliveryTime; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public int getAdminUserId() { return adminUserId; }
    public void setAdminUserId(int adminUserId) { this.adminUserId = adminUserId; }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author ADMIN
 */
public class CartItem {
    private int id;
    private int userId;
    private int bookId;
    private double price;
    private int quantity;

    // Constructor
    public CartItem(int id, int userId, int bookId, double price, int quantity) {
        this.id = id;
        this.userId = userId;
        this.bookId = bookId;
        this.price = price;
        this.quantity = quantity;
    }

    // Default Constructor
    public CartItem() {
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Calculate total price for the item
    public double getTotalPrice() {
        return this.price * this.quantity;
    }
}

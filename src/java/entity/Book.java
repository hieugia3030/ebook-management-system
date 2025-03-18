package entity;

public class Book {

    private int bookId;
    private String bookName;
    private String author;
    private double price;
    private int categoryId;
    private String status;
    private String photo;
    private String userEmail;

    // Constructor with all fields (excluding bookId for auto-increment cases)
    public Book(String bookName, String author, double price, int bookCategory, String status, String photo, String userEmail) {
        this.bookName = bookName;
        this.author = author;
        this.price = price;
        this.categoryId = bookCategory;
        this.status = status;
        this.photo = photo;
        this.userEmail = userEmail;
    }

    // Constructor with bookId (if needed)
    public Book(int bookId, String bookName, String author, double price, int bookCategory, String status, String photo, String userEmail) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.author = author;
        this.price = price;
        this.categoryId = bookCategory;
        this.status = status;
        this.photo = photo;
        this.userEmail = userEmail;
    }

    // Getters and Setters
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategory(int bookCategory) {
        this.categoryId = bookCategory;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
}

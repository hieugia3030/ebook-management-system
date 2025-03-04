package entity;

public class Book {
    private int bookId;
    private String bookname;
    private String author;
    private double price;
    private String bookCategory;
    private String status;
    private String photo;
    private String userEmail;

    // Default constructor
    public Book() {
    }

    // Parameterized constructor
    public Book(int bookId, String bookname, String author, double price, 
                String bookCategory, String status, String photo, String userEmail) {
        this.bookId = bookId;
        this.bookname = bookname;
        this.author = author;
        this.price = price;
        this.bookCategory = bookCategory;
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

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
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

    public String getBookCategory() {
        return bookCategory;
    }

    public void setBookCategory(String bookCategory) {
        this.bookCategory = bookCategory;
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

    // toString() method for debugging
    @Override
    public String toString() {
        return "Book [bookId=" + bookId + ", bookname=" + bookname + ", author=" + author 
               + ", price=" + price + ", bookCategory=" + bookCategory + ", status=" + status 
               + ", photo=" + photo + ", userEmail=" + userEmail + "]";
    }
}

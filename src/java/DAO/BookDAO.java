package DAO;

import entity.Book;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO extends MyDAO {

    public boolean insertBook(Book book) throws SQLException{
        xSql = "INSERT INTO Book (bookName, author, price, categoryId, status, photo, user_email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, book.getBookName());
            ps.setString(2, book.getAuthor());
            ps.setDouble(3, book.getPrice());
            ps.setInt(4, book.getCategory()); 
            ps.setString(5, book.getStatus());
            ps.setString(6, book.getPhoto());
            ps.setString(7, book.getUserEmail());

            return ps.executeUpdate() > 0; // Returns true if insertion is successful
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                throw e;
            }
        }
    }

    public List<Book> getAllBooks() throws SQLException{
        List<Book> books = new ArrayList<>();
        xSql = "SELECT * FROM Book";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Book book = new Book(
                        rs.getInt("bookId"),
                        rs.getString("bookName"),
                        rs.getString("author"),
                        rs.getDouble("price"),
                        rs.getInt("categoryId"),
                        rs.getString("status"),
                        rs.getString("photo"),
                        rs.getString("user_email")
                );
                books.add(book);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                throw e;
            }
        }
        return books;
    }

    public Book getBookById(int id) throws SQLException{
        Book book = null;
        xSql = "SELECT * FROM Book WHERE bookId = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                book = new Book(
                        rs.getInt("bookId"),
                        rs.getString("bookName"),
                        rs.getString("author"),
                        rs.getDouble("price"),
                        rs.getInt("categoryId"), 
                        rs.getString("status"),
                        rs.getString("photo"),
                        rs.getString("user_email")
                );
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                throw e;
            }
        }
        return book;
    }

    public boolean updateBook(Book book) throws SQLException{
        xSql = "UPDATE Book SET bookName=?, author=?, price=?, categoryId=?, status=?, photo=? WHERE bookId=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, book.getBookName());
            ps.setString(2, book.getAuthor());
            ps.setDouble(3, book.getPrice());
            ps.setInt(4, book.getCategory()); // Fixed
            ps.setString(5, book.getStatus());
            ps.setString(6, book.getPhoto());
            ps.setInt(7, book.getBookId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                throw e;
            }
        }
    }

    public boolean deleteBook(int bookId) throws SQLException{
        xSql = "DELETE FROM Book WHERE bookId = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                throw e;
            }
        }
    }
}

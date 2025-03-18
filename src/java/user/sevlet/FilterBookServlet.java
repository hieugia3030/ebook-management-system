/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package user.sevlet;

import DAO.BookDAO;
import DAO.CategoryDAO;
import com.google.gson.Gson;
import entity.Book;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "FilterBookServlet", urlPatterns = {"/filter-book"})
public class FilterBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String[] categoryIds = request.getParameterValues("categoryIds");
        String priceStr = request.getParameter("maxPrice");
        BookDAO bookDAO = new BookDAO();
        List<Book> filteredBooks;

        try {
            int maxPrice = Integer.parseInt(priceStr);
            List<Integer> categoryList;
            if (categoryIds != null) {
                categoryList = Arrays.stream(categoryIds)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                filteredBooks = bookDAO.getFilteredBooks(categoryList, maxPrice);
            } else {
                filteredBooks = bookDAO.getAllBooksWithMaxPrice(maxPrice);
            }

            String json = new Gson().toJson(booksToResponse(filteredBooks));
            out.write(json);
            out.flush();
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(e.getMessage());
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("FormatException" + e.getMessage());
        }
    }

    List<BookResponse> booksToResponse(List<Book> books) throws SQLException {
        List<BookResponse> list = new ArrayList<>();
        CategoryDAO catDAO = new CategoryDAO();
        for (Book book : books) {
            String category = catDAO.getCategoryById(book.getCategoryId()).getCategoryName();
            BookResponse res = new BookResponse(book.getBookId(), book.getBookName(), book.getAuthor(), book.getPrice(), book.getCategoryId(), category, book.getStatus(), book.getPhoto(), book.getUserEmail());
            list.add(res);
        }
        return list;
    }

    class BookResponse {

        private int bookId;
        private String bookName;
        private String author;
        private double price;
        private int categoryId;
        private String categoryName;
        private String status;
        private String photo;
        private String userEmail;

        public BookResponse(int bookId, String bookName, String author, double price, int categoryId, String categoryName, String status, String photo, String userEmail) {
            this.bookId = bookId;
            this.bookName = bookName;
            this.author = author;
            this.price = price;
            this.categoryId = categoryId;
            this.categoryName = categoryName;
            this.status = status;
            this.photo = photo;
            this.userEmail = userEmail;
        }

    }
}

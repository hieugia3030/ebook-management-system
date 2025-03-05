/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin.servelet;

import DAO.BookDAO;
import entity.Book;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

@WebServlet("/add_book")
@MultipartConfig
public class BooksAddServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Getting parameters from the form
        String bookName = request.getParameter("bname");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("price");
        String bookCategory = request.getParameter("btype"); // Book category dropdown
        String status = request.getParameter("bstatus"); // Book status dropdown
        Part part = request.getPart("bimg"); // Uploaded file

        User user = (User) session.getAttribute("userobj");
        if (user == null) {
            session.setAttribute("failedMsg", "You must be logged in to add a book!");
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = user.getEmail();

        // Convert price to double
        double price = 0.0;
        if (priceStr != null && !priceStr.isEmpty()) {
            try {
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (part != null) {
            try {
                String fileName = part.getSubmittedFileName(); // Get uploaded file name
                String uploadPath = getServletContext().getRealPath("") + File.separator + "book";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);
                System.out.println("File saved at: " + filePath);
            } catch (Exception e) {
                session.setAttribute("errMsg", "Add Book Failed! There is no Image Provided!");
                response.sendRedirect("admin/add_books.jsp");
                return;
            }
        } else {
            session.setAttribute("errMsg", "Add Book Failed! The image is null");
            response.sendRedirect("admin/add_books.jsp");
            return;
        }
        // Getting the file name
        String fileName = part.getSubmittedFileName();

        Book book = new Book(bookName, author, price, bookCategory, status, fileName, userEmail);

        String path = getServletContext().getRealPath("");

        String validationError = validate(book);
        if (validationError != null) {
            session.setAttribute("errMsg", validationError);
            response.sendRedirect("admin/add_books.jsp");
            return;
        }

        BookDAO bookDAO = new BookDAO();
        String msg = bookDAO.insertBook(book);

        if (msg.isBlank()) {
            session.setAttribute("succMsg", "Added Book Successfully!");
            response.sendRedirect("admin/add_books.jsp");
        } else {
            String errMsg = "Add Book Failed! Insert Book to Database Failed" + msg;
            session.setAttribute("errMsg", errMsg);
            response.sendRedirect("admin/add_books.jsp");
        }

    }

    private String validate(Book book) {
        if (book.getBookName() == null || book.getBookName().trim().isEmpty()) {
            return "Book name cannot be empty!";
        }
        if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
            return "Author cannot be empty!";
        }
        if (book.getPrice() <= 0) {
            return "Price must be a number greater than 0!";
        }
        return null; // No errors
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Used for adding books in admin panel.";
    }// </editor-fold>

}

package admin.servelet;

import DAO.BookDAO;
import entity.Book;
import entity.User;
import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.SQLException;

@WebServlet("/edit_book")
@MultipartConfig
public class EditBookServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            HttpSession session = request.getSession();
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBookById(bookId); 

            if (book != null) {
                session.setAttribute("editBook", book);
                response.sendRedirect("admin/edit_book.jsp");
            } else {
                session.setAttribute("errMsg", "Book not found");
                response.sendRedirect("admin/all_books.jsp");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errMsg", "Invalid book ID format");
            response.sendRedirect("admin/all_books.jsp");
        } catch (Exception e) {
            request.getSession().setAttribute("errMsg", "An error occurred while fetching book details");
            response.sendRedirect("admin/all_books.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String error = "";

        // Check if user is logged in
        User user = (User) session.getAttribute("userobj");
        if (user == null) {
            session.setAttribute("failedMsg", "You must be logged in to edit a book!");
            response.sendRedirect("login.jsp");
            return;
        }
        String userEmail = user.getEmail();

        // Getting parameters from form
        String idStr = request.getParameter("id");
        int id;
        if (idStr != null && !idStr.isEmpty()) {
            try {
                id = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
                session.setAttribute("errMsg", "Invalid Book ID!");
                response.sendRedirect("edit_book.jsp");
                return;
            }
        } else {
            session.setAttribute("errMsg", "Book ID is missing!");
            response.sendRedirect("admin/edit_book.jsp");
            return;
        }

        String bookName = request.getParameter("bname");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("price");
        int bookCategory = 0; // Book category dropdown
        String status = request.getParameter("bstatus");
        Part part = request.getPart("bimg");

        // Convert price to double
        double price = 0.0;
        if (priceStr != null && !priceStr.isEmpty()) {
            try {
                bookCategory = Integer.parseInt(request.getParameter("btype"));
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                error = e.getMessage();
                e.printStackTrace();
            }
        }

        // Handling file upload
        String fileName = null;
        if (part != null && part.getSize() > 0) {
            fileName = part.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "book";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String filePath = uploadPath + File.separator + fileName;
            part.write(filePath);
        } else {
            fileName = request.getParameter("oldPhoto");
        }

        // Create Book object
        Book book = new Book(id, bookName, author, price, bookCategory, status, fileName, userEmail);

        // Validate input
        String validationError = validate(book);
        if (validationError != null) {
            session.setAttribute("errMsg", error);
            response.sendRedirect("admin/edit_book.jsp");
            return;
        }

        // Update book in database
        BookDAO bookDAO = new BookDAO();
        try {
            bookDAO.updateBook(book);
            session.setAttribute("succMsg", "Book updated successfully!");
        } catch (SQLException e) {
            session.setAttribute("errMsg", "Update failed! Database error.\n" + e.getMessage());
        }

        response.sendRedirect("admin/all_books.jsp");
    }

    private String validate(Book book) {
        if (book.getBookName() == null || book.getBookName().trim().isEmpty()) {
            return "Book name cannot be empty!";
        }
        if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
            return "Author cannot be empty!";
        }
        if (book.getPrice() <= 0) {
            return "Price must be a NUMBER greater than 0!";
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "Servlet for editing books in admin panel.";
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package admin.servelet;

import DAO.BookDAO;
import entity.Book;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="SetBookSessionServelet", urlPatterns={"/set_book"})
public class SetBookSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBookById(bookId);

            if (book != null) {
                HttpSession session = request.getSession();
                session.setAttribute("editBook", book);
                response.sendRedirect("admin/edit_book.jsp");
            } else {
                request.getSession().setAttribute("errMsg", "Book not found");
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
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin.servelet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/add_books")
public class BooksAddServelet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Getting parameters from the form
        String bookName = request.getParameter("bname");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("price");
        String bookCategory = request.getParameter("btype"); // Book category dropdown
        String status = request.getParameter("bstatus"); // Book status dropdown
        Part part = request.getPart("bimg"); // Uploaded file

        // Convert price to double
        double price = 0.0;
        if (priceStr != null && !priceStr.isEmpty()) {
            try {
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Getting the file name
        String fileName = part.getSubmittedFileName();

        // Print to check values (for debugging)
        System.out.println("Book Name: " + bookName);
        System.out.println("Author: " + author);
        System.out.println("Price: " + price);
        System.out.println("Category: " + bookCategory);
        System.out.println("Status: " + status);
        System.out.println("Photo: " + fileName);
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

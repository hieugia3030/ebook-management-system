<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="DAO.BookDAO"%>
<%@page import="entity.Book"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin: All book</title>
        <%@include file="allCss.jsp" %>;
    </head>
    <body>
        <%@include file="navbar.jsp" %>;
        <h3 class="text-center">All Books in Store</h3>

        <table class="table table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Image</th>
                    <th scope="col">Book Name</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Categories</th>
                    <th scope="col">Status</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
            BookDAO dao = new BookDAO();
            List<Book> books = dao.getAllBooks();
                %>

                <% if (books.isEmpty()) { %>
                <tr>
                    <td colspan="8" class="text-center">
                        <p class="text-muted">No books added! So sad 😢</p>
                    </td>
                </tr>
                <% } else { 
        for (Book book : books) { %>
                <tr>
                    <td><%= book.getBookId() %></td>
                    <td><img src="book/<%= book.getPhoto() %>" width="50"></td>
                    <td><%= book.getBookName() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td>$<%= book.getPrice() %></td>
                    <td><%= book.getBookCategory() %></td>
                    <td><%= book.getStatus() %></td>
                    <td>
                        <a href="#" class="btn btn-sm btn-primary">Edit</a>
                        <a href="#" class="btn btn-sm btn-danger">Delete</a>
                    </td>
                </tr>
                <% } 
    } %>
            </tbody>
        </table>
        <div>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>


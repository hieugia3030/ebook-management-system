<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="DAO.*"%>
<%@page import="entity.Book"%>

<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin: All Books</title>
    <%@include file="allCss.jsp" %>
    <script>
        function editBook(bookId) {
            var form = document.createElement("form");
            form.method = "POST";
            form.action = "../set_book";
            var input = document.createElement("input");
            input.type = "hidden";
            input.name = "bookId";
            input.value = bookId;
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }

        function deleteBook(bookId) {
            if (confirm("Are you sure you want to delete this book?")) {
                var form = document.createElement("form");
                form.method = "POST";
                form.action = "../delete_book"; 
                var input = document.createElement("input");
                input.type = "hidden";
                input.name = "bookId";
                input.value = bookId;
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>

    <style>
        body {
            background-color: #f7f7f7;
            font-family: 'Arial', sans-serif;
        }

        main {
            padding: 30px;
        }

        h3 {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            text-align: center;
            padding: 15px;
            font-size: 16px;
            color: #333;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        td img {
            width: 50px;
            height: 50px;
            border-radius: 5px;
            object-fit: cover;
        }

        td button {
            margin: 5px;
            border-radius: 5px;
            padding: 6px 12px;
            font-size: 14px;
        }

        td button.btn-primary {
            background-color: #007bff;
            color: white;
        }

        td button.btn-danger {
            background-color: #dc3545;
            color: white;
        }

        td button:hover {
            opacity: 0.9;
            cursor: pointer;
        }

        .empty-message {
            font-size: 18px;
            color: #aaa;
        }

        .table-container {
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            background-color: white;
        }
    </style>
</head>
<body>    
    <%@include file="navbar.jsp" %>

    <c:remove var="errMsg" scope="session"/>
    <c:remove var="succMsg" scope="session"/>
    
    <main>
        <h3 class="text-center">All Books in Store</h3>

        <div class="table-container">
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
                    CategoryDAO catDao = new CategoryDAO();
                    %>

                    <% if (books.isEmpty()) { %>
                        <tr>
                            <td colspan="8" class="empty-message">
                                <p>No books added! So sad 😢</p>
                            </td>
                        </tr>
                    <% } else { 
                        for (Book book : books) { %>
                        <tr>
                            <td><%= book.getBookId() %></td>
                            <td><img src="../book/<%= book.getPhoto() %>" alt="<%= book.getBookName() %>"></td>
                            <td><%= book.getBookName() %></td>
                            <td><%= book.getAuthor() %></td>
                            <td>$<%= book.getPrice() %></td>
                            <td><%= catDao.getCategoryById(book.getCategoryId()).getCategoryName() %></td>
                            <td><%= book.getStatus() %></td>
                            <td>
                                <button onclick="editBook('<%= book.getBookId() %>')" class="btn btn-sm btn-primary">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button onclick="deleteBook(<%= book.getBookId() %>)" class="btn btn-sm btn-danger">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </button>
                            </td>
                        </tr>
                    <% } 
                    } %>
                </tbody>
            </table>
        </div>
    </main>

    <%@include file="footer.jsp" %>
</body>
</html>

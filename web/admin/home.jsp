<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin: Home</title>
        <%@include file="allCss.jsp" %>
        <style>
            a{
                text-decoration: none;
                color: black;
            }

            a:hover {
                text-decoration: none;
                color: black;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container">
            <div class="row p-5">
                <div class="col-md-4">
                    <a href="add_books.jsp">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-plus-square fa-3x text-primary"></i><br>  
                                <h4>Add Books</h4> 
                                --------------
                            </div>
                        </div>
                    </a>
                </div>


                <div class="col-md-4">
                    <a href="all_books.jsp">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-book-open fa-3x text-danger"></i><br>  
                                <h4>All Books</h4> 
                                --------------
                            </div>
                        </div>
                    </a>
                </div>


                <div class="col-md-4">
                    <a href="orders.jsp">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-box-open fa-3x text-warning"></i><br>  
                                <h4>Order</h4>
                                --------------
                            </div>
                        </div> 
                    </a>
                </div>     
            </div>

        </div>
        <div>
        </div>
    </body>
    <%@include file="footer.jsp" %>
</html>

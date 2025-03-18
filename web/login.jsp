<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ebook: Login</title>
        <%@include file="all_component/allCss.jsp" %>
        <style>
            .card {
                height: 60%;
                width: 100%;
                max-width: 400px;
            }
        </style>
    </head>
    <body>
        <%@include file="all_component/navbar.jsp" %>

        <div class="container vh-100 d-flex align-items-center justify-content-center">
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center">Login</h3>

                    <c:if test="${not empty failedMsg}">
                        <div class="text-danger text-center">
                            ${failedMsg}
                        </div>
                        <c:remove var="failedMsg" scope="session" />
                    </c:if>  

                    <form action="login" method="post" id="loginForm">
                        <div class="form-group">
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" required name="email" id="email" value="${email}">
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" required name="password" id="password">
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember Me</label>
                        </div>
                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary w-100">Login</button><br>
                            <a href="register.jsp">Create Account</a>
                        </div>
                    </form> 
                </div>
            </div>  
    </body>
</html>

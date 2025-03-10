<div class="container-fluid" style="height: 10px;background-color: #303f9f"></div>
<%@page import="java.net.URLDecoder" %>
<%@page import="java.nio.charset.StandardCharsets" %>
<%@page import="com.google.gson.Gson" %>
<%@page import="entity.*" %>
<%
    User userobj = (User) session.getAttribute("userobj");

    // If session expired, check cookies
    if (userobj == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_data".equals(cookie.getName())) {
                    String decodedUserJson = URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8);
                    Gson gson = new Gson();
                    userobj = gson.fromJson(decodedUserJson, User.class);
                    
                    // Restore user session
                    if (userobj != null) {
                        session.setAttribute("userobj", userobj);
                    }
                    break;
                }
            }
        }
    }
%>

<div class="container-fluid p-3 bg-light">
    <div class="row"> 
        <div class="col-md-3 text-success"> 
            <h3> <i class="fas fa-book"></i> Ebooks</h3> 
        </div>
        <div class="col-md-6">
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
        <div class="col-md-3">
            <c:if test="${not empty userobj}">
                <a href="cart.jsp" class="btn btn-warning"><i class="fas fa-shopping-cart"></i> Cart</a>
                <a href="#" class ="btn btn-success"><i class="fas fa-user"></i> ${userobj.getName()}</a>
                <a href="#" class="btn btn-primary text-white" data-toggle="modal" data-target="#logoutModal">
                    <i class="fas fa-sign-out-alt"></i> Log Out
                </a>
            </c:if>
            <c:if test="${empty userobj}">
                <a href="login.jsp" class ="btn btn-success"><i class="fas fa-sign-in-alt"></i> Login</a>
                <a href="register.jsp" class ="btn btn-primary text-white"><i class="fas fa-user-plus"></i> Register</a>
            </c:if>
        </div>
    </div>

</div>

<!-- Vertically centered modal -->
<!-- Logout Confirmation Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to log out?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <a href="logout" class="btn btn-primary">Log Out</a>
            </div>
        </div>
    </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
    <a class="navbar-brand" href="index.jsp"><i class="fas fa-home"></i></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" 
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <!-- Categories Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="categoriesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Categories
                </a>
                <div class="dropdown-menu" aria-labelledby="categoriesDropdown">
                    <%-- Fetch categories dynamically in JSP --%>
                    <%
                        // Sample categories list, replace this with database query
                        String[] cats = {"Fiction", "Dystopian", "Classic", "History", "Psychology", "Self-Help"};
                        int i = 0;
                        for (String category : cats) {
                    %>
                    <a class="dropdown-item" href="products.jsp?categoryId=<%= i+1 %>"><%= category %></a>
                    <%
                        i++;
                        }
                    %>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="index.jsp">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="products.jsp">Products</a>
            </li>

        </ul>
    </div>
</nav>



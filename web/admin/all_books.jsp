<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin: All book</title>
<%@include file="allCss.jsp" %>;
    </head>
    <body>
<%@include file="navbar.jsp" %>;
        <h3 class="text-center">Hello Admin</h3>
        
    <c:if test="${not empty succMsg}">
        <h5 class ="text-center text-danger">${succMsg}</h5>
        <c:remove var="succMsg" scope="session" />  
    </c:if>

    <c:if test="${not empty failedMsg}">
        <h5 class ="text-center text-danger">${failedMsg}</h5>
        <c:remove var="failedMsg" scope="session" />  
    </c:if>
    
        
<table class="table table-striped">
  <thead class="bg-primary text-white">
    <tr>
      <th scope="col">Id</th>
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
      BookDAOImpl dao = new BookDAOImpl (DBConnect.getConn());
      List<BookDtls> list =dao.getAllBooks();
      for (bookDtls b :list){
      %>
    <tr>
        <td><%=b.getbookId()%></td>
        <td><img src"" style="width: 50px; height: 50Px;"></td>
      <td><%=b.getBookName()%></td>
      <td><%=b.getAuthor()%></td>
      <td><%=b.getPrice()%></td>
      <td><%=b.getBookCategory()%></td>
      <td><%=b.getStatus()%></td>
      <td><a href="" class="btn btn-sm btn-primary"><<i class="fas fa-edit"></i></i>Edit</a>
          <a href="" class="btn btn-sm btn-danger">Delete</a>
      </td>
      <td>
          <a href="#" class="btn btn-sm btn-primary">Edit</a>
          <a href="#" class="btn btn-sm btn-danger">Delete</a>
      </td>
    </tr>
    <%
      } 
    %> 
    
  </tbody>
</table>
 
 <div>
<%@include file="footer.jsp" %>
</div>
    </body>


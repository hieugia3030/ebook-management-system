<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Error</title>
        <%@include file ="all_component/allCss.jsp"%>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </head>
    <body>
        <%@ include file="all_component/navbar.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card mt-5">
                        <div class="card-body text-center">
                            <h3 class="text-danger">Error</h3>
                            <p>${errMsg}</p>
                            <a onclick="goBack()" class="btn btn-primary">Go Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="all_component/footer.jsp" %>
    </body>
</html>

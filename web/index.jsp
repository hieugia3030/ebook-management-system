<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ebook: Index</title>
        <%@include file ="all_component/allCss.jsp"%>

    </head>
    <body style="background-color: #f7f7f7;">
        <%@include file="all_component/navbar.jsp"%>
        <jsp:include page="all_component/slide_show.jsp" />
        <jsp:include page="all_component/highlights.jsp" />
        <jsp:include page="all_component/categories.jsp" />
        <br>

        <!-- Start Fiction Bookt -->

        <div class="container-fluid">
            <h3 class="text-center">Fiction</h3>
            <div class="row book-list">
                <div class="col-md-3">
                    <div class="card crd-ho">
                        <img src="book/jv2.jpg" alt="Book Cover">
                        <div class="card-body text-center">
                            <p class="book-category">SÁCH TRUYỆN TIẾNG ANH</p>
                            <h5 class="book-title">Building Single Page Applications in .NET Core 3</h5>
                            <p class="book-price">50,000₫</p>
                            <a href="#" class="cart-icon">
                                <i class="fa fa-shopping-cart"></i>
                            </a>
                        </div>
                    </div>    
                </div>

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <img src="book/jv2.jpg" class="card-img-top" alt="Book Cover">
                        <div class="card-body text-center">
                            <p class="book-category">SÁCH TRUYỆN TIẾNG ANH</p>
                            <h5 class="book-title">Building Single Page Applications in .NET Core 3</h5>
                            <p class="book-price">50,000₫</p>
                            <a href="#" class="cart-icon">
                                <i class="fa fa-shopping-cart"></i>
                            </a>
                        </div>
                    </div>    
                </div>   

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <img src="book/jv2.jpg" class="card-img-top" alt="Book Cover">
                        <div class="card-body text-center">
                            <p class="book-category">SÁCH TRUYỆN TIẾNG ANH</p>
                            <h5 class="book-title">Building Single Page Applications in .NET Core 3</h5>
                            <p class="book-price">50,000₫</p>
                            <a href="#" class="cart-icon">
                                <i class="fa fa-shopping-cart"></i>
                            </a>
                        </div>
                    </div>    
                </div>   

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <img src="book/jv2.jpg" class="card-img-top" alt="Book Cover">
                        <div class="card-body text-center">
                            <p class="book-category">SÁCH TRUYỆN TIẾNG ANH</p>
                            <h5 class="book-title">Building Single Page Applications in .NET Core 3</h5>
                            <p class="book-price">50,000₫</p>
                            <a href="#" class="cart-icon">
                                <i class="fa fa-shopping-cart"></i>
                            </a>
                        </div>
                    </div>    
                </div>       
            </div>
            <br>
            <div class="text-center mt-1">
                <a href="" Class="btn btn-danger btn-sm text-white">View ALL</a> 
            </div>          


        </div>
        <!-- End Recent Book -->
        <hr>
        <!-- Start New Book -->

        <div class="container-fluid">
            <h3 class="text-center">Dystopian</h3>
            <div class="row">
                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <div class="img-container">
                                <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            </div>
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-danger btn-sm ml-2">Add Cart</a>
                                <a href="" class="btn btn-success btn-sm ml-2">View Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <div class="img-container">
                                <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            </div>
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-danger btn-sm ml-2">Add Cart</a>
                                <a href="" class="btn btn-success btn-sm ml-2">view Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>   

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <div class="img-container">
                                <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            </div>
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-danger btn-sm ml-2">Add Cart</a>
                                <a href="" class="btn btn-success btn-sm ml-2">view Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>   

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-danger btn-sm ml-2">Add Cart</a>
                                <a href="" class="btn btn-success btn-sm ml-2">view Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>       

            </div>
            <div class="text-center mt-1">
                <a href="" Class="btn btn-danger btn-sm text-white">View ALL</a> 
            </div>          


        </div>
        <!-- End New Book -->
        <hr>
        <!-- Start Old Book -->

        <div class="container-fluid">
            <h3 class="text-center">Classic</h3>
            <div class="row">
                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-success btn-sm ml-5">view Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-success btn-sm ml-5">view Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>   

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-success btn-sm ml-5">view Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>   

                <div class="col-md-3">
                    <div class="card crd-ho">
                        <div class="card-body text-center">
                            <img alt="" src="book/jv2.jpg" style="width: 150px; height: 200px" class="img-thumblin">
                            <p>Java Programing</p>
                            <p>Josh Thompsons</p>
                            <p>Categories:New</p>
                            <div class="row"> 
                                <a href="" class="btn btn-success btn-sm ml-5">view Details</a>
                                <a href="" class="btn btn-danger btn-sm ml-2">299</a>
                            </div>
                        </div>                        
                    </div>    
                </div>       

            </div>
            <div class="text-center mt-1">
                <a href="" Class="btn btn-danger btn-sm text-white">View ALL</a> 
            </div>          


        </div>
        <!-- End Old Book -->




        <%@include file="all_component/footer.jsp" %>
    </body>
</html>

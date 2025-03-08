<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.CategoryDAO" %>
<%@page import="entity.Category" %>
<%@page import="java.util.List" %>

<%
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            /* Book Categories Section */
            .book-categories {
                text-align: center;
                padding: 10px 10vw;
                background-color: #f8f9fa;
            }

            /* Title */
            .book-categories h2 {
                font-size: 24px;
                margin-bottom: 25px;
            }

            /* Category List */
            .category-list {
                display: flex;
                justify-content: space-between;
                gap: 25px;
                flex-wrap: wrap;
            }

            /* Individual Category Item */
            .category-item {
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
                text-align: center;
                width: 180px;
            }

            .category-item img {
                width: 160px;
                height: 200px;
                object-fit: cover;
                border-radius: 8px;
                transition: transform 0.3s;
            }

            .category-item h3 {
                font-size: 14px;
                margin-top: 12px;
                color: #333;
            }

            /* Hover Effects */
            .category-item:hover {
                transform: translateY(-5px);
                box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
            }

            .category-item:hover img {
                transform: scale(1.05);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .category-list {
                    flex-direction: column;
                    align-items: center;
                }

                .category-item {
                    width: 90%;
                }

                .category-item img {
                    width: 100%;
                    height: auto;
                }
            }
        </style>
    </head>
    <body>
        <div class="book-categories">
            <h2>Featured Categories</h2>
            <div class="category-list">
                <% for (Category category : categories) { %>
                    <div class="category-item">
                        <img src="book/<%= category.getImage() %>" alt="<%= category.getCategoryName() %>">
                        <h3><%= category.getCategoryName() %></h3>
                    </div>
                <% } %>
            </div>
        </div>
    </body>
</html>

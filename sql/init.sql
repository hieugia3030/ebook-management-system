use master

CREATE DATABASE EBookDB

USE EBookDB

CREATE TABLE BookCategory (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryName NVARCHAR(100) NOT NULL UNIQUE,
	image NVARCHAR(255),
);

CREATE TABLE Book (
    bookId INT IDENTITY(1,1) PRIMARY KEY,
    bookName NVARCHAR(255) NOT NULL,
    author NVARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    categoryId INT NOT NULL,
    status NVARCHAR(50) NOT NULL,
    photo NVARCHAR(255),
    user_email NVARCHAR(255) NOT NULL,
    FOREIGN KEY (categoryId) REFERENCES BookCategory(categoryId) ON DELETE CASCADE
);

CREATE TABLE [User] (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE Cart (
    cartId INT PRIMARY KEY IDENTITY(1,1),   
    userId INT NOT NULL,                     
    bookId INT NOT NULL,                    
    quantity INT NOT NULL DEFAULT 1,        
    addedAt DATETIME DEFAULT GETDATE(),   
    FOREIGN KEY (userId) REFERENCES [User](id) ON DELETE CASCADE,
    FOREIGN KEY (bookId) REFERENCES Book(bookId) ON DELETE CASCADE
);

INSERT INTO [User] values('Admin', 'admin@gmail.com', 'admin', '0398333162')
DBCC CHECKIDENT ('Book', RESEED, 0);



INSERT INTO BookCategory (categoryName, image) VALUES
('Fiction', 'fiction.jpg'),
('Dystopian', 'dystopian.jpg'),
('Classic', 'classic.jpg'),
('History', 'history.jpg'),
('Psychology', 'psychology.jpg'),
('Self-Help', 'self_help.jpg');


INSERT INTO Book (bookname, author, price, categoryId, status, photo, user_email) 
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 10.99, 1, 'Available', 'gatsby.jpg', 'admin1@example.com'),
('1984', 'George Orwell', 8.99, 2, 'Available', '1984.jpg', 'admin2@example.com'),
('To Kill a Mockingbird', 'Harper Lee', 12.50, 3, 'Available', 'mockingbird.jpg', 'admin1@example.com'),
('The Catcher in the Rye', 'J.D. Salinger', 9.75, 3, 'Available', 'catcher.jpg', 'admin2@example.com'),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 15.99, 4, 'Available', 'sapiens.jpg', 'admin1@example.com'),
('The Alchemist', 'Paulo Coelho', 11.25, 1, 'Available', 'alchemist.jpg', 'admin2@example.com'),
('Thinking, Fast and Slow', 'Daniel Kahneman', 14.49, 5, 'Available', 'thinkingfastslow.jpg', 'admin1@example.com'),
('Atomic Habits', 'James Clear', 13.95, 6, 'Available', 'atomic_habits.jpg', 'admin2@example.com');



INSERT INTO Cart (userId, bookId, quantity) 
VALUES 
(16, 1, 2),  -- 2 copies of "The Great Gatsby"
(16, 3, 1),  -- 1 copy of "To Kill a Mockingbird"
(16, 5, 1),  -- 1 copy of "Sapiens: A Brief History of Humankind"
(16, 7, 3);  -- 3 copies of "Thinking, Fast and Slow"

SELECT * FROM Book

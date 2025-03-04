use master

CREATE DATABASE EBookDB

USE EBookDB

CREATE TABLE Book (
    bookId INT IDENTITY(1,1) PRIMARY KEY,
    bookname NVARCHAR(255) NOT NULL,
    author NVARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    bookCategory NVARCHAR(100) NOT NULL,
    status NVARCHAR(50) NOT NULL,
    photo NVARCHAR(255),
    user_email NVARCHAR(255) NOT NULL
);


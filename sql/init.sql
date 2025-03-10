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
('The Great Gatsby', 'F. Scott Fitzgerald', 10.99, 1, 'Available', 'the_great_gatsby.jpg', 'admin1@example.com'),
('1984', 'George Orwell', 8.99, 2, 'Available', '1984.jpg', 'admin2@example.com'),
('To Kill a Mockingbird', 'Harper Lee', 12.50, 3, 'Available', 'to_kill_a_mockingbird.jpg', 'admin1@example.com'),
('The Catcher in the Rye', 'J.D. Salinger', 9.75, 3, 'Available', 'the_catcher_in_the_rye.jpg', 'admin2@example.com'),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 15.99, 4, 'Available', 'sapiens_a_brief_history_of_humankind.jpg', 'admin1@example.com'),
('The Alchemist', 'Paulo Coelho', 11.25, 1, 'Available', 'the_alchemist.jpg', 'admin2@example.com'),
('Thinking, Fast and Slow', 'Daniel Kahneman', 14.49, 5, 'Available', 'thinking_fast_and_slow.jpg', 'admin1@example.com'),
('Atomic Habits', 'James Clear', 13.95, 6, 'Available', 'atomic_habits.jpg', 'admin2@example.com');



INSERT INTO Cart (userId, bookId, quantity) 
VALUES 
(16, 1, 2),  -- 2 copies of "The Great Gatsby"
(16, 3, 1),  -- 1 copy of "To Kill a Mockingbird"
(16, 5, 1),  -- 1 copy of "Sapiens: A Brief History of Humankind"
(16, 7, 3);  -- 3 copies of "Thinking, Fast and Slow"

SELECT * FROM Book WHERE categoryId in (1,2,3)

INSERT INTO Book (bookname, author, price, categoryId, status, photo, user_email) 
VALUES 
-- Fiction (categoryId = 1)
('Pride and Prejudice', 'Jane Austen', 10.50, 1, 'Available', 'pride_and_prejudice.jpg', 'admin1@example.com'),
('Jane Eyre', 'Charlotte Brontë', 9.99, 1, 'Available', 'jane_eyre.jpg', 'admin2@example.com'),
('The Hobbit', 'J.R.R. Tolkien', 14.25, 1, 'Available', 'the_hobbit.jpg', 'admin1@example.com'),
('Moby-Dick', 'Herman Melville', 13.00, 1, 'Available', 'moby_dick.jpg', 'admin2@example.com'),
('Little Women', 'Louisa May Alcott', 11.75, 1, 'Available', 'little_women.jpg', 'admin1@example.com'),
('The Adventures of Huckleberry Finn', 'Mark Twain', 10.00, 1, 'Available', 'huckleberry_finn.jpg', 'admin2@example.com'),
('The Count of Monte Cristo', 'Alexandre Dumas', 12.50, 1, 'Available', 'count_of_monte_cristo.jpg', 'admin1@example.com'),
('Anna Karenina', 'Leo Tolstoy', 15.25, 1, 'Available', 'anna_karenina.jpg', 'admin2@example.com'),

-- Dystopian (categoryId = 2)
('Brave New World', 'Aldous Huxley', 12.99, 2, 'Available', 'brave_new_world.jpg', 'admin1@example.com'),
('Fahrenheit 451', 'Ray Bradbury', 11.50, 2, 'Available', 'fahrenheit_451.jpg', 'admin2@example.com'),
('The Handmaid''s Tale', 'Margaret Atwood', 10.99, 2, 'Available', 'handmaids_tale.jpg', 'admin1@example.com'),
('We', 'Yevgeny Zamyatin', 13.75, 2, 'Available', 'we.jpg', 'admin2@example.com'),
('The Giver', 'Lois Lowry', 9.25, 2, 'Available', 'the_giver.jpg', 'admin1@example.com'),
('Oryx and Crake', 'Margaret Atwood', 12.00, 2, 'Available', 'oryx_and_crake.jpg', 'admin2@example.com'),
('Children of Men', 'P.D. James', 14.50, 2, 'Available', 'children_of_men.jpg', 'admin1@example.com'),
('Snow Crash', 'Neal Stephenson', 13.25, 2, 'Available', 'snow_crash.jpg', 'admin2@example.com'),

-- Classic (categoryId = 3)
('Crime and Punishment', 'Fyodor Dostoevsky', 14.99, 3, 'Available', 'crime_and_punishment.jpg', 'admin1@example.com'),
('War and Peace', 'Leo Tolstoy', 18.99, 3, 'Available', 'war_and_peace.jpg', 'admin2@example.com'),
('Great Expectations', 'Charles Dickens', 11.25, 3, 'Available', 'great_expectations.jpg', 'admin1@example.com'),
('Wuthering Heights', 'Emily Brontë', 12.50, 3, 'Available', 'wuthering_heights.jpg', 'admin2@example.com'),
('The Picture of Dorian Gray', 'Oscar Wilde', 10.75, 3, 'Available', 'dorian_gray.jpg', 'admin1@example.com'),
('Les Misérables', 'Victor Hugo', 17.25, 3, 'Available', 'les_miserables.jpg', 'admin2@example.com'),
('Dracula', 'Bram Stoker', 9.99, 3, 'Available', 'dracula.jpg', 'admin1@example.com'),
('Frankenstein', 'Mary Shelley', 8.50, 3, 'Available', 'frankenstein.jpg', 'admin2@example.com'),

-- History (categoryId = 4)
('Guns, Germs, and Steel', 'Jared Diamond', 16.50, 4, 'Available', 'guns_germs_steel.jpg', 'admin1@example.com'),
('The Wright Brothers', 'David McCullough', 14.25, 4, 'Available', 'wright_brothers.jpg', 'admin2@example.com'),
('The Silk Roads', 'Peter Frankopan', 18.75, 4, 'Available', 'silk_roads.jpg', 'admin1@example.com'),
('1776', 'David McCullough', 15.99, 4, 'Available', '1776.jpg', 'admin2@example.com'),
('A People''s History of the United States', 'Howard Zinn', 16.25, 4, 'Available', 'peoples_history.jpg', 'admin1@example.com'),
('The Diary of a Young Girl', 'Anne Frank', 9.99, 4, 'Available', 'anne_frank_diary.jpg', 'admin2@example.com'),
('The Rise and Fall of the Third Reich', 'William L. Shirer', 19.99, 4, 'Available', 'third_reich.jpg', 'admin1@example.com'),
('The Romanovs', 'Simon Sebag Montefiore', 17.50, 4, 'Available', 'romanovs.jpg', 'admin2@example.com'),

-- Psychology (categoryId = 5)
('The Power of Habit', 'Charles Duhigg', 12.99, 5, 'Available', 'power_of_habit.jpg', 'admin1@example.com'),
('Influence: The Psychology of Persuasion', 'Robert Cialdini', 14.75, 5, 'Available', 'influence.jpg', 'admin2@example.com'),
('Mindset: The New Psychology of Success', 'Carol S. Dweck', 13.50, 5, 'Available', 'mindset.jpg', 'admin1@example.com'),
('Predictably Irrational', 'Dan Ariely', 15.00, 5, 'Available', 'predictably_irrational.jpg', 'admin2@example.com'),
('Thinking in Bets', 'Annie Duke', 12.25, 5, 'Available', 'thinking_in_bets.jpg', 'admin1@example.com'),
('The Paradox of Choice', 'Barry Schwartz', 11.99, 5, 'Available', 'paradox_of_choice.jpg', 'admin2@example.com'),
('The Social Animal', 'Elliot Aronson', 13.99, 5, 'Available', 'social_animal.jpg', 'admin1@example.com'),
('Grit', 'Angela Duckworth', 14.50, 5, 'Available', 'grit.jpg', 'admin2@example.com'),

-- Self-Help (categoryId = 6)
('The 7 Habits of Highly Effective People', 'Stephen R. Covey', 14.99, 6, 'Available', '7_habits.jpg', 'admin1@example.com'),
('Dare to Lead', 'Brené Brown', 15.25, 6, 'Available', 'dare_to_lead.jpg', 'admin2@example.com'),
('Awaken the Giant Within', 'Tony Robbins', 16.50, 6, 'Available', 'awaken_the_giant_within.jpg', 'admin1@example.com'),
('The Subtle Art of Not Giving a F*ck', 'Mark Manson', 12.75, 6, 'Available', 'subtle_art.jpg', 'admin2@example.com'),
('You Are a Badass', 'Jen Sincero', 11.99, 6, 'Available', 'you_are_a_badass.jpg', 'admin1@example.com'),
('Make Your Bed', 'William H. McRaven', 10.50, 6, 'Available', 'make_your_bed.jpg', 'admin2@example.com'),
('Essentialism: The Disciplined Pursuit of Less', 'Greg McKeown', 13.75, 6, 'Available', 'essentialism.jpg', 'admin1@example.com'),
('Atomic Habits', 'James Clear', 13.95, 6, 'Available', 'atomic_habits.jpg', 'admin2@example.com');

SELECT TOP 3 * FROM (SELECT * FROM Book WHERE categoryId = 1) AS a
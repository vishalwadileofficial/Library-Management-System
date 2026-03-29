CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Table: Admin (for login)
CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- In a real app, use hashing!
    name VARCHAR(100) NOT NULL
);

-- Table: Books
CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    quantity INT NOT NULL DEFAULT 1,
    available INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Students
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    branch VARCHAR(50),
    year INT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Issue Records
CREATE TABLE IF NOT EXISTS issue_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    student_id INT,
    issue_date DATE NOT NULL,
    return_date DATE, -- Expected return date
    actual_return_date DATE, -- When it was actually returned
    status ENUM('ISSUED', 'RETURNED') DEFAULT 'ISSUED',
    fine DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Sample Data: Admin
INSERT INTO admin (username, password, name) VALUES ('admin', 'admin123', 'Library Admin');

-- Sample Data: Books
INSERT INTO books (title, author, category, quantity, available) VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 5, 5),
('Clean Code', 'Robert C. Martin', 'Programming', 3, 3),
('Introduction to Java', 'Daniel Liang', 'Education', 10, 10),
('Data Structures and Algorithms', 'Narasimha Karumanchi', 'Computer Science', 4, 4),
('The Alchemist', 'Paulo Coelho', 'Fiction', 6, 6);

-- Sample Data: Students
INSERT INTO students (name, email, branch, year) VALUES 
('John Doe', 'john@example.com', 'CS', 3),
('Jane Smith', 'jane@example.com', 'IT', 2),
('Mike Johnson', 'mike@example.com', 'ECE', 4);

-- Sample Data: Issue Records (History)
-- Assuming some books were issued and returned previously
INSERT INTO issue_records (book_id, student_id, issue_date, return_date, actual_return_date, status, fine) VALUES
(2, 1, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 13 DAY), DATE_SUB(CURDATE(), INTERVAL 12 DAY), 'RETURNED', 0.00),
(1, 2, DATE_SUB(CURDATE(), INTERVAL 10 DAY), DATE_SUB(CURDATE(), INTERVAL 3 DAY), NULL, 'ISSUED', 0.00); 
-- Note for the second record: It's still issued and overdue if today is > return_date (7 days loan period usually).  

CREATE DATABASE IF NOT EXISTS loan_management;
USE loan_management;

-- 1. Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Customer', 'Employee') NOT NULL
);

-- 2. Loans Table
CREATE TABLE Loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    user_id INT,
    loan_type VARCHAR(50) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    status ENUM('Approved', 'Pending', 'Rejected') NOT NULL,
    application_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 3. Activity Log Table
CREATE TABLE ActivityLog (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_text VARCHAR(255) NOT NULL,
    activity_date DATE NOT NULL,
    status_color ENUM('GREEN', 'AMBER', 'RED') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Insert Users (Password is '1234' for everyone)
INSERT INTO Users (name, email, password, role) VALUES
('Rahul Sharma', 'rahul@example.com', '1234', 'Customer'),
('Priya Patel', 'priya@example.com', '1234', 'Customer'),
('Amit Kumar', 'amit@example.com', '1234', 'Customer'),
('Sneha Desai', 'sneha@example.com', '1234', 'Customer'),
('Vikram Singh', 'vikram@example.com', '1234', 'Customer'),
('Sammer Rawal', 'admin', '1234', 'Employee'),
('Aaditya Chahal', 'aaditya.admin@example.com', '1234', 'Employee');

-- Insert Loans
-- Note: User ID 1 is Rahul Sharma, User ID 2 is Priya Patel, etc.
INSERT INTO Loans (loan_id, user_id, loan_type, amount, status, application_date) VALUES
('L001', 1, 'Home Loan', 5000000.00, 'Approved', '2026-01-15'),
('L002', 1, 'Personal Loan', 50000.00, 'Pending', '2026-04-01'),
('L003', 2, 'Education Loan', 200000.00, 'Approved', '2026-03-15'),
('L004', 3, 'Business Loan', 1000000.00, 'Rejected', '2026-02-20'),
('L005', 4, 'Home Loan', 800000.00, 'Approved', '2026-01-10');

-- Insert Activity Log for Rahul Sharma (user_id 1)
INSERT INTO ActivityLog (user_id, activity_text, activity_date, status_color) VALUES
(1, 'Loan Application Submitted', '2026-04-01', 'AMBER'),
(1, 'EMI Payment Successful', '2026-04-01', 'GREEN'),
(1, 'EMI Payment Successful', '2026-03-01', 'GREEN'),
(1, 'Loan Approved', '2026-01-20', 'GREEN');

-- Create database
CREATE DATABASE IF NOT EXISTS PetShopDB;
USE PetShopDB;

-- Users table with extended customer information
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    birthday DATE,
    address TEXT,
    email VARCHAR(100),
    phone VARCHAR(15),
    role ENUM('admin', 'customer') NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_username UNIQUE (username),
    CONSTRAINT uk_email UNIQUE (email)
);

-- Pets table
CREATE TABLE Pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    type VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    age INT CHECK (age >= 0),
    gender ENUM('Male', 'Female') NOT NULL,
    description TEXT,
    image LONGBLOB,
    added_by VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (added_by) REFERENCES Users(username) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

-- Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'processing', 'completed', 'cancelled') DEFAULT 'pending',
    shipping_address TEXT NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_name) REFERENCES Users(username)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Order Details table
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    pet_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_time DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id)
        ON DELETE NO ACTION
);

-- Initial admin users
INSERT INTO Users (username, password, role, full_name, email) VALUES 
    ('tus', '123', 'admin', 'Admin Tus', 'tus@admin.com'),
    ('sang', '321', 'admin', 'Admin Sang', 'sang@admin.com');
    
UPDATE Users
SET full_name = 'Admin Son'
WHERE username = 'son';

-- Grant permissions
GRANT ALL PRIVILEGES ON PetShopDB.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

-- Drop statements (if needed)
DROP TABLE OrderDetails;
DROP TABLE Orders;
DROP TABLE Pets;
DROP TABLE Users;
DROP DATABASE PetShopDB;

INSERT INTO Pets (
    name, price, type, breed, age, gender, description, image, added_by
)
VALUES (
    'Luna', 220.00, 'Cat', 'Persian', 2, 'Female', 'Calm and fluffy.', NULL, 'tus'
);

ALTER TABLE users MODIFY password VARCHAR(255) NULL;
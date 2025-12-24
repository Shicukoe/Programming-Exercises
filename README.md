# Pet Shop Management System

## Overview

The Pet Shop Management System is a Java Servlet/JSP web application designed to support core operations of a pet shop through a lightweight e-commerce workflow. The system enables role-based user authentication, pet catalog management, shopping cart functionality, checkout processing, and administrative order management. The project follows Object-Oriented Programming (OOP) principles and a layered architecture suitable for academic evaluation and technical interviews.

## Authors

* Nguyễn Thanh Sơn – 10422072
* Nguyễn Thanh Tú – 10422080
* Võ Tấn Sang – 10422114

Lecturer: Ralf-Oliver Mevius

## Project Repository

[https://github.com/Shicukoe/Programming-Exercises.git](https://github.com/Shicukoe/Programming-Exercises.git)

---

## Key Features

### Pet Management

* Create, update, and delete pet records
* Search pets by ID, type, or breed
* Manage pricing and availability

### User Management

* User registration and authentication
* Role-based access control (admin, customer)
* Profile information stored per user

### Shopping & Orders

* Session-based shopping cart
* Checkout and order persistence
* Administrative order status management

---

## System Architecture

The application follows a layered architecture:

* **Controller Layer**: Servlet-based request handling and routing
* **Service / DAO Layer**: Business logic and database access
* **Mapper Layer**: Result set mapping to domain models
* **Model Layer**: Domain entities (User, Pet, Order, OrderDetail)

The project is built and packaged using Maven and deployed as a WAR file to Apache Tomcat.

---

## Database Schema

The system uses a relational database with the following tables:

### Users

* `user_id` (INT, PK, AUTO_INCREMENT)
* `username` (VARCHAR, UNIQUE, NOT NULL)
* `password` (VARCHAR, NOT NULL)
* `full_name` (VARCHAR)
* `birthday` (DATE)
* `address` (TEXT)
* `email` (VARCHAR, UNIQUE)
* `phone` (VARCHAR)
* `role` (ENUM: admin, customer)
* `created_at` (TIMESTAMP)

### Pets

* `pet_id` (INT, PK, AUTO_INCREMENT)
* `name` (VARCHAR, NOT NULL)
* `price` (DECIMAL)
* `type` (VARCHAR)
* `breed` (VARCHAR)
* `age` (INT)
* `gender` (ENUM: Male, Female)
* `description` (TEXT)
* `image` (LONGBLOB)
* `added_by` (FK → Users.username)
* `created_at` (TIMESTAMP)

### Orders

* `order_id` (INT, PK, AUTO_INCREMENT)
* `customer_name` (VARCHAR)
* `full_name` (VARCHAR)
* `shipping_address` (TEXT)
* `phone` (VARCHAR)
* `email` (VARCHAR)
* `total_amount` (DECIMAL)
* `order_date` (TIMESTAMP)
* `status` (ENUM: pending, processing, completed, cancelled)

### OrderDetails

* `order_detail_id` (INT, PK, AUTO_INCREMENT)
* `order_id` (FK → Orders.order_id)
* `pet_id` (FK → Pets.pet_id)
* `quantity` (INT)
* `price_at_time` (DECIMAL)

---

## Build and Deployment

### Prerequisites

* Java JDK 8 or later
* Apache Maven 3.6+
* Apache Tomcat 11.0.7
* MySQL-compatible database server

### Database Setup

1. Create a database and import the SQL script:

   * `database/newdatabasepet.sql`
2. Verify that all tables and initial user records are created successfully.

### Application Configuration

* Update JDBC connection settings in the DAO configuration files to match your local database credentials.

### Build

```bash
mvn clean package
```

The generated WAR file will be located in the `target/` directory.

### Deployment

1. Copy the WAR file to the Tomcat `webapps/` directory.
2. Start Apache Tomcat.
3. Access the application via:

   * `http://localhost:8080/first-app-1.0`

---

## Default Access (Demo)

The database includes sample users for demonstration and testing purposes:

* Admin users: `tus / 123`, `sang / 321`

These credentials are intended solely for academic demonstration.

---

## Testing

* Manual integration testing performed via browser and database inspection
* Order creation validated to ensure correct insertion of order and order detail records

---

## Strengths and Limitations

### Strengths

* Clear separation of concerns using a layered architecture
* Practical implementation of e-commerce workflows
* Maven-based build and WAR deployment suitable for enterprise environments

### Limitations

* No automated unit or integration tests
* Passwords stored in plain text for demonstration purposes
* Limited input validation and security hardening

---

## Future Enhancements

* Implement password hashing (e.g., BCrypt)
* Add input validation and CSRF protection
* Introduce RESTful APIs and a modern frontend
* Add automated testing and CI/CD pipeline

---

## Key Source Files

* Controllers: `LoginController.java`, `CartController.java`
* DAO implementations: `UserDAO.java`, `OrderDAO.java`
* Database schema: `database/newdatabasepet.sql`

---

## CV-Ready Summary

* Developed a Java Servlet/JSP-based pet shop e-commerce application with role-based authentication, shopping cart, and order management.
* Applied DAO and layered architectural patterns with Maven-based build and WAR deployment on Apache Tomcat.
* Technologies: Java, Servlets, JSP, JSTL, Maven, Tomcat, MySQL.

---

This project was developed as part of a university coursework assignment and is intended for academic demonstration and portfolio presentation.

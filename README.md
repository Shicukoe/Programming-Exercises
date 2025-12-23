# Pet Shop Management System

## Overview

The Pet Shop Management System is a full-stack Java web application developed as a course project to demonstrate core web application development skills. The system supports user authentication, role-based access control, pet (product) management, shopping cart functionality, checkout, and order management. The project emphasizes backend development, database design, and server-side business logic following standard web application architecture.

---

## Team Members

* Nguyễn Thanh Tú – 10422080
* Nguyễn Thanh Sơn – 10422072
* Võ Tấn Sang – 10422114

All source code and collaboration were managed using GitHub.

---

## Abstract

This project presents the design and implementation of a Java-based web application for pet shop management. The system applies classical web application principles using Java Servlets, JSP, JDBC, and a relational database. Core functionalities include user authentication, role-based authorization, product (pet) management, shopping cart handling, and order processing. The application is packaged as a WAR file and deployed on Apache Tomcat, demonstrating practical knowledge of backend web development, server-side state management, and database-driven workflows.

---

## Technical Architecture

* **Backend**: Java Servlets, JSP
* **Architecture Pattern**: MVC + DAO
* **Database**: MySQL (relational)
* **Build Tool**: Maven
* **Deployment**: Apache Tomcat (WAR deployment)

The application follows a layered structure:

* Controller layer for request handling
* DAO layer for database access using JDBC
* Model layer for domain entities

---

## Core Backend Features

* User authentication and authorization
* Role-based access control for admin and customer
* CRUD operations for pet (product) management
* Session-based shopping cart
* Order creation with order-detail persistence
* MySQL relational data handling with foreign keys

---

## System Diagram and Request Flow

### System Architecture Overview

The application follows a classic Java web application architecture deployed on Apache Tomcat:

```
Client (Browser)
      |
      |  HTTP Requests / Responses
      v
Servlet Controllers (MVC - Controller Layer)
      |
      |  Business Logic Invocation
      v
DAO Layer (JDBC)
      |
      |  SQL Queries
      v
MySQL Database
```

### Request Flow Description

1. The client sends an HTTP request (e.g., login, add to cart, checkout).
2. A corresponding **Servlet Controller** handles the request and validates input.
3. The controller invokes **DAO classes** to perform database operations using JDBC.
4. DAO classes execute SQL queries and map results to model objects.
5. The controller processes business logic and forwards the response to JSP views.
6. The JSP renders dynamic content and returns the response to the client.

This flow ensures clear separation between presentation, business logic, and data access.

---

## Database Design

### Entity Relationship Overview

The database is designed using a normalized relational model with clear relationships between entities.

### Tables

#### Users

| Column     | Type      | Description                         |
| ---------- | --------- | ----------------------------------- |
| user_id    | INT (PK)  | Unique user identifier              |
| username   | VARCHAR   | Login username (unique)             |
| password   | VARCHAR   | User password (plain text for demo) |
| full_name  | VARCHAR   | Full name                           |
| birthday   | DATE      | Date of birth                       |
| address    | TEXT      | Address                             |
| email      | VARCHAR   | Email address                       |
| phone      | VARCHAR   | Phone number                        |
| role       | ENUM      | User role (admin, customer)         |
| created_at | TIMESTAMP | Account creation time               |

#### Pets

| Column      | Type         | Description    |
| ----------- | ------------ | -------------- |
| pet_id      | INT (PK)     | Pet identifier |
| name        | VARCHAR      | Pet name       |
| price       | DECIMAL      | Pet price      |
| type        | VARCHAR      | Pet type       |
| breed       | VARCHAR      | Pet breed      |
| age         | INT          | Pet age        |
| gender      | ENUM         | Male / Female  |
| description | TEXT         | Description    |
| image       | LONGBLOB     | Pet image      |
| added_by    | VARCHAR (FK) | Added by user  |
| created_at  | TIMESTAMP    | Created time   |

#### Orders

| Column           | Type      | Description      |
| ---------------- | --------- | ---------------- |
| order_id         | INT (PK)  | Order identifier |
| customer_name    | VARCHAR   | Username         |
| full_name        | VARCHAR   | Snapshot name    |
| shipping_address | TEXT      | Shipping address |
| phone            | VARCHAR   | Contact phone    |
| email            | VARCHAR   | Contact email    |
| total_amount     | DECIMAL   | Total price      |
| order_date       | TIMESTAMP | Order time       |
| status           | ENUM      | Order status     |

#### OrderDetails

| Column          | Type     | Description       |
| --------------- | -------- | ----------------- |
| order_detail_id | INT (PK) | Order detail ID   |
| order_id        | INT (FK) | Related order     |
| pet_id          | INT (FK) | Related pet       |
| quantity        | INT      | Quantity          |
| price_at_time   | DECIMAL  | Price at purchase |

Relationships:

* One User → Many Orders
* One Order → Many OrderDetails
* One Pet → Many OrderDetails

---

## Deployment and Setup

### Prerequisites

* Java JDK 8 or later
* Apache Maven
* Apache Tomcat 11.x
* MySQL database server

### Database Setup

1. Create a MySQL database.
2. Import the SQL schema from `database/newdatabasepet.sql`.
3. Verify that required tables (`Users`, `Pets`, `Orders`, `OrderDetails`) are created.

### Application Configuration

* Update JDBC connection details (URL, username, password) in the DAO configuration file to match local database credentials.

### Build and Deployment (Tomcat)

```bash
mvn clean package
```

1. Copy the generated WAR file from the `target/` directory to Tomcat’s `webapps/` folder.
2. Start Apache Tomcat.
3. Access the application at:
   `http://localhost:8080/first-app-1.0`

---

## Technologies Used

**Backend**

* Java
* Servlets
* JSP
* JDBC
* Maven
* Apache Tomcat

**Database**

* MySQL

---



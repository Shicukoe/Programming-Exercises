# Pet Shop Management System

## Overview

The Pet Shop Management System is a full-stack Java web application developed as a course project to demonstrate core web application development skills. The system supports user authentication, role-based access control, pet (product) management, shopping cart functionality, checkout, and order management. The project emphasizes backend development, database design, and server-side business logic following standard web application architecture.

---

## Team Members

* Nguyễn Thanh Tú – Team Leader, Backend Developer
* Nguyễn Thanh Sơn – Frontend / Support
* Võ Tấn Sang – Backend / Support

All source code and collaboration were managed using GitHub.

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

## My Responsibilities (Team Leader & Backend Focus)

As the **team leader and primary backend developer**, my responsibilities included:

* Designing the **overall backend architecture** and project structure
* Designing the **relational database schema** and implementing SQL tables
* Implementing **JDBC-based DAO classes** for users, pets, orders, and order details
* Developing **Servlet controllers** for authentication, cart handling, and order processing
* Implementing **role-based access control** (admin / customer)
* Handling **session management** for login state and shopping cart
* Implementing **business logic** for checkout and order persistence
* Coordinating team work and managing source code via GitHub

---

## Core Backend Features

* User authentication and authorization
* Role-based access control for admin and customer
* CRUD operations for pet (product) management
* Session-based shopping cart
* Order creation with order-detail persistence
* MySQL relational data handling with foreign keys

---

## Database Design

* Normalized relational schema
* Foreign key constraints between Users, Pets, Orders, and OrderDetails
* Cascading rules for order-item relationships

The database was designed to ensure data consistency and support transactional order workflows.

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




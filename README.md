# **Pet Shop Management System**

## **Overview**
The Pet Shop Management System is a web application designed to streamline and simplify the operations of a pet shop. It allows administrators to manage pets and staff efficiently while adhering to Object-Oriented Programming (OOP) principles such as encapsulation, inheritance, and polymorphism.

### **Key Features**
- **Pet Management**:
  - Add, edit, and delete pet information.
  - Search pets by ID or other attributes like type and breed.
- **User Management**:
  - Add, edit, or remove user accounts.
  - Role-based access control for administrators and staff.
- **Additional Functionalities**:
  - Generate to-do lists for staff.
  - Secure login system for users with roles.

---

## **Authors**
- Nguyễn Thanh Sơn – 10422072
- Nguyễn Thanh Tú – 10422080
- Trần Sĩ Nguyên – 10422057
- Võ Tấn Sang – 10422114

Lecturer: **Dr. Tran Hong Ngoc**

---

## **Report**
For a detailed explanation of the system's design, implementation, and evaluation, please refer to our comprehensive project report:  
[**Download the Report**](./Our%20Report%20for%20the%20Project.docx)

---
## **System Requirements**
1. **Java Development Kit (JDK)**: Version 8 or later.
2. **Apache Tomcat**: Version 8.5 or later.
3. **Maven**: Version 3.6 or later.
4. **Oracle Database**: Tested with Oracle 12c or later.
5. **Web Browser**: Modern browser like Chrome or Firefox.

---

## **Project Structure**
The project follows a layered architecture with the following packages:
- `com.petshop.controllers`: Handles incoming HTTP requests and interacts with the services.
- `com.petshop.models`: Contains entity classes that represent database tables.
- `com.petshop.services`: Implements business logic and interacts with the DAO layer.
- `com.petshop.dao`: Manages database CRUD operations.
- `com.petshop.mapper`: Maps database records to Java objects and vice versa.

---

## **Database Schema**
### **Users Table**
Stores information about the system users (e.g., admins, staff).
| Column Name | Data Type       | Description                         |
|-------------|-----------------|-------------------------------------|
| id          | INT (PK)        | Unique identifier for each user     |
| name        | VARCHAR(100)    | Full name of the user               |
| password    | VARCHAR(100)    | User password                       |
| role        | VARCHAR(20)    | Role of the user (Admin/Customer) |

### **Pets Table**
Stores information about the pets available for sale or adoption.
| Column Name | Data Type       | Description                         |
|-------------|-----------------|-------------------------------------|
| id          | INT (PK)        | Unique identifier for each pet      |
| name        | VARCHAR(100)    | Name of the pet                     |
| price       | DECIMAL(10,2)   | Price of the pet                    |
| type        | VARCHAR(50)     | Type of pet (e.g., Dog, Cat)        |
| breed       | VARCHAR(100)    | Breed of the pet                    |
| age         | INT             | Age of the pet in months            |
| gender      | ENUM ('Male', 'Female') | Gender of the pet               |
| description | VARCHAR(255)    | Description or notes about the pet  |
| added_by    | VARCHAR(100)    | User who added the pet              |

---
## **Building, Deploying, and Testing**

### **1. Building the Project**
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/first-app-1.0.git
    cd first-app-1.0
    ```
2. Build the project using Maven:
    ```bash
    mvn clean package
    ```
3. Locate the generated WAR file in the `target/` directory:
    ```
    target/first-app-1.0.war
    ```

---

### **2. Deploying the Application**
1. Copy the WAR file to the `webapps` folder of your Apache Tomcat server:
    ```bash
    cp target/first-app-1.0.war /path/to/tomcat/webapps/ (for example mine is : "C:\Users\Admin\Downloads\apache-tomcat-8.5.34")
    We will leave the zip file of apache tomcat above. You should download and extract that file to use
    ```
2. Start the Tomcat server:
    ```bash
    # On Windows
    C:\path\to\tomcat\bin\startup.bat


    # On Linux/Mac
    ./path/to/tomcat/bin/startup.sh
    ```
3. Verify deployment:
    - Open your web browser and navigate to:
      ```
      http://localhost:8080/first-app-1.0
      ```

---

### **3. Testing the Application**
1. **Login Functionality**:
    - Go to the login page and log in with the default admin credentials:
      - **Username**: tus
      - **Password**: 123
        **OR**
      - **Username**: sang
      - **Password**: 321
2. **Pet Management**:
    - Add a pet with details such as name, type, breed, and price.
    - Edit an existing pet’s information.
    - Delete a pet record.
3. **User Management**:
    - Add new users with roles (Admin or Staff).
    - Edit user roles or delete users.
4. **Database Validation**:
    - Use an SQL client (e.g., SQL Developer) to verify that changes are reflected in the database.

---

## **Troubleshooting**

 **Build Failures**:
   - Run the following commands to clean and rebuild the project:
     ```bash
     mvn clean
     mvn package
     ```
---
## **Demo**
The Demo of our project:
- To be more obvious, the demo which share the information about how to open server and to demonstrate the work of our project will be marked here: https://www.youtube.com/watch?v=eJ0_qB9Sbig&t=6s

---

## **Assessment**
### Strengths:
- Well-organized project structure using OOP principles.
- Modular codebase for scalability and maintainability.
- User-friendly interface for managing pets and users.

### Areas for Improvement:
- Enhance mobile compatibility of the interface.
- Add advanced search filters for pets.

---

## **License**
This project is licensed under the MIT License.

---

## **Contact**
For further inquiries, contact:
- Nguyễn Thanh Sơn – 10422072
- Nguyễn Thanh Tú – 10422080
- Trần Sĩ Nguyên – 10422057
- Võ Tấn Sang – 10422114

Binh Duong, WS2024

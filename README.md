# Library Management System using SQL Project --P2

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

![Library_Project](https://github.com/Ujwal0712/Library_System_management_p2/blob/main/library.jpg)

## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup
![ERD](https://github.com/Ujwal0712/Library_System_management_p2/blob/main/library_erd.png)

- **Database Creation**: Created a database named `library_db`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
create database Librabry_Project2;
use Librabry_Project2;

DROP TABLE IF EXISTS branch;
CREATE TABLE branch(
	branch_id varchar(10) primary key,	
    manager_id varchar(10),	
    branch_address varchar(50),
	contact_no varchar(20)
);


-- Create table "Employee"
DDROP TABLE IF EXISTS employee;
CREATE TABLE employee(
	emp_id varchar(10) primary key,
	emp_name varchar(20),
	position varchar(20),
	salary int,
	branch_id varchar(10)
);


-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members(
	member_id varchar(10)primary key,
	member_name	varchar(20),
    member_address varchar(75),
    reg_date date
    );

-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books (
    isbn VARCHAR(20) PRIMARY KEY,
    book_title VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    rental_price decimal(10,2),
    status VARCHAR(20),
    author VARCHAR(100),
    publisher VARCHAR(100)
);



-- Create table "IssueStatus"
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employee(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn));




-- Create table "ReturnStatus"
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)

            );

```

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

```
**Task 2: Update an Existing Member's Address**

```sql
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
DELETE FROM issued_status
WHERE issued_id = 'IS121';

```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

```


**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
select
	issued_emp_id,
    count(issued_id) as total_book_issued
    from issued_status
    group by 1
    having count(issued_id)>1;
    
```

### 3. CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

```sql
 create table Book_cnts
 as
SELECT 
    b.isbn,
    b.book_title,
    COUNT(ist.issued_id) as no_issued
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1, 2;
```


### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Specific Category**:

```sql
SELECT * FROM books
WHERE category = 'Classic';

```

8. **Task 8: Find Total Rental Income by Category**:

```sql
select 
            category,
	sum(rental_price) as total_rental_income,
    count(*)
from books
group by 1;

```

9. **List Members Who Registered in the Last 180 Days**:
```sql
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL 180 day;
```

10. **List Employees with Their Branch Manager's Name and their branch details**:

```sql
SELECT 
    e1.*,
    b.manager_id,
    e2.emp_name as manager
FROM employee as e1
JOIN  
branch as b
ON b.branch_id = e1.branch_id
JOIN
employee as e2
ON b.manager_id = e2.emp_id;

```

Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql
CCREATE TABLE books_price_greater_than_seven
AS    
SELECT * FROM Books
WHERE rental_price > 7;

select * from books_price_greater_than_seven;
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
SELECT 
    DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;
```
## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
   git clone https://github.com/Ujwal0712/Library_System_management_p2.git
   ```
2. **Set Up the Database**: Execute the SQL scripts in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `analysis_queries.sql` file to perform the analysis.
4. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/ujwal-mendhe-0652b62ba/)
- **Github**: [Connect with me professionally](https://github.com/Ujwal0712)

Thank you for your support, and I look forward to connecting with you!



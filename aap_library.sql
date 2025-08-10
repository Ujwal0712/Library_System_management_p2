-- librabry Management System project 2
-- Creating Branch Table
create database Librabry_Project2;
use Librabry_Project2;

DROP TABLE IF EXISTS branch;
CREATE TABLE branch(
	branch_id varchar(10) primary key,	
    manager_id varchar(10),	
    branch_address varchar(50),
	contact_no varchar(10)
);
DROP TABLE IF EXISTS employee;
CREATE TABLE employee(
	emp_id varchar(10) primary key,
	emp_name varchar(20),
	position varchar(20),
	salary int,
	branch_id varchar(10)
);

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

DROP TABLE IF EXISTS members;
CREATE TABLE members(
	member_id varchar(10)primary key,
	member_name	varchar(20),
    member_address varchar(75),
    reg_date date
    );
   
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
            
Alter table employee
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);

Alter table return_status
add constraint fk_issued_status
foreign key (issued_id)
references issued_status(issued_id);

	
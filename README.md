🏊 Swimming Club Management System — DBMS Project
1. Introduction

This repository implements a Database Management System (DBMS) for managing the operations of a Swimming Club.
It provides structured storage, relationships, and queries for handling swimmers, guardians, instructors, staff, pools, courses, competitions, suppliers, and billing.

The project demonstrates:

Conceptual design via ER Diagram.

Logical schema with primary/foreign keys.

Physical implementation using MySQL with scripts to create, populate, and query the database.

2. Repository Structure
.
├── docs/
│   ├── ER_Diagram.drawio.png         # ER Diagram (conceptual model)
│   ├── Relational_Schema.docx        # Relational schema (tables, attributes, constraints)
│   ├── Metadata_Tables.xlsx          # Metadata (domains, types, keys, etc.)
│   ├── PKs_and_FKs.xlsx              # Primary and foreign key definitions
│   ├── Relationships_and_Degree.xlsx # Cardinalities & degree of relationships
├── sql/
│   ├── create_tables.sql             # MySQL CREATE TABLE statements with constraints
│   ├── insert_data.sql               # Sample data insertion (FK-consistent order)
│   ├── queries.sql                   # Example queries (joins, reports, analytics)
├── .gitignore                        # Ignore temporary/unnecessary files
└── README.md                         # Project documentation

3. Database Design

Conceptual Model: ER Diagram created in Draw.io.

Logical Model: Tables normalized with PKs, FKs, and constraints.

Physical Model: Implemented in MySQL with create_tables.sql.

Key entities:

Swimmer (Kid, Adult subtypes)

Guardian (linked to kids)

Instructor & Staff (employees)

Course & Pool (scheduling and capacity management)

Competition (adults participation & awards)

Supplier & Product (orders, supplies, bills)

Developer & Contract (pool maintenance, warranties)

4. SQL Scripts
4.1 create_tables.sql

Creates all tables with PK/FK constraints.

Uses InnoDB engine for referential integrity.

4.2 insert_data.sql

Inserts demo data for testing queries.

Populates employees, swimmers, guardians, courses, suppliers, etc.

4.3 queries.sql

Contains example queries such as:

List all swimmers with their courses and instructors.

Find guardians of each kid.

Get adults linked to charities.

Show competitions and winners.

Generate billing and supplier reports.

5. Setup & Installation
5.1 Install MySQL

Download MySQL Community Installer
.

Install MySQL Server + Workbench.

Configure a root password during setup.

5.2 Create Database
CREATE DATABASE swimming_club CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE swimming_club;

5.3 Run Scripts

Run sql/create_tables.sql to create schema.

Run sql/insert_data.sql to load sample data.

Test queries from sql/queries.sql.

6. Example Outputs
Example: Swimmers with their courses & instructors
SELECT
  s.Swimmer_ID, s.Swimmer_FName, s.Swimmer_LName,
  c.Course_ID, cs.Course_Day, cs.Course_Time,
  e.E_F_Name AS Instructor_FName, e.E_L_Name AS Instructor_LName
FROM COURSE_SCHEDULE cs
JOIN SWIMMER s ON s.Swimmer_ID = cs.Swimmer_ID
JOIN COURSE c ON c.Course_ID = cs.Course_ID
JOIN INSTRUCTOR i ON i.I_E_ID = c.I_E_ID
JOIN EMPLOYEE e ON e.E_ID = i.I_E_ID;

7. Tech Stack

Database: MySQL 8.x

Modeling Tool: Draw.io

Documentation: Word, Excel

SQL Editor: MySQL Workbench

8. Results

All constraints validated (PK, FK, domain, cardinality).

Sample data successfully inserted with no FK violations.

Queries return meaningful reports (swimmers, guardians, competitions, billing).

9. Reproducibility

Clone this repository.

Open MySQL Workbench and connect to your server.

Run the SQL scripts in order:

create_tables.sql

insert_data.sql

queries.sql

10. License

This project is for academic and learning purposes only.

11. Acknowledgments

University DBMS coursework inspiration.

MySQL documentation for syntax reference.

Draw.io for ER diagramming.

Swimming Club Management System (DBMS Project)

This project is a Database Management System (DBMS) designed to manage the operations of a Swimming Club.
It covers swimmers, courses, instructors, staff, competitions, suppliers, billing, and maintenance schedules.

📌 Features

ER Diagram and Relational Schema

Normalized tables with Primary Keys (PKs) and Foreign Keys (FKs)

Metadata documentation (attributes, domains, constraints)

SQL Scripts:

create_tables.sql → defines schema with constraints

insert_data.sql → sample dataset

queries.sql → example queries (joins, aggregations, constraints check)

🗂️ Repository Structure
DBMS-Swimming-Club-Management/
│── README.md
│── .gitignore
│── docs/
│   ├── ER_Diagram.drawio.png
│   ├── Relational_Schema.docx
│   ├── Metadata_Tables.xlsx
│   ├── PKs_and_FKs.xlsx
│   ├── Relationships_and_Degree.xlsx
│── sql/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── queries.sql

🖼️ ER Diagram

⚙️ Installation & Setup
1. Install MySQL

Download MySQL Community Installer
.

Install MySQL Server + Workbench.

Set a root password during installation.

2. Create Database
CREATE DATABASE swimming_club CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE swimming_club;

3. Run Scripts

In MySQL Workbench:

Open and run sql/create_tables.sql

Open and run sql/insert_data.sql

Test queries in sql/queries.sql

📝 Example Queries

List all swimmers with their courses, instructors, and pools.

Find guardians of each kid swimmer.

Get adults associated with charities.

Check competitions and awards.

Generate billing and supplier reports.

👩‍💻 Tech Stack

Database: MySQL

Tools: MySQL Workbench, Draw.io

Documentation: Word, Excel, PNG

📜 License

This project is for academic and learning purposes only.

/* ===========================
   Swimming Club DB (MySQL)
   ===========================
   Engine: InnoDB (FK support)
   Charset: utf8mb4
*/

SET NAMES utf8mb4;
SET time_zone = '+00:00';
SET FOREIGN_KEY_CHECKS = 0;

/* -------- Drop in reverse dependency order -------- */
DROP TABLE IF EXISTS WARRANTY;
DROP TABLE IF EXISTS CONTRACT;
DROP TABLE IF EXISTS MAINTENANCE_SCHEDULE;
DROP TABLE IF EXISTS BILL;
DROP TABLE IF EXISTS ORDER_DETAILS;
DROP TABLE IF EXISTS `ORDER`;
DROP TABLE IF EXISTS SUPPLY_SCHEDULE;
DROP TABLE IF EXISTS SUPPLIER;
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS COMPETITION_SCHEDULE;
DROP TABLE IF EXISTS COMPETITION;
DROP TABLE IF EXISTS SWIMMER_CHARITY_IDF;
DROP TABLE IF EXISTS CHARITY;
DROP TABLE IF EXISTS MANAGER;
DROP TABLE IF EXISTS NEIGHBOURHOOD;
DROP TABLE IF EXISTS SWIMMER_GUARDIAN;
DROP TABLE IF EXISTS GUARDIAN_INFO;
DROP TABLE IF EXISTS COURSE_SCHEDULE;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS POOL;
DROP TABLE IF EXISTS DEVELOPER;
DROP TABLE IF EXISTS STAFF;
DROP TABLE IF EXISTS INSTRUCTOR;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS ADULT;
DROP TABLE IF EXISTS KIDS;
DROP TABLE IF EXISTS SWIMMER;

SET FOREIGN_KEY_CHECKS = 1;

/* =======================
   Core reference tables
   ======================= */

CREATE TABLE EMPLOYEE (
  E_ID            INT PRIMARY KEY,
  E_F_Name        VARCHAR(50) NOT NULL,
  E_L_Name        VARCHAR(50) NOT NULL,
  E_Primary_Contact VARCHAR(30),
  E_Type          ENUM('Instructor','Staff') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE INSTRUCTOR (
  I_E_ID          INT PRIMARY KEY,
  Coaching_Certificate VARCHAR(100),
  Classes_Taught  INT DEFAULT 0,
  CONSTRAINT fk_instructor_employee
    FOREIGN KEY (I_E_ID) REFERENCES EMPLOYEE(E_ID)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE STAFF (
  S_E_ID          INT PRIMARY KEY,
  Num_Pool_Assigned INT DEFAULT 0,
  Bill_Processed  INT DEFAULT 0,
  CONSTRAINT fk_staff_employee
    FOREIGN KEY (S_E_ID) REFERENCES EMPLOYEE(E_ID)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE DEVELOPER (
  Developer_Name          VARCHAR(80) PRIMARY KEY,
  Developer_Primary_Contact VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Pool / Course
   ======================= */

CREATE TABLE POOL (
  Pool_Number     INT PRIMARY KEY,
  Pool_Capacity   INT NOT NULL,
  Pool_Condition  VARCHAR(40),
  Pool_Feature    VARCHAR(100),
  Developer_Name  VARCHAR(80),
  CONSTRAINT fk_pool_developer
    FOREIGN KEY (Developer_Name) REFERENCES DEVELOPER(Developer_Name)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE COURSE (
  Course_ID       INT PRIMARY KEY,
  I_E_ID          INT NOT NULL,
  Course_Capacity INT NOT NULL,
  Pool_Number     INT NOT NULL,
  CONSTRAINT fk_course_instructor
    FOREIGN KEY (I_E_ID) REFERENCES INSTRUCTOR(I_E_ID)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_course_pool
    FOREIGN KEY (Pool_Number) REFERENCES POOL(Pool_Number)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Swimmers & subtypes
   ======================= */

CREATE TABLE SWIMMER (
  Swimmer_ID      INT PRIMARY KEY,
  Swimmer_FName   VARCHAR(50) NOT NULL,
  Swimmer_LName   VARCHAR(50) NOT NULL,
  Swimmer_Age     INT NOT NULL,
  Reference_ID    VARCHAR(30),
  Swimmer_Type    ENUM('Kid','Adult') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Subtype tables: PK is also FK to SWIMMER (inheritance)
CREATE TABLE KIDS (
  K_ID INT PRIMARY KEY,
  CONSTRAINT fk_kids_swimmer
    FOREIGN KEY (K_ID) REFERENCES SWIMMER(Swimmer_ID)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ADULT (
  A_ID INT PRIMARY KEY,
  CONSTRAINT fk_adult_swimmer
    FOREIGN KEY (A_ID) REFERENCES SWIMMER(Swimmer_ID)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Guardian & relationships
   ======================= */

CREATE TABLE GUARDIAN_INFO (
  Guardian_ID       INT PRIMARY KEY,
  Guardian1_F_Name  VARCHAR(50),
  Guardian1_L_Name  VARCHAR(50),
  Guardian2_F_Name  VARCHAR(50),
  Guardian2_L_Name  VARCHAR(50),
  `Guardian1_Phone#` VARCHAR(20),
  `Guardian2_Phone#` VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE SWIMMER_GUARDIAN (
  K_ID        INT,
  Guardian_ID INT,
  PRIMARY KEY (K_ID, Guardian_ID),
  CONSTRAINT fk_swimmer_guardian_kid
    FOREIGN KEY (K_ID) REFERENCES KIDS(K_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_swimmer_guardian_guardian
    FOREIGN KEY (Guardian_ID) REFERENCES GUARDIAN_INFO(Guardian_ID)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Scheduling
   ======================= */

CREATE TABLE COURSE_SCHEDULE (
  Course_ID   INT,
  Swimmer_ID  INT,
  Course_Day  ENUM('Mon','Tue','Wed','Thu','Fri','Sat','Sun') NOT NULL,
  Course_Time TIME NOT NULL,
  PRIMARY KEY (Course_ID, Swimmer_ID, Course_Day, Course_Time),
  CONSTRAINT fk_cs_course
    FOREIGN KEY (Course_ID) REFERENCES COURSE(Course_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_cs_swimmer
    FOREIGN KEY (Swimmer_ID) REFERENCES SWIMMER(Swimmer_ID)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Charity / neighbourhood / manager
   ======================= */

CREATE TABLE NEIGHBOURHOOD (
  Neighbourhood VARCHAR(80) PRIMARY KEY,
  Approx_neighb_population INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE MANAGER (
  Manager_ID   INT PRIMARY KEY,
  Manager_Name VARCHAR(80),
  Manager_Email VARCHAR(80)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE CHARITY (
  Charity_Name           VARCHAR(80) PRIMARY KEY,
  Charity_Contact_Number VARCHAR(30),
  Neighbourhood          VARCHAR(80),
  Manager_ID             INT,
  CONSTRAINT fk_charity_neighbourhood
    FOREIGN KEY (Neighbourhood) REFERENCES NEIGHBOURHOOD(Neighbourhood)
      ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_charity_manager
    FOREIGN KEY (Manager_ID) REFERENCES MANAGER(Manager_ID)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE SWIMMER_CHARITY_IDF (
  A_ID        INT,
  Charity_Name VARCHAR(80),
  PRIMARY KEY (A_ID, Charity_Name),
  CONSTRAINT fk_sc_adult
    FOREIGN KEY (A_ID) REFERENCES ADULT(A_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_sc_charity
    FOREIGN KEY (Charity_Name) REFERENCES CHARITY(Charity_Name)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Competition
   ======================= */

CREATE TABLE COMPETITION (
  Competition_Name  VARCHAR(120) PRIMARY KEY,
  Competition_Award VARCHAR(120)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE COMPETITION_SCHEDULE (
  Competition_Name VARCHAR(120),
  A_ID             INT,
  PRIMARY KEY (Competition_Name, A_ID),
  CONSTRAINT fk_compsched_comp
    FOREIGN KEY (Competition_Name) REFERENCES COMPETITION(Competition_Name)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_compsched_adult
    FOREIGN KEY (A_ID) REFERENCES ADULT(A_ID)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Product / Supplier / Orders / Billing
   ======================= */

CREATE TABLE PRODUCT (
  Product_Number INT PRIMARY KEY,
  Product_Name   VARCHAR(120) NOT NULL,
  Product_Price  DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE SUPPLIER (
  Supplier_Name          VARCHAR(120) PRIMARY KEY,
  Supplier_Primary_Contact VARCHAR(50),
  Supplier_Speciality    VARCHAR(120)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE SUPPLY_SCHEDULE (
  Supplier_Name VARCHAR(120),
  Supply_Date   DATE,
  Product_Number INT,
  PRIMARY KEY (Supplier_Name, Supply_Date, Product_Number),
  CONSTRAINT fk_supsch_supplier
    FOREIGN KEY (Supplier_Name) REFERENCES SUPPLIER(Supplier_Name)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_supsch_product
    FOREIGN KEY (Product_Number) REFERENCES PRODUCT(Product_Number)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ORDER` (
  Order_Number  INT PRIMARY KEY,
  Order_Date    DATE NOT NULL,
  S_E_ID        INT NOT NULL,
  CONSTRAINT fk_order_staff
    FOREIGN KEY (S_E_ID) REFERENCES STAFF(S_E_ID)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ORDER_DETAILS (
  Order_Number  INT,
  Product_Number INT,
  Order_Quantity INT NOT NULL CHECK (Order_Quantity > 0),
  PRIMARY KEY (Order_Number, Product_Number),
  CONSTRAINT fk_od_order
    FOREIGN KEY (Order_Number) REFERENCES `ORDER`(Order_Number)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_od_product
    FOREIGN KEY (Product_Number) REFERENCES PRODUCT(Product_Number)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE BILL (
  Bill_Number  INT PRIMARY KEY,
  Bill_Amount  DECIMAL(10,2) NOT NULL,
  Supplier_Name VARCHAR(120) NOT NULL,
  CONSTRAINT fk_bill_supplier
    FOREIGN KEY (Supplier_Name) REFERENCES SUPPLIER(Supplier_Name)
      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Maintenance
   ======================= */

CREATE TABLE MAINTENANCE_SCHEDULE (
  Pool_Number INT,
  S_E_ID      INT,
  PRIMARY KEY (Pool_Number, S_E_ID),
  CONSTRAINT fk_ms_pool
    FOREIGN KEY (Pool_Number) REFERENCES POOL(Pool_Number)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ms_staff
    FOREIGN KEY (S_E_ID) REFERENCES STAFF(S_E_ID)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =======================
   Contracts / Warranty
   ======================= */

CREATE TABLE CONTRACT (
  Developer_Name VARCHAR(80),
  Contract_Number INT PRIMARY KEY,
  Contract_Warranty VARCHAR(120),
  CONSTRAINT fk_contract_developer
    FOREIGN KEY (Developer_Name) REFERENCES DEVELOPER(Developer_Name)
      ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE WARRANTY (
  Contract_Number INT PRIMARY KEY,
  Warranty_Items  VARCHAR(200),
  CONSTRAINT fk_warranty_contract
    FOREIGN KEY (Contract_Number) REFERENCES CONTRACT(Contract_Number)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

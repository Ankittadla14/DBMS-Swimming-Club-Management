/* Minimal demo data respecting FK order */

-- Employees
INSERT INTO EMPLOYEE VALUES
  (101,'Isha','Patel','+1-555-111','Instructor'),
  (102,'Mark','Lee','+1-555-222','Instructor'),
  (201,'Sara','Ng','+1-555-333','Staff'),
  (202,'Jon','Cruz','+1-555-444','Staff');

INSERT INTO INSTRUCTOR VALUES
  (101,'Level-2 Coach',10),
  (102,'Level-1 Coach',4);

INSERT INTO STAFF VALUES
  (201,2,15),
  (202,1,7);

-- Developer
INSERT INTO DEVELOPER VALUES
  ('BlueWave Constructions','bluewave@example.com');

-- Pools
INSERT INTO POOL VALUES
  (1,40,'Good','Indoor Heated','BlueWave Constructions'),
  (2,25,'Excellent','Outdoor','BlueWave Constructions');

-- Courses
INSERT INTO COURSE VALUES
  (5001,101,20,1),
  (5002,102,15,2);

-- Swimmers
INSERT INTO SWIMMER VALUES
  (1,'Aarav','Shah',10,NULL,'Kid'),
  (2,'Mia','Rodriguez',12,NULL,'Kid'),
  (3,'Liam','Kim',27,NULL,'Adult'),
  (4,'Sophia','Bose',31,NULL,'Adult');

INSERT INTO KIDS VALUES (1),(2);
INSERT INTO ADULT VALUES (3),(4);

-- Guardians
INSERT INTO GUARDIAN_INFO VALUES
  (9001,'Ravi','Shah','Priya','Shah','+1-555-888','+1-555-889'),
  (9002,'Carlos','Rodriguez',NULL,NULL,'+1-555-777',NULL);

INSERT INTO SWIMMER_GUARDIAN VALUES
  (1,9001),
  (2,9002);

-- Neighbourhood / Manager / Charity
INSERT INTO NEIGHBOURHOOD VALUES
  ('North District', 32000);

INSERT INTO MANAGER VALUES
  (3001,'Helen Park','helen@charities.org');

INSERT INTO CHARITY VALUES
  ('WaterForAll','+1-555-123','North District',3001);

INSERT INTO SWIMMER_CHARITY_IDF VALUES
  (3,'WaterForAll'),
  (4,'WaterForAll');

-- Competition
INSERT INTO COMPETITION VALUES
  ('City Swim 2025','Gold Medal'),
  ('Spring Sprint','Trophy');

INSERT INTO COMPETITION_SCHEDULE VALUES
  ('City Swim 2025',3),
  ('Spring Sprint',4);

-- Course schedule
INSERT INTO COURSE_SCHEDULE VALUES
  (5001,1,'Mon','16:00:00'),
  (5001,2,'Wed','16:00:00'),
  (5002,3,'Tue','18:00:00');

-- Products / Suppliers / Supplies
INSERT INTO PRODUCT VALUES
  (7001,'Goggles',12.50),
  (7002,'Swim Cap',7.99);

INSERT INTO SUPPLIER VALUES
  ('AquaSupplies','+1-555-909','Accessories'),
  ('PoolWorld','+1-555-808','Equipment');

INSERT INTO SUPPLY_SCHEDULE VALUES
  ('AquaSupplies','2025-08-01',7001),
  ('AquaSupplies','2025-08-01',7002),
  ('PoolWorld','2025-08-05',7002);

-- Orders / Order Details
INSERT INTO `ORDER` VALUES
  (80001,'2025-08-15',201);

INSERT INTO ORDER_DETAILS VALUES
  (80001,7001,10),
  (80001,7002,20);

-- Bills
INSERT INTO BILL VALUES
  (85001,325.00,'AquaSupplies');

-- Maintenance
INSERT INTO MAINTENANCE_SCHEDULE VALUES
  (1,201),
  (2,202);

-- Contracts / Warranty
INSERT INTO CONTRACT VALUES
  ('BlueWave Constructions',60001,'2 years structural');
INSERT INTO WARRANTY VALUES
  (60001,'Tiles, pumps, heaters');

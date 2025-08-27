/* Example analytical/use-case queries */

/* 1) List all swimmers with their scheduled courses, instructor, pool */
SELECT
  s.Swimmer_ID, s.Swimmer_FName, s.Swimmer_LName, s.Swimmer_Type,
  cs.Course_Day, cs.Course_Time,
  c.Course_ID, i.I_E_ID AS Instructor_ID, e.E_F_Name AS Instructor_FName, e.E_L_Name AS Instructor_LName,
  p.Pool_Number, p.Pool_Feature
FROM COURSE_SCHEDULE cs
JOIN SWIMMER s       ON s.Swimmer_ID = cs.Swimmer_ID
JOIN COURSE c        ON c.Course_ID = cs.Course_ID
JOIN INSTRUCTOR i    ON i.I_E_ID = c.I_E_ID
JOIN EMPLOYEE e      ON e.E_ID = i.I_E_ID
JOIN POOL p          ON p.Pool_Number = c.Pool_Number
ORDER BY cs.Course_Day, cs.Course_Time;

/* 2) Guardians of each kid */
SELECT
  k.K_ID AS Kid_ID, s.Swimmer_FName, s.Swimmer_LName,
  g.Guardian_ID, g.Guardian1_F_Name, g.Guardian1_L_Name, g.`Guardian1_Phone#`
FROM KIDS k
JOIN SWIMMER s ON s.Swimmer_ID = k.K_ID
LEFT JOIN SWIMMER_GUARDIAN sg ON sg.K_ID = k.K_ID
LEFT JOIN GUARDIAN_INFO g ON g.Guardian_ID = sg.Guardian_ID
ORDER BY k.K_ID;

/* 3) Adults and their charities */
SELECT
  a.A_ID, sw.Swimmer_FName, sw.Swimmer_LName,
  sc.Charity_Name, c.Charity_Contact_Number, c.Neighbourhood
FROM ADULT a
JOIN SWIMMER sw ON sw.Swimmer_ID = a.A_ID
LEFT JOIN SWIMMER_CHARITY_IDF sc ON sc.A_ID = a.A_ID
LEFT JOIN CHARITY c ON c.Charity_Name = sc.Charity_Name;

/* 4) Instructors teaching more than N classes */
SELECT
  i.I_E_ID, e.E_F_Name, e.E_L_Name, i.Classes_Taught
FROM INSTRUCTOR i
JOIN EMPLOYEE e ON e.E_ID = i.I_E_ID
WHERE i.Classes_Taught > 5;

/* 5) Order with items and total */
SELECT
  o.Order_Number, o.Order_Date, e.E_F_Name AS Staff_First, e.E_L_Name AS Staff_Last,
  od.Product_Number, p.Product_Name, od.Order_Quantity, (od.Order_Quantity * p.Product_Price) AS Line_Total
FROM `ORDER` o
JOIN STAFF st ON st.S_E_ID = o.S_E_ID
JOIN EMPLOYEE e ON e.E_ID = st.S_E_ID
JOIN ORDER_DETAILS od ON od.Order_Number = o.Order_Number
JOIN PRODUCT p ON p.Product_Number = od.Product_Number
ORDER BY o.Order_Number;

/* 6) Pools and their developers */
SELECT
  p.Pool_Number, p.Pool_Capacity, p.Pool_Condition, d.Developer_Name, d.Developer_Primary_Contact
FROM POOL p
LEFT JOIN DEVELOPER d ON d.Developer_Name = p.Developer_Name;

/* 7) Maintenance assignments per staff */
SELECT
  ms.Pool_Number, ms.S_E_ID, e.E_F_Name, e.E_L_Name
FROM MAINTENANCE_SCHEDULE ms
JOIN EMPLOYEE e ON e.E_ID = ms.S_E_ID
ORDER BY ms.Pool_Number, ms.S_E_ID;

/* 8) Competitions per adult swimmer */
SELECT
  cs.Competition_Name, sw.Swimmer_FName, sw.Swimmer_LName
FROM COMPETITION_SCHEDULE cs
JOIN ADULT a ON a.A_ID = cs.A_ID
JOIN SWIMMER sw ON sw.Swimmer_ID = a.A_ID
ORDER BY cs.Competition_Name;

/* 9) Supplier bills */
SELECT
  b.Bill_Number, b.Bill_Amount, b.Supplier_Name
FROM BILL b
ORDER BY b.Bill_Number;

/* 10) Stock supplied on a date */
SELECT
  s.Supplier_Name, ss.Supply_Date, p.Product_Name, p.Product_Number
FROM SUPPLY_SCHEDULE ss
JOIN SUPPLIER s ON s.Supplier_Name = ss.Supplier_Name
JOIN PRODUCT p ON p.Product_Number = ss.Product_Number
WHERE ss.Supply_Date BETWEEN '2025-08-01' AND '2025-08-31';

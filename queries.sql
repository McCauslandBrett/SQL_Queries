-- lab 6 refernece syntax
-- • Find the total number of parts supplied by each supplier.
SELECT COUNT(C.pid), C.sid
FROM Catalog C
GROUP BY C.sid;

-- -- • Find the total number of parts supplied by each supplier who
-- -- supplies at least 3 parts.
--
SELECT COUNT(C.pid),S.sid,S.sname
FROM Suppliers S, Catalog C
WHERE S.sid = C.sid
GROUP BY S.sid
HAVING COUNT(C.pid) >= 3;
--  -- For every supplier that supplies only green parts,
--   -- print the name of the supplier and the total number of
--   -- parts that he supplies.
SELECT COUNT(C.pid),S.sid,S.sname
FROM Suppliers S, Catalog C
WHERE S.sid = C.sid
and S.sid = C.sid
and S.sid NOT IN (
          SELECT S2.sid
          FROM Suppliers S2, Parts P2, Catalog C2
          WHERE S2.sid = C2.sid
          and P2.pid = C2.pid
          and P2.Color != 'Green')
GROUP BY S.sid;



-- -- For every supplier that supplies green part and red part,
-- -- print the name of the supplier and the price of
-- -- the most expensive part that he supplies.
SELECT Suppliers.sname, MAX(Catalog.cost)
FROM Suppliers, Catalog, Parts
WHERE Parts.pid = Catalog.pid
and Suppliers.sid = Catalog.sid
and Suppliers.sid
    IN(SELECT Suppliers.sid
       FROM Suppliers, Parts , Catalog
       WHERE Suppliers.sid = Catalog.sid
       and Parts.pid = Catalog.pid
       and Parts.color = 'Red')
and Suppliers.sid
     IN(SELECT Suppliers.sid
        FROM Suppliers,Parts,Catalog
        WHERE Suppliers.sid = Catalog.sid
        and Parts.pid=Catalog.pid
        and Parts.color = 'Green')
Group BY Suppliers.sname;


-- ################ Assumption Dept has dname: string ###################################################
-- Emp(eid: integer, ename: string, age: integer, salary: real)
-- Works(eid: integer, did: integer, pc_time: integer)
-- Dept(did: integer, budget: real, managerid: integer,dname: string)
-- ###################################################################
-- 1. Print the names and ages of each employee who works
 -- in both the Hardware department and the Software department.
SELECT Emp.ename,Emp.age
FROM Emp , Works , Dept
WHERE Emp.eid = Works.eid
  and Works.did = Dept.did
  and Dept.dname = "Software"
  and Emp.eid IN (
      SELECT Emp.eid
      FROM Emp , Works , Dept
      WHERE Emp.eid = Works.eid
      and Works.did = Dept.did
      and Dept.dname = "Hardware");

-- 2. For each department with more than 20
-- full-time-equivalent employees
-- (i.e., where the part~time and full-time employees add up to at least that
-- many full-time employees), print the did together with the number
-- of employees that work in that department.
SELECT Works.did, count(Works.eid) AS fullTimeEmp
FROM Works
GROUP BY Works.did
HAVING 20 <= (SELECT SUM(Works.pc_time) FROM Works WHERE Works.did = Works.did);

-- 3. Print the name of each employee whose salary
-- exceeds the budget of all of the departments that
-- he or she works in.
SELECT Emp.ename
FROM Emp, Works, Dept
WHERE Emp.eid = Works.eid
and Works.did = Dept.did
and Emp.salary >= (
  SELECT MAX(Dept.budget)
  FROM Dept
  WHERE Dept.did = Dept.did
) ;

-- 4. Find the managerids of managers who manage only departments
-- with budgets greater than $1 million.
SELECT Dept.managerid
FROM Dept
WHERE 1000000 <= (SELECT Dept.budget
                  FROM Dept
                  WHERE Dept.managerid = Dept.managerid
                  );

-- ################ Assumption Dept has dname: string ###################################################
-- Emp(eid: integer, ename: string, age: integer, salary: real)
-- Works(eid: integer, did: integer, pc_time: integer)
-- Dept(did: integer, budget: real, managerid: integer,dname: string)
-- ###################################################################

-- 5. Find the enames of managers who manage the departments
 -- with the largest budgets.
 SELECT Emp.ename
 FROM Emp, Works, Dept
 WHERE Emp.eid = Works.eid
 and Works.did = Dept.did
 and Emp.salary >= (
   SELECT MAX(Dept.budget)
   FROM Dept
   WHERE Dept.did = Dept.did
 ) ;
-- 6. If a manager manages more than one department, he or she
-- controls the sum of all the budgets for those departments.
-- Find the managerids of managers who control more than $5 million.
SELECT Dept.managerid
FROM Dept
GROUP BY Dept.managerid
HAVING SUM (Dept.budget) >= 5000000;

-- ################ Assumption Dept has dname: string ###################################################
-- Emp(eid: integer, ename: string, age: integer, salary: real)
-- Works(eid: integer, did: integer, pc_time: integer)
-- Dept(did: integer, budget: real, managerid: integer,dname: string)
-- ###################################################################

-- 7. Find the managerids of managers who control the largest amounts.
SELECT Dept.managerid
FROM (SELECT DISTINCT Dept.managerid, SUM(Dept.budget) AS deptvalue FROM Dept GROUP BY Dept.managerid) AS managersums
WHERE managersums.managerid IN (MAX(managersums.deptvalue));
-- 8. Find the enames of managers who manage only departments with
-- budgets larger than
-- $1 million, but at least one department with budget less than $5 million.

SELECT Emp.ename
FROM Emp , Dept
WHERE Emp.eid = Dept.managerid
and Dept.budget>=1000000
and Dept.budget<5000000;
-- **********  *************



-- Problem 2: Consider a database with the following relations:
-- ###################################################################
-- employee (employee-name, street, city)
-- works (employee-name, company-name, salary) company (company-name, city)
-- manages (employee-name, manager-name)
-- ###################################################################
-- Write the following queries in SQL:

-- a. Find the name, street address and cities of residence of all employees who work for First Bank Corporation
-- and earn more than $10,000
SELECT employee.employee-name, employee.street, employee.city
FROM employee, works
WHERE employee.employee-name = works.employee-name
and company-name = 'First Bank Corporation'
and salary > 10000;
-- b. Find all employees in the database who live in the same
-- cities and on the same streets as do their managers
SELECT emp.employee-name
FROM employee emp, employee mang, manages m
WHERE emp.employee-name = m.employee-name
and m.manager-name = mang.employee-name
and emp.city = mang.city
and emp.street = mang.street ;

-- c. Find all employees in the database who do not work for
-- First Bank Corporation
SELECT employee-name
FROM works
WHERE NOT (company-name = 'First Bank Corporation');
-- d. Find all employees who earn more than average
-- salary of all employees of their company
SELECT employee-name
FROM works O
WHERE salary > (SELECT avg(salary)
                FROM works I
                WHERE O.company-name = I.company-name
              );

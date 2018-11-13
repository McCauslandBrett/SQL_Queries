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
Group BY Suppliers.sname


-- ###################################################################
-- Emp(eid: integer, ename: string, age: integer, salary: real)
-- Works(eid: integer, did: integer, pet_time: integer)
-- Dept(did.· integer, budget: real, managerid: integer)
-- ###################################################################
-- 1. Print the names and ages of each employee who works
 -- in both the Hardware department and the Software department.
SELECT Emp.ename,Emp.age
FROM Emp , Works
WHERE S.sid = C.sid

-- 2. For each department with more than 20
-- full-time-equivalent employees
-- (i.e., where the part~time and full-time employees add up to at least that
-- many full-time employees), print the did together with the number
-- of employees that work in that department.



-- 3. Print the name of each employee whose salary
-- exceeds the budget of all of the depart- ments that
-- he or she works in.

-- 4. Find the managerids of managers who manage only departments
-- with budgets greater than $1 million.

-- 5. Find the enames of managers who manage the departments
 -- with the largest budgets.

-- 6. If a manager manages more than one department, he or she
-- controls the sum of all the budgets for those departments.
-- Find the managerids of managers who control more than $5 million.

-- 7. Find the managerids of managers who control the largest amounts.


-- 8. Find the enames of managers who manage only departments with
-- budgets larger than
-- $1 million, but at least one department with budget less than $5 million.

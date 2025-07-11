
-- create a temp table to get max salary
-- pick the max salary from Employee table which is not in temp table

select max(salary) as SecondHighestSalary
from Employee
where salary not in
    (select max(salary)
    from Employee)
  
-----------------------------------------------------------------------------------------------------------

-- write a query to get offset 1 salary(skip first row)
-- but this won't give 'null' as answer
-- so write a simple select, and select that
  
  select(
        select distinct salary SecondHighestSalary
        from Employee 
        order by salary desc 
        limit 1 offset 1
    )  as SecondHighestSalary


-- amaazon- 2
-- adobe- 2
-- microsoft- 2
-- accencture- 2
-- google- 4
-- oracle- 3
-- tcs- 3
-- infosys- 2
-- yahoo- 2
-- apple- 2
-- mckinsey- 2
-- amdocs- 2

-- Using dense rank
    
SELECT DISTINCT salary AS SecondHighestSalary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) ranked
WHERE rnk = 2;

--using self join

SELECT MAX(e1.salary) AS SecondHighestSalary
FROM Employee e1
JOIN (SELECT MAX(salary) AS max_salary FROM Employee) e2
ON e1.salary < e2.max_salary;


--using CTE

WITH RankedSalaries AS (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
)
SELECT salary AS SecondHighestSalary
FROM RankedSalaries
WHERE rnk = 2
LIMIT 1;

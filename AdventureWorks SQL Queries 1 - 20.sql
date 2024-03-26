USE AdventureWorks; 

/* 1. Write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. 
Sort the result set in ascending order on jobtitle.*/ 

SELECT * FROM HumanResources.Employee 
ORDER BY JobTitle ASC 
GO

/* Write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database.
Sort the output in ascending order on lastname.*/

SELECT e.*  
FROM person.person AS e  
ORDER BY LastName
GO 

/* 3. Write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) 
from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. 
Arranged the output in ascending order by lastname.*/

SELECT FirstName, LastName, BusinessEntityID AS Empolyee_ID
FROM Person.Person
ORDER BY LastName ASC; 

/* 4. Write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. 
Return productid, productnumber, and name. Arranged the output in ascending order on name.*/ 

SELECT ProductID, ProductNumber, Name
FROM Production.Product
WHERE SellStartDate IS NOT NULL AND ProductLine='T'
ORDER BY NAME; 

/* 5. Write a query in SQL to return all rows from the salesorderheader table in Adventureworks database 
and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, 
percentage of tax column. Arranged the result set in ascending order on subtotal.*/ 

SELECT SalesOrderID, CustomerID, OrderDate, SubTotal, (TaxAmt/SubTotal)*100 AS TaxPercent
FROM Sales.SalesOrderHeader
ORDER BY SubTotal ASC; 

/* 6. Write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. 
Return jobtitle column and arranged the resultset in ascending order.*/

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle ASC; 

/* 7. Write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. 
Sort the output in ascending order on customerid.*/ 

SELECT CustomerID, SUM(Freight) AS TotalFreight
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID ASC; 

/* 8. Write a query in SQL to find the average and the sum of the subtotal for every customer. 
Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. 
Sort the result on customerid column in descending order.*/

SELECT CustomerID, SalesPersonID, AVG(SubTotal) AS AvgSubTotal, SUM(SubTotal) AS TotalSubTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC; 

/* 9. Write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. 
Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order*/ 

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
WHERE ShelF IN ('A', 'C', 'H')
GROUP BY ProductID 
HAVING SUM(Quantity) > 500
ORDER BY ProductID ASC; 

-- 10. Write a query in SQL to find the total quentity for a group of locationid multiplied by 10.

SELECT SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY (LocationID*10); 

/* 11. write a query in SQL to find the persons whose last name starts with letter 'L'. 
Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.*/ 

SELECT p.BusinessEntityID, FirstName, LastName, PhoneNumber
FROM Person.PersonPhone AS pp
JOIN Person.Person as p
ON pp.BusinessEntityID=p.BusinessEntityID
WHERE LastName LIKE 'L%'
ORDER BY LastName, FirstName; 

/* 12. Write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. 
Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.*/

SELECT SalesPersonID, CustomerID, SUM(SubTotal) AS TotalSubTotal
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (SalesPersonID, CustomerID); 

/* 13. Write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. 
Return locationid, shelf and sum of quantity as TotalQuantity.*/

SELECT LocationID, Shelf, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY CUBE(LocationID, Shelf); 

/* 14. Write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. 
Return locationid, shelf and sum of quantity as TotalQuantity.*/

SELECT LocationID, Shelf, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY GROUPING SETS(ROLLUP(LocationID, Shelf), CUBE(LocationID, Shelf));

/* 15. Write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
Return locationid and total quantity. Group the results on locationid.*/ 

SELECT LocationID, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY ROLLUP(LocationID); 

/* 16. Write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. 
Sort the result in ascending order on city.*/

SELECT CITY, COUNT(*) AS TotalEmployees
FROM Person.Address
GROUP BY CITY
ORDER BY CITY ASC; 

/* 17. Write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. 
Sort the result in ascending order on year part of order date.*/ 

SELECT YEAR(OrderDate) AS SalesYear, SUM(TotalDue) AS SumTotalDue
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate) 
ORDER BY SumTotalDue ASC; 

/* 18. Write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year 
is on or before 2016. Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date.*/ 

SELECT YEAR(OrderDate) AS SalesYear, SUM(TotalDue) AS SumTotalDue
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) <= 2016
GROUP BY YEAR(OrderDate) 
ORDER BY SumTotalDue ASC; 

/* 19. Write a query in SQL to find the contacts who are designated as a manager in various departments. 
Returns ContactTypeID, name. Sort the result set in descending order.*/ 

SELECT ContactTypeID, Name
FROM Person.ContactType
WHERE Name LIKE '%Manager'
ORDER BY Name DESC; 

/* 20. Write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.*/

SELECT pp.BusinessEntityID, LastName, FirstName
FROM Person.BusinessEntityContact AS pb 
INNER JOIN Person.ContactType AS pc
	ON pc.ContactTypeID = pb.ContactTypeID
INNER JOIN Person.Person AS pp
	ON pp.BusinessEntityID = pb.PersonID
WHERE pc.Name = 'Purchasing Manager'
ORDER BY LastName, FirstName;








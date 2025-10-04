use AdventureWorks2012
---1.	Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales schema) to show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’

select SalesOrderHeader.SalesOrderID,SalesOrderHeader.ShipDate
from AdventureWorks2012.Sales.SalesOrderHeader
where SalesOrderHeader.OrderDate between  '7/28/2002' and '7/29/2014'

---2.	Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)

select Production.Product.ProductID, Production.Product.Name
from Production.Product
where Production.Product.StandardCost<110.00

---3.	Display ProductID, Name if its weight is unknown

select Production.Product.ProductID, Production.Product.Name
from Production.Product
where Production.Product.Weight is null 

---4.	 Display all Products with a Silver, Black, or Red Color

select * 
from Production.Product
where Production.Product.Color='Silver' or Production.Product.Color='Black' or Production.Product.Color='Red'

---5.	 Display any Product with a Name starting with the letter B 

select * 
from Production.Product 
where Production.Product.Name like 'B%'

---6.	Run the following Query
--UPDATE Production.ProductDescription
--SET Description = 'Chromoly steel_High of defects'
--WHERE ProductDescriptionID = 3
--Then write a query that displays any Product description with underscore value in its description.

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3


select Description
from  Production.ProductDescription
where Description like '%[_]%'


---7.	Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014'

select
 OrderDate,
sum (TotalDue) 
from Sales.SalesOrderHeader
where OrderDate between  '7/1/2001' and '7/31/2014'
GROUP BY OrderDate
ORDER BY OrderDate;

--8.	 Display the Employees HireDate (note no repeated values are allowed)

select distinct HireDate
from HumanResources.Employee

--9.	 Calculate the average of the unique ListPrices in the Product table

select avg(Production.Product.ListPrice)
from Production.Product

--10.	Display the Product Name and its ListPrice within the values of 100 and 120 the list should has the following format "The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)

select  'The ' + Name + ' is only! ' + cast(ListPrice as varchar(20)) as ProductInfo
from Production.Product
where Production.Product.ListPrice between 100 and 120
order by Production.Product.ListPrice

--11.	a)	 Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
--Note: Check your database to see the new table and how many rows in it?
--b)	Try the previous query but without transferring the data? 

SELECT rowguid, Name, SalesPersonID, Demographics
INTO Sales.store_Archive
FROM Sales.Store;

SELECT rowguid, Name, SalesPersonID, Demographics
INTO Sales.store_Archive
FROM Sales.Store
WHERE 1 = 2;






--12.	Using union statement, retrieve the today’s date in different styles using convert or format funtion.

SELECT CONVERT(varchar(20), GETDATE(), 101) AS TodayDate  -- mm/dd/yyyy
UNION
SELECT CONVERT(varchar(20), GETDATE(), 103)               -- dd/mm/yyyy
UNION
SELECT CONVERT(varchar(20), GETDATE(), 120)               -- yyyy-mm-dd hh:mi:ss
UNION
SELECT FORMAT(GETDATE(), 'dddd, MMMM dd, yyyy');          -- Friday, September 28, 2025

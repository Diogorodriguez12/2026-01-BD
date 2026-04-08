SELECT p.ProductName
FROM Products p
WHERE NOT EXISTS (
    SELECT e.EmployeeID
    FROM Employees e
    WHERE NOT EXISTS (
        SELECT od.ProductID
        FROM OrderDetails od
        JOIN Orders o ON od.OrderID = o.OrderID
        WHERE o.EmployeeID = e.EmployeeID
          AND od.ProductID = p.ProductID
    )
);

SELECT DISTINCT c.CompanyName
FROM   Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM   Orders o
    JOIN   OrderDetails od ON od.OrderID  = o.OrderID
    JOIN   Products        p  ON p.ProductID = od.ProductID
    WHERE  o.CustomerID = c.CustomerID
      AND  p.UnitPrice  >= 50
);
SELECT DISTINCT
    e.Title,
    e.FirstName,
    e.LastName
FROM Employees e
JOIN Orders o 
    ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od 
    ON o.OrderID = od.OrderID
JOIN Products p 
    ON od.ProductID = p.ProductID
WHERE p.ProductName IN ('Gravad Lax', 'Mishi Kobe Niku');
SELECT
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    c.CompanyName AS CustomerName
FROM   Orders    o
JOIN   Shippers  s  ON s.ShipperID  = o.ShipVia
JOIN   Employees e  ON e.EmployeeID = o.EmployeeID
JOIN   Customers c  ON c.CustomerID = o.CustomerID
WHERE  s.CompanyName = 'Speedy Express'
  AND  c.City = 'Bruxelles';

SELECT DISTINCT
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    e.Address,
    e.City,
    e.Region
FROM   Employees e
JOIN   Orders    o ON o.EmployeeID = e.EmployeeID
WHERE  o.ShipCountry = 'Belgium';
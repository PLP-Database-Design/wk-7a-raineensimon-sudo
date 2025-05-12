
-- Question 1: Achieving 1NF
SELECT 
    OrderID, 
    CustomerName, 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM 
    ProductDetail 
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n 
    ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
ORDER BY 
    OrderID;

-- Question 2: Achieving 2NF
-- Creating the Order table to store OrderID and CustomerName
CREATE TABLE OrderTable (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Inserting data into the Order table
INSERT INTO OrderTable (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Creating the OrderDetails table to store OrderID, Product, and Quantity
CREATE TABLE OrderDetailsTable (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID)
);

-- Inserting data into the OrderDetailsTable
INSERT INTO OrderDetailsTable (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

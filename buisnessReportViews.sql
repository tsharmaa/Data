-- View 1: SalesReport
-- Summarizes total profit per product along with product details.
CREATE OR REPLACE VIEW SalesReport AS
SELECT 
    p.ProductID, 
    p.ProductName, 
    p.ProductDescription, 
    COALESCE(SUM(s.SaleProfit), 0) AS TotalProfit
FROM ProductInfo p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.ProductDescription;

-- View 2: CustomerPreferences
-- Lists customers with their preferences and ratings for better marketing insights.
CREATE OR REPLACE VIEW CustomerPreferences AS
SELECT 
    c.CustomerID, 
    r.Name AS CustomerName, 
    r.Address, 
    r.Email, 
    c.Preferences, 
    c.Ratings
FROM CustomerInfo c
JOIN Registration r ON c.RegistrationID = r.RegistrationID;

-- View 3: InventoryStatus
-- Shows products with inventory levels at or below restock threshold to help manage stock.
CREATE OR REPLACE VIEW InventoryStatus AS
SELECT 
    i.InventoryID, 
    p.ProductName, 
    i.Quantity, 
    i.LastRestockDate, 
    i.RestockThreshold
FROM Inventory i
JOIN ProductInfo p ON i.InventoryID = p.InventoryID
WHERE i.Quantity <= i.RestockThreshold;

-- View 4: EmployeeShiftSchedule
-- Displays employee shifts for scheduling and resource management.
CREATE OR REPLACE VIEW EmployeeShiftSchedule AS
SELECT 
    es.EmployeeID, 
    e.FirstName || ' ' || e.LastName AS EmployeeName, 
    es.CurrentDate, 
    es.ShiftStartTime, 
    es.ShiftEndTime, 
    es.BreakStartTime, 
    es.BreakEndTime
FROM EmployeeShifts es
JOIN Employee e ON es.EmployeeID = e.EmployeeID;

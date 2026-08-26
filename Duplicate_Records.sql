SELECT 
    CustomerID,
    Name,
    Email,
    COUNT(*) AS RecordCount
FROM CustomerImport
GROUP BY 
    CustomerID, 
    Name, 
    Email
HAVING COUNT(*) > 1;

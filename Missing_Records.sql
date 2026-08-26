SELECT 
    s.CustomerID
FROM SourceTable s
LEFT JOIN DestinationTable d 
    ON s.CustomerID = d.CustomerID
WHERE d.CustomerID IS NULL;

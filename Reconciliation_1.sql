-- A client asks for a report on how much money system has collected versus traditional methods (Checks/Portal)

SELECT 
    source, 
    SUM(amount_paid) AS total_collected
FROM payments
GROUP BY source
ORDER BY total_collected DESC;

/* Goal: Identify potential duplicate transactions to prevent 
customer dissatisfaction and financial discrepancies.
*/

SELECT 
    patient_id, 
    transaction_amount, 
    transaction_time,
    provider_id,
    COUNT(*) as duplicate_count
FROM 
    patient_transactions
WHERE 
    -- Look at the last 24 hours
    transaction_time >= NOW() - INTERVAL '24 hours'
GROUP BY 
    patient_id, 
    transaction_amount, 
    transaction_time, 
    provider_id
HAVING 
    COUNT(*) > 1
ORDER BY 
    transaction_time DESC;

-- If this query returns results, 
-- I would immediately trigger a 'Stop-Payment' alert to the dev team.

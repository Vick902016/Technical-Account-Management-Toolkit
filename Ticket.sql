-- Query to identify accounts with > 20% increase in 'High' priority tickets
WITH TicketCounts AS (
    SELECT 
        account_id,
        COUNT(CASE WHEN priority = 'High' THEN 1 END) as high_prio_count,
        DATE_TRUNC('month', created_at) as report_month
    FROM support_tickets
    GROUP BY 1, 3
)
SELECT 
    a.account_name,
    curr.high_prio_count as current_month,
    prev.high_prio_count as last_month
FROM accounts a
JOIN TicketCounts curr ON a.id = curr.account_id
JOIN TicketCounts prev ON a.id = prev.account_id 
    AND curr.report_month = prev.report_month + INTERVAL '1 month'
WHERE curr.high_prio_count > (prev.high_prio_count * 1.2);

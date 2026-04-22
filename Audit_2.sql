--Sometimes a patient pays on Cedar, but the "EHR" (the hospital's main computer) doesn't get the message. This is a post-back error.
--Task: Find all invoice_ids where a payment exists in the payments table, but the invoice status is still 'Open' in the invoices table.
--The Logic: This identifies a technical "desync" where the money was taken, but the record wasn't updated.

SELECT 
    i.invoice_id, 
    i.amount_due, 
    pay.amount_paid
FROM invoices i
JOIN payments pay ON i.invoice_id = pay.invoice_id
WHERE i.status = 'Open'; -- This reveals the error: it should be 'Paid'


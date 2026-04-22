--A hospital administrator claims Cedar isn't showing all their invoices. You need to find which patients have "Open" invoices but no recorded payments in the system yet.
--Task: Join patients and invoices to list names and amounts for all "Open" bills.

SELECT 
    p.name, 
    i.amount_due
FROM patients p
JOIN invoices i ON p.patient_id = i.patient_id
WHERE i.status = 'Open';

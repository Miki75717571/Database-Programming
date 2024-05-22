–-Retrieve Users Who Have Unpaid Fines Greater Than a 10$
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    SUM(f.Amount) AS TotalUnpaidFines
FROM 
    Users u
JOIN 
    Fines f ON u.UserID = f.UserID
WHERE 
    f.Paid = FALSE
GROUP BY 
    u.UserID, u.FirstName, u.LastName
HAVING 
    SUM(f.Amount) > 10;

–-Find the Most Recent Reservation for Each User
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    r.RentalDate
FROM 
    Users u
JOIN 
    Reservations r ON u.UserID = r.UserID
WHERE 
    r.RentalDate = (
        SELECT MAX(r.RentalDate)
        FROM Reservations r2
        WHERE r2.UserID = u.UserID
    );


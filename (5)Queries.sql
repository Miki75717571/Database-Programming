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

    --  Retrieve Users Who Have Reserved More Than a 3 books
SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    COUNT(r.ReservationID) AS TotalBooksReserved
FROM 
    Users u
JOIN 
    Reservations r ON u.UserID = r.UserID
GROUP BY 
    u.UserID, u.FirstName, u.LastName
HAVING 
    COUNT(r.ReservationID) > 3;


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

–List All Books with Their Authors and Genres, But Only for Books Published After a 1948

SELECT 
    b.Title,
    LISTAGG(a.FirstName || ' ' || a.LastName, ', ') WITHIN GROUP (ORDER BY a.LastName, a.FirstName) AS Authors,
    LISTAGG(g.Name, ', ') WITHIN GROUP (ORDER BY g.Name) AS Genres
FROM 
    Books b
JOIN 
    BooksAuthors ba ON b.BookID = ba.BookID
JOIN 
    Authors a ON ba.AuthorID = a.AuthorID
JOIN 
    BooksGenres bg ON b.BookID = bg.BookID
JOIN 
    Genres g ON bg.GenreID = g.GenreID
WHERE 
    b.ReleaseDate > DATE '1948-01-01'
GROUP BY 
    b.Title;

–Retrieve the Top 3 Users with the Most Reservations

SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    COUNT(r.ReservationID) AS TotalReservations
FROM 
    Users u
JOIN 
    Reservations r ON u.UserID = r.UserID
GROUP BY 
    u.UserID, u.FirstName, u.LastName
ORDER BY 
    TotalReservations DESC
FETCH FIRST 3 ROWS ONLY;

–Find Books That Have Never Been Reserved

SELECT 
    b.BookID,
    b.Title,
    b.ReleaseDate
FROM 
    Books b
LEFT JOIN 
    Reservations r ON b.BookID = r.BookID
WHERE 
    r.ReservationID IS NULL;


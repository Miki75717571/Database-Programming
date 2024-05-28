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
    f.Paid = 0
GROUP BY 
    u.UserID, u.FirstName, u.LastName
HAVING 
    SUM(f.Amount) > 10;

    --  Retrieve Users Who Have Reserved More Than a 2 books
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
    COUNT(r.ReservationID) > 2;


–-Find the Most Recent Reservation for Each User
SELECT 
    UserID,
    FirstName,
    LastName,
    RentalDate
FROM (
    SELECT 
        u.UserID,
        u.FirstName,
        u.LastName,
        r.RentalDate,
        ROW_NUMBER() OVER(PARTITION BY u.UserID ORDER BY r.RentalDate DESC) as rn
    FROM 
        Users u
    JOIN 
        Reservations r ON u.UserID = r.UserID
) 
WHERE rn = 1;

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

–Retrieve the Total Number of Books for Each Genre
SELECT 
    g.GenreID,
    g.Name AS GenreName,
    COUNT(bg.BookID) AS TotalBooks
FROM 
    Genres g
JOIN 
    BooksGenres bg ON g.GenreID = bg.GenreID
GROUP BY 
    g.GenreID, g.Name;

–Retrieve Authors Who Have Written More Than 2 Books
    SELECT 
    a.AuthorID,
    a.FirstName,
    a.LastName,
    COUNT(ba.BookID) AS TotalBooksWritten
FROM 
    Authors a
JOIN 
    BooksAuthors ba ON a.AuthorID = ba.AuthorID
GROUP BY 
    a.AuthorID, a.FirstName, a.LastName
HAVING 
    COUNT(ba.BookID) > 2;

–List All Users with Their Total Number of Reservations and Total Fines (if any)
    SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    COUNT(r.ReservationID) AS TotalReservations,
    COALESCE(SUM(f.Amount), 0) AS TotalFines
FROM 
    Users u
LEFT JOIN 
    Reservations r ON u.UserID = r.UserID
LEFT JOIN 
    Fines f ON u.UserID = f.UserID
GROUP BY 
    u.UserID, u.FirstName, u.LastName;

–Retrieve Books That Have Been Reserved Between January 1, 2023, and February 1, 2023
    SELECT 
    b.BookID,
    b.Title,
    b.ReleaseDate,
    r.RentalDate
FROM 
    Books b
JOIN 
    Reservations r ON b.BookID = r.BookID
WHERE 
    r.RentalDate BETWEEN DATE '2023-01-01' AND DATE '2023-02-01';
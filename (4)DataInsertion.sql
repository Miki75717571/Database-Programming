-- Insert data into Users
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES
(3, 'jessica.garcia@example.com', 'password789', '9876543210', 'Jessica', 'Garcia'),
(4, 'christopher.lopez@example.com', 'password101', '8765432109', 'Christopher', 'Lopez'),
(5, 'susan.hall@example.com', 'password102', '7654321098', 'Susan', 'Hall'),
(6, 'sarah.taylor@example.com', 'password103', '6543210987', 'Sarah', 'Taylor'),
(7, 'jane.smith@example.com', 'password104', '5432109876', 'Jane', 'Smith'),
(8, 'michael.johnson@example.com', 'password105', '4321098765', 'Michael', 'Johnson'),
(9, 'emily.brown@example.com', 'password106', '3210987654', 'Emily', 'Brown'),
(10, 'daniel.martinez@example.com', 'password107', '2109876543', 'Daniel', 'Martinez'),
(11, 'christopher.anderson@example.com', 'password108', '1098765432', 'Christopher', 'Anderson'),
(12, 'amanda.thomas@example.com', 'password109', '0987654321', 'Amanda', 'Thomas');

-- Insert data into Authors
INSERT INTO Authors (AuthorID, FirstName, LastName) VALUES
(2, 'George', 'Orwell'),
(3, 'Agatha', 'Christie'),
(4, 'J.R.R.', 'Tolkien'),
(5, 'Stephen', 'King');

-- Insert data into Genres
INSERT INTO Genres (GenreID, Name) VALUES
(1, 'Classic'),
(2, 'Dystopian'),
(3, 'Mystery'),
(4, 'Horror'),
(5, 'Adventure');

-- Insert data into Books
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES
(3, 'Murder on the Orient Express', TO_DATE('1934-01-01', 'YYYY-MM-DD'), '9780062693662'),
(4, 'The Hobbit', TO_DATE('1937-09-21', 'YYYY-MM-DD'), '9780547928227'),
(5, 'The Shining', TO_DATE('1977-01-28', 'YYYY-MM-DD'), '9780385121675'),
(6, '1984', TO_DATE('1949-06-08', 'YYYY-MM-DD'), '9780451524935'),
(7, 'The Catcher in the Rye', TO_DATE('1951-07-16', 'YYYY-MM-DD'), '9780316769488');


-- Insert data into BooksAuthors
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES
(3, 3), -- Agatha Christie for 'Murder on the Orient Express'
(4, 4), -- J.R.R. Tolkien for 'The Hobbit'
(5, 5), -- Stephen King for 'The Shining'
(6, 2), -- George Orwell for '1984'
(7, 6); -- J.D. Salinger for 'The Catcher in the Rye'

-- Insert data into BooksGenres
INSERT INTO BooksGenres (BookID, GenreID) VALUES
(3, 3), -- Mystery for 'Murder on the Orient Express'
(4, 5), -- Adventure for 'The Hobbit'
(5, 4), -- Horror for 'The Shining'
(6, 2), -- Dystopian for '1984'
(7, 1); -- Classic for 'The Catcher in the Rye'

-- Insert data into Reservations
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES
(3, 3, 3, '2023-01-10', '2023-01-25', NULL),
(4, 4, 4, '2023-01-15', '2023-01-30', '2023-01-29'),
(5, 5, 5, '2023-01-20', '2023-02-04', NULL),
(6, 6, 6, '2023-01-25', '2023-02-09', '2023-02-08'),
(7, 7, 7, '2023-01-30', '2023-02-14', NULL);

-- Insert data into Fines
INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid) VALUES
(1, 3, 3, 0.0, 1),
(2, 4, 4, 0.0, 1),
(3, 5, 5, 15.0, 0),
(4, 6, 6, 0.0, 1),
(5, 7, 7, 25.0, 0);

-- Insert data into Users
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (3, 'jessica.garcia@example.com', 'password789', '9876543210', 'Jessica', 'Garcia');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (4, 'christopher.lopez@example.com', 'password101', '8765432109', 'Christopher', 'Lopez');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (5, 'susan.hall@example.com', 'password102', '7654321098', 'Susan', 'Hall');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (6, 'sarah.taylor@example.com', 'password103', '6543210987', 'Sarah', 'Taylor');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (7, 'jane.smith@example.com', 'password104', '5432109876', 'Jane', 'Smith');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (8, 'michael.johnson@example.com', 'password105', '4321098765', 'Michael', 'Johnson');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (9, 'emily.brown@example.com', 'password106', '3210987654', 'Emily', 'Brown');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (10, 'daniel.martinez@example.com', 'password107', '2109876543', 'Daniel', 'Martinez');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (11, 'christopher.anderson@example.com', 'password108', '1098765432', 'Christopher', 'Anderson');
INSERT INTO Users (UserID, Email, Password, Phone, FirstName, LastName) VALUES (12, 'amanda.thomas@example.com', 'password109', '0987654321', 'Amanda', 'Thomas');
-- Insert data into Authors
INSERT INTO Authors (AuthorID, FirstName, LastName) VALUES (2, 'George', 'Orwell');
INSERT INTO Authors (AuthorID, FirstName, LastName) VALUES (3, 'Agatha', 'Christie');
INSERT INTO Authors (AuthorID, FirstName, LastName) VALUES (4, 'J.R.R.', 'Tolkien');
INSERT INTO Authors (AuthorID, FirstName, LastName) VALUES (5, 'Stephen', 'King');
INSERT INTO Authors (AuthorID, FirstName, LastName) VALUES (6, 'J.D.', 'Salinger');

-- Insert data into Genres
INSERT INTO Genres (GenreID, Name) VALUES (1, 'Classic');
INSERT INTO Genres (GenreID, Name) VALUES (2, 'Dystopian');
INSERT INTO Genres (GenreID, Name) VALUES (3, 'Mystery');
INSERT INTO Genres (GenreID, Name) VALUES (4, 'Horror');
INSERT INTO Genres (GenreID, Name) VALUES (5, 'Adventure');

-- Insert data into Books
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (3, 'Murder on the Orient Express', TO_DATE('1934-01-01', 'YYYY-MM-DD'), '9780062693662');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (4, 'The Hobbit', TO_DATE('1937-09-21', 'YYYY-MM-DD'), '9780547928227');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (5, 'The Shining', TO_DATE('1977-01-28', 'YYYY-MM-DD'), '9780385121675');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (6, '1984', TO_DATE('1949-06-08', 'YYYY-MM-DD'), '9780451524935');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (7, 'The Catcher in the Rye', TO_DATE('1951-07-16', 'YYYY-MM-DD'), '9780316769488');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (8, 'To Kill a Mockingbird', TO_DATE('1960-07-11', 'YYYY-MM-DD'), '9780061120084');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (9, 'Pride and Prejudice', TO_DATE('1813-01-28', 'YYYY-MM-DD'), '9780141439518');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (10, 'The Alchemist', TO_DATE('1988-01-01', 'YYYY-MM-DD'), '9780061122415');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (11, 'The Lord of the Rings', TO_DATE('1954-07-29', 'YYYY-MM-DD'), '9780618640157');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (12, 'Harry Potter', TO_DATE('1997-06-26', 'YYYY-MM-DD'), '9780590353427');
INSERT INTO Books (BookID, Title, ReleaseDate, ISBN) VALUES (13, 'The Great Gatsby', TO_DATE('1925-04-10', 'YYYY-MM-DD'), '9780743273565');
-- Insert data into BooksAuthors
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES (3, 3); -- Agatha Christie for 'Murder on the Orient Express'
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES (4, 4); -- J.R.R. Tolkien for 'The Hobbit'
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES (5, 5); -- Stephen King for 'The Shining'
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES (6, 2); -- George Orwell for '1984'
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES (7, 6); -- J.D. Salinger for 'The Catcher in the Rye'
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES (8, 6);
INSERT INTO BooksAuthors (BookID, AuthorID) VALUES (9, 6);

-- Insert data into BooksGenres
INSERT INTO BooksGenres (BookID, GenreID) VALUES (3, 3); -- Mystery for 'Murder on the Orient Express'
INSERT INTO BooksGenres (BookID, GenreID) VALUES (4, 5); -- Adventure for 'The Hobbit'
INSERT INTO BooksGenres (BookID, GenreID) VALUES (5, 4); -- Horror for 'The Shining'
INSERT INTO BooksGenres (BookID, GenreID) VALUES (6, 2); -- Dystopian for '1984'
INSERT INTO BooksGenres (BookID, GenreID) VALUES (7, 1); -- Classic for 'The Catcher in the Rye'

-- Insert data into Reservations
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (3, 3, 3, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-25', 'YYYY-MM-DD'), NULL);
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (4, 4, 4, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2023-01-30', 'YYYY-MM-DD'), TO_DATE('2023-01-29', 'YYYY-MM-DD'));
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (5, 5, 5, TO_DATE('2023-01-20', 'YYYY-MM-DD'), TO_DATE('2023-02-04', 'YYYY-MM-DD'), NULL);
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (6, 6, 6, TO_DATE('2023-01-25', 'YYYY-MM-DD'), TO_DATE('2023-02-09', 'YYYY-MM-DD'), TO_DATE('2023-02-08', 'YYYY-MM-DD'));
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (7, 7, 7, TO_DATE('2023-01-30', 'YYYY-MM-DD'), TO_DATE('2023-02-14', 'YYYY-MM-DD'), NULL);
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (8, 3, 8, TO_DATE('2023-02-05', 'YYYY-MM-DD'), TO_DATE('2023-02-20', 'YYYY-MM-DD'), NULL);
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (9, 3, 9, TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_DATE('2023-02-25', 'YYYY-MM-DD'), NULL);
INSERT INTO Reservations (ReservationID, UserID, BookID, RentalDate, ExpirationDate, ReturnDate) VALUES (10, 4, 13, TO_DATE('2023-02-15', 'YYYY-MM-DD'), TO_DATE('2023-03-02', 'YYYY-MM-DD'), NULL);

-- Insert data into Fines
INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid) VALUES (1, 3, 3, 0.0, 1);
INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid) VALUES (2, 4, 4, 0.0, 1);
INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid) VALUES (3, 5, 5, 15.0, 0);
INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid) VALUES (4, 6, 6, 0.0, 1);
INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid) VALUES (5, 7, 7, 25.0, 0);
INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid) VALUES (6, 8, 7, 47.0, 0);


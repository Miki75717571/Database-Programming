CREATE OR REPLACE PACKAGE LibraryManagement AS
    -- Procedures
    PROCEDURE AddNewUser(p_Email IN NVARCHAR2, p_Password IN NVARCHAR2, p_Phone IN NVARCHAR2, p_FirstName IN NVARCHAR2, p_LastName IN NVARCHAR2);
    PROCEDURE UpdateBookInfo(p_BookID IN INT, p_Title IN NVARCHAR2, p_ReleaseDate IN DATE, p_ISBN IN NVARCHAR2);
    PROCEDURE ReserveBook(p_UserID IN INT, p_BookID IN INT, p_RentalDate IN DATE, p_ExpirationDate IN DATE);
    PROCEDURE ReturnBook(p_ReservationID IN INT, p_ReturnDate IN DATE);
    PROCEDURE AddNewAuthor(p_FirstName IN NVARCHAR2, p_LastName IN NVARCHAR2);
    PROCEDURE UpdateAuthor(p_AuthorID IN INT, p_FirstName IN NVARCHAR2, p_LastName IN NVARCHAR2);
    PROCEDURE DeleteUser(p_UserID IN INT);
    PROCEDURE GetReservationsForUser(p_UserID IN INT);
    PROCEDURE GetBooksForAuthor(p_AuthorID IN INT);

    -- Functions
    FUNCTION GetBookAge(p_BookID INT) RETURN INT;
    FUNCTION GetAuthorFullName(p_AuthorID INT) RETURN NVARCHAR2;
    FUNCTION GetTotalUnpaidFines(p_UserID IN INT) RETURN FLOAT;
    FUNCTION GetBooksBorrowedCount(p_UserID IN INT) RETURN INT;
    FUNCTION IsBookAvailable(p_BookID IN INT) RETURN BOOLEAN;
END LibraryManagement;
/

CREATE OR REPLACE PACKAGE BODY LibraryManagement AS
    -- Add New User Procedure
    PROCEDURE AddNewUser(
        p_Email IN NVARCHAR2,
        p_Password IN NVARCHAR2,
        p_Phone IN NVARCHAR2,
        p_FirstName IN NVARCHAR2,
        p_LastName IN NVARCHAR2
    ) IS
        v_Count INT;
    BEGIN
        -- Check if the email already exists
        SELECT COUNT(*)
        INTO v_Count
        FROM Users
        WHERE Email = p_Email;

        IF v_Count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Email already exists');
        ELSE
            -- Insert the new user
            INSERT INTO Users (Email, Password, Phone, FirstName, LastName)
            VALUES (p_Email, p_Password, p_Phone, p_FirstName, p_LastName);
        END IF;
    END AddNewUser;

    -- Update Book Info Procedure
    PROCEDURE UpdateBookInfo(
        p_BookID IN INT,
        p_Title IN NVARCHAR2,
        p_ReleaseDate IN DATE,
        p_ISBN IN NVARCHAR2
    ) IS
        v_Count INT;
    BEGIN
        -- Check if the book exists
        SELECT COUNT(*)
        INTO v_Count
        FROM Books
        WHERE BookID = p_BookID;

        IF v_Count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Book ID does not exist');
        ELSE 
            UPDATE Books
            SET Title = p_Title, ReleaseDate = p_ReleaseDate, ISBN = p_ISBN
            WHERE BookID = p_BookID;
        END IF;
    END UpdateBookInfo;

    -- Reserve Book Procedure
    PROCEDURE ReserveBook (
        p_UserID IN INT,
        p_BookID IN INT,
        p_RentalDate IN DATE,
        p_ExpirationDate IN DATE
    ) IS
        v_BookCount INT;
    BEGIN
        -- Check if the book is already reserved
        SELECT COUNT(*)
        INTO v_BookCount
        FROM Reservations
        WHERE BookID = p_BookID AND ReturnDate IS NULL;

        IF v_BookCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'The book is already reserved');
        ELSE
            -- Insert a new reservation
            INSERT INTO Reservations (UserID, BookID, RentalDate, ExpirationDate)
            VALUES (p_UserID, p_BookID, p_RentalDate, p_ExpirationDate);
        END IF;
    END ReserveBook;

    -- Return Book Procedure
    PROCEDURE ReturnBook (
        p_ReservationID IN INT,
        p_ReturnDate IN DATE
    ) IS
        v_ReservationCount INT;
    BEGIN
        -- Check if the reservation exists
        SELECT COUNT(*)
        INTO v_ReservationCount
        FROM Reservations
        WHERE ReservationID = p_ReservationID;

        IF v_ReservationCount = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Reservation ID does not exist');
        ELSE
            -- Update the reservation with the return date
            UPDATE Reservations
            SET ReturnDate = p_ReturnDate
            WHERE ReservationID = p_ReservationID;
        END IF;
    END ReturnBook;

    -- Add New Author Procedure
    PROCEDURE AddNewAuthor (
        p_FirstName IN NVARCHAR2,
        p_LastName IN NVARCHAR2
    ) IS
    BEGIN
        -- Insert a new author
        INSERT INTO Authors (FirstName, LastName)
        VALUES (p_FirstName, p_LastName);
    END AddNewAuthor;

    -- Update Author Info Procedure
    PROCEDURE UpdateAuthor (
        p_AuthorID IN INT,
        p_FirstName IN NVARCHAR2,
        p_LastName IN NVARCHAR2
    ) IS
        v_AuthorCount INT;
    BEGIN
        -- Check if the author exists
        SELECT COUNT(*)
        INTO v_AuthorCount
        FROM Authors
        WHERE AuthorID = p_AuthorID;

        IF v_AuthorCount = 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Author ID does not exist');
        ELSE
            -- Update the author's information
            UPDATE Authors
            SET FirstName = p_FirstName, LastName = p_LastName
            WHERE AuthorID = p_AuthorID;
        END IF;
    END UpdateAuthor;

    -- Delete User Procedure
    PROCEDURE DeleteUser (
        p_UserID IN INT
    ) IS
        v_UserCount INT;
    BEGIN
        -- Check if the user exists
        SELECT COUNT(*)
        INTO v_UserCount
        FROM Users
        WHERE UserID = p_UserID;

        IF v_UserCount = 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'User ID does not exist');
        ELSE
            -- Delete the user
            DELETE FROM Users
            WHERE UserID = p_UserID;
        END IF;
    END DeleteUser;

    -- Get Reservations for User Procedure
    PROCEDURE GetReservationsForUser (
        p_UserID IN INT
    ) IS
        CURSOR c_Reservations IS
            SELECT *
            FROM Reservations
            WHERE UserID = p_UserID;
        v_Reservation c_Reservations%ROWTYPE;
    BEGIN
        OPEN c_Reservations;

        LOOP
            FETCH c_Reservations INTO v_Reservation;
            EXIT WHEN c_Reservations%NOTFOUND;

            -- Show information about the reservation
            DBMS_OUTPUT.PUT_LINE('BookID: ' || v_Reservation.BookID || ', RentalDate: ' || v_Reservation.RentalDate || ', ExpirationDate: ' || v_Reservation.ExpirationDate);
        END LOOP;

        CLOSE c_Reservations;
    END GetReservationsForUser;

    -- Get Books for Author Procedure
    PROCEDURE GetBooksForAuthor(p_AuthorID IN INT) AS
        CURSOR book_cursor IS
            SELECT b.BookID, b.Title, b.ReleaseDate, b.ISBN
            FROM Books b
            INNER JOIN BooksAuthors ba ON b.BookID = ba.BookID
            WHERE ba.AuthorID = p_AuthorID;
        book_record book_cursor%ROWTYPE;
    BEGIN
        OPEN book_cursor;
        LOOP
            FETCH book_cursor INTO book_record;
            EXIT WHEN book_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('BookID: ' || book_record.BookID || ', Title: ' || book_record.Title || ', ReleaseDate: ' || TO_CHAR(book_record.ReleaseDate, 'YYYY-MM-DD') || ', ISBN: ' || book_record.ISBN);
        END LOOP;
        CLOSE book_cursor;
    END GetBooksForAuthor;

    -- Get Book Age Function
    FUNCTION GetBookAge(p_BookID INT) RETURN INT IS
        v_ReleaseDate DATE;
        v_Age INT;
    BEGIN
        SELECT ReleaseDate INTO v_ReleaseDate FROM Books WHERE BookID = p_BookID;

        v_Age := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM v_ReleaseDate);

        RETURN v_Age;
    END GetBookAge;

    -- Get Author Full Name Function
    FUNCTION GetAuthorFullName(p_AuthorID INT) RETURN NVARCHAR2 IS
        v_FirstName NVARCHAR2(30);
        v_LastName NVARCHAR2(30);
        v_FullName NVARCHAR2(61);
    BEGIN
        SELECT FirstName, LastName INTO v_FirstName, v_LastName FROM Authors WHERE AuthorID = p_AuthorID;

        v_FullName := v_FirstName || ' ' || v_LastName;

        RETURN v_FullName;
    END GetAuthorFullName;

    -- Get Total Unpaid Fines Function
    FUNCTION GetTotalUnpaidFines(p_UserID IN INT) RETURN FLOAT IS
        v_TotalFines FLOAT;
    BEGIN
        SELECT SUM(FineAmount) INTO v_TotalFines FROM Fines WHERE UserID = p_UserID AND Paid = 0;

        RETURN NVL(v_TotalFines, 0);
    END GetTotalUnpaidFines;

    -- Get Books Borrowed Count Function
    FUNCTION GetBooksBorrowedCount(p_UserID IN INT) RETURN INT IS
        v_BorrowedCount INT;
    BEGIN
        SELECT COUNT(*) INTO v_BorrowedCount FROM Reservations WHERE UserID = p_UserID AND ReturnDate IS NULL;

        RETURN v_BorrowedCount;
    END GetBooksBorrowedCount;

    -- Is Book Available Function
    FUNCTION IsBookAvailable(p_BookID IN INT) RETURN BOOLEAN IS
        v_ReservedCount INT;
    BEGIN
        SELECT COUNT(*) INTO v_ReservedCount FROM Reservations WHERE BookID = p_BookID AND ReturnDate IS NULL;

        RETURN v_ReservedCount = 0;
    END IsBookAvailable;
END LibraryManagement;
/

--test block
DECLARE
    v_UserID INT := 4; -- Change this to test with different users
    v_TotalFines FLOAT;
BEGIN
    -- Call the function from the package
    v_TotalFines := LibraryManagement.GetTotalUnpaidFines(v_UserID);
    
    -- Print the result
    DBMS_OUTPUT.PUT_LINE('Total unpaid fines for UserID ' || v_UserID || ': ' || v_TotalFines);
END;
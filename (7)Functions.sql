
-- The function should take a BookID as input and return the age of the book in years
create or replace FUNCTION GetBookAge(p_BookID INT)
RETURN INT
IS
    v_ReleaseDate DATE;
    v_Age INT;
BEGIN
    SELECT ReleaseDate INTO v_ReleaseDate FROM Books WHERE BookID = p_BookID;

    v_Age := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM v_ReleaseDate);

    RETURN v_Age;
END;


create or replace FUNCTION GetAuthorFullName(p_AuthorID INT)
RETURN NVARCHAR2
IS
    v_FirstName NVARCHAR2(30);
    v_LastName NVARCHAR2(30);
    v_FullName NVARCHAR2(61);
BEGIN
    SELECT FirstName, LastName INTO v_FirstName, v_LastName FROM Authors WHERE AuthorID = p_AuthorID;

    v_FullName := v_FirstName || ' ' || v_LastName;

    RETURN v_FullName;
END;

– total fines for a user

CREATE OR REPLACE FUNCTION GetTotalUnpaidFines (
    p_UserID IN INT
) RETURN FLOAT IS
    v_TotalFines FLOAT;
BEGIN
    -- Calculate the total unpaid fines for the user
    SELECT SUM(Amount)
    INTO v_TotalFines
    FROM Fines
    WHERE UserID = p_UserID AND Paid = FALSE;

    -- Return 0 if no fines are found
    IF v_TotalFines IS NULL THEN
        v_TotalFines := 0;
    END IF;

    RETURN v_TotalFines;
END;

– retrieve books borrowed by a user

CREATE OR REPLACE FUNCTION GetBooksBorrowedCount (
    p_UserID IN INT
) RETURN INT IS
    v_BooksBorrowedCount INT;
BEGIN
    -- Count the number of books borrowed by the user
    SELECT COUNT(*)
    INTO v_BooksBorrowedCount
    FROM Reservations
    WHERE UserID = p_UserID;

    RETURN v_BooksBorrowedCount;
END;

create or replace FUNCTION IsBookAvailable (
    p_BookID IN INT
) RETURN BOOLEAN IS
    v_BookCount INT;
BEGIN
    -- Check if the book is currently reserved
    SELECT COUNT(*)
    INTO v_BookCount
    FROM Reservations
    WHERE BookID = p_BookID AND ReturnDate IS NULL;

    -- If count is 0, the book is available
    IF v_BookCount = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;


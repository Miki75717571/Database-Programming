–-Trigger to Enforce Email Uniqueness in Users Table

CREATE OR REPLACE TRIGGER trg_users_email_uniqueness
BEFORE INSERT OR UPDATE ON Users
FOR EACH ROW
DECLARE
    v_Count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_Count
    FROM Users
    WHERE Email = :NEW.Email;

    IF v_Count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email already exists');
    END IF;
END;

-- Trigger to Handle Overdue Returns and Apply Fines
CREATE OR REPLACE TRIGGER trg_handle_overdue_return
AFTER UPDATE ON Reservations
FOR EACH ROW
DECLARE
    v_DaysOverdue INT;
    v_FineAmount FLOAT;
    v_TotalUnpaidFines FLOAT;
    v_Message VARCHAR2(4000);
    v_FineID INT;
BEGIN
    -- Check if the return date is set and the book was overdue
    IF :NEW.ReturnDate IS NOT NULL AND :OLD.ReturnDate IS NULL AND :OLD.ExpirationDate < :NEW.ReturnDate THEN
        v_DaysOverdue := TRUNC(:NEW.ReturnDate) - TRUNC(:OLD.ExpirationDate);
        v_FineAmount := v_DaysOverdue * 1;  -- Assume the fine is 1 currency unit per day overdue

        -- Get the next value of the sequence
        SELECT Fines_FineID_Seq.NEXTVAL INTO v_FineID FROM DUAL;

        -- Insert the fine record
        INSERT INTO Fines (FineID, BookID, UserID, Amount, Paid)
        VALUES (v_FineID, :NEW.BookID, :NEW.UserID, v_FineAmount, 0);

        -- Calculate the total unpaid fines for the user
        SELECT SUM(Amount)
        INTO v_TotalUnpaidFines
        FROM Fines
        WHERE UserID = :NEW.UserID AND Paid = 0;

        -- Mark the fine as paid if the user has no outstanding fines
        IF v_TotalUnpaidFines = 0 THEN
            UPDATE Fines
            SET Paid = 1
            WHERE FineID = v_FineID;
        END IF;

        -- Create a notification message
        v_Message := 'Dear user, your book with ID ' || :NEW.BookID || ' was returned ' ||
                     v_DaysOverdue || ' days late. A fine of ' || v_FineAmount || ' has been applied to your account.';

        -- Display the notification (using DBMS_OUTPUT for simplicity)
        DBMS_OUTPUT.PUT_LINE(v_Message);
    END IF;
END;
/
-- Trigger to Automatically Assign IDs to Authors, Genres, and Users
create or replace TRIGGER Authors_Before_Insert
BEFORE INSERT ON Authors
FOR EACH ROW
BEGIN
  :new.AuthorID := Authors_AuthorID_Seq.NEXTVAL;
END;

create or replace TRIGGER Reservations_Before_Insert
BEFORE INSERT ON Reservations
FOR EACH ROW
BEGIN
  :new.RESERVATIONID := Reservations_ReservationID_Seq.NEXTVAL;
END;

create or replace TRIGGER Users_Before_Insert
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
   :new.UserID := Users_UserID_Seq.NEXTVAL;
END;
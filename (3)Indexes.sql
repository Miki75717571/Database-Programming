-- Indexes

CREATE INDEX Users_Email_IDX
  ON Users (Email);

CREATE INDEX Reservations_UserID_IDX
  ON Reservations (UserID);

CREATE INDEX Reservations_BookID_IDX
  ON Reservations (BookID);

CREATE INDEX Books_ISBN_IDX
  ON Books (ISBN);

CREATE INDEX BooksAuthors_BookID_IDX
  ON BooksAuthors (BookID);

CREATE INDEX BooksAuthors_AuthorID_IDX
  ON BooksAuthors (AuthorID);

CREATE INDEX BooksGenres_BookID_IDX
  ON BooksGenres (BookID);

CREATE INDEX BooksGenres_GenreID_IDX
  ON BooksGenres (GenreID);

CREATE INDEX Fines_BookID_IDX
  ON Fines (BookID);

CREATE INDEX Fines_UserID_IDX
  ON Fines (UserID);

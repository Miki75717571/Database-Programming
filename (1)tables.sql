CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  Email NVARCHAR2(50),
  Password NVARCHAR2(50),
  Phone NVARCHAR2(15),
  FirstName NVARCHAR2(30),
  LastName NVARCHAR2(30)
);

CREATE TABLE Reservations (
  ReservationID INT PRIMARY KEY,
  UserID INT,
  BookID INT,
  RentalDate DATE,
  ExpirationDate DATE,
  ReturnDate DATE,
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

CREATE TABLE Books (
  BookID INT PRIMARY KEY,
  Title NVARCHAR2(32),
  ReleaseDate DATE,
  ISBN NVARCHAR2(20)
);

CREATE TABLE Fines (
  FineID INT PRIMARY KEY,
  BookID INT,
  UserID INT,
  Amount FLOAT,
  Paid Number(1),
  FOREIGN KEY (BookID) REFERENCES Books(BookID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Genres (
  GenreID INT PRIMARY KEY,
  Name NVARCHAR2(20)
);

CREATE TABLE BooksGenres (
  BookID INT,
  GenreID INT,
  FOREIGN KEY (BookID) REFERENCES Books(BookID),
  FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
  PRIMARY KEY (BookID, GenreID)
);

CREATE TABLE Authors (
  AuthorID INT PRIMARY KEY,
  FirstName NVARCHAR2(30),
  LastName NVARCHAR2(30)
);

CREATE TABLE BooksAuthors (
  BookID INT,
  AuthorID INT,
  FOREIGN KEY (BookID) REFERENCES Books(BookID),
  FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
  PRIMARY KEY (BookID, AuthorID)
);

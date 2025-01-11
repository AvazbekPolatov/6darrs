-- 1.authors jadvali
DROP TABLE IF EXISTS authors CASCADE;

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    country VARCHAR(100)
);

-- INSERT: authors jadvaliga ma'lumot qo'shish
INSERT INTO authors (name, birth_date, country)
VALUES
('J.K. Rowling', '1965-07-31', 'Buyuk Britaniya'),
('Jorj Oruell', '1903-06-25', 'Buyuk Britaniya'),
('Haruki Murakami', '1949-01-12', 'Yaponiya'),
('Isik Asimov', '1920-01-02', 'Rossiya'),
('Lev Tolstoy', '1828-09-09', 'Rossiya');

-- SELECT: authors jadvalidagi barcha ma'lumotlarni tanlash
SELECT * FROM authors;

-- 2.publishers jadvali--------------------------------------------
DROP TABLE IF EXISTS publishers CASCADE;
CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    founded_year INT
);

-- INSERT: publishers jadvaliga ma'lumot qo'shish
INSERT INTO publishers (name, city, founded_year)
VALUES
('Penguin Random House', 'Nyu-York', 1927),
('HarperCollins', 'Nyu-York', 1989),
('Macmillan', 'London', 1843),
('Oxford University Press', 'Oxford', 1586),
('Hachette', 'Parij', 1826);

-- SELECT: publishers jadvalidagi barcha ma'lumotlarni tanlash
SELECT * FROM publishers;

-- 3.books jadvali----------------------------------------------------------
DROP TABLE IF EXISTS books CASCADE; 

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(155) NOT NULL,
    author_id INT REFERENCES authors(author_id) ON DELETE CASCADE,
    publisher_id INT REFERENCES publishers(publisher_id) ON DELETE CASCADE,
    genre VARCHAR(100),
    publication_date DATE,
    price DECIMAL(10, 2)
);

-- INSERT: books jadvaliga ma'lumot qo'shish
INSERT INTO books (title, author_id, publisher_id, genre, publication_date, price)
VALUES
('Harry Potter va Sehrgar Tosh', 1, 1, 'Fantastika', '1997-06-26', 29.99),
('bir narsa top ', 2, 2, 'Distopiya', '1949-06-08', 14.99),
('Norveg Yozigi', 3, 3, 'Adabiyot', '1987-09-04', 19.99),
('Asos', 4, 4, 'Ilmiy-fantastika', '1951-06-01', 24.99),
('Urush va Tinchlik', 5, 5, 'Tarixiy adabiyot', '1869-01-01', 39.99),
('Harry Potter va Sirli Xona', 1, 1, 'Fantastika', '1998-07-02', 29.99),
('Hayvonlar Ferma', 2, 2, 'Distopiya', '1945-08-17', 9.99),
('Kafkada Qirgoqda', 3, 3, 'Adabiyot', '2002-01-01', 21.99),
('Men, Robot', 4, 4, 'Ilmiy-fantastika', '1950-12-02', 19.99),
('Anna Karenina', 5, 5, 'Tarixiy adabiyot', '1878-04-01', 34.99);


-- SELECT: books jadvalidagi barcha ma'lumotlarni tanlash
SELECT * FROM books;

-- 4.book_reviews jadvali-------------------------------------------------
DROP TABLE IF EXISTS book_reviews CASCADE; 

CREATE TABLE book_reviews (
    review_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id) ON DELETE CASCADE,
    review_text TEXT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_date DATE
);

-- INSERT: book_reviews jadvaliga O'zbekcha sharhlar qo'shish
INSERT INTO book_reviews (book_id, review_text, rating, review_date)
VALUES
(1, 'Sehrli dunyo va ajoyib boshlanish!', 5, '2025-01-11'),
(2, 'Distopik kelajakni tasvirlovchi ajoyib roman.', 4, '2025-01-10'),
(3, 'Gozal va fikrga boy roman.', 5, '2025-01-09'),
(4, 'Psykoxistoriyaning chuqur tahlili.', 4, '2025-01-08'),
(5, 'Tarixiy adabiyotning durdonasi.', 5, '2025-01-07');

-- SELECT: book_reviews jadvalidagi barcha ma'lumotlarni tanlash
SELECT * FROM book_reviews;
-- ---------------------------------------------------------------------------

-- SELECT: books jadvalidagi barcha ma'lumotlarni chiqarish
SELECT * FROM books;

-- ----------------------------------------------------------------------

-- SELECT: books jadvalidagi ma'lumotlarni satr nomlarini o'zgartirib chiqaring
SELECT title AS "Kitob Nomi", genre AS "Janr", price AS "Narx" FROM books;

-- ---------------------------------------------------------------------------------


-- SELECT: books jadvalidagi kitoblarni narx bo'yicha pasayish tartibida saralash
SELECT title, price FROM books ORDER BY price DESC;

-- ---------------------------------------------------------------------------------

-- SELECT: Fantastika janridagi kitoblarni qidirish
SELECT title FROM books WHERE genre = 'Fantastika';

-- ---------------------------------------------------------------------------------

-- SELECT: books jadvalidagi faqat birinchi 5 kitobni chiqarish
SELECT title FROM books LIMIT 5;

-- -------------------------------------------------------------------------------

-- SELECT: Fantastika va Distopiya janridagi kitoblarni qidirish
SELECT title FROM books WHERE genre IN ('Fantastika', 'Distopiya');

-- -------------------------------------------------------------------------------

-- SELECT: narxi 10 va 30 orasida bo'lgan kitoblarni qidirish
SELECT title, price FROM books WHERE price BETWEEN 10 AND 30;

-- -------------------------------------------------------------------------------

-- SELECT: "Harry" so'zi bilan boshlanadigan kitoblarni qidirish
SELECT title FROM books WHERE title LIKE 'Harry%';

-- -------------------------------------------------------------------------------

-- SELECT: book_reviews jadvalidagi sharh matni bo'lmagan yozuvlarni topish
SELECT * FROM book_reviews WHERE review_text IS NULL;

-- -------------------------------------------------------------------------------

-- SELECT: books, authors va publishers jadvalarini JOIN qilib, to'liq ma'lumotlarni chiqarish
SELECT b.title AS "Kitob Nomi", a.name AS "Muallif", p.name AS "Nashriyot", b.genre AS "Janr", b.price AS "Narx"
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN publishers p ON b.publisher_id = p.publisher_id;
















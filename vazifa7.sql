DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS actor_movie;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

-- Tablitsalar 
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT REFERENCES categories(category_id)
);

-- ---------------------------------------------------------------------------
-- Malumotlar
-- 5 ta kategoriya qo'shish
INSERT INTO categories (category_name) VALUES 
('Electronics'), 
('Clothing'), 
('Furniture'), 
('Books'), 
('Sports');

-- 15 ta product qo'shish, shulardan 5 tasi kategoriyaga bog'lanmagan
INSERT INTO products (product_name, category_id) VALUES 
('Smartphone', 1), 
('Laptop', 1), 
('Tablet', 1),
('T-shirt', 2), 
('Jeans', 2),
('Chair', 3), 
('Table', 3),
('Novel', 4), 
('Magazine', 4),
('Basketball', 5), 
('Football', 5),
('book', NULL),
('Smarttv', NULL),
('Tarvuz', NULL),
('Uzum', NULL),
('Limon', NULL);

-- 1.Productga bog'langan kategoriyalar va unga bog'langan mahsulotlar
SELECT c.category_name, p.product_name
FROM categories c
JOIN products p ON c.category_id = p.category_id;

-- 2.Productga bog'langan va bog'lanmagan kategoriyalar va kategoriyalarga bog'langan mahsulotlar
SELECT c.category_name, p.product_name
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id;

-- 3.Productga bog'langan kategoriyalar va kategoriyalarga bog'langan va bog'lanmagan mahsulotlar 
SELECT c.category_name, p.product_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id;

-- 4.Kategoriyalarga bog'lanmagan mahsulotlar
SELECT product_name
FROM products
WHERE category_id IS NULL;

-- 5.Mahsulotlarga bog'lanmagan kategoriyalar
SELECT category_name
FROM categories c
WHERE NOT EXISTS (
    SELECT 1 
    FROM products p 
    WHERE c.category_id = p.category_id
);

-- 6.Barcha kategoriya va barcha mahsulotlar
SELECT * FROM categories;
SELECT * FROM products;

-- 7.Mahsulotlarga bog'lanmagan barcha kategoriyalar va kategoriyalarga bog'lanmagan barcha mahsulotlar
SELECT c.category_name AS Unlinked_Category
FROM categories c
WHERE NOT EXISTS (
    SELECT 1 
    FROM products p 
    WHERE c.category_id = p.category_id
)
UNION
SELECT p.product_name AS Unlinked_Product
FROM products p
WHERE p.category_id IS NULL;
-- 8.Kategoriya va mahsulotlar CROSS JOIN
SELECT c.category_name, p.product_name
FROM categories c
CROSS JOIN products p;

-- 9.Kategoriya va mahsulotlar NATURAL JOIN
SELECT *
FROM categories
NATURAL JOIN products;

-- O'z-o'zidan qo'shilish
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    manager_id INT
);

-- Ma'lumotlar
INSERT INTO employees (emp_name, manager_id) VALUES 
('Alice', NULL), 
('Bob', 1), 
('Charlie', 1), 
('David', 2), 
('Eva', 3);


SELECT e1.emp_name AS Employee, e2.emp_name AS Manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.emp_id;

-- Aktyorlar va Filmlar jadvali
CREATE TABLE actors(
 actor_id SERIAL PRIMARY KEY,
 actor_name VARCHAR(50) NOT NULL
);

CREATE TABLE movies(
 movie_id SERIAL PRIMARY KEY,
 movie_title VARCHAR(50) NOT NULL
);

CREATE TABLE actor_movie(
 actor_id INT,
 movie_id INT,
 FOREIGN KEY (actor_id) REFERENCES actors(actor_id),
 FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- Aktyorlarni qo'shish
INSERT INTO actors (actor_name) VALUES ('Robert Downey Jr.'), ('Chris Evans'), ('Scarlett Johansson'), ('Chris Hemsworth'), ('Mark Ruffalo');

-- Filmlarni qo'shish
INSERT INTO movies (movie_title) VALUES ('Avengers'), ('Iron Man'), ('Thor'), ('Hulk'), ('Captain America');

-- Aktyor va filmlar bog’lanishi
INSERT INTO actor_movie (actor_id, movie_id) VALUES 
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), 
(1, 2), (3, 3), (4, 4), (5, 5);

SELECT a.actor_name, COUNT(am.movie_id) AS Movie_Count
FROM actors a
LEFT JOIN actor_movie am ON a.actor_id = am.actor_id
GROUP BY a.actor_name;
-- -----------------------------------------------------
-- Har bir toifani va shu toifadan nechtadan mahsulot borligini

SELECT c.category_name, COUNT(p.product_id) AS Product_Count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;




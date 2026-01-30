
PART 1 | Basic SQL Operations and JOIN queries

1. Basic Selection:

SELECT
    title,
    publication_year
FROM books
WHERE publication_year > 2000
ORDER BY publication_year DESC;


2. Filtering:

SELECT
    genres.genre_name,
    SUM(copies_owned) AS total_copies_owned
FROM books
INNER JOIN genres
ON books.genre_id = genres.genre_id
GROUP BY
    genres.genre_name
HAVING total_copies_owned > 5
ORDER BY books.copies_owned DESC;


3. Pattern Matching:

SELECT
    title
FROM books
WHERE title LIKE '%History%'
ORDER BY title ASC;


4. JOIN Operations:

SELECT
    loans.loan_id,
    loans.checkout_date,
    loans.due_date,
    patrons.first_name,
    patrons.last_name,
    patrons.email
FROM loans
INNER JOIN patrons
ON loans.patron_id = patrons.patron_id
WHERE loans.checkout_date BETWEEN '2023-01-01' AND '2023-01-31'
ORDER BY loans.checkout_date ASC;


5. Multi-table JOIN:

SELECT
    books.title,
    authors.first_name AS author_first_name,
    authors.last_name AS author_last_name,
    loans.checkout_date,
    loans.due_date
FROM books
INNER JOIN authors
    ON books.author_id = authors.author_id
INNER JOIN loans
    ON books.book_id = loans.book_id
ORDER BY checkout_date ASC;


6. Self JOIN:

SELECT
    patron1.first_name AS Patron1_First_Name,
    patron1.last_name AS Patron1_Last_Name,
    patron2.first_name AS Patron2_First_Name,
    patron2.last_name AS Patron2_Last_Name,
    patron2.city AS Patron2_City
FROM patrons AS patron1
INNER JOIN patrons AS patron2
    ON patron1.city = patron2.city
    AND patron1.last_name < patron2.last_name
ORDER BY patron1.city, patron1.last_name, patron2.last_name;


7. Multi-table JOIN with Filtering

SELECT
    books.genre_id,
    patrons.first_name,
    patrons.last_name,
    branches.branch_name
FROM loans
INNER JOIN books
    ON loans.book_id = books.book_id
INNER JOIN branches
    ON loans.branch_id = branches.branch_id
INNER JOIN patrons
    ON loans.patron_id = patrons.patron_id
WHERE books.genre_id = 1;

___________________________________________


PART 2 | Aggregation and GROUP BY Operations

8. COUNT Aggregation:

SELECT
    genres.genre_name,
    COUNT(DISTINCT book_id) AS total_books
FROM books
LEFT JOIN genres
    ON books.genre_id = genres.genre_id
GROUP BY genres.genre_name;


9. Multiple Aggregations

SELECT
    branches.branch_name,
    AVG(julianday(return_date) - julianday(checkout_date)) AS average_duration,
    MIN(julianday(return_date) - julianday(checkout_date)) AS shortest_duration,
    MAX(julianday(return_date) - julianday(checkout_date)) AS longest_duration
FROM loans
LEFT JOIN branches
    ON loans.branch_id = branches.branch_id
WHERE return_date IS NOT NULL
GROUP BY branches.branch_name;


10. Conditional Aggregation
** was not able to get the query to return data using return_date = ''
** the column displayed empty cells as NULL

SELECT
    patrons.patron_id,
    patrons.first_name AS patron_first_name,
    patrons.last_name AS patron_last_name,
    COUNT(loans.book_id) AS total_overdue_books
FROM loans
LEFT JOIN patrons
    ON loans.patron_id = patrons.patron_id
WHERE loans.due_date < CURRENT_DATE AND loans.return_date IS NULL
GROUP BY
    patrons.patron_id,
    patrons.last_name,
    patrons.first_name;


11. Time-based Analysis:

SELECT
    strftime('%Y', date(checkout_date)) AS checkout_year,
    strftime('%m', date(checkout_date)) AS checkout_month,
    COUNT(DISTINCT patron_id) AS total_patrons,
    COUNT(loan_id) AS total_loans
FROM loans
GROUP BY
    checkout_year,
    checkout_month;


___________________________________________


BONUS:







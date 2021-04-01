		# Lab | SQL Join (Part II)
USE sakila;

# 1. Write a query to display for each store its store ID, city, and country.
SELECT * FROM sakila.address; 

SELECT DISTINCT(s.store_id), ci.city, ct.country
FROM sakila.store s
JOIN sakila.address a
USING (address_id)
JOIN sakila.city ci
USING (city_id)
JOIN sakila.country ct
USING (country_id)
GROUP BY s.store_id;


# 2. Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM sakila.payment;
SELECT * FROM sakila.address;
SELECT * FROM sakila.store;
SELECT * FROM sakila.customer;
 -- store + customer (storeid) + 

SELECT DISTINCT(s.store_id), SUM(p.amount)
FROM sakila.store s
JOIN sakila.customer c
USING (store_id)
JOIN sakila.payment p
USING (customer_id)
GROUP BY s.store_id;
-- Store 1 brought 37.001,52$, store 2 brought 30.414,99$


# 3. Which film categories are longest?
SELECT c.name, SUM(f.length)
FROM sakila.film f
JOIN sakila.film_category fc
USING (film_id)
JOIN sakila.category c
USING (category_id)
GROUP BY c.name
ORDER BY SUM(f.length) DESC
LIMIT 3;
-- I've added the limit3 to put a limit for the longest film categories which are: Sports, Foreign and Family.

# 4. Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(DISTINCT r.rental_id)
FROM sakila.payment p
JOIN sakila.rental r
USING (rental_id)
JOIN sakila.inventory i
USING (inventory_id)
JOIN sakila.film f
USING (film_id)
GROUP BY f.title
ORDER BY COUNT(DISTINCT r.rental_id) DESC;


# 5. List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount)
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
JOIN sakila.inventory i
USING (film_id)
JOIN sakila.rental r
USING (inventory_id)
JOIN sakila.payment p
USING (rental_id)
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;


# 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT * FROM sakila.rental;

SELECT f.title, i.store_id, rental_id, r.return_date
FROM sakila.film f
JOIN sakila.inventory i
USING (film_id)
JOIN sakila.rental r
USING (inventory_id)
WHERE (f.title = 'ACADEMY DINOSAUR') AND (i.store_id = '1') AND (return_date IS NULL);
-- The film is available for rent from Store 1. Checking for both stores, it is not available for store 2.


# 7. Get all pairs of actors that worked together.
SELECT  first_name, last_name, fa.film_id
FROM sakila.actor a
RIGHT JOIN sakila.film_actor fa
USING(actor_id);

# 8. Get all pairs of customers that have rented the same film more than 3 times.
SELECT customer_id, first_name, last_name, film_id
FROM sakila.customer c
RIGHT JOIN sakila.rental  r
USING (customer_id)
RIGHT JOIN sakila.inventory i
USING (inventory_id);


# 9. For each film, list actor that has acted in more films.
SELECT fa.film_id, actor_id, a.first_name, a.last_name
FROM sakila.film_actor fa
RIGHT JOIN sakila.actor a
USING (actor_id)
ORDER BY actor_id;

SELECT a1.film_id, a2.actor_id
FROM sakila.film_actor a1
JOIN sakila.film_actor a2
ON (a1.actor_id = a2.actor_id) AND (a1.film_id <> a2.film_id)
ORDER BY a1.film_id ASC;


SELECT * FROM online_retail_store.categories_table;

-- 1. Retrieve a list of all customers along with their email addresses.
SELECT customer_id, first_name, last_name, email
FROM Customers_table
where email is not null;
-- 2. Find the total number of orders placed by each customer.
SELECT custom_id, COUNT(order_id) AS total_orders
FROM orders_table
GROUP BY custom_id;
 -- 3. List all products along with their prices.
SELECT product_id, product_name, price
FROM Products;
-- 4. Retrieve the category with the highest number of products.
SELECT categore_id, COUNT(product_id) AS total_products
FROM Products
GROUP BY categore_id
ORDER BY total_products DESC
LIMIT 1;
-- Intermediate Queries:
-- 5. Find all customers who have not placed any orders.
SELECT customer_id, first_name, last_name
FROM Customers
WHERE customer_id NOT IN (SELECT customer_id FROM Orders);
-- 6. List the products with the highest and lowest prices.
SELECT product_id, product_name, price
FROM Products
WHERE price = (SELECT MAX(price) FROM Products)
   OR price = (SELECT MIN(price) FROM Products);
-- 7. Calculate the average order amount for each customer.
SELECT customer_id, AVG(total_amount) AS average_order_amount
FROM Orders
GROUP BY customer_id;
-- 8. Find the categories that do not have any products.
SELECT category_id, category_name
FROM Categories
WHERE category_id NOT IN (SELECT category_id FROM Products);
-- Advanced Queries:
-- 9. Retrieve a list of customers who have placed orders for products with a price higher than $100.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Products p ON o.product_id = p.product_id
WHERE p.price > 100;
-- 10. List the customers who have placed orders for products from at least three different categories.
SELECT c.customer_id, c.first_name, c.last_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT p.category_id) >= 3;
-- 11. Find the products with the highest and lowest average customer ratings (if a rating table is available).
SELECT product_id, product_name, AVG(rating) AS average_rating
FROM Ratings
GROUP BY product_id, product_name
ORDER BY average_rating DESC
LIMIT 1;

SELECT product_id, product_name, AVG(rating) AS average_rating
FROM Ratings
GROUP BY product_id, product_name
ORDER BY average_rating ASC
LIMIT 1;
-- 12. Calculate the total revenue generated from each category.
SELECT c.category_id, c.category_name, SUM(p.price * o.total_amount) AS total_revenue
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
LEFT JOIN Orders o ON p.product_id = o.product_id
GROUP BY c.category_id, c.category_name;

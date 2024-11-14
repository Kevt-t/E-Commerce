-- 1. Retrieve Customer Order Details
SELECT 
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    orders.order_id,
    orders.order_date
FROM 
    customers
JOIN 
    orders ON customers.customer_id = orders.customer_id
WHERE 
    orders.status = 'Delivered';

-- 2. Get Detailed Order Items for a Specific Order
SELECT 
    orders.order_id,
    products.product_id,
    products.name AS product_name,
    order_details.quantity,
    order_details.price_per_product
FROM 
    orders
JOIN 
    order_details ON orders.order_id = order_details.order_id
JOIN 
    products ON order_details.product_id = products.product_id
WHERE 
    orders.order_id = 1
ORDER BY 
    products.product_id ASC;

-- 3. List Orders with Customer Information
SELECT 
    orders.order_id,
    orders.order_date,
    orders.status,
    customers.first_name,
    customers.last_name,
    customers.email
FROM 
    orders
JOIN 
    customers ON orders.customer_id = customers.customer_id
WHERE 
    orders.status = 'Pending';

-- 4. Calculate Total Sales per Customer
SELECT 
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    SUM(order_details.quantity * order_details.price_per_product) AS total_sales
FROM 
    customers
JOIN 
    orders ON customers.customer_id = orders.customer_id
JOIN 
    order_details ON orders.order_id = order_details.order_id
GROUP BY 
    customers.customer_id, customers.first_name, customers.last_name;

-- 5. Find Products Ordered by Multiple Customers
SELECT 
    products.product_id,
    products.name,
    COUNT(DISTINCT orders.customer_id) AS customer_count
FROM 
    products
JOIN 
    order_details ON products.product_id = order_details.product_id
JOIN 
    orders ON order_details.order_id = orders.order_id
GROUP BY 
    products.product_id, products.name
HAVING 
    customer_count > 1;

-- 6. Display All Product Sales with Quantities and Customers
SELECT 
    products.product_id,
    products.name,
    order_details.quantity,
    customers.customer_id,
    customers.first_name
FROM 
    products
JOIN 
    order_details ON products.product_id = order_details.product_id
JOIN 
    orders ON order_details.order_id = orders.order_id
JOIN 
    customers ON orders.customer_id = customers.customer_id
ORDER BY 
    products.product_id, customers.customer_id ASC;

#Reflection Questions
-- After completing the joins, reflect on the following:
-- - How does joining tables help you get a fuller picture of customer orders and product information?
-- - Joining tables provides a multidimensional view of data that enhances business intelligence, while aggregations turn raw data into actionable insights, making them fundamental to decision-making in e-commerce.

-- - Which joins were most challenging to understand? Why?
-- - Combining more than two tables was tricky, it requires carefully linking the appropriate foreign keys across multiple relationships. In this activity, I was getting confused retrieving detailed order items by joining the orders, order_details, and products tables.

-- -  How could joining tables and using aggregations be useful for reporting in an e-commerce application?
-- - Joining tables and aggregating data allow for comprehensive sales and customer reports, inventory tracking, and performance insights. This helps in making informed decisions on marketing, stock management, and customer service improvements.

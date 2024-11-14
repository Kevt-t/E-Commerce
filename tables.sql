
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- 2. Create the Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create the Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create the Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 5. Create the Order Details Table
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_product DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 6. Populate the Tables with Sample Data

-- Sample data for the customers table
INSERT INTO customers (first_name, last_name, email, phone, address, city, state, zip_code)
VALUES 
    ('Kevin', 'Tellez-Torres', 'kevin@gmail.com', '1234567890', '110 SCP St', 'Akron', 'OH', '62701'),
    ('George', 'Tellez-Torres', 'george@gmail.com', '0987654321', '354 CI St', 'Akron', 'IL', '62702');

-- Sample data for the products table
INSERT INTO products (name, description, price, stock_quantity)
VALUES 
    ('SCP 096 Plushie', 'A medium sized plushie of shy guy, known for covering its face. Not recommended to look at its face!', 25.99, 150),
    ('SCP 173 Plushie', 'A small plushie of peanut, also known as the "Sculpture". Make sure not to blink!', 29.99, 200),
    ('SCP 682 Plushie', 'A large plushie of SCP-682, the hard-to-destroy reptile. Maybe a little easier to destroy.', 74.99, 100);

-- Fetch customer IDs to confirm them
SELECT * FROM customers;

-- Assuming that the customer IDs are confirmed as 1 for Kevin and 2 for George, proceed with the following inserts.
-- If IDs are different, adjust them accordingly in the following inserts.

-- Sample data for the orders table
-- Order for Kevin (customer_id = 1)
INSERT INTO orders (customer_id, total_amount, status)
VALUES 
    (1, 155.96, 'Pending');

-- Order for George (customer_id = 2)
INSERT INTO orders (customer_id, total_amount, status)
VALUES 
    (2, 74.99, 'Pending');

-- Sample data for the order_details table
-- Order details for Kevin's order (order_id = 1)
INSERT INTO order_details (order_id, product_id, quantity, price_per_product)
VALUES 
    (1, 1, 2, 25.99),  -- 2 SCP 096 Plushies at $25.99 each
    (1, 2, 2, 29.99);  -- 2 SCP 173 Plushies at $29.99 each

-- Order details for George's order (order_id = 2)
INSERT INTO order_details (order_id, product_id, quantity, price_per_product)
VALUES 
    (2, 3, 1, 74.99);  -- 1 SCP 682 Plushie at $74.99

-- 7. **Write Queries to Test Your Database**
--    - Retrieve all orders for a specific customer, showing only the order IDs and date
--    - SELECT order_id, order_date FROM orders WHERE customer_id = 1;

--    - Retrieve all details for a specific order, showing each product’s name, quantity, and price per item.
		/*
		SELECT 
			p.name AS product_name, 
			od.quantity, 
			od.price_per_product
		FROM 
			order_details od
		JOIN 
			products p ON od.product_id = p.product_id
		WHERE 
			od.order_id = 1;
		*/

--    - Write a query to update the stock in the `products` table after an order has been placed.
		/*
		UPDATE 
			products p 
		JOIN
			order_details od ON p.product_id = od.product_id 
		SET 
			p.stock_quantity = p.stock_quantity - od.quantity 
		WHERE 
			od.order_id = 1;
*/

-- #### Reflection
-- - How do the tables work together to create a full picture of customers and orders?
-- - When a customer places an order, a new entry is created in the orders table, which links back to the customers table using the customer_id. This establishes a relationship between a customer and their orders.

-- - Why are foreign keys essential in linking different tables in a relational database?
-- - They prevent stray records by ensuring that any value in a foreign key field must match an existing primary key in the referenced table.

-- - What challenges did you face when designing this schema?
-- - As I designed this schema, one of my main challenges was deciding on the appropriate data types and constraints for each column. I wanted to make sure that the schema would not only be efficient but also enforce data integrity and make sense for the data it would store. 

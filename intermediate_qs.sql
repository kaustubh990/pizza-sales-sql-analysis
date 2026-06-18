

USE pizzahut;

SELECT
    pizza_types.category,
    SUM(orders_details.quantity) AS total_quantity
FROM orders_details
JOIN pizzas
    ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;






SELECT
    pizza_types.category,
    COUNT(pizzas.pizza_id) AS total_pizzas
FROM pizzas
JOIN pizza_types
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_pizzas DESC;








SELECT
    pizza_types.name,
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS revenue
FROM orders_details
JOIN pizzas
    ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;



--qs-Which are the top 5 pizzas that generated the highest revenue?
SELECT
    pizza_types.name AS pizza_type,
    SUM(orders_details.quantity * pizzas.price) AS revenue
FROM orders_details
JOIN pizzas
    ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 5;




--qs-Find the average number of pizzas ordered per day.
SELECT
    ROUND(AVG(total_pizzas), 2) AS avg_pizzas_per_day
FROM (
    SELECT
        orders.order_date,
        SUM(orders_details.quantity) AS total_pizzas
    FROM orders
    JOIN orders_details
        ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date
) AS daily_orders;



--Which pizza category contributes the most to total revenue?
SELECT
    pizza_types.category,
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS revenue
FROM orders_details
JOIN pizzas
    ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

--Which pizza type has generated the highest total revenue across all orders?

SELECT
    pizza_types.name AS pizza_type,
    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS revenue
FROM orders_details
JOIN pizzas
    ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 1;



--What is the average order value (AOV) for all pizza orders?


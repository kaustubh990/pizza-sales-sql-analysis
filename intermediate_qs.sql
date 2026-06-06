

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

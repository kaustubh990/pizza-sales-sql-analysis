USE pizzahut;

SELECT
    pizza_types.name AS pizza_type,
    ROUND(
        SUM(orders_details.quantity * pizzas.price) * 100 /
        (
            SELECT SUM(orders_details.quantity * pizzas.price)
            FROM orders_details
            JOIN pizzas
                ON orders_details.pizza_id = pizzas.pizza_id
        ),
        2
    ) AS revenue_percentage
FROM orders_details
JOIN pizzas
    ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY revenue_percentage DESC;

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





--qs 2
SELECT
    orders.order_date,
    SUM(orders_details.quantity * pizzas.price) AS daily_revenue,
    SUM(SUM(orders_details.quantity * pizzas.price))
        OVER (ORDER BY orders.order_date) AS cumulative_revenue
FROM orders
JOIN orders_details
    ON orders.order_id = orders_details.order_id
JOIN pizzas
    ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY orders.order_date
ORDER BY orders.order_date;




--qs3
WITH pizza_revenue AS (
    SELECT
        pizza_types.category,
        pizza_types.name AS pizza_type,
        SUM(orders_details.quantity * pizzas.price) AS revenue
    FROM orders_details
    JOIN pizzas
        ON orders_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types
        ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    GROUP BY pizza_types.category, pizza_types.name
),
ranked_pizzas AS (
    SELECT
        category,
        pizza_type,
        revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS rank_num
    FROM pizza_revenue
)
SELECT
    category,
    pizza_type,
    revenue
FROM ranked_pizzas
WHERE rank_num <= 3
ORDER BY category, revenue DESC;

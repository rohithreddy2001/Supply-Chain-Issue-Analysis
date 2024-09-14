create table Orders_Aggregate as (
SELECT 
    oa.*, 
    ol.product_id, 
    ol.product_name, 
    ol.category 
FROM 
    fact_orders_aggregate oa 
INNER JOIN (
    SELECT 
        order_id, 
        MIN(product_id) AS product_id,  -- Choosing the first product_id for each order_id
        MIN(product_name) AS product_name,  -- Choosing the first product_name for each order_id
        MIN(category) AS category  -- Choosing the first category for each order_id
    FROM 
        order_lines 
    GROUP BY order_id
) ol 
USING (order_id)
)
USE RetailDB;

-- Task 3 – CTE and ROW_NUMBER (Top 3 Products) --
WITH ProductSales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(s.total_sales) AS total_sales
    FROM Products p
    JOIN Sales s
    ON p.product_id = s.product_id
    GROUP BY p.product_id, p.product_name, p.category
),

RankedProducts AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS ranking
    FROM ProductSales
)
SELECT *
FROM RankedProducts
WHERE ranking <= 3;


-- Task 4 – LEAD and LAG (Month-on-Month Sales) --
SELECT
    p.product_name,
    s.sale_month,
    s.total_sales,

    LAG(s.total_sales) OVER (
        PARTITION BY s.product_id
        ORDER BY s.sale_month
    ) AS previous_sales,

    LEAD(s.total_sales) OVER (
        PARTITION BY s.product_id
        ORDER BY s.sale_month
    ) AS next_sales,

    s.total_sales - LAG(s.total_sales) OVER (
        PARTITION BY s.product_id
        ORDER BY s.sale_month
    ) AS monthly_change

FROM Sales s
JOIN Products p
ON s.product_id = p.product_id;


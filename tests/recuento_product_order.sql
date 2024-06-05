SELECT *
FROM {{ ref('int_product_order') }}
where abs(transaction_shipping_cost + transaction_cost - transaction_discount - transaction_total_cost) > 0.01 
/* comprueba si el recuento de los costes proporcionales al producto son correctos con una tolerancia de un centimo debido a los decimales */
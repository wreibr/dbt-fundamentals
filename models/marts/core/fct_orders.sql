
{{config(
    materialized="table"
    )
}}

with 

payments as (

    select * from {{ ref('stg_payments') }}

    ),

orders as (

    select * from {{ ref('stg_orders') }}

    ),

payment_orders as (

    select
        order_id,

        sum(amount) as amount,
        count(order_id) as number_of_payments

    from payments

    group by 
        order_id

    ),

final as (

    select
        o.order_id,
        o.customer_id,
        o.order_date,
        coalesce(p.amount, 0) as amount,
        coalesce(p.number_of_payments, 0) as number_of_payments

    from orders as o

    left join payment_orders as p using (order_id)

    )

select * from final
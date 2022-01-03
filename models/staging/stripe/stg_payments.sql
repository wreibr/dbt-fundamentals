
with

payments as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod,
        status,
        amount / 100 as amount

    from {{source('stripe','payment')}}

    where
        status = 'success'

    )

select * from payments

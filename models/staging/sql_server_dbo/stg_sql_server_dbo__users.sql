with 

source_users as (

    select * from {{ ref('base_sql_server_dbo__users') }}

),
source_orders as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        U.user_id,
        U.updated_at_utc,
        U.address_id,
        U.last_name,
        U.created_at_utc,
        U.phone_number,
        O.total_orders,
        U.first_name,
        U.email,
        coalesce (regexp_like(U.email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address,
        U._fivetran_deleted,
        U.date_load_utc

    from source_users U
    join (select user_id, count(order_id) as total_orders from source_orders group by user_id) O
    on U.user_id = O.user_id  

)

select * from renamed

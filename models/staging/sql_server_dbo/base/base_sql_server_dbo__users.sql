with 

source_users as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        U.user_id,
        U.updated_at as updated_at_utc,
        U.address_id,
        U.last_name,
        U.created_at as created_at_utc,
        U.phone_number,
        U.total_orders,
        U.first_name,
        U.email,
        coalesce (regexp_like(U.email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc

    from source_users U
    

)

select * from renamed
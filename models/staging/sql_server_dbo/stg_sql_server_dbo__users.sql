with 

source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id,
        updated_at,
        address_id,
        last_name,
        created_at as created_at_utc,
        phone_number,
        total_orders,
        first_name,
        email,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc

    from source

)

select * from renamed

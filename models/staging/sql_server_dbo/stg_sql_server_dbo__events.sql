with 

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        case 
            when product_id = '' then md5('')
            else product_id
        end as product_id,
        session_id,
        created_at as created_at_utc,
        iff(order_id = '', md5('sin order'),order_id) as order_id,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc

    from source

)

select * from renamed

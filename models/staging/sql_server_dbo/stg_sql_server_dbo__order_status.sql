with 

source as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        md5(status) as order_status_id,
        status as order_status

    from source

    union 

    select
        md5('') as order_status_id,
        null

)

select * from renamed
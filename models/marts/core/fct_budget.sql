with 

source as (

    select * from {{ ref('stg_google_sheets__budget') }}

),

renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        date_load_utc

    from source

)

select * from renamed
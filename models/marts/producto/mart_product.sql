with 

stg_events as (

    select * from {{ ref('fct_events') }}
),

int_sum_events as (

    select * from {{ ref('int_event_session') }}
),

dim_user as (

    select * from {{ ref('dim_users') }}
),

rename as (

    select 
        E.session_id,
        E.user_id,
        U.first_name,
        U.last_name,
        min(E.created_at_utc) as first_event_time_utc,
        max(E.created_at_utc) as last_event_time_utc,
        datediff(minute, first_event_time_utc, last_event_time_utc) as session_length_minutes,
        CHECKOUT_AMOUNT,
        PACKAGE_SHIPPED_AMOUNT,
        ADD_TO_CART_AMOUNT,
        PAGE_VIEW_AMOUNT
        
    from stg_events E
    join int_sum_events S
    on E.session_id = S.session_id
    join dim_user U 
    on E.user_id = U.user_id
    group by 1,2,3,4,8,9,10,11  

)

select * from rename
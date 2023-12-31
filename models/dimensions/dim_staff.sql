{{ config(
    post_hook = 'insert into {{this}}(staff_id) VALUES (-1)'
) }}

WITH staff_base AS (

    SELECT
        *,
        (
            CASE
                WHEN active :: INT = 1 THEN 1
                ELSE 0
            END
        ) AS active_int,
        (
            CASE
                WHEN active :: INT = 1 THEN 'yes'
                ELSE 'no'
            END
        ) AS active_desc,
        '{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}' :: TIMESTAMP AS dbt_time
    FROM
        {{ source(
            'stg_source',
            'staff'
        ) }}
)
SELECT
    staff_id,
    first_name,
    last_name,
    email,
    active_int AS active,
    active_desc,
    last_update,
    dbt_time
FROM
    staff_base

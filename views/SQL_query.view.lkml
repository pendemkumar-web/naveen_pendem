view: sql_runner_query {
  derived_table: {
    sql: SELECT
          products.category  AS `products.category`,
              (YEAR(users.created_at )) AS `users.created_year`,
          COALESCE(SUM(order_items.sale_price ), 0) AS `order_items.total_revenue`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id
      WHERE ((( inventory_items.created_at  ) >= ((TIMESTAMP('2017-01-01'))) AND ( inventory_items.created_at  ) < ((DATE_ADD(TIMESTAMP('2017-01-01'),INTERVAL 1 year)))))
      GROUP BY
          1,
          2
      ORDER BY
          2 DESC
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_category {
    type: string
    sql: ${TABLE}.`products.category` ;;
  }

  dimension: users_created_year {
    type: number
    sql: ${TABLE}.`users.created_year` ;;
  }

  dimension: order_items_total_revenue {
    type: number
    sql: ${TABLE}.`order_items.total_revenue` ;;
  }

  set: detail {
    fields: [
      products_category,
      users_created_year,
      order_items_total_revenue
    ]
  }
}



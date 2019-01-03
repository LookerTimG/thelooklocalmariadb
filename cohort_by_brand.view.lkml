view: cohort_by_brand {
  derived_table: {
    sql: SELECT u.id AS user_id
          , p.brand

      FROM order_items oi
      INNER JOIN inventory_items ii
      ON oi.inventory_item_id = ii.id
      INNER JOIN products p
      ON ii.product_id = p.id
      INNER JOIN orders o
      ON oi.order_id = o.id
      INNER JOIN users U
      ON o.user_id = u.id
      WHERE {% condition brand_purchased %} p.brand {% endcondition %}
       ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  filter: brand_purchased {
    description: "Choose the brand your cohort has purchased"
    type: string
#     suggest_explore: order_items
#     suggest_dimension: products.brand
    suggest_explore: order_items
    suggest_dimension: products.brand
  }
}

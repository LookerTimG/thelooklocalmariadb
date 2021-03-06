connection: "thelooklocalmariadb"
#connection: "postgres_local_thelook"

# include all the views
include: "order_items.view"
include: "inventory_items.view"
include: "orders.view"
include: "products.view"
include: "users.view"
include: "cohort_by_brand.view"
include: "filter_test.view"


explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: cohort_by_brand {
    type: inner
    relationship: one_to_one
    sql_on: ${users.id} = ${cohort_by_brand.user_id} ;;
  }
}

  explore: filter_test {}

view: filter_test {
  derived_table: {
    sql: SELECT *
    FROM thelook.products
    WHERE {% condition brand_filter %} brand {% endcondition %}
       ;;
  }

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: brand {
      type: string
      sql: ${TABLE}.brand ;;
    }

    dimension: category {
      type: string
      sql: ${TABLE}.category ;;
    }

    dimension: department {
      type: string
      sql: ${TABLE}.department ;;
    }

    dimension: item_name {
      type: string
      sql: ${TABLE}.item_name ;;
    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
    }

    dimension: retail_price {
      type: string
      sql: ${TABLE}.retail_price ;;
    }

    dimension: sku {
      type: string
      sql: ${TABLE}.sku ;;
    }

    measure: count {
      type: count
      drill_fields: [id, item_name, inventory_items.count]
    }

    filter: brand_filter {
      description: "Filter on the brand"
      suggest_explore: filter_test
      suggest_dimension: brand
    }
  }

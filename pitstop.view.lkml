view: pitstop {
  sql_table_name: car_race.pitstop ;;

  dimension: f_pitstop_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.fPitstop_id ;;
  }

  dimension: car_id {
    type: number
    sql: ${TABLE}.Car_id ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      minute15,
      minute,
      second
    ]
    sql: ${TABLE}.End_time ;;
  }

  dimension: num_pit_crew {
    type: number
    sql: ${TABLE}.Num_pit_crew ;;
  }

  dimension: racer_id {
    type: number
    sql: ${TABLE}.Racer_id ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      minute15,
      minute,
      second
    ]
    sql: ${TABLE}.Start_time ;;
  }

  dimension: duration_seconds {
    label: "Time in seconds car was in the pit"
    description: "calculated from start and end times"
    type: number
    sql: TIMESTAMPDIFF(SECOND,${start_raw},${end_raw}) ;;
  }

dimension_group: duration_group {
  label: "time spent in pitstop"
  description: "Time in pitstop in various intervals"
  type: duration
  sql_start: ${start_raw} ;;
  sql_end: ${end_raw} ;;
  intervals: [
    second,
    minute
  ]
}

  measure: count {
    type: count
    drill_fields: [f_pitstop_id]
  }

  measure: duration_seconds_sum {
    label: "Time in seconds car was in the pit"
    description: "calculated from start and end times"
    type: sum
    sql: ${seconds_duration_group};;
  }

  measure: duration_seconds_avg {
    label: "Average time in seconds car was in pit"
    description: "Average calculated from duration_seconds"
    type: average
    sql: ${duration_seconds} ;;
    value_format_name: decimal_2
  }
}

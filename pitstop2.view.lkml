view: pitstop2 {
  derived_table: {
    sql: WITH C1
      AS
      (
      SELECT Car_id,
        fPitstop_id,
        Num_pit_crew,
        Racer_id,
        Start_time,
      TIME_TO_SEC(TIMEDIFF(End_time, Start_time)) AS Pit_time
      FROM car_race.pitstop
      ORDER BY Car_id, Start_time
      )
      SELECT Car_id,
        fPitstop_id,
        Num_pit_crew,
        Racer_id,
        Start_time,
        Pit_time,
        CASE WHEN LAG(Car_id, 1) OVER(ORDER BY Car_id, Start_time) = Car_id
              THEN Pit_time - LAG(Pit_time, 1) OVER(ORDER BY Car_id, Start_time)
              ELSE NULL
              END AS Pit_stop_difference
      FROM C1
       ;;
  }

  dimension: car_id {
    type: number
    sql: ${TABLE}.Car_id ;;
  }

  dimension: f_pitstop_id {
    type: number
    sql: ${TABLE}.fPitstop_id ;;
  }

  dimension: num_pit_crew {
    type: number
    sql: ${TABLE}.Num_pit_crew ;;
  }

  dimension: racer_id {
    type: number
    sql: ${TABLE}.Racer_id ;;
  }

  dimension_group: start_time {
    type: time
    sql: ${TABLE}.Start_time ;;
  }

  dimension: pit_time {
    type: number
    sql: ${TABLE}.Pit_time ;;
  }

  dimension: pit_stop_difference {
    type: number
    sql: ${TABLE}.Pit_stop_difference ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

measure: pit_stop_trend {
  type: string
  sql: CASE WHEN SUM(${pit_stop_difference}) < 0 THEN 'Decrease'
      WHEN SUM(${pit_stop_difference}) > 0 THEN 'Increase'
      ELSE 'No Change'
      END
      ;;
}

measure: pit_time_avg {
  type: average
  sql: ${pit_time} ;;
  value_format_name: decimal_1
}

  set: detail {
    fields: [
      car_id,
      f_pitstop_id,
      num_pit_crew,
      racer_id,
      start_time_time,
      pit_time,
      pit_stop_difference
    ]
  }
}

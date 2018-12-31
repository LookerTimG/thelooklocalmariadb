connection: "localmariadb_testdb"

include: "pitstop.view.lkml"
include: "pitstop2.view.lkml"
# include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: pitstop {}

explore: pitstop2 {}

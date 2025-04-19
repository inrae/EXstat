# Selection of stations from Aqui-FR database
# (https://www.drias-eau.fr/accompagnement/sections/414)
# H1700010: La Seine à Pont-sur-Seine
# H5920014: La Seine à Paris - Austerlitz [>2006]

library(dplyr)

df <- readr::read_delim(
  "data-raw/Aqui-FR-Qnat_1852_2008_Seine.csv",
  delim = ";"
)

df <- df |> select("date", "H1700010", "H5920014")

readr::write_tsv(df, "inst/examples/Aqui-FR-Qnat.tsv")

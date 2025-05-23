#   ___                _ 
#  / __| __ _  _ _  __| |
# | (__ / _` || '_|/ _` |
#  \___|\__,_||_|  \__,_|
# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1
#
# *1   INRAE, France
#
# This file is part of CARD R library.
#
# CARD R library is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# CARD R library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CARD R library.
# If not, see <https://www.gnu.org/licenses/>.


## INFO ______________________________________________________________
### English __________________________________________________________
CARD$P.variable_en = "med{dtLF}"
CARD$P.unit_en = "day"
CARD$P.name_en = "Median duration of low flows"
CARD$P.description_en = "Median of the durations of the longest continuous period with 10-day mean flows below the maximum of VCN10"
CARD$P.method_en = "1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - minimum (extraction from the series of VCN10)
3. no temporal aggregation - the maximum of the series of VCN10 is taken as the threshold
4. annual aggregation [Month of maximum monthly flows] - number of days in the longest period below the previous threshold
5. no temporal aggregation - median"
CARD$P.sampling_period_en = "Month of maximum monthly flows"
CARD$P.topic_en = "Flow, Low Flows, Duration"

### French ___________________________________________________________
CARD$P.variable_fr = "med{dtBE}"
CARD$P.unit_fr = "jour"
CARD$P.name_fr = "Médiane de la durée des basses eaux"
CARD$P.description_fr = "Médiane des durées de la plus longue période continue de la moyenne sur 10 jours sous le maximum des VCN10"
CARD$P.method_fr = "1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum (extraction de la série des VCN10)
3. aucune agrégation temporelle - le maximum de la série des VCN10 est pris comme seuil
4. agrégation annuelle [Mois du maximum des débits mensuels] - nombre de jours de la plus longue période sous le précédent seuil
5. aucune agrégation temporelle - médiane"
CARD$P.sampling_period_fr = "Mois du maximum des débits mensuels"
CARD$P.topic_fr = "Débit, Basses Eaux, Durée"

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 1
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"

### P2 _______________________________________________________________
CARD$P2.funct = list(VCN10=minNA)
CARD$P2.funct_args = list("VC10", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = "all"

### P3 _______________________________________________________________
CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("VCN10", na.rm=TRUE)
CARD$P3.time_step = "none"
CARD$P3.keep = "all"

### P4 _______________________________________________________________
CARD$P4.funct = list(dtLF=apply_threshold)
CARD$P4.funct_args = list("VC10", lim="upLim", where="<=", what="length", select="longest")
CARD$P4.time_step = "year"
CARD$P4.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P4.NApct_lim = 3

### P5 _______________________________________________________________
CARD$P5.funct = list("med{dtLF}"=median)
CARD$P5.funct_args = list("dtLF", na.rm=TRUE)
CARD$P5.time_step = "none"


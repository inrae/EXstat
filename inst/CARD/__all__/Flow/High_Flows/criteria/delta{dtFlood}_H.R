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


Horizon = c("H1", "H2", "H3")
Horizon_en = c("near", "middle", "distant")
Horizon_fr = c("proche", "moyen", "lointain")
H0 = c("1976-01-01", "2005-08-31")
H1 = c("2021-01-01", "2050-12-31")
H2 = c("2041-01-01", "2070-12-31")
H3 = c("2070-01-01", "2099-12-31")


## INFO ______________________________________________________________
### English __________________________________________________________
CARD$P.variable_en = paste0("delta{dtFlood}_", Horizon)
CARD$P.unit_en = "day"
CARD$P.name_en = paste0("Average change of the duration of floods between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = paste0("Duration of floods, sampled by annual maxima. The series exploited is the difference between the raw flow and the base flow, assimilated to runoff Qr. Floods are identified based on the annual maximum in the Qr series, and for each flood, the duration is defined as the number of days where Qr is above half of the annual maxima.")
CARD$P.method_en = paste0("1. no temporal aggregation - Qr difference between daily flow values and base flow
2. annual aggregation [Month of minimum monthly flows] - maximum Qr
3. annual aggregation [Month of minimum monthly flows] - division by two of the annual maxima to obtain a threshold
4. annual aggregation [Month of minimum monthly flows] - number of days where the difference is above the threshold
5. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow, High Flows, Duration"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta{dtCrue}_", Horizon)
CARD$P.unit_fr = "jour"
CARD$P.name_fr = paste0("Changement moyen de la durée des crues entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = paste0("Durée des crues, échantillonnées par maxima annuel. La série exploitée est la différence entre le débit brut et le débit de base, assimilé au ruissellement Qr. Les crues sont identifiées sur la base du maximum annuel dans la série des Qr et pour chaque crue, la durée est définie comme le nombre de jours où Qr est supérieur au maxima annuel divisé par 2.")
CARD$P.method_fr = paste0("1. aucune agrégation temporelle - différence Qr entre les valeurs journalières de débit par le débit de base
2. agrégation annuelle [Mois du minimum des débits mensuels] - maximum de Qr
3. agrégation annuelle [Mois du minimum des débits mensuels] - division par deux des maxima annuels pour obtenir un seuil
4. agrégation annuelle [Mois du minimum des débits mensuels] - nombre de jours où la différence est supérieure au seuil
5. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit, Hautes Eaux, Durée"

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(dQ=dBFS)
CARD$P1.funct_args = list("Q")
CARD$P1.time_step = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(dQXA=maxNA)
CARD$P2.funct_args = list("dQ", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P2.keep = "all"

### P3 _______________________________________________________________
CARD$P3.funct = list(lowLim=divided)
CARD$P3.funct_args = list("dQXA", 2, first=TRUE)
CARD$P3.time_step = "year"
CARD$P3.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P3.keep = "all"

### P4 _______________________________________________________________
CARD$P4.funct = list(dtFlood=apply_threshold)
CARD$P4.funct_args = list("dQ", lim="lowLim", where=">=", what="length", select="dQXA")
CARD$P4.time_step = "year"
CARD$P4.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P4.NApct_lim = 3

### P5 _______________________________________________________________
CARD$P5.funct = list("delta{dtFlood}_H1"=get_deltaX,
                     "delta{dtFlood}_H2"=get_deltaX,
                     "delta{dtFlood}_H3"=get_deltaX)
CARD$P5.funct_args = list(list("dtFlood", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise),
                          list("dtFlood", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise),
                          list("dtFlood", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise))
CARD$P5.time_step = "none"

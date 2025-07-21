invisible(source("R/preConfigurated.R"))

MXB107_Info = read.csv("./datasets/MXB107_2025_ClassInfo.csv")
str(MXB107_Info)

# Extract all classes that start after 9am on either thursday or friday base R
notOnline = MXB107_Info$Location != "Online"
onThursday = MXB107_Info$Day %in% c("Thu", "Fri")
startAfter9AM = MXB107_Info$From > 9
subset(MXB107_Info, notOnline & onThursday & startAfter9AM)

# dplyr
MXB107_Info %>%
  filter(Location != "Online",
         Day %in% c("Thu", "Fri"),
         From > 9) -> results
print(results)

# Internal classes
MXB107_Info %>%
  filter(Type == "Lecture (Internal)")

# Wednesday pracs
MXB107_Info %>%
  filter(str_detect(Type, "Practical"), #base R: str_detect(MXB107_Info$Type, pattern = "Practical")
         Day == "Wed")

         


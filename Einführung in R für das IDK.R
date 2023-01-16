# Einführung in R für das IDK
# bibs@zhaw.ch

# Bibliotheken ----
library(here)
library(readr)
library(readxl)

# Daten laden
data("iris")

# Code ----

# Normale Eingabe von Code in Konsole:
1 + 2

# Zuweisung des Werts an Objekt “x”:
x <- 1 + 2
x

# Benutzung des Objekts “x”:
x + 4

# Komplizierteres
x + c(4,-4)

# Datenformate ----
d = seq(from = 1,to = 12) # Vektor mit Zahlen von 1 bis 12
d # Gibt das Objekt "d" im Output aus
View(d) # Anzeigen von "d"
str(d) # Struktur von "d"

m = matrix(data = d, nrow = 3, byrow = FALSE) 
# Vektor d in Matrix mit 3 Reihen umwandeln (ergibt Matrix 3 x 4)
m # Gibt das Objekt "d" im Output aus
View(m) # Anzeigen von "m"
str(m) # Struktur von "m"
# Einführung in R für das IDK
# bibs@zhaw.ch

# Bibliotheken ----
library(here) # Für saubere Pfade
library(readr) # Import von Daten in versch. Formaten
library(readxl) # Import von Excel
library(ggplot2) # Schöne Abbildungen
library(vtable) # Beschreibung von Daten
library(janitor) # Für schöne Tabellen
library(haven) # Import von SPSS, Stata etc.

# Übungsdaten aus R laden ----
data("iris") # Schwertlilien
data("ToothGrowth") # Toothgrowth (from guinea pigs)

# Code ----

## Normale Eingabe von Code in Konsole
1 + 2

## Zuweisung des Werts an Objekt “x"
x <- 1 + 2
x

## Benutzung des Objekts “x”
x + 4

## Eingabe mehrere Werte als Vektor
y <- c(4, -4)
y

# Komplizierteres
## x (3) plus 4 und minus 4, ergibt zwei Werte 
x + c(4,-4)

## Gleiches Resultat, weil y vorher als 4 / -4 definiert
x + y

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

# Importieren von Daten ----
# csv
Churn <- readr::read_table(here("Daten", "Churn.csv"))

# txt
Arrivals <- readr::read_table(here("Daten", "Arrivals.txt"))

# Excel
alpenquer <- readxl::read_excel(here("Daten", "Alpenquerender_Gueterverkehr_Schiene.xls"))

# rda (eigenes R-Format)
load(here("Daten", "Treibstoffpreise_CH.rda"))
# Daten müssen hier keinem Objekt mehr zugewiesen werden!

# Import von SPSS
car_sales <- haven::read_spss(here("Daten", "car_sales.sav"))

# Dimensionen von Daten ----
View(iris)
str(iris) # Datentypen
dim(iris)
nrow(iris) # Anzahl Fälle / Reihen
ncol(iris) # Anzahl Variablen / Spalten
length(iris) 
# Anzahl Variablen / Spalten (ACHTUNG: in diesem Fall, bei Vektoren gibt es die Länge des Vektors!)
class(iris)
head(iris) # Zeigt erste 6 Beobachtungen
tail(iris) # Zeigt letzte 6 Beobachtungen
summary(iris)

# Analysen ----
# Mittelwert von Sepal.Length in iris
mean(iris$Sepal.Length)

# Mittelwert als Objekt abspeichern
sepal_length_mean <- mean(iris$Sepal.Length)
sepal_length_mean

# Ditto Median
sepal_length_median <- median(iris$Sepal.Length)
sepal_length_median

# Einfache Zusammenfassung der Variable
summary(iris$Sepal.Length)

## Alternative mit Paket {vtable} ----
vtable:::vtable(iris)

# Summary statistics
vtable:::sumtable(iris)

# Summary statistics, getrennt nach "Species"
vtable:::sumtable(iris,
                  group = 'Species', # summary statistics groupiert nach Variable "Species"
                  group.test = TRUE) # Zeigt statistische Signifikanztests zwischen den Gruppen

## Einfache Häufigkeiten ----
# Mit Basisfunktion "table"
table(iris$Species)

## Alternative mit Paket {janitor} ----
janitor::tabyl(iris$Species)

# Alternative Schreibweise mit tidyverse-Stil
iris |> 
  janitor::tabyl(Species)

## Kreuztabellen ----
table(ToothGrowth$supp, ToothGrowth$dose)

# Abbildungen ----
## Einfacher Plot
plot(iris)

plot(iris$Species)

## Histogramm
hist(iris$Sepal.Length,
     xlab = "Länge in cm",
     ylab = "Häufigkeit",
     main = "Sepal Length")

# Horizontale Linie einfügen
abline(h = mean(iris$Sepal.Length), # Höhe der Linie = Mittelwert 
       col="red", # Farbe der Linie
       lwd = 2) # Dicke des Striches

## Boxplot
# Erste Schreibweise, Data nicht explizit zugewiesen
boxplot(iris$Sepal.Length,
        ylab = "Länge in cm",
        main = "Sepal Length")
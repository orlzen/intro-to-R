# Einführung in R für das IDK - Beispielcodes
# bibs@zhaw.ch

# Vorbereitung ----

## Benötigte Pakete installieren ----

install.packages("tidyverse", dependencies = TRUE)
install.packages("here", dependencies = TRUE)
install.packages("readr", dependencies = TRUE)
install.packages("readxl", dependencies = TRUE)
install.packages("vtable", dependencies = TRUE)
install.packages("janitor", dependencies = TRUE)
install.packages("haven", dependencies = TRUE)
install.packages("expss", dependencies = TRUE)
install.packages("tidylog", dependencies = TRUE)
install.packages("conflicted", dependencies = TRUE)

## Bibliotheken laden ----
library(here) # Für saubere Pfade
library(readr) # Import von Daten in versch. Formaten
library(readxl) # Import von Excel
library(ggplot2) # Schöne Abbildungen
library(vtable) # Beschreibung von Daten
library(janitor) # Für schöne Tabellen
library(haven) # Import von SPSS, Stata etc.
library(expss) # Für SPSS-ähnliche Tabellen
library(tidylog, warn.conflicts = FALSE) # Für direkte Protokolle von Funktionen aus dem tidyverse
library(conflicted) # Für Hilfe mit Paket-Konflikten

## Daten laden ----
# csv
Churn <- readr::read_table(here("Daten", "Churn.csv"))

# txt
Arrivals <- readr::read_table(here("Daten", "Arrivals.txt"))

# Excel
alpenquer <- readxl::read_excel(here("Daten", "Alpenquerender_Gueterverkehr_Schiene.xls"))

# rda (eigenes R-Format)
load(here("Daten", "Treibstoffpreise_CH.rda"))

# Import von SPSS
car_sales <- haven::read_spss(here("Daten", "car_sales.sav"))

# Laden von in R bestehenden Daten
# Müssen keinem Objekt mehr zugewiesen werden!
data("iris")
data("USArrests")
data("AirPassengers") # Spezialfall Zeitreihe

## Exportieren / Speichern von Daten ----

# Einzelnen Datensatz speichern im .Rds-Format
saveRDS(Churn, here("Datenexport", "Churn_save.Rds"))

# Mehrere geladenen Daten speichern im .Rdata-Format
save(list = c("Churn", "Arrivals"), 
     # Objekte "Churn" und "Arrivals" werden exportiert
     file = here("Datenexport/Churn_Arrivals.Rdata"))
# Beim Export in .Rdata braucht es den Zusatz "file = ..." 

# Exportieren in SPSS-Format
haven::write_sav(iris, here("Datenexport", "iris.sav"))

# Erste Arbeiten in R ----
## Einfache Eingabe und Zuweisung an Objekte ----
1 + 2

a <- 9
a

x <- 1 + 2
x

x + 4

farbe <- "rosa"
farbe

Erste_Zahl <- 4

Zweite_Zahl <- 5

Erste_Zahl * Zweite_Zahl

# Objekte können nicht als Zahlen benannt werden!

# 1 <- 2
# Error in 1 <- 2 : invalid (do_set) left-hand side to assignment

## Komplizierteres ----

y <- c(4, -4)
y

# x (3 von oben) plus 4 und minus 4, ergibt zwei Werte
x + c(4,-4)

# Gleiches Resultat, weil y vorher als 4 / -4 definiert
x + y

# Vektor mit Zahlen von 1 bis 12
d = seq(from = 1, to = 12) 
d
View(d) # Anzeigen von "d"
str(d) # Struktur von "d"
class(d)

# Für jeden Monat (12 Zahlen) einen Wert definieren
rate_pro_monat <- c(0, 100, 200, 50, 0, 0, 0, 0, 100, 0, 0, 0)
rate_pro_monat

# Wert für den zweiten Monat erhalten und getrennt abspeichern
rate_februar <- rate_pro_monat[2]
rate_februar

# Wert für den fünften Monat ergänzen
rate_pro_monat[5] <- 150
rate_pro_monat

# Länge des Vektors herausfinden
length(rate_pro_monat)

# Werte für die Monate Februar-April extrahieren
rate_pro_monat[c(2,3,4)]

# Oder
rate_pro_monat[2:4]

# Ist jeder Wert von "rate_pro_monat" grösser Null?
rate_pro_monat > 0

# Vektor d in Matrix "m" mit 3 Reihen umwandeln (ergibt Matrix 3 x 4)
m = matrix(data = d, 
           nrow = 3) 

m
View(m) # Anzeigen von "m"
str(m) # Struktur von "m"

# Vektor d in Matrix "n" mit 3 Reihen umwandeln 
# Aber in aufsteigend in Zeilen statt Spalten
# (ergibt Matrix 3 x 4)
n = matrix(data = d, 
           nrow = 3, 
           byrow = TRUE) # Aufteilung nach Zeilen, nicht Spalten

n
View(n) # Anzeigen von "n"
str(n) # Struktur von "n"

# Erstellt aus der Matrize "n" ein neues Objekt "n_df" als data frame
n_df <- as.data.frame(n)

# Mit "View" sind keine Unterschiede ersichtlich
View(n)
View(n_df)

# Bei der Ausgabe der Objekte sieht man einige Unterschiede
n
n_df

# Offensichtlich wird der Unterschied, wenn man die Struktur der  
# beiden Objekte abgefragt
str(n)

# n ist immer noch eine Reihe von integers
str(n_df)
# n_df ist ein data frame mit Beobachtungen und Variablen

# Überprüfen, ob n und n_df identisch sind
setequal(n, n_df)

# Überschreibt das bestehende Objekt "n" als data frame
n <- as.data.frame(n)

# Nochmals berprüfen, ob n und n_df identisch sind
setequal(n, n_df)

# Ich habe eine Rate pro Quartal
rate_pro_quartal <- c(3.1, 0.1, 5.4, 1.1)
rate_pro_quartal

# Das ist aber nicht so übersichtlich.
# Ich gebe deshalb jedem Wert einen "Namen"
names(rate_pro_quartal) <- c("Q1","Q2","Q3","Q4")
rate_pro_quartal

# Alternative in einem Schritt
rate_pro_quartal_2 <- c("Q1" = 3.1, "Q2" = 0.1, "Q3" = 5.4, "Q4" = 1.1)

# Überprüfen, ob die Objekte identisch sind
rate_pro_quartal == rate_pro_quartal_2

## Auswahl von Elementen in einer Tabelle ----

# Wir benutzen als Beispiel die "iris"-Daten
# Falls noch nicht geladen: data("iris")

# Auswahl des ersten Wertes der ersten Spalte ("Sepal.Length")
# Diese drei Befehle sind identisch!

iris[1, 1]
iris[1,"Sepal.Length"] # Spalte mit Name "Sepal.Length"
iris$Sepal.Length[1] # Spalte mit Name "Sepal.Length"

## Dimensionen und Eigenschaften von Matrizen und data frames ----

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

## Fehlende Werte ----

# Funktioniert nicht, wegen NAs:
mean(car_sales$price)

# Die NAs müssen aktiv ausgeklammert werden von der Analyse:
mean(car_sales$price, na.rm = TRUE)

## Kategoriale / ordinale Variablen & labels ----

faktorbeispieldaten <- data.frame(age = c(21, 30, 25, 41, 29, 33), # 6 Altersangaben
                                  sex = factor(c(1, 2, 1, 2, 1, 2), # 6 Geschlechtsangaben
                                               labels = c("Female", "Male")))
# Labels für Geschlecht (1 = "Female", 2 = "Male", automatisch zugeteilt)

# Gleiches Ergebnis, aber ohne numerische Faktorvariable
faktorbeispieldaten_2 <- data.frame(age = c(21, 30, 25, 41, 29, 33), # 6 Altersangaben
                                    sex = factor(c("Female", "Male", "Female", "Male", "Female", "Male"))) 

## Variablenlabels ----

faktorbeispieldaten <- expss::apply_labels(faktorbeispieldaten,
                                           age = "Alter in Jahren",
                                           sex = "Geschlecht")

# Recodierungen und Berechnung neuer Variablen ----

## Recodierung von numerischen Variablen ----

### Numerische Variablen in numerische Variabeln umcodieren ----

# Bestehende Variable "Petal.Length" logarithmieren
iris$Petal.Length <- log(iris$Petal.Length)

# Neue Variable "sepal_total" erstellen aus Summe
# von Sepal.Length + Sepal.Width
iris$sepal_total <- iris$Sepal.Length + iris$Sepal.Width

# Bestehende Variable "Petal.Length" logarithmieren
iris <- iris |> 
  dplyr::mutate(PetalLength = log(iris$Petal.Length))

# Neue Variable "petal_total" erstellen aus Summe
# von Petal.Length + Petal.Width
iris <- iris |> 
  dplyr::mutate(petal_total = Petal.Length + Petal.Width)

### Numerische Variablen in kategoriale Variabeln (Faktorvariablen) umcodieren ----

iris$petallength_cat <- cut(iris$Petal.Length, # Zuweisen an neue Variable
                            c(0, 0.5, 1, 1.5, 2), # Grenzen neuer Kategorien setzen
                            labels = c("tief", # Labels der Kategorien definieren
                                       "tief-mittel",
                                       "hoch-mittel",
                                       "hoch"))

## Recodierung von kategoriellen Faktorvariablen ----

# Ich möchte eine neue Variable "manufact_herkunft" erstellen
# basierend auf der Marke "manufact"
car_sales <- car_sales |> 
  dplyr::mutate(manufact_herkunft = dplyr::case_when(manufact == "Acura"         ~ "USA",
                                                     manufact == "Audi"          ~ "Deutschland",
                                                     manufact == "BMW"           ~ "Deutschland",
                                                     manufact == "Buick"         ~ "USA",
                                                     manufact == "Cadillac"      ~ "USA",
                                                     manufact == "Chevrolet"     ~ "USA",
                                                     manufact == "Chrysler"      ~ "USA",
                                                     manufact == "Dodge"         ~ "USA",
                                                     manufact == "Ford"          ~ "USA",
                                                     manufact == "Honda"         ~ "Asien",
                                                     manufact == "Hyundai"       ~ "Asien",
                                                     manufact == "Infiniti"      ~ "USA",
                                                     manufact == "Jaguar"        ~ "England",
                                                     manufact == "Jeep"          ~ "USA",
                                                     manufact == "Lexus"         ~ "Asien",
                                                     manufact == "Lincoln"       ~ "USA",
                                                     manufact == "Mercedes-Benz" ~ "Deutschland",
                                                     manufact == "Mercury"       ~ "USA",
                                                     manufact == "Mitsubishi"    ~ "Asien",
                                                     manufact == "Nissan"        ~ "Asien",
                                                     manufact == "Oldsmobile"    ~ "USA",
                                                     manufact == "Plymouth"      ~ "USA",
                                                     manufact == "Pontiac"       ~ "USA",
                                                     manufact == "Porsche"       ~ "Deutschland",
                                                     manufact == "Saab"          ~ "Schweden",
                                                     manufact == "Saturn"        ~ "USA",
                                                     manufact == "Subaru"        ~ "Asien",
                                                     manufact == "Toyota"        ~ "Asien",
                                                     manufact == "Volkswagen"    ~ "Deutschland",
                                                     manufact == "Volvo"         ~ "Schweden")
         )

## Neue Variablen anhand mehrerer Bedingungen definieren ----

# Ich möchte eine neue Variable erstellen für die Kombination
# aus Hubraum (engine_s) und Gewicht (curb_wgt)
car_sales <- car_sales |> 
  dplyr::mutate(hubraum_gewicht = dplyr::case_when((engine_s < 3) & (curb_wgt < 3.5) ~ "Klein & leicht",
                                                   (engine_s >= 3) & (curb_wgt < 3.5) ~ "Gross & leicht",
                                                   (engine_s < 3) & (curb_wgt >= 3.5) ~ "Klein & schwer",
                                                   (engine_s >= 3) & (curb_wgt >= 3.5) ~ "Gross und schwer"
                                                   ))

# Analysen ----

## Erste deskriptive Statistiken ----

# Mittelwert von Sepal.Length in iris
# Meine Empfehlung
mean(iris$Sepal.Length)

# Geht auch
mean(iris[ , 1])

# Geht auch
mean(iris[ , "Sepal.Length"])

# Mittelwert als Objekt abspeichern
sepal_length_mean <- mean(iris$Sepal.Length)
sepal_width_mean <- mean(iris$Sepal.Width)
sepal_length_mean

# Ditto Median
sepal_length_median <- median(iris$Sepal.Length)
sepal_length_median

# Einfache Zusammenfassung der Variable
summary(iris$Sepal.Length)

vtable:::vtable(iris)


# Summary statistics
vtable:::sumtable(iris)


# Summary statistics, getrennt nach "Species"
vtable:::sumtable(iris,
                  group = 'Species', # summary statistics groupiert nach Variable "Species"
                  group.test = TRUE) # Zeigt statistische Signifikanztests zwischen den Gruppen

## Einfache Häufigkeitstabellen ----

# Mit Basisfunktion "table"
table(iris$Species)

iris |> 
  dplyr::count(Species)

forcats::fct_count(iris$Species, 
                   prop = TRUE) # Gibt Verhältnisse an

janitor::tabyl(iris$Species)

# Alternative, andere Schreibweise, etwas eleganterer Output
iris |> 
  janitor::tabyl(Species)

# Oder mit formatierten Prozentzahlen
iris |> 
  tabyl(Species) |> 
  adorn_pct_formatting(digits = 2)

expss::fre(iris$Species)

## Kreuztabellen ----

# Wir wechseln zu den "ToothGrowth"-Daten (Zahnlänge von Meerschweinchen)
# Falls noch nicht geladen: data("ToothGrowth")

table(ToothGrowth$supp, ToothGrowth$dose)

xtabs(formula = ~ supp + dose, data = ToothGrowth)

# Alternative Schreibweise mit tidyverse-Stil
ToothGrowth |> 
  janitor::tabyl(supp, dose)

# Oder eben dann mit allem, was man will
ToothGrowth %>%
  tabyl(supp, dose) %>%
  adorn_totals("col") %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 2) %>%
  adorn_ns() %>%
  adorn_title()

ggplot(iris) +
  aes(x = Sepal.Length, y = Sepal.Width) +
  geom_point(shape = "circle", size = 1.5, colour = "red") +
  theme_minimal()

# Mit absoluten Zahlen
expss::cro(ToothGrowth$supp, list(total(), ToothGrowth$dose), 
           total_statistic = "u_cases")

# Mit Prozenten in Zeile
expss::cro_rpct(ToothGrowth$supp, list(total(), ToothGrowth$dose), 
                total_statistic = "u_cases")

# Mit Prozenten in Spalte
expss::cro_cpct(ToothGrowth$supp, list(total(), ToothGrowth$dose), 
                total_statistic = "u_cases")

# Mit Prozenten für Total
expss::cro_tpct(ToothGrowth$supp, list(total(), ToothGrowth$dose), 
                total_statistic = "u_cases")

# Abbildungen ----

## Säulen- / Balkendiagramm ----

plot(iris$Species)

#Alternative
# barplot(table(iris$Species))

## Histogramm ----

hist(iris$Sepal.Length,
     xlab = "Länge in cm",
     ylab = "Häufigkeit",
     main = "Sepal Length")

# Horizontale Linie einfügen
abline(h = mean(iris$Sepal.Length), # Höhe der Linie = Mittelwert 
       col = "red", # Farbe der Linie
       lwd = 1) # Dicke des Striches

## Boxplot ----

# Erste Schreibweise, Data nicht explizit zugewiesen
boxplot(iris$Sepal.Length,
        ylab = "Länge in cm",
        main = "Sepal Length")


boxplot(Sepal.Length ~ Species,
        data = iris, # Andere Schreibweise, Data explizit zugewiesen
        ylab = "Länge in cm",
        xlab = "Species",
        main = "Sepal Length nach Species")

## Streudiagramm ----

plot(x = iris$Sepal.Length,
     y = iris$Petal.Length,
     xlab = "Sepal Length",
     ylab = "Petal Length",
     main = "Streudiagramm Sepal Length gegen Petal Length",
     col = iris$Species, # Punkte gefärbt nach Species
     pch = 20) # Schwarze Punkte statt leere Kreise

legend("bottomright", # legende ist unten rechts
       lty = 1, # definiert die Linienart der Legende
       col = c("black", "red", "lightgreen"),
       legend = c("setosa", 
                  "versicolor",
                  "virginica"))

## Pairs ----

# Alle Variablen von iris
pairs(iris)

# Befehl eingeschränkt auf Spalten 1:4 von iris 
# (und alle Zeilen, keine Eingabe vor Komma)
pairs(iris[,1:4])

## Standard-Plot (inkl. Streudiagramm) ----

plot(iris)

plot(iris$Species)

plot(iris$Sepal.Width, iris$Sepal.Length)

## ggplot2 ----

# Variante 1 mit ggplot2
ggplot(iris) +                                     # Daten 
    aes(x = Sepal.Length) +                        # Aesthetics 
    geom_histogram() +                             # Art der Visualisierung 
    labs(                                          # Labels 
        x = "Länge in cm",                         # X-Achse
        y = "Häufigkeit",                          # Y-Achse
        main = "Sepal Length (mit ggplot, Var. 1)" # Titel
    )

# Variante 2 mit ggplot2
ggplot(iris) +
    aes(x = Sepal.Length) +
    geom_histogram(binwidth = 0.2) +   # Breite der bins definiert anstatt default
    facet_wrap(~ Species) +            # Pro Ausprägung von "Species" eine Abbildung  
    labs(
        x = "Länge in cm",
        y = "Häufigkeit",
        main = "Sepal Length (mit ggplot, Var. 2)"
    )

# Variante 3 mit ggplot2
ggplot(iris) +
    aes(x = Sepal.Length,                   # X-Achse
        fill = Species) +                   # Füllung der bins
    geom_histogram(binwidth = 0.2,          # Breite der bins definiert anstatt default
                   alpha = 0.5,             # Durchsichtigkeit der Säulen
                   position = "identity") + # Überlagerung der Säulen
    theme_minimal() +                       # Weisser Hintergrund, kein Rahmen
    labs(
        x = "Länge in cm",
        y = "Häufigkeit",
        main = "Sepal Length (mit ggplot, Var. 3)"
    )

# Scatterplot mit Regressionsgeraden
ggplot(iris) +
  aes(x = Sepal.Length, 
      y = Sepal.Width,
      color = Species,
      fill = Species) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(x = "Sepal Width in cm",
       y = "Sepal Length in cm")

# Mit übertriebenen Darstellungen
ggplot(iris) +
  aes(x = Species) +
  geom_bar(fill = "pink") + # Pinke Füllung
  stat_count(geom = "text", # Datenbeschriftung
             colour = "yellow", # Farbe der Datenbeschriftung
             size = 7.5,        # Grösse der Datenbeschriftung
             angle = -45,       # Beschriftung gekippt um -45 Grad
             aes(label = after_stat(count)), # Label ist die gezählte Anzahl
             position = position_stack(vjust = 0.5)) +   # Beschriftung ist vertikal nach unten versetzt
  theme_dark()              # Anderes "theme"

# Mit ZHAW-Blau

ggplot(iris) +
  aes(x = Petal.Length,
      y = Sepal.Length) +
  geom_point(col = "#0079DB",
             size = 3) +
  xlim(0, 2.2) +
  ylim(3, 8.3) +
  annotate("text",
           x = 1,
           y = 7.5,
           label = "Diese Gruppe hat grössere Blumen") +
  geom_curve(aes(x = 1,
                 y = 7.2,
                 xend = 1.4,
                 yend = 6.5),
             arrow = arrow()) +
  theme_minimal() +
  labs(x = "Länge Blüttenblatt [in cm]",
       y = "Länge Kelchblatt [in cm]")

## Abbildungen über das Menu erstellen mit dem {esquisse}-Paket ----

ggplot(USArrests) +
  aes(x = Murder, 
      y = Assault, 
      colour = Rape, 
      size = UrbanPop) +
  geom_point(shape = "circle") +
  scale_color_viridis_c(option = "inferno") +
  theme_minimal()

# Resultate von Analysen als Objekte ----

# Einfache lineare Regression
fit_iris <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, 
               data = iris)

# Zusammenfassung des Modells
summary(fit_iris)

# Elemente der Liste anschauen
names(fit_iris)

# Koeffizienten anschauen
fit_iris$coefficients

plot(fit_iris, which = 1)

plot(fit_iris, which = 2)

plot(fit_iris, which = 3)

plot(fit_iris, which = 4)

plot(fit_iris, which = 5)

plot(fit_iris, which = 6)

# Weiterführendes ----

## Tidyverse ----

# Mit base R
virginica_base <- transform(subset(iris, 
                                   Species == "virginica"),
                            sepallength_width = (Sepal.Length + Sepal.Width),
                            petallength_width = (Petal.Length + Petal.Width))

View(virginica_base)

# Mit tidyverse
virginica_tidy <- iris |> 
  dplyr::filter(Species == "virginica") |> 
  dplyr::mutate(sepallength_width = (Sepal.Length + Sepal.Width)) |>   
  dplyr::mutate(petallength_width = (Petal.Length + Petal.Width))

View(virginica_tidy)

# Randnotiz: Tidyverse beginnt die Zeilennummerierung wieder bei 1, mit base R 
# bleibt die Zeilennummerierung wie im ursprünglichen Datensatz, fängt bei 101 an

# Mit tidylog
virginica_tidylog <- iris |> 
  tidylog::filter(Species == "virginica") |> 
  tidylog::mutate(sepallength_width = (Sepal.Length + Sepal.Width)) |>   
  tidylog::mutate(petallength_width = (Petal.Length + Petal.Width))

## Loops (while und for) ----

# Beispiel für einen while-loop:
# Anfangen mit x = 0
x <- 0

while (x < 1000) { # Solange x kleiner 1000 ist
  x <- x + 17      # wird x immer um 17 erhöht
  }

print(x)
# Der loop hat aufgehört bei 1003 nach 59 Wiederholungen
# (59 x 17 = 1003)

## Bedingungen (if) ----

# Beispiel für einen for-loop:
for (i in 1:3) {  # Für jedes Element des Vektors 1:3
  print("hello")  # Gib "hello" aus
  }

# Elemente festlegen
today <- Sys.Date() # heutiges Datum bestimmen
day <- weekdays(today) # Wochentag heute bestimmen

# Ausgabe je nach Tag
if(day == "Monday") {
  print("I don’t like Mondays")
  } else {
print("I’m a happy little automaton")
    }

## Funktionen (function) ----

# Erstelle eine Funktion "vierfach"
vierfach <- function(x) {
  y <- x * 4        # Multipliziere die Eingabe x mit 4 und speichere es als y
  return(y)         # Gib das Resultat y aus
}

# Ausführen der Funktion
vierfach(10)

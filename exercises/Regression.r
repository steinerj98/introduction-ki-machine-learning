## Exercise 
## Laden Sie die Daten aus der Datei Maschinendaten.xlsx (csv)
## 1.   Führen Sei eine lineare Regression durch, wobei "Qualitaeatsparameter" die Zielvariable ist.
##      Wählen Sie als Einflussvariablen die Spalten Werkzeug, Maschine und Vorschub. Berechnen Sie auch MAD.
## 2.   Prognostizieren Sie die Qualität eines produzierten Teiles bei Verwendung von Werkzeug 3, Maschine A, 
##      Vorschub 2.5

setwd("/home/steinerj/Documents/Bachelory-Study/Artificial Intelligence/AI/introduction-ki-machine-learning/data")
Daten <- read.csv("Maschinendaten.csv",header=TRUE,sep=",",fill=TRUE)

Daten[,"ID"] <- as.factor(Daten[,"ID"]) # Könnten wir auch ignorieren, da in der Berechnug nicht berücksichtigt
Daten[,"Maschine"] <- as.factor(Daten[,"Maschine"])
Daten[,"Werkzeug"] <- as.factor(Daten[,"Werkzeug"])

summary(Daten)

model <- lm(Qualitaetsparameter ~ Werkzeug + Maschine + Vorschub, data=Daten)
model

Qualitaetsparameter <- Daten[,"Qualitaetsparameter"]
Prognosen <- model$fitted.values


Prognosenfehler <- mean(abs(Qualitaetsparameter - Prognosen))
Prognosenfehler

Prognose <- (model$coefficients["(Intercept)"] + (model$coefficients["Werkzeug3"]) + 0 + (2.5 * model$coefficients["Vorschub"]))
Prognose
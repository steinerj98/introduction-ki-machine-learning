library(ANN2)

setwd("/home/steinerj/Documents/Bachelory-Study/Artificial Intelligence/AI/introduction-ki-machine-learning/data")

Daten <- read.csv("Maschinendaten.csv",header=TRUE,sep=",",fill=TRUE)

Daten[,"ID"] <- as.factor(Daten[,"ID"]) # Könnten wir auch ignorieren, da in der Berechnug nicht berücksichtigt
Daten[,"Maschine"] <- as.factor(Daten[,"Maschine"])
Daten[,"Werkzeug"] <- as.factor(Daten[,"Werkzeug"])

length(Daten[,1])

Daten.train <- Daten[1:350, ]
Daten.test <- Daten[351:500, ]

# Erstellen eines Datensatzes mit Dummy-Codierung der kategoriellen Variablen

X <- model.matrix(Qualitaetsparameter ~ Werkzeug + Maschine + Vorschub, data=Daten.train)
X <- X[,-1] # Intercept entfernen
summary(X)

y <- Daten.train[,"Qualitaetsparameter"]

# Trainieren des neuronalen Netzes
# hidden.layers = (4,3) z.B. 2 Versteckte Schichten mit 4 & 3 Neuronen
model <- neuralnetwork(X, y, hidden.layers=c(4,3), regression = TRUE, 
                       loss.type = "absolute", learn.rates = 1e-04,n.epochs = 100,
                       verbose=FALSE)

# Berechnung der Prognose mit dem Testdatensatz
X.Test = model.matrix(Qualitaetsparameter ~ Werkzeug + Maschine + Vorschub, data=Daten.test)
X.Test <- X.Test[,-1] # Intercept entfernen
summary(X.Test)

y.Test = Daten.test[,"Qualitaetsparameter"]

prognosen <- predict(model,X.Test)$predictions    
mean(abs(prognosen-y.Test))
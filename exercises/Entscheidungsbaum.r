library(tree)

setwd("/home/steinerj/Documents/Bachelory-Study/Artificial Intelligence/AI/introduction-ki-machine-learning/data")

Daten <- read.csv("Maschinendaten.csv",header=TRUE,sep=",",fill=TRUE)
Daten[,"ID"] <- as.factor(Daten[,"ID"]) # Könnten wir auch ignorieren, da in der Berechnug nicht berücksichtigt
Daten[,"Maschine"] <- as.factor(Daten[,"Maschine"])
Daten[,"Werkzeug"] <- as.factor(Daten[,"Werkzeug"])

length(Daten[,1])

Daten.train <- Daten[1:350, ]
Daten.test <- Daten[351:500, ]

# Berechnung des Modells auf den Trainingsdaten:

Baum <- tree(Qualitaetsparameter ~ Werkzeug + Maschine + Vorschub, data=Daten.train)
tuning <- cv.tree(Baum, K=5)
t <- which.min(tuning$dev)
Anzahl.Endknoten <- tuning$size[t]

model <- prune.tree(Baum, best=Anzahl.Endknoten)
plot(model)
text(model)

# Berechnung der Prognoseergebniss auf den Testdaten

X.test <- Daten.test[,c("Werkzeug", "Maschine", "Vorschub")]
prognosen <- predict(model, X.test)

# Berechnung des mittleren Prognosefehlers (MAD)

y.test <- Daten.test[, "Qualitaetsparameter"]
mean(abs(y.test-prognosen))


x.neu <- data.frame(3, "A", 2.5)
names(x.neu) <- names(X.test)
X <- rbind(X.test, x.neu)

prognose <- predict(model, X)
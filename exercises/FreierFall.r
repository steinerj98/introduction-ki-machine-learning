setwd("/home/steinerj/Documents/Bachelory-Study/Artificial Intelligence/AI/introduction-ki-machine-learning/data")
Daten <- read.csv("FreierFall.csv", header=TRUE, sep=",", fill=TRUE)

# Daten der ersten 12 Zeilen
Daten[1:12,]
summary(Daten)

# Einzelne Spalten in Variablen einlesen
zeit <- Daten[,"Zeit"]
position <- Daten[,"Position"]

# Durchschnittswert und Standardabweichung der Position
mean(position)
sd(position)

# Ausgeben der Graphik
plot(zeit,position,main="Freier Fall", xlab="Zeit", ylab="Position",col="blue",pch=19)
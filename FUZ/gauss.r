rm(list=ls(all=TRUE))
#Creating the FIS
library(FuzzyToolkitUoN);
library(rgl);
source('gensurf3d.R')

#Create the Fuzzy Inference System
fis = newFIS("MedicalAdvisor");

#fis$defuzzMethod='centroid'#, 'bisector', 'mom', 'som' or 'lom'.
fis$defuzzMethod='som'

#fis$andMethod = function(a) a[1]*a[2];
#fis$orMethod = function(a) 1-(1-a[1])*(1-a[2]);


#Adds variable temperature
fis = addVar(fis, "input", "temperature", c(33,43));

#Adds temperature membership function
fis = addMF(fis, "input", 1, gaussMF("low", c(33:43), c(3,33,1)));
fis = addMF(fis, "input", 1, gaussMF("normal", c(33:43), c(3,37,1)));
fis = addMF(fis, "input", 1, gaussMF("high", c(33:43), c(3,43,1)));


#Adds variable headache
fis = addVar(fis, "input", "headache", c(0,100));

#Adds headache membership function
fis = addMF(fis, "input", 2, gaussMF("normal", 0:100, c(20,0,1)));
fis = addMF(fis, "input", 2, gaussMF("mild", 0:100, c(20,20,1)));
fis = addMF(fis, "input", 2, gaussMF("moderate", 0:100, c(20,40,1)));
fis = addMF(fis, "input", 2, gaussMF("severe", 0:100, c(20,75,1)));
fis = addMF(fis, "input", 2, gaussMF("profound", 0:100, c(20,100,1)));


#Adds output variable emergency
fis = addVar(fis, "output", "emergency", c(0,100));

#Adds emergency membership functions
fis = addMF(fis, "output", 1, gaussMF("none", c(0:100), c(25,0,1)));
fis = addMF(fis, "output", 1, gaussMF("mild", c(0:100), c(25,25,1)));
fis = addMF(fis, "output", 1, gaussMF("careful", c(0:100), c(25,50,1)));
fis = addMF(fis, "output", 1, gaussMF("worry", c(0:100), c(25,75,1)));
fis = addMF(fis, "output", 1, gaussMF("urgent", c(0:100), c(25,100,1)));

rulesVector = c();
#Rules

#If temperature is normal and headache is none then emergency is none
rulesVector = rbind(rulesVector, c(2,1,1,1,1));

#If temperature is very_high then emergency is urgent
rulesVector = rbind(rulesVector, c(3,0,5,1,2));

#If temperature is very_low then emergency is urgent
rulesVector = rbind(rulesVector, c(1,0,5,1,2));

#If headache is profound then emergency is urgent
rulesVector = rbind(rulesVector, c(0,5,5,2,2));


fis = addRule(fis, rulesVector);


x11();
par(mfrow=c(3,1))
plotMF(fis,"input",1)
plotMF(fis,"input",2)
plotMF(fis,"output",1)

x11();
par(mfrow=c(1,1))
gensurf(fis);


evalMatrix = matrix( c(43, 100, 80, 37,0,0, 39,20,50, 35,20,50, 33,0,80, 43,0,80, 36,20,15), ncol=3);
costFunFis <- function (fis, data){
	inputFIS  = data[,1:ncol(data)-1];
	outputFIS = data[,ncol(data)];
		
	prediction = evalFIS(inputFIS, fis);
	return (sqrt(sum((prediction-outputFIS)^2)));
}

j=costFunFis(fis,evalMatrix);
j

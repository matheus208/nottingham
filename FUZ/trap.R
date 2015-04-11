 rm(list=ls(all=TRUE))
FIS= newFIS('tippertest')
	
	FIS= addVar(FIS, "input", "service", 0:10)
	FIS= addVar(FIS, "input", "food", 0:10)
	FIS= addVar(FIS, "output", "tip", 0:30)

	#The following block is going to be input 1's membership functions
	mf1= gaussMF("poor", 0:10, c(1.5, 0, 1))
	mf2= gaussMF("good", 0:10, c(1.5, 5, 1))
	mf3= gaussMF("excellent", 0:10, c(1.5, 10, 1))
	
	#The following block is going to be input 2's membership functions
	mf4= trapMF("rancid", 0:10, c(0, 0, 1, 3, 1))
	mf5= trapMF("delicious", 0:10, c(7, 9, 10, 10, 1))
	
	#The following block is going to be output 1's membership functions
mf6= triMF("cheap", 0:30, c(0, 5, 10, 1))
	mf7= triMF("average", 0:30, c(10, 15, 20, 1))
	mf8= triMF("generous", 0:30, c(20, 25, 30, 1))
	#The following three blocks simply add the membership functions to the relevant variables
	FIS= addMF(FIS, "input", 1, mf1)
	FIS= addMF(FIS, "input", 1, mf2)
	FIS= addMF(FIS, "input", 1, mf3)
	
	FIS= addMF(FIS, "input", 2, mf4)
	FIS= addMF(FIS, "input", 2, mf5)
	
	FIS= addMF(FIS, "output", 1, mf6)
	FIS= addMF(FIS, "output", 1, mf7)
	FIS= addMF(FIS, "output", 1, mf8)

	#The following block adds the rules to the fis structure
	FIS= addRule(FIS, c(1,1,1,1,2))
	FIS= addRule(FIS, c(2,0,2,1,1))
	FIS= addRule(FIS, c(3,2,3,1,2))




x11();
par(mfrow=c(3,1))
plotMF(FIS,"input",1)
plotMF(FIS,"input",2)
plotMF(FIS,"output",1)

x11();
par(mfrow=c(1,1))
gensurf(FIS);


evalMatrix = matrix( c(43, 100, 80, 37,0,0, 39,20,50, 35,20,50), ncol=3);
costFunFis <- function (fis, data){
	inputFIS  = data[,1:ncol(data)-1];
	outputFIS = data[,ncol(data)];
		
	prediction = evalFIS(inputFIS, fis);
	return (sqrt(sum((prediction-outputFIS)^2)));
}

j=costFunFis(FIS,evalMatrix);
j
rm(list=ls(all=TRUE))

FIS= newFIS('tippertest')

FIS= addVar(FIS, "input", "service", 33:43)
FIS= addVar(FIS, "input", "food", 0:10)
FIS= addVar(FIS, "output", "tip", 0:30)

#The following block is going to be input 1's membership functions
mf1= trapMF("very_low", 33:43, 	c(0, 0, 1, 3, 1))
mf2= trapMF("low", 33:43, 		c(33,34,36,37, 1))
mf2= trapMF("normal", 33:43, 		c(35,36,38,39, 1))
mf2= trapMF("high", 33:43, 		c(38,39,40,43, 1))
mf3= trapMF("very_high", 33:43, 	c(40,42,43,43, 1))

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
	
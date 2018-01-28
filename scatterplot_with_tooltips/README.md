## Create a html file with a scatterplot produced in R with tooltips for each dot in your image  

## 1. Create a scatterplot in R
## 2. then run the tthtml function with a file name
## 3. on the command line run the perl script and get a html file with the scatter plot and tooltips for each dot (see example below)

## in R
```
tthtml <- function(fname,x,y){

	coord.matrix=paste(grconvertX(x, "user", "device"), grconvertY(y, "user", "device"))

	### the csv file contains the coordinates of the points in the scatterplot
	write.table(coord.matrix,paste(fname,".csv",sep=""),quote=F,col.names=F)
	### the id file contains all tooltip information, id1 value1 id2 value2 etc ...
	write.table(coord.matrix,paste(fname,".id",sep=""),quote=F,col.names=F)
	
}

fname="table1"
x=seq(0,6,0.1)
y=sin(x)

png(paste(fname,".png",sep=""),900,900)
plot(x,y)
```
## call tthtml before dev.off()
```
tthtml(fname,x,y)

dev.off()
```

## on command line , table1 is the name from the fname variable above ...
```
perl html_map.pl table1
```

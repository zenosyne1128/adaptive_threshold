library(jpeg)
library('RgoogleMaps')
setwd('D:/Rfiles')
inp <- readJPEG("dot_before.jpg")
input<- RGB2GRAY(inp)
w <- length(input[1,])
h <- length(input[,1])
out <- matrix(NA, h, w)
intImg <- matrix(NA, h, w)
s <- w/16
t <- 20

for (i in 1:h) {
  sum <- 0
  for (j in 1:w){
    sum <- sum + input[i,j]
    if (i == 1) 
      intImg[i,j] <- sum
    else 
      intImg[i,j] <- intImg[i-1,j] + sum
  }
}
for (i in 1:h) {
  for (j in 1:w) {
    x1 = max(i-s, 1)
    x2 = min(i+s, h)
    y1 = max(j-s, 1)
    y2 = min(j+s, w)
    count = (x2-x1+1) * (y2-y1+1)
    if (x1 == 1 & y1 == 1)
      sum = intImg[x2,y2]
    else if (x1== 1 & y1 > 1)
      sum = intImg[x2,y2]-intImg[x2,y1-1]
    else if (x1 >1 & y1 == 1)
      sum = intImg[x2,y2]-intImg[x1-1,y1]
    else
      sum = intImg[x2,y2] - intImg[(x1-1),y2] - intImg[x2,(y1-1)] + intImg[(x1-1),(y1-1)]
    a <- input[i,j]*count
    b <- sum*(100-t)/100
    if (a < b)
      out[i,j] <-  0  #black0
    else
      out[i,j] <-  1  #white255
  }
}
writeJPEG(out, 'dot_after.jpg', quality = 0.95)

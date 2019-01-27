library(shiny)

real <<- c(0.00813302,0.000705795,0.000114894,0.000422103,0.000259991,0.000393026,0.000243953,0.000136286,0.000132157,0.000451278,0.000123686,0.000169962,0.000107092,0.000103899,0.000225236,0.000420584,0.000365115,0.000574176,0.000723218,0.000628578,
          0.000531597,0.001126176,0.000936391,0.000820079,0.001072363,0.00092029,0.000991858,0.001037108,0.000910879,0.000905893,0.001072041,0.001170934,0.001640074,0.001714328,0.001537419,0.00184354,0.002132078,0.002292734,0.002459243,0.002828024,
          0.003049253,0.003531308,0.003249391,0.004104831,0.004730149,0.005928189,0.005909893,0.00741218,0.0073642,0.008780274,0.008748602,0.00996324,0.011187343,0.012019356,0.013535596,0.014489332,0.015378797,0.017817739,0.018303012,0.019301587,
          0.021491112,0.024531222,0.02474197,0.026998859,0.029276752,0.030907116,0.035502959,0.036543586,0.040603713,0.041920679,0.045559683,0.052865685,0.056870285,0.058908703,0.063020408,0.071535416,0.079165862,0.08324541,0.093448276,0.100541377,
          0.112631427,0.130211574,0.137106485,0.147880445,0.153275649,0.183576411,0.177312213,0.203598485,0.193548387,0.221978022,0.249500998,0.295353982,0.280701754,0.316008316,0.28440367,0.28458498,0.271186441,0.237288136,0.26744186,0.057324841,0.078817734)


vypocet <- function(beta0,r,h,vec,vek){   
 
  f <- function(y){
    return(-r*y)
  }
  presne <- function(x){
    return(exp(-beta0-r*x))
  }
  
  n <- floor(vek/h)       
  M <- matrix(0,7,n+1) 
  M[1,1] <- 0
  M[2:7,1] <- exp(-beta0) # y(0)
  
  for(i in 1:n) M[1,(i+1)] <- M[1,i]+h  ; xka<-M[1,] #Xka
  for(i in 1:n) M[3,(i+1)] <- M[3,i]+h*f(M[3,i]) #Euler napred
  for(i in 1:n) M[4,i+1] <- (M[4,i])/(1+h*r)  #Euler spat
  
  M[2,] <- presne(seq(from=0,by=h,to=vek)) #Presne riesenie
  
  for(i in 1:n){
    k1 <- f(M[5,i])
    k2 <- f(M[5,i]+k1*h/2)
    M[5,i+1] <- M[5,i]+h*k2
    k1 <- f(M[6,i])
    k2 <- f(M[6,i]+k1*h)
    M[6,i+1] <- M[6,i]+h*(k1+k2)/2
    F1 <- f(M[7,i])
    F2 <- f(M[7,i]+h*F1/2)
    F3 <- f(M[7,i]+h*F2/2)
    F4 <- f(M[7,i]+h*F3)
    M[7,i+1] <- M[7,i]+h/6*(F1+2*F2+2*F3+F4)
  } 
  
  
  dataf <- as.data.frame(t(M))
  dataf[,2:7]<-1/dataf[,2:7]
  
  colnames(dataf) <- c("vek","presne","eulernapred","eulerspat","polygon","heun","runge")
  
  plot(M[1,],1/M[2,],type="l",lwd=2,xlab="Vek",ylab="Intenzita umrtnosti")
  legend( x="topleft",cex=1,legend=c("Presne riesenie","Euler napred","Euler spatny","Polygonova","Heunova","Runge-Kutta"),
          lwd=rep(2,6),col=c("black","red","blue","yellow","brown","green"),merge=F )
  if("1" %in% vec) lines(M[1,],1/M[3,],col="red",lwd=2)          #Euler napred
  if("2" %in% vec) lines(M[1,],1/M[4,],col="blue",lwd=2)         #Euler spat
  if("3" %in% vec) lines(M[1,],1/M[5,],col="yellow",lwd=2)       #Vylepsena polygonova
  if("4" %in% vec) lines(M[1,],1/M[6,],col="brown",lwd=2)        #Heunova metoda
  if("5" %in% vec) lines(M[1,],1/M[7,],col="green",lwd=2)#Runge Kutta
  if("6" %in% vec) points(1:vek,real[1:vek])  
}


shinyServer(
  function(input, output) {
    output$graf <- renderPlot({
      vypocet(beta0=-8.2,r=input$r,h=input$h,vec=input$metody,vek=input$vek)
    })
  }
)
# server.R  


library(shiny)
library(shinythemes)
library(ggplot2)
library(OptionPricing)

CallPayoff <- function(S,E){
  return( pmax(S-E,0) )
}
PutPayoff <- function(S,E){
  return( pmax(E-S,0) )
}
Callprice <- function(S,E,r,sigma,tau){
  S*pnorm((log(S/E)+(r+0.5*sigma^2)*tau)/(sigma*sqrt(tau)))-E*exp(-r*tau)*pnorm((log(S/E)+(r-0.5*sigma^2)*tau)/(sigma*sqrt(tau)))
}

Putprice <- function(S,E,r,sigma,tau){
  Callprice(S,E,r,sigma,tau)-S+E*exp(-r*tau)
}

ocen <- function(aky,S,E,r,sigma,tau) { 
  
  hodnoty<-NULL
  price_start <- NULL
  
  if(aky =="Call"){  BS <- Callprice(S=S,E=E,r=r,sigma=sigma,tau=tau)}
  else {  BS <- Putprice(S=S,E=E,r=r,sigma=sigma,tau=tau)}
  
  for (i in 1:100) { 
    price <- S*exp((r-0.5*sigma^2)*tau+sigma*sqrt(tau)*rnorm(1000))
    if(aky=="Call") price_end <- pmax(0,price-E)
    else price_end <- pmax(0,E-price)
    price_start <- c(price_start,price_end*(exp(-r*tau)))
    hodnota <- mean(price_start )
    hodnoty <- c(hodnoty,hodnota)
  }
  
  df<-data.frame(xko=seq(from=1000,to=1000*100,by=1000)/1000,y=hodnoty,bska=rep(BS,length(hodnoty)))
  ggplot(df, aes(xko)) + 
    geom_line(aes(y = hodnoty, colour = "Monte-Carlo"),size=1) + 
    geom_line(aes(y = bska, colour = "Black-Scholes"),size=1)  +
    xlab("Number of simulations in thousands") + ylab("Price of option")
}

profit <- function(S,E1,E2,E3,E4,typ1,typ2,typ3,typ4,typ11,typ22,typ33,typ44,
                   pocet1,pocet2, pocet3,pocet4){
  #pocet1 <- input$pocet1;  pocet2 <- input$pocet2;  pocet3 <- input$pocet3;  pocet4 <- input$pocet4;
  price1 <- 0;  price2 <- 0;  price3 <- 0;  price4 <- 0;
  if(typ1=="Call") pomoc1 <- pocet1*typ11*CallPayoff(S=S,E=E1)
  else if(typ1=="Put") pomoc1 <- pocet1*typ11*PutPayoff(S=S,E=E1)
  else pomoc1 <- 0;
  
  if(typ2=="Call") pomoc2 <- pocet2*typ22*CallPayoff(S=S,E=E2)
  else if(typ2=="Put") pomoc2 <- pocet2*typ22*PutPayoff(S=S,E=E2)
  else pomoc2 <- 0;
  
  if(typ3=="Call") pomoc3 <- pocet3*typ33*CallPayoff(S=S,E=E3)
  else if(typ3=="Put") pomoc3 <- pocet3*typ33*PutPayoff(S=S,E=E3)
  else pomoc3 <- 0;
  
  if(typ4=="Call") pomoc4 <- pocet4*typ44*CallPayoff(S=S,E=E4)
  else if(typ3=="Put") pomoc4 <- pocet4*typ44*PutPayoff(S=S,E=E4)
  else pomoc4 <- 0;
  return(pomoc1+pomoc2+pomoc3+pomoc4)
}

shinyServer(function(input, output) {

  xka <- reactive({seq(from=input$slider[1],to=input$slider[2])})
 
  output$plot <- renderPlot({
    
 ggplot() + geom_hline(yintercept = 0) + geom_line(aes(y = profit(S=xka(),E1=input$E1,E2=input$E2,E3=input$E3,E4=input$E4,
                                        typ1=input$typ1,typ2=input$typ2,typ3=input$typ3,typ4=input$typ4,
                                        typ11=as.numeric(input$typ11),typ22=as.numeric(input$typ22),typ33=as.numeric(input$typ33),typ44=as.numeric(input$typ44),
                                        input$pocet1,input$pocet2,input$pocet3,input$pocet4)-input$cenastrat,
                             x = xka()),size=1.4,colour="#00BFC4",arrow = arrow(length=unit(0.30,"cm"), ends="both", type = "closed"))+xlab("Stock price") + ylab("Profit & Payoff diagram")+
      geom_line(arrow = arrow())+geom_line(aes(y = (profit(S=xka(),E1=input$E1,E2=input$E2,E3=input$E3,E4=input$E4,
                            typ1=input$typ1,typ2=input$typ2,typ3=input$typ3,typ4=input$typ4,
                            typ11=as.numeric(input$typ11),typ22=as.numeric(input$typ22),typ33=as.numeric(input$typ33),typ44=as.numeric(input$typ44),
                            input$pocet1,input$pocet2,input$pocet3,input$pocet4)),
                   x = xka()),linetype="dashed",color="#F8766D",size=1.0,arrow = arrow(length=unit(0.30,"cm"), ends="both", type = "closed"))
              
    })
  
  blackscholes <- reactive(ifelse(input$aky=="Call",
            as.numeric(BS_EC( T = input$tau, K = input$ecko, r = input$urok, sigma = input$sigma, S0 = input$stock )[1]),
            as.numeric(BS_EP( T = input$tau, K = input$ecko, r = input$urok, sigma = input$sigma, S0 = input$stock )[1])))
  
  delta <-reactive(ifelse(input$aky=="Call",
                          as.numeric(BS_EC( T = input$tau, K = input$ecko, r = input$urok, sigma = input$sigma, S0 = input$stock )[2]),
                          as.numeric(BS_EP( T = input$tau, K = input$ecko, r = input$urok, sigma = input$sigma, S0 = input$stock )[2])))
  
  gamma <- reactive(ifelse(input$aky=="Call",
                           as.numeric(BS_EC( T = input$tau, K = input$ecko, r = input$urok, sigma = input$sigma, S0 = input$stock )[3]),
                           as.numeric(BS_EP( T = input$tau, K = input$ecko, r = input$urok, sigma = input$sigma, S0 = input$stock )[3])))
  
  output$plot2 <- renderPlot({ocen(aky=input$aky,S=input$stock,E=input$ecko,r=input$urok,sigma=input$sigma,tau=input$tau)})
  output$text <- renderPrint({paste("Black-Scholes price of option is ",round(blackscholes(),2),", Delta is ",round(delta(),2),"and Gamma is ",round(gamma(),2))
  })
})
###C5E7E2
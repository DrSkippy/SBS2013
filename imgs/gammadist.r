#!/usr/bin/env Rscript
library(ggplot2)
library(gridExtra)
library(reshape2)
bg <- "#646464"
gr <- "#858585"

points <- seq(0,20,0.1)
X <- data.frame(x=points, 
    one=dgamma(points, shape=1, scale=1), 
    two=dgamma(points,shape=1, scale=2), 
    three=dgamma(points, shape=3, scale=3), 
    four=dgamma(points, shape=2, scale=2) )
Z <- data.frame(x=points,
    one=pgamma(points, shape=1, scale=1),
    two=pgamma(points,shape=1, scale=2),
    three=pgamma(points, shape=3, scale=3),
    four=pgamma(points, shape=2, scale=2) )

Y <- melt(X, id="x")
Y$variable <- factor(Y$variable, labels=c("1,1", "1,2", "3,3", "2,2"))
W <- melt(Z, id="x")
W$variable <- factor(W$variable, labels=c("1,1", "1,2", "3,3", "2,2"))

lab <- paste(sep="", expression(alpha), ", ", expression(beta))
p<- ggplot(data=Y) +
    geom_line(aes(x,value, color=variable), size=2) + 
    scale_y_continuous(limit=c(0,0.5)) +
    ylab("PDF") +
    scale_color_hue(name=lab) +
    theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
    )

p1<- ggplot(data=W) +
    geom_line(aes(x,value, color=variable), size=2) + 
    scale_y_continuous(limit=c(0,1.0)) +
    ylab("CDF") + 
    scale_color_hue(name=lab) +
    theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
    )

# Great lookikng in beamer
pdf("gammadist.pdf")
    grid.arrange(p,p1,ncol = 1)
dev.off()

# High res looks like crap in beamer and fonts far too small at this res
png(filename = "./gammadist.png", width = 1000, height = 750, units = 'px')
print(grid.arrange(p,p1,ncol = 1,
    main=textGrob("Gamma Probability Distribution and Cumlative Distribution", vjust=1, gp=gpar(fontface = "bold", cex=1.4))))
dev.off()


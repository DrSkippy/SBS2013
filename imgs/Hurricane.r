#!/usr/bin/env Rscript
library(ggplot2)
library(gridExtra)
library(xts)

bg <- "#646464"
gr <- "#858585"

blu <- "#7570b3"
reds <- "#d95f02"
grn <- "#1b9e77"

Y = read.delim(file="hurricane.csv", sep=",", header=TRUE)
Y$dates <- as.POSIXct(Y$Date,fmt="%Y-%m-%d %H:%M")
# guiding eye totrend, not lagging moving average signal
Z <- xts(x=Y$Hurricane, order.by=(Y$dates - 86400/2))
X <- apply.daily(Z,mean)
summary(Y)

pdf("hurricane.pdf", height=4)
    ggplot(data=Y) +
    #geom_point(aes(dates,Hurricane), color=grn) +
    geom_line(aes(dates,Hurricane), size=1, color=grn, alpha=0.7) +
    ylab("Twitter \"hurricane\" Activity") +
    xlab("Date") +
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()

pdf("hurricane_trend.pdf", height=4)
    ggplot(Y) + 
    geom_point(aes(dates,Hurricane), size=1, color=grn) +
    geom_smooth(aes(index(X),coredata(X)), size=2, color=reds, alpha=0.7) +
    ylab("Twitter \"hurricane\" Activity") +
    xlab("August 2011") + 
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()


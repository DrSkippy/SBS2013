#!/usr/bin/env Rscript
library(ggplot2)
library(gridExtra)
bg <- "#646464"
gr <- "#858585"

blu <- "#7570b3"
reds <- "#d95f02"
grn <- "#1b9e77"

Y = read.delim(file="VA_earthquake.csv", sep=",", header=TRUE)
Y$dates <- as.POSIXct(Y$date,fmt="%Y-%m-%d %H:%M")
summary(Y)

pdf("va_quake.pdf", height=4)
    ggplot(data=Y) +
    geom_point(aes(dates,Twitter), color=grn) +
    geom_line(aes(dates,Twitter), size=2, color=grn, alpha=0.4) +
    ylab("Twitter \"quake\" Activity") +
    xlab("August 2011") +
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()

pdf("va_quake_fit1.pdf", height=4)
    ggplot(data=Y) + 
    geom_point(aes(dates,Twitter), color=grn) +
    geom_line(aes(dates,Pulse), size=2, color=reds, alpha=0.7) +
    ylab("Twitter \"quake\" Activity") +
    xlab("August 2011") + 
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()


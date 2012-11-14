#!/usr/bin/env Rscript
library(ggplot2)
library(gridExtra)
bg <- "#646464"
gr <- "#858585"

Y = read.delim(file="fake_curves.csv", sep=",", header=TRUE)
Y$dates <- as.POSIXct(Y$time)
Y$perc <-Y$count/10.
levels(Y$type)[levels(Y$type)=="fake"] <- "No Power"
levels(Y$type)[levels(Y$type)=="robocall_disregard"] <- "Robocall-Disregard"
levels(Y$type)[levels(Y$type)=="robocall_restored"] <- "Robocall-Power On"
summary(Y)

pdf("fake.pdf", height=4)
    ggplot(data=Y) +
    geom_point(aes(dates,perc,color=type)) +
    ylab("Normlized Activity") +
    xlab("2012 Nov 02") +
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()

pdf("fake_fit.pdf", height=4)
    ggplot(data=Y) + 
    geom_point(aes(dates,perc,color=type)) +
    stat_smooth(aes(dates,perc,color=type),se=FALSE, size=1, alpha=0.5) + 
    ylab("Normlized Activity") +
    xlab("2012 Nov 02") + 
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()


Y = read.delim(file="fake_curves_gamma.csv", sep=",", header=TRUE)
Y$dates <- as.POSIXct(Y$time)
Y$perc <-Y$count/10.
levels(Y$type)[levels(Y$type)=="fake"] <- "No Power"
levels(Y$type)[levels(Y$type)=="robocall_disregard"] <- "Robocall-Disregard"
levels(Y$type)[levels(Y$type)=="robocall_restored"] <- "Robocall-Power On"
levels(Y$type)[levels(Y$type)=="fakeFit"] <- "No Power (Social Pulse)"
levels(Y$type)[levels(Y$type)=="disregardFit"] <- "Robocall-Disregard (SP)"
levels(Y$type)[levels(Y$type)=="restoredFit"] <- "Robocall-Power On (SP)"
summary(Y)

pdf("fake_fit2.pdf", height=4)
    ggplot(data=Y) +
    geom_point(data = subset(Y, type == "No Power"), aes(dates,perc,color=type)) +
    geom_point(data = subset(Y, type == "Robocall-Disregard"), aes(dates,perc,color=type)) +
    geom_point(data = subset(Y, type == "Robocall-Power On"), aes(dates,perc,color=type)) +
    geom_line(data = subset(Y, type == "No Power (Social Pulse)"), aes(dates,perc,color="No Power")) +
    geom_line(data = subset(Y, type == "Robocall-Disregard (SP)"), aes(dates,perc,color="Robocall-Disregard")) +
    geom_line(data = subset(Y, type == "Robocall-Power On (SP)"), aes(dates,perc,color="Robocall-Power On")) +
    ylab("Normlized Activity") +
    xlab("2012 Nov 02") +
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()

Y = read.delim(file="real_curves.csv", sep=",", header=TRUE)
Y$dates <- as.POSIXct(Y$time)
Y$perc <-Y$count/128.
levels(Y$type)[levels(Y$type)=="real"] <- "just restored power"
levels(Y$type)[levels(Y$type)=="gammaFit"] <- "Social Pulse Fit"
summary(Y)

pdf("real.pdf", height=4)
    ggplot(data=subset(Y, type == "just restored power")) +
    geom_point(aes(dates,perc,color=type)) +
    ylab("Normalized Activity") +
    xlab("Date") +
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()

pdf("real_fit.pdf", height=4)
    ggplot(data=Y) +
    geom_point(data = subset(Y, type == "just restored power"),aes(x=dates,y=perc,color=type)) +
    geom_line(data = subset(Y, type == "Social Pulse Fit"),aes(x=dates,y=perc,color=type)) +
    ylab("Normalized Activity") +
    xlab("Date") + 
        theme(
                panel.background = element_rect(fill = bg),
                panel.grid.major = element_line(colour = gr),
                panel.grid.minor = element_line(colour = gr)
        )
dev.off()


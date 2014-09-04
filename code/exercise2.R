#!/usr/bin/env Rscript

library(HMM)

states = c('GC_rich','not_GC_rich')
emissions = c('A','T','G','C')
startProbs = c(0.5,0.5)

load('observations_exercise2.RData')

###################
# your code below #
###################
# first, estimate the parameters of the HMM given only the emissions

# using the estimated parameters,
# find the most likely sequence of states that generated the observations
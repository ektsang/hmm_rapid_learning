#!/usr/bin/env Rscript

library(HMM)

states = c('GC_rich','not_GC_rich')
emissions = c('A','T','G','C')
startProbs = c(0.5,0.5)

transProbs1 = matrix(c(0.9,0.1,0.1,0.9), nrow=2, byrow=T)
rownames(transProbs1) = colnames(transProbs1) = states
emitProbs1 = matrix(c(0.1,0.1,0.4,0.4,0.4,0.4,0.1,0.1), nrow=2, byrow=T)
rownames(emitProbs1) = states
colnames(emitProbs1) = emissions

# simulation 1
set.seed(1)

hmm1 = initHMM(states, emissions, startProbs, transProbs1, emitProbs1)

simulation1 = simHMM(hmm1, 10000)

###################
# your code below #
###################
# given labeled states, estimate transition and emission probabilities






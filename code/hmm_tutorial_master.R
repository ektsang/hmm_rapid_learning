#!/usr/bin/env Rscript

library(HMM)

states = c('GC_rich','not_GC_rich')
emissions = c('A','T','G','C')
startProbs = c(0.5,0.5)

# simulation 1
set.seed(1)

transProbs1 = matrix(c(0.9,0.1,0.1,0.9), nrow=2, byrow=T)
rownames(transProbs1) = colnames(transProbs1) = states
emitProbs1 = matrix(c(0.1,0.1,0.4,0.4,0.4,0.4,0.1,0.1), nrow=2, byrow=T)
rownames(emitProbs1) = states
colnames(emitProbs1) = emissions

hmm1 = initHMM(states, emissions, startProbs, transProbs1, emitProbs1)

simulation1 = simHMM(hmm1, 10000)

########################################################

# given labeled states, calculate transition and emission probabilities
labels = simulation1$states
values = simulation1$observation

# emissions probabilities
values_GC = values[labels=="GC_rich"]
emitprob_GC = table(values_GC)/length(values_GC)
values_notGC = values[labels=="not_GC_rich"]
emitprob_notGC = table(values_notGC)/length(values_notGC)

emitprob = rbind(emitprob_GC, emitprob_notGC)[,c(1,4,3,2)] # reorder columns that were alphabetized by table
print(emitprob)

# transition probabilities
observedTransitions = matrix(c(labels[-length(labels)], labels[-1]), ncol=2, byrow=F)

transitions_GC = observedTransitions[observedTransitions[,1]=="GC_rich",2]
transprob_GC = table(transitions_GC)/length(transitions_GC)
transitions_notGC = observedTransitions[observedTransitions[,1]=="not_GC_rich",2]
transprob_notGC = table(transitions_notGC)/length(transitions_notGC)

transprob = rbind(transprob_GC,transprob_notGC)
print(transprob)

########################################################

# simulation 2
set.seed(1)

transProbs2 = matrix(c(0.89,0.11,0.14,0.86), nrow=2, byrow=T)
emitProbs2 = matrix(c(0.16,0.19,0.31,0.34,0.35,0.32,0.17,0.16), nrow=2, byrow=T)

hmm2 = initHMM(states, emissions, startProbs, transProbs2, emitProbs2)

simulation2 = simHMM(hmm2, 5000)

########################################################

# given no information about the states, 
# find the most likely sequence of states that generated the observations
observations = simulation2$observation
save(observations, file="observations_exercise2.RData")

# infer parameters
fit = baumWelch(hmm1, observations)

# infer most likely sequence of states
state_sequence = viterbi(fit$hmm, observations)

# actual state sequence
simulations = simulation2$states
save(simulations, file="states_exercise2.RData")

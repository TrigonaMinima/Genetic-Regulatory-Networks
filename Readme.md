Genetic Regulatory Networks
=======

# Data

We are currently using the data-set provided in the [Dream Challenge](https://www.synapse.org/#!Synapse:syn3049712/wiki/) so that we can test the results of our algorithm.

# What is Mutual Information?

For calculating mutual information we need to understand Shanon Entropy which is basically calculated in terms of the probability of observing a particular symbol or event, pi, within a given sequence. It can be calculated for multiple variables and is given by the following formula:

For calculating entropy for a 2 state system we take logarithmic base as 2. It is maximum when both the states are equiprobable. p(0)=p(1)=1/2, then H=1.

In case of mutiple variables we need to consider the probabilities of every possible combination of the values of the variables apply the given formula.

Now Mutual Information can be calculated by using Shannon Entropy in the following manner:


In probability theory and information theory, the mutual information (MI) or transinformation of two random variables is a measure of the variables' mutual dependence. Not limited to real-valued random variables like the correlation coefficient, MI is more general and determines how similar the joint distribution p(X,Y) is to the products of factored marginal distribution p(X)p(Y). MI is the expected value of the pointwise mutual information (PMI). The most common unit of measurement of mutual information is the bit.

Intuitively, mutual information measures the information that X and Y share: it measures how much knowing one of these variables reduces uncertainty about the other. For example, if X and Y are independent, then knowing X does not give any information about Y and vice versa, so their mutual information is zero. At the other extreme, if X is a deterministic function of Y and Y is a deterministic function of X then all information conveyed by X is shared with Y: knowing X determines the value of Y and vice versa. As a result, in this case the mutual information is the same as the uncertainty contained in Y (or X) alone, namely the entropy of Y (or X). Moreover, this mutual information is the same as the entropy of X and as the entropy of Y. (A very special case of this is when X and Y are the same random variable.)

# How are we using Mutual Information?

We are basically trying to determine that which genes are regulating a purticual gene in a GRN. Now if a gene is regulating another gene then they must have some mutual information, since the expression value of the regulated gene can be calculated on the basis of the regulator gene.

Now, if A' is an output gene and X is an input gene. We say that X regulates A' if M(A’,X)=H(A’) and if we use the MI formula given above, we just need to check if H(X)=H(A’,X). In this case X can also be a combination of many genes.


# Data

Our data is a time-series data in which we have the gene expressions at various times. We will consider the gene expressions at time t as input and at t+1 as output. Then for the next instance t+1 as input and t+2 as output and so on.

# Algorithm

1. Read input file

2. Transform input file to desired format(Write all gene expressions twice, once in output and then in input, except for t=0)

3. Start with k=1, for first gene(G1), calculate H(X),H(G1',X) for X = G1, G2,.....Gn, as soon as they are obtained to be equal we move to the next gene.

4. If for all possible values of X they are found to be unequal, then consider all combinations taking k=2 genes at a time and then recalcuate both the values for X = (G1,G2), (G1,G3), .... (Gn-1,Gn)

# Implementation

The algorithm was implemented and the resulting GRNs were visualized using D3.js

http://bl.ocks.org/agr-shrn/raw/71e270fe62eeea503e46/

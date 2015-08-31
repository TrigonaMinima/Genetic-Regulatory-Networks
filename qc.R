# Calculation of quality control information.
# Function AffyRNAdeg() from package Affy calculates
# RNA degradation.
# Other descriptives will be calculated using the
# function qc() from package simpleaffy.
# biocLite("simpleaffy")
library(simpleaffy)

deg <- AffyRNAdeg(dat)
aqc <- qc(dat)

plot(aqc)
# Above command will generate the QC stats plot

# RNA degradation plot
# Sample a no. of colors from all available colors into cols
# distinct colors are equal to the no. of samples in dat onject.
cols <- sample(colors(), nrow(pData(dat)))

# Plots the actual image using above colors,
plotAffyRNAdeg(deg, col=cols)

# A legend is added, for every array it holds one thin line
# colored using the above cols object.
legend(legend=sampleNames(dat), x="topleft", lty=1, cex=0.5, col=cols)

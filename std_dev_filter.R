library(genefilter)

# Standard deviation filter
# 1. Calculate the std deviation of every single gene
# 2. Retaining the genes with (sd >= 2)
rsd <- rowSds(dat.m)
i <- rsd >= 2
dat.f <- dat.m[i,]


print("Creating data dump... (dat.f.txt created)")
write.table(dat.f,
    "BeforeStatTest/StdFilter/dat.f.txt",
    sep="\t",
    row.names=T,
    col.names=T,
    quote=F)

rm(rsd, i)

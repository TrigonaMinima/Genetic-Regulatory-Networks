# source("http://www.bioconductor.org/biocLite.R")
# biocLite("hgu133plus2.db")
library(hgu133plus2.db)

gsea <- function(dat, fname){
    allg <- get("hgu133plus2ENTREZID")
    allg <- as.data.frame(unlist(as.list(allg)))
    # Contains all the probes that we consider interesting
    myids <- unique(allg[rownames(dat),])

    print("Dumping myids...")
    write.table(myids,
        paste(fname, "myids.txt", sep=""),
        sep="\t",
        row.names=T,
        col.names=T,
        quote=F)

    rm(allg)
    myids
}

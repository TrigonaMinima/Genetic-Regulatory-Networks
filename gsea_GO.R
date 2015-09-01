library(GO.db)
library(GOstats)

GO <- function(myids, fname){
    params <- new("GOHyperGParams",
        geneIds=myids,
        annotation=c("hgu133plus2"),
        ontology="BP",
        pvalueCutoff=0.05,
        conditional=FALSE,
        testDirection="over")
    resultBP <- hyperGTest(params)
    params <- new("GOHyperGParams",
        geneIds=myids,
        annotation=c("hgu133plus2"),
        ontology="MF",
        pvalueCutoff=0.05,
        conditional=FALSE,
        testDirection="over")
    resultMF <- hyperGTest(params)
    params <- new("GOHyperGParams",
        geneIds=myids,
        annotation=c("hgu133plus2"),
        ontology="CC",
        pvalueCutoff=0.05,
        conditional=FALSE,
        testDirection="over")
    resultCC <- hyperGTest(params)

    fname <- paste(fname, "hypergeo_GO.html", sep="")
    htmlReport(resultBP, fname, append=T)
    htmlReport(resultMF, fname, append=T)
    htmlReport(resultCC, fname, append=T)

    rm(params, fname)
    result <- list(resultBP = resultBP,
        resultMF = resultMF,
        resultCC = resultCC)
}

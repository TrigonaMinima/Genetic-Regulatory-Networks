library(KEGG.db)

KEGG <- function(myids, fname) {
    params <- new("KEGGHyperGParams",
        geneIds=myids,
        annotation="hgu133plus2",
        pvalueCutoff=0.05,
        testDirection="over")
    result <- hyperGTest(params)

    fname <- paste(fname, "hypergeo_KEGG.html", sep="")
    htmlReport(result, fname, append=T)
    print("HTML report generated...")

    rm(params, fname)
    result
}

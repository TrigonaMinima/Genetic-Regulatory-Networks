library(amap)

cluster <- function(dat, fname){
    clust.genes <- hcluster(x=dat, method="pearson", link="average")
    clust.arrays <- hcluster(x=t(dat), method="pearson", link="average")

    # Usual coloring scheme for microarray data in heatmaps is to
    # present down-regulated genes with green, and up-regulated genes with red.
    # Function colorRampPalette() takes first argument as the color for the
    # smallest observation (the most down-regulated gene), and second argument
    # the color for the largest observation (the most up-regulated gene). The
    # number after the command specifies how many different colors between the
    # extremes should be generated, here we use 32 colors.
    heatcol <- colorRampPalette(c("Green", "Red"))(32)

    # Function heatmap() generates the heatmap. It takes in 4 arguments
    # x = matrix dataset (dat.m is converted to matrix here)
    # Rowv = dendogram of clustred genes
    # Colv = dendogram of clustred samples
    # col = coloring scheme to be used

    png(paste(fname, "heatmap.png"), width=12, height=10, units="in", res=250)
    heatmap(x=as.matrix(dat),
        Rowv=as.dendrogram(clust.genes),
        Colv=as.dendrogram(clust.arrays),
        col=heatcol)
    dev.off()

    rm(clust.genes, clust.arrays, heatcol)
}

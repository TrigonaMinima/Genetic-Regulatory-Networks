
optimal_clusters <- function(dat, fname){
    # Test a maximum of 100 clusters
    kmax <- c(30)

    # If there are less than 100 genes or arrays make the max.
    # no. of cluster equal to the number of genes or arrays.
    if(nrow(dat) < 30) {
        kmax <- nrow(dat)
    }

    # Create an empty vector for storing the within SS values
    km <- rep(NA, (kmax-1))
    # Minimum number of cluster is 2
    i <- c(2)
    # Test all numbers of clusters between 2 max. 100 using the while loop
    while(i < kmax) {
        km[i] <- sum(kmeans(dat.m, i, iter.max=20000, nstart=10)$withinss)
        # Terminate the run if the change in within SS is less than 1

        if(i >= 3 & km[i-1] / km[i] <= 1.99) {
            i <- kmax
        }else {
            i <- i + 1
        }
    }

    # Plot the number of K against the within SS
    png(paste(fname, "optimal.png"))
    plot(
         2:kmax,
         km,
         xlab="K",
         ylab="sum(withinss)",
         type="b",
         pch="+",
         main="Terminated when change less than 2%"
    )
    dev.off()
}

clustering <- function(dat, clusters, fname){
    km <- kmeans(x=as.matrix(dat), algorithm="Lloyd",
    centers=clusters, iter.max=200000, nstart=10)

    # K-means clustering is usually visualized by drawing the gene expression
    # pattern across the arrays using a single line graph per cluster.
    # Function matplot() does the actual plotting.
    # The idea is to get a general view of the pattern in the data.

    max.dat <- max(dat)
    min.dat <- min(dat)

    k <- c(clusters)

    # Plot the number of K against the within SS
    png(paste(fname, "kmeans.png"), width=12, height=7, units="in", res=250)
    par(mfrow=c(ceiling(sqrt(k)), ceiling(sqrt(k))))

    for(i in 1:k) {
        matplot(t(dat[km$cluster==i,]), type="l",
        main=paste("cluster:", i), ylab="log expression",
        col=1, lty=1, ylim=c(min.dat, max.dat))
    }
    dev.off()
}

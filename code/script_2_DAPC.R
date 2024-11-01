## Using discriminant analysis of principal components to infer genetic population structure ##

# Load relevant packages
library(vcfR)
library(adegenet)
library(ggplot2)

# Set working directory
setwd("C:/Users/rafae/Downloads/aulagenpopmz/data")

# Read in SNP data
snpdata.vcf <- read.vcfR("snpdata.vcf")

# Convert vcf to genind
snpdata.geni <- vcfR2genind(snpdata.vcf)

# Read in sample info
sample.info <- read.table("sampleinfo.csv", sep = ",", header = TRUE)

# Reorder sample info to match order of samples in genind
sample.info <- sample.info[match(indNames(snpdata.geni), sample.info$id), ]

# Set population membership
pop(snpdata.geni) <- sample.info[, "pop"]


# Discriminant analysis tests groups defined a priori. For DAPC, we can either use our own groupings based on external information (e.g. taxa or whatever grouping we want) or, when groups are unknown or uncertain, we can use the K-means clustering algorithm as implemented in the 'find.clusters' function to identify the statistically optimal number of clusters before performing DAPC.

# It is important to note that the groups identified via K-means or any other clustering algorithm are statistically optimal but not necessarily biologically meaningful! It is you the responsible for the biological inference based on the results of the algorithm.

# Let's first use the 'find.clusters' function to infer clusters de novo (i.e., without any a priori information about the samples). When using the K-means clustering algorithm, different possible numbers of clusters are compared using BIC. The optimal numbers are those associated with the lowest BIC values. The function 'find.clusters' will return some graphs and ask you to choose the number of PCs to retain and then the number of clusters to consider. Apart from computational time, there is no reason for keeping a small number of PCs at this step. We will keep all PCs by specifying to retain 200 PCs (there are actually less PCs, so all of them are kept if you specify a larger number). Choosing the number of clusters to retain, however, may sometimes be a tricky exercise. When BIC values are similar for multiple numbers of clusters, make sure to visualize the results under all these possible values to assess which one is the best in the context of your study system.

# Run the 'find.clusters' function interactively
num.clust <- find.clusters(snpdata.geni, max.n.clust = 10)

# 200

# 4

# We can also run the 'find.clusters' function specifying the parameters in the function once we know the statistically optimal number of clusters
kmeans4 <- find.clusters(snpdata.geni, n.pca = 200, n.clust = 4)

# We can check which samples were retrieved in each cluster
k4.ind <- table(indNames(snpdata.geni), kmeans4$grp)

k4.ind

# And also how many samples of each of the populations you defined a priori were retrieved in each cluster
k4.pop <- table(pop(snpdata.geni), kmeans4$grp)

k4.pop

# Or both information combined
k4.ind.pop <- data.frame(sample = indNames(snpdata.geni),
                         pop = pop(snpdata.geni),
                         k.means.cluster = kmeans4$grp)

k4.ind.pop

# Now that you have inferred clusters using K-means, perform the DAPC on these clusters. We don't want to use too many PCs at this step, because this could lead to overfitting of the model (i.e., separation among groups could be artificially inflated). We will follow the "k-1 criterion" (Thia 2023, Mol. Ecol. Resour. 23: 523-538) and retain k-1 PCs in the analysis. For the analysis using k = 4, this means we will retain 3 PCs (i.e. k-1). We also need to choose a number of discriminant functions to retain. For small numbers of clusters, retaining all of them is reasonable; when there are tens of clusters, it is likely that the first few dimensions will carry more information than the others, and then only those can be retained.
dapc.kmeans.k4 <- dapc(snpdata.geni, pop = kmeans4$grp, n.pca = 3, n.da = 3)

# The output contains a lot of information
dapc.kmeans.k4

# We can visualize the DAPC using the default scatterplot function of the 'adegenet' package
scatter(dapc.kmeans.k4)

# We can customize several aspects of this plot, for example
mycolors <- c("red","blue","green","orange")

scatter(dapc.kmeans.k4,
        scree.da = FALSE,
        scree.pca = FALSE,
        bg = "white",
        pch = 20,
        cell = 0,
        cstar = 0,
        col = mycolors,
        solid = 0.4,
        cex = 3,
        clab = 0,
        leg = TRUE)

# Alternatively, we can extract relevant information from the output into a new dataframe and use ggplot to customize whatever we want
dapc.kmeans.k4.df <- data.frame(individual = row.names(dapc.kmeans.k4$ind.coord),
                         LD1 = dapc.kmeans.k4$ind.coord[, 1],
                         LD2 = dapc.kmeans.k4$ind.coord[, 2],
                         population = pop(snpdata.geni),
                         group = dapc.kmeans.k4$grp)

# Custom scatterplot using ggplot
ggplot(data = dapc.kmeans.k4.df, aes(x = LD1, y = LD2, color = population)) +
  geom_point(size = 4, alpha = 0.7) +
  theme_bw()


# We could also perform DAPC on clusters that we defined a priori, instead of using K-means to identify clusters in the data. In this data set we are using, there are 4 clearly separated genetic clusters, so that our a priori groupings are perfectly consistent with the groups identified by the K-means clustering algorithm. But this will often not be the case, and you will have to decide what is the purpose of performing a DAPC: do you want to use DAPC to test your a priori groupings, or do you want to use it to test groupings inferred de novo via a clustering algorithm like K-means?
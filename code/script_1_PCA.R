## Using principal component analysis to infer genetic population structure ##

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

# Extract allele frequencies and replace missing data with the mean allele frequency
allele.freq <- tab(snpdata.geni, freq = TRUE, NA.method = "mean")

# Perform PCA, retaining the first three principal components (we typically examine only the first two axes, sometimes the third; so, there's no need to retain more axes)
pcares <- dudi.pca(allele.freq, scale = FALSE, scannf = FALSE, nf = 3)

# Plot eigenvalues
barplot(pcares$eig, main = "PCA eigenvalues")

# Plot a subset of the eigenvalues for closer examination
barplot(pcares$eig[1:5], main = "PCA eigenvalues")

# Calculate the proportion of variance explained by each PC
eig_perc <- pcares$eig / sum(pcares$eig)

# Prepare a data frame for plotting PCA results
pca_df <- data.frame(individual = row.names(pcares$li),
                      PC1 = pcares$li[, 1],
                      PC2 = pcares$li[, 2],
                      PC3 = pcares$li[, 3],
                      population = pop(snpdata.geni))

# We typically make a scatterplot of the first two PC axes
ggplot(data = pca_df, aes(x = PC1, y = PC2, color = population)) +
  geom_point(size = 5, alpha = 0.7) +
  xlab(paste0("PC 1 (", round(eig_perc[1]*100, 0), "% variance explained)")) +
  ylab(paste0("PC 2 (", round(eig_perc[2]*100, 0), "% variance explained)")) +
  theme_bw()

# But we could also examine the PCs individually. For example, plotting PC1 as a histogram
ggplot(data = pca_df, aes(x = PC1, fill = population)) +
  geom_density(alpha = 0.8, color = NA) +
  theme_bw()

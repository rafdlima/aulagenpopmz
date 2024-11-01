## Estimating Fst ##

# Load relevant packages
library(vcfR)
library(adegenet)
library(StAMPP)

# Set working directory
setwd("C:/Users/rafae/Downloads/aulagenpopmz/data")

# Read in SNP data
snpdata.vcf <- read.vcfR("snpdata.vcf")

# Convert vcf to genlight
snpdata.gen <- vcfR2genlight(snpdata.vcf)

# Read in sample info
sample.info <- read.table("sampleinfo.csv", sep = ",", header = TRUE)

# Reorder sample info to match order of samples in genlight
sample.info <- sample.info[match(indNames(snpdata.gen), sample.info$id), ]

# Set population membership
pop(snpdata.gen) <- sample.info[, "pop"]

# Calculate Fst using the 'stamppFst' function from the package 'StAMPP'
fst.estimates <- stamppFst(snpdata.gen, nboots = 100, percent = 95)

# See results with two decimals
round(fst.estimates$Fsts, 2)
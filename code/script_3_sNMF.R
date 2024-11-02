## Inferring genetic population structure with sparse Nonnegative Matrix Factorization (sNMF) ##

### Load relevant packages
library(vcfR)
library(LEA)


### Create directories to store outputs
# Create new directory for outputs from the sNMF run using alpha = 50
dir.create("C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a50")

# Create new directory for outputs from the sNMF run using alpha = 100
dir.create("C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a100")


### Prepare data
# Define path for SNP data
pathvcf <- "C:/Users/rafae/Downloads/aulagenpopmz/data/snpdata.vcf"

# Convert the SNP data, saving one geno file in each directory
vcf2geno(input.file = pathvcf, output.file = "C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a50/snpdata.geno")

vcf2geno(input.file = pathvcf, output.file = "C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a100/snpdata.geno")


### Run sNMF for each alpha value
snmf_a50 <- snmf(input.file = "C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a50/snpdata.geno",
                   K = 1:10,
                   entropy = TRUE,
                   repetitions = 20,
                   project = "new",
                   alpha = 50)

snmf_a100 <- snmf(input.file = "C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a100/snpdata.geno",
                   K = 1:10,
                   entropy = TRUE,
                   repetitions = 20,
                   project = "new",
                   alpha = 100)
				   

### Load sNMF outputs (OPTIONAL)
# For each sNMF run, set the working directory where the output is stored and read it into R
setwd("C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a50")
snmf_a50 <- load.snmfProject("snpdata.snmfProject")

setwd("C:/Users/rafae/Downloads/aulagenpopmz/data/snmf/snmf_a100")
snmf_a100 <- load.snmfProject("snpdata.snmfProject")


### Read in sample info to reorder samples in the bar plot (OPTIONAL)
# Read in sample info file and reorder it according to the SNP dataset you used as input for the analysis
setwd("C:/Users/rafae/Downloads/aulagenpopmz/data")

sample.info <- read.table("sampleinfo.csv", sep = ",", header = TRUE)

snpdata.vcf <- read.vcfR("snpdata.vcf")

sample.info <- sample.info[match(colnames(snpdata.vcf@gt)[-1], sample.info$id), ]

remove(snpdata.vcf)


### Cross-entropy plot
# Plot cross-entropy for the snmf run using alpha 50
plot(snmf_a50)

# Plot cross-entropy for the snmf run using alpha 100
plot(snmf_a100)


### Bar plot of ancestry coefficients
# First identify the best replicate run for the chosen k value
ce.a100 <- cross.entropy(snmf_a100, K = 4)
bestrun.a100 <- which.min(ce.a100)

# Default bar plot using the 'barchart' function from the package LEA (alternatively, you could extract relevant info from snmf_a100 into a dataframe and plot using ggplot)
par(mar = c(4.1, 4.1, 0.5, 0.2))
barchart(snmf_a100,
         K = 4,
         run = bestrun.a100,
         col = c("red","lightblue","olivedrab","gold"),
         xlab = "Individuals",
         ylab = "Ancestry coefficients",
         las = 2,
         space = 0)


### Other plots outside R (OPTIONAL)
# Get the Q-matrix containing the ancestry coefficients from the best replicate run
Qmatrix.a100 <- Q(snmf_a100, K = 4, run = bestrun.a100)

# Then you could combine this 'Qmatrix.a100' with relevant sample info (e.g. coordinates) in a single table to plot in QGIS (not shown here)
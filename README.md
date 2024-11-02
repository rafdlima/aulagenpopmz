# **Aula de análises genéticas populacionais**


Este repositório contém todos os dados e códigos que nós usaremos durante a aula. Nós usaremos como exemplo um conjunto de dados com 553 SNPs de 45 indivíduos, e exploraremos cinco tipos de análises amplamente usadas para estudar a estrutura genética de populações.


> [!IMPORTANT]
> Nós faremos todas as análises partindo do pressuposto que os dados já foram devidamente filtrados e otimizados para cada análise. Não falaremos sobre filtragem de SNPs.
> Porém, acho importante ressaltar que a filtragens dos dados genéticos afeta todas as análises subsequentes e, portanto, é imprescindível saber o que está fazendo e dedicar tempo nessa etapa que precede a análise dos dados. O seguinte artigo é uma revisão extremamente bem escrita resumindo quase tudo sobre o assunto:
> [Hemstrom et al. 2024. Next-generation data filtering in the genomics era. Nature Reviews Genetics 25: 750-767.](https://doi.org/10.1038/s41576-024-00738-6)
> O pacote [SNPfiltR](https://devonderaad.github.io/SNPfiltR/) no R é excelente para fazer a filtragem dos SNPs.


## Tutoriais:
1. [Principal Component Analysis (PCA)](https://rafdlima.github.io/aulagenpopmz/vignettes/PCA.html)
2. [Discriminant Analysis of Principal Components (DAPC)](https://rafdlima.github.io/aulagenpopmz/vignettes/DAPC.html)
3. [Sparse Nonnegative Matrix Factorization (sNMF)](https://rafdlima.github.io/aulagenpopmz/vignettes/sNMF.html)
4. [Fixation index (*F*<sub>ST</sub>)](https://rafdlima.github.io/aulagenpopmz/vignettes/FST.html)
5. [Triangle plots](https://rafdlima.github.io/aulagenpopmz/vignettes/triangle.html)


## Literatura:
### PCA
- [Shlens 2014. A tutorial on principal component analysis. arXiv.](https://arxiv.org/pdf/1404.1100)
- [Patterson et al. 2006. Population structure and eigenanalysis. PLoS Genetics 2: e190.](https://doi.org/10.1371/journal.pgen.0020190)
- [Novembre & Stephens 2008. Interpreting principal component analyses of spatial population genetic variation. Nature Genetics 40: 646-649.](https://doi.org/10.1038/ng.139)
- [Yi & Latch 2022. Nonrandom missing data can bias principal component analysis inference of population genetic structure. Molecular Ecology Resources 22: 602-611.](https://doi.org/10.1111/1755-0998.13498)

### DAPC
- [Jombart et al. 2010. Discriminant analysis of principal components: a new method for the analysis of genetically structured populations. BMC Genetics 11: 1-15.](https://doi.org/10.1186/1471-2156-11-94)
- [Miller et al. 2020. The influence of a priori grouping on inference of genetic clusters: simulation study and literature review of the DAPC method. Heredity 125: 269-280.](https://doi.org/10.1038/s41437-020-0348-2)
- [Thia 2023. Guidelines for standardizing the application of discriminant analysis of principal components to genotype data. Molecular Ecology Resources 23: 523-538.](https://doi.org/10.1111/1755-0998.13706)

### sNMF e afins
- [Pritchard et al. 2000. Inference of population structure using multilocus genotype data. Genetics 155: 945-959.](https://doi.org/10.1093/genetics/155.2.945)
- [Frichot et al. 2014. Fast and efficient estimation of individual ancestry coefficients. Genetics 196: 973-983.](https://doi.org/10.1534/genetics.113.160572)
- [Janes et al. 2017. The K = 2 conundrum. Molecular Ecology 26: 3594-3602.](https://doi.org/10.1111/mec.14187)
- [Lawson et al. 2018. A tutorial on how not to over-interpret STRUCTURE and ADMIXTURE bar plots. Nature Communications 9: 3258.](https://doi.org/10.1038/s41467-018-05257-7)
- [Meirmans 2015. Seven common mistakes in population genetics and how to avoid them. Molecular Ecology 24: 3223-3231.](https://doi.org/10.1111/mec.13243)
- [Wiens & Colella 2024. That’s not a hybrid: how to distinguish patterns of admixture and isolation-by-distance. Molecular Ecology Resources e14039.](https://doi.org/10.1111/1755-0998.14039)

### Medidas de diferenciação
- Páginas 81-91 de [Hahn 2018. Molecular population genetics. Oxford University Press, New York.](https://global.oup.com/academic/product/molecular-population-genetics-9780878939657?cc=br&lang=en&)
- [Holsinger & Weir 2009. Genetics in geographically structured populations: defining, estimating and interpreting FST. Nature Reviews Genetics 10: 639-650.](https://doi.org/10.1038/nrg2611)
- [Bhatia et al. 2013. Estimating and interpreting FST: the impact of rare variants. Genome Research 23: 1514-1521.](http://www.genome.org/cgi/doi/10.1101/gr.154831.113)
- [Willing et al. 2012. Estimates of genetic differentiation measured by FST do not necessarily require large sample sizes when using many SNP markers. PLoS ONE 7: e42649.](https://doi.org/10.1371/journal.pone.0042649)

### Inferência robusta de hibridização
- [Wiens & Colella 2024. triangulaR: an R package for identifying AIMs and building triangle plots using SNP data from hybrid zones. bioRxiv. ](https://doi.org/10.1101/2024.03.28.587167)
- Ver também https://omys-omics.github.io/triangulaR/articles/triangle_plot_basics.html
- e https://omys-omics.github.io/triangulaR/articles/explore_triangle_plots.html

# QTA with R 2019 
# Manual cmp coding
# Codebook: https://manifestoproject.wzb.eu/down/documentation/codebook_MPDataset_MPDS2015a.pdf
# e.g. per202: "Democracy, favourable"

# From GitHub 
cmp_coding <- read.csv(url("https://raw.githubusercontent.com/julianbernauer/QTA_R_course/master/cmp_coding.csv"), encoding="UTF-8")
View(cmp_coding)

# Four raters 
aa <- as.character(cmp_coding$cmp_category_aa)
cm <- as.character(cmp_coding$cmp_category_cm)
dh <- as.character(cmp_coding$cmp_category_dh)
kb <- as.character(cmp_coding$cmp_category_kb)

# Absolute agreement of coders
# Following http://dwoll.de/rexrepos/posts/interRaterICC.html
library(irr)
agree(cbind(aa,cm,dh,kb))



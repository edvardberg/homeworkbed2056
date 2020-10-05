library(tidyverse)
library(rvest)

browseURL("http://timeplan.uit.no/emne_timeplan.php?sem=20h&module%5B%5D=BED-2056-1&View=list")

# Laster opp data
bed2056<- "http://timeplan.uit.no/emne_timeplan.php?sem=20h&module%5B%5D=BED-2056-1&View=list"
datascraped <- Sys.time()  
webpag <- read_html(bed2056)
html_session("http://timeplan.uit.no/emne_timeplan.php?sem=20h&module%5B%5D=BED-2056-1&View=list")

# kombinerer data til et table
x<-html_table(html_nodes(webpag, "div table")[1:14])

# velger variabler

bed2056 <- as.data.frame(matrix(unlist(x), nrow =14, byrow=T),stringsAsFactors=FALSE)


view(bed2056)

bed2056

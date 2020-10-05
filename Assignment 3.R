#Velger biblotek
library(tidyverse)
library(rvest)
library(tidyr)
#leser html-link
browseURL("https://www.datacamp.com/courses/tech:r")
browseURL("https://www.datacamp.com/courses/tech:python")
# laster ned data
r.dc <- "https://www.datacamp.com/courses/tech:r"
python.dc<- "https://www.datacamp.com/courses/tech:python"
# sjekker systime for 2xx- alt ok
datascraped <- Sys.time()
datascraped
r.dc <- read_html(r.dc)
python.datacamp<- read_html(python.dc) 
r.dc<-html_session("https://www.datacamp.com/courses/tech:r")
python.dc<-html_session("www.datacamp.com/courses/tech:python")
# course-block__title er node for r-kursene og course-block__title er node for Python
r.node<-as.data.frame(html_text(html_nodes(r.dc, ".course-block__title")))
r<-cbind(r.node, "R") 

python.node<-as.data.frame(html_text(html_nodes(python.dc,".course-block__title")))
p<-cbind(python.node,"Python") 
#Setter inn navnene til kollonene 
colnames(r)<-c("Tech","Language") 

colnames(p)<- c("Tech", "Language")
#Kombinerer r og python 
comb<-bind_rows(r,p)
colnames(comb)<-c("Tech","")

view(comb)

comb

library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)
#Her må man sette sin egen WD
setwd("C:\Users\47958\Desktop\BED2056")

#Henter inn data, som jeg lastet ned og pakket ut. Fjern "#"
#Birth17 <- read_csv("Birth17.txt")
#Birth18 <- read_csv("Birth18.txt")
#Birth19 <- read_csv("Birth19.txt")
################################################################

#Valgte å sortere data etter år
Birth17 <- Birth17 %>% mutate(Year=2017)
Birth18 <- Birth18 %>% mutate(Year=2018)
Birth19 <- Birth19 %>% mutate(Year=2019)

#Samlet data i et datasett

BirthTot <- bind_rows(Birth17,Birth18,Birth19)
#gjør variablene numerisk
BirthTot$BirthMonth <- as.numeric(BirthTot$BirthMonth)
BirthTot$BirthWeight <- as.numeric(BirthTot$BirthWeight)
#sjekekr str
str(BirthTot)

allbirth <- BirthTot %>%  group_by(Year, SexOfInfant) %>% mutate(count=row_number()) %>% filter(count==max(count))

dataplotSOF <- ggplot(data = BirthTot, aes(x=SexOfInfant,y=count, fill=SexOfInfant)) + geom_bar(stat="identity")+
  theme_hc()+
  ylab(expression("Antall fødsler")) +
  xlab("Sex of Infant")+
  facet_wrap(~Year) +skip_empty_rows(=TRUE)


#gjennomsnittsvekt
gjbirth <- allbirth %>%
  group_by(Year,SexOfInfant)%>%
  summarise(avgWeight=mean(BirthWeight))

gjbirth

#Fødsler etter ukedager

#Omrangerer på variablene
ukebasis <- allbirth %>%
  arrange(Year,SexOfInfant,BirthDayOfWeek) 
#datawrangle
ukebasis<-ukebasis%>%  
  group_by(Year,SexOfInfant,BirthDayOfWeek) %>%
  mutate(count=row_number()) %>%
  filter(count==max(count))
#plot
ukebasis %>% 
  ggplot(aes(x=BirthDayOfWeek, y=count,group=SexOfInfant)) +
  geom_line(aes(color=SexOfInfant))+
  ylab(expression("Fødsler")) +
  xlab("Weekday 1=Sunday,7=Monday") 


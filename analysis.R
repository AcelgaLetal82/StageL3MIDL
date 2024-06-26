library("tidyverse")
library("ggplot2")
library("dplyr")

setwd("c:\\Users\\malat\\OneDrive\\Bureau\\S6\\Stage\\StageL3MIDL")
dataset <- read.csv(".\\data_rugby.csv", sep=";", dec=".")

#Quelques infos pour s'échauffer

#évolution du score
datasetScore= data.frame(dataset["MatchTime"], dataset["hometeamCurrentScore"], dataset["awayteamCurrentScore"])
ggplot() + 
  geom_line(data = datasetScore, mapping = aes(x=MatchTime, y=hometeamCurrentScore), color="blue") +
  geom_line(data = datasetScore, mapping = aes(x=MatchTime, y=awayteamCurrentScore), color="red") + 
  geom_smooth(se=T)

#Proportion de chaque action
dsAction <- data.frame(dataset["action"], dataset["actionName"], dataset["MatchTime"])
dsActionCount <- dsAction %>% group_by(actionName) %>% tally(sort=TRUE) 
dsActionProp <- data.frame(dsActionCount, dsActionCount["n"] / colSums(dsActionCount["n"]))
names(dsActionProp) <- c("actionName", "occ", "prop")
View(dsActionCount)
ggplot(data = dsActionProp) +
  geom_bar(mapping = aes(x=1, fill=actionName)) + 
  coord_polar(theta="y")

#Localisation des passes en fonction de l'équipe
dsPass <- subset(dataset, subset = actionName == "Pass")
View(dsPass)

ggplot(data = dsPass, aes(x=x_coord,y=y_coord, color=ActionTypeName)) + 
  geom_point() + 
  facet_wrap(~isHome) + 
  theme_classic()






## Lambros Vagias 
## u803120

## Load packages ---------------------------------------------------------------
library(dplyr)
library(ggplot2)

## Load data -------------------------------------------------------------------
spells <- read.csv("E:/data/spells.csv", stringsAsFactors = FALSE)
# note: you can adapt this line ON YOUR MACHINE, however, restore to the above
# before handing in your assignment for smooth evaluation

# these example exercises show how to store your answers.

## Exercise 0a -----------------------------------------------------------------
ten_flights <- slice(flights, 1:10)
answer0a <- ten_flights

## Exercise 0b -----------------------------------------------------------------
answer0b <- ggplot(flights, aes(x = DEP_DELAY)) + ## how to store a ggplot object
  geom_bar()

## Note: Please delete these demo's, and this comment, before handing in.


## Exercise 1 -----------------------------------------------------------------
Q1_spells <- spells %>%
  filter(level >= 4) %>%
  select(-starts_with("c"))%>%
  select(-description)

answer1 <- Q1_spells

## Exercise 2 -----------------------------------------------------------------
count_S = lengths(lapply(spells$components, grepRaw, pattern = "S", all = TRUE, fixed = TRUE))
count_V = lengths(lapply(spells$components, grepRaw, pattern = "V", all = TRUE, fixed = TRUE))
count_M = lengths(lapply(spells$components, grepRaw, pattern = "M", all = TRUE, fixed = TRUE))
Q2_spells <- spells %>%
  mutate(number_of_components=count_M+ count_S+ count_V) 

answer2 <- Q2_spells

## Exercise 3 ----------------------------------------------------------------
Q3_spells <- spells %>%
group_by(school, level) %>%
  summarise(spells_per_level=n()) %>%
  filter(level<= 7) %>%
  arrange(desc(level),desc(spells_per_level))
  
answer3 <- Q3_spells
 
## Exercise 4 ---------------------------------------------------------- 
q4_spells<-spells%>%
  filter(school!="Abjuration" & school !="Enchantment") %>%
  group_by(level,name) %>%
  summarise() %>%
  arrange(level,name) %>%
  slice (0:3)
answer4 <- q4_spells

## Exercise 5 ------------------------------------------- 
q5 <- spells%>%
  mutate(RequiresMat=grepl( ")",components)) %>%
  mutate(HighLow=level)
q5$HighLow[qtest5$HighLow>=4] <- "High level"
q5$HighLow[qtest5$HighLow<4] <- "Low Level"
answer5 <- ggplot(data=q5,aes(x=factor(HighLow),fill=RequiresMat))+
  geom_bar(position = "dodge")+
  scale_fill_discrete(name="Material Components" ,labels=c("No Material Components","With Material Components"))+
  facet_grid(~school) 
answer5

## Exercise 6 -------------------------------------------
q6 <- spells
char_vec <- (q6$duration)
char_vec <- factor(na_if(char_vec,("1,000 gp and one ornately carved bar of silver worth"  )))
char_vec <- recode_factor(char_vec, `Concentration, up to 1 day` = "1 day", `Concentration, up to 1 hour` = "1 hour", 
                       `Concentration, up to 1 minute` = "1 minute",`Concentration, up to 10 minutes`="10 minutes",`Concentration, up to 8 hours`="8 hours",
                       `24 hours`="1 day",`Up to 1 hour`="1 hour",`Up to 1 minute`="1 minute",`Up to 8 hours`="8 hours",`1day`="1 day")
q6$duration <- char_vec
answer6 <- q6       
       
## Exercise 7 -------------------------------------------      
q7<- q6[complete.cases(q6), ]
answer7 <- ggplot(data=q7,aes(x=factor(duration,level = c("Until dispelled","1 day","8 hours","1 hour","10 minutes","1 minute","1 round","Instantaneous"))
              ,fill=school))+
              geom_bar()+
              coord_flip()+
              scale_fill_discrete(name="School of Magic",)+
              xlab("Duration of Spells")+
              ylab("Number of Spells")
## Exercise 8 -------------------------------------------        
q8 <- spells %>%
  filter (school == "Evocation" |school =="Illusion")
answer8 <- ggplot(data = q8, aes(x = factor(school),y=factor(level))) + 
  geom_dotplot(binaxis='y',stackdir = "center",binwidth = 1.5,dotsize = 0.5)+
  theme_minimal() +
  ylab("Spell Level") +
  xlab("Schools of Magic")+
  scale_x_discrete(breaks = NULL)
## Exercise 9 -------------------------------------------  
q9 <- spells
Fire_vector <- filter(q9,grepl("fire|Fire",description))
Fire_vector <- nrow(Fire_vector)

Fleece<- q9 %>%
  select(-c(casting_time,duration,range,description)) %>%
  filter(grepl('fleece|Fleece',components)) %>%
  arrange(level)

stone <- q9 %>%
  filter(grepl("Stone|stone",name))%>%
  summarise(highest=max(level),lowest=min(level))  %>%
  unlist() %>%
  unname()
stone_vector <- factor(c("lowest","highest"))
names(stone) <- stone_vector
answer9 <- list(Fire_vector,Fleece,stone)
## Exercise 10 -------------------------------------------  
Q10 <-spells %>%
  group_by(school, level) %>%
  summarise(n_spells=n()) 
answer10 <- ggplot(data=Q10,aes(x=school,y=factor(level),fill=school))+
  geom_point(aes(color=school,size=n_spells))+
  xlab("School of Magic")+
  ylab("Spell Level")+
  scale_x_discrete(breaks = NULL)+
  theme_minimal()+
  labs(title="Number of Spells per Level for Magic Schools")+
  guides(color = guide_legend(order=1),
         size = guide_legend(order=2),  fill = "none")
answer10









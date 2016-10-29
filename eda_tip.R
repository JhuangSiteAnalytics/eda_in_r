#=====================================================
# ggplot
#=====================================================
library(ggplot2)
data(diamonds)

ggplot(diamonds,aes(x=carat,y=price))+geom_point()
ggplot(diamonds,aes(x=carat,y=price),color=cut)+geom_point()
ggplot(diamonds,aes(x=carat,y=price),color=clarity, size=cut)+geom_point()+geom_smooth()
ggplot(diamonds,aes(x=carat,y=price),color=clarity)+geom_point()+geom_smooth(se='False')

#===========================
# easily create multiple graph
#===========================
ggplot(diamonds,aes(x=carat,y=price),color=cut)+geom_point()+facet_wrap(~clarity)
ggplot(diamonds,aes(x=carat,y=price),color=cut)+geom_point()+facet_grid(color~clarity)

## historgram
ggplot(diamonds,aes(x=price, fill=clarity))+geom_histogram(binwidth=200)
ggplot(diamonds,aes(x=price, fill=cut))+geom_histogram(binwidth=200)
ggplot(diamonds,aes(x=price))+geom_histogram(binwidth=200)+facet_wrap(~clarity)
ggplot(diamonds,aes(x=price))+geom_histogram(binwidth=200)+facet_wrap(~clarity, scale="free_y")

ggplot(diamonds,aes(x=price))+geom_density()

ggplot(diamonds,aes(x=color, y=price))+geom_boxplot()
ggplot(diamonds,aes(x=color, y=price))+geom_boxplot()+scale_y_log10()
ggplot(diamonds,aes(x=color, y=price))+geom_violin()+scale_y_log10()
ggplot(diamonds,aes(x=color, y=price))+geom_violin()+scale_y_log10()+facet_wrap(~clarity)

x=rnorm(1000)
qplot(x)
qplot(x,binwidth=1)+xlab("Random Variable")
y=rnorm(1000)
qplot(x,y)
qplot(x,y)+geom_smooth()

data("WorldPhones")
# install.packages("reshape2")
library(reshape2)
WorldPhones.m=melt(WorldPhones)
colnames(WorldPhones.m)=c("Year","Continent", "Phones")
ggplot(WorldPhones.m, aes(x=Year, y=Phones, color=Continent))+geom_line()
p=ggplot(WorldPhones.m, aes(x=Year, y=Phones, color=Continent))+geom_line()

ggsave("WorldPhone.png")



#======================
# ggplot model fit
#======================
library(splines)
library(tidyverse)
library(modelr)

sim5 <- tibble(
  x = seq(0, 3.5 * pi, length = 50),
  y = 4 * sin(x) + rnorm(length(x))
)

ggplot(sim5, aes(x, y)) +
  geom_point()

mod1 <- lm(y ~ ns(x, 1), data = sim5)
mod2 <- lm(y ~ ns(x, 2), data = sim5)
mod3 <- lm(y ~ ns(x, 3), data = sim5)
mod4 <- lm(y ~ ns(x, 4), data = sim5)
mod5 <- lm(y ~ ns(x, 5), data = sim5)

summary(mod5)

grid <- sim5 %>% 
  data_grid(x = seq_range(x, n = 50, expand = 0.1)) %>% 
  gather_predictions(mod1, mod2, mod3, mod4, mod5, .pred = "y")

ggplot(sim5, aes(x, y)) + 
  geom_point() +
  geom_line(data = grid, colour = "red") +
  facet_wrap(~ model)


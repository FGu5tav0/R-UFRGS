library(tidyverse)
library(lmerTest)


lm <- lmer(Petal.Length ~ Sepal.Length * Sepal.Width + (1|Species), data = iris)

summary(lm)

anova(lm)

lm2 <- lmer(Petal.Length ~ Sepal.Length + Sepal.Width + (1|Species), data = iris)

lm3 <- lmer(Petal.Length ~ Sepal.Length + (1|Species), data = iris)

lm4 <- lmer(Petal.Length ~ 1 + (1|Species), data = iris)

anova(lm, lm2, lm3, lm4)

anova(lm, lm2, lm3, lm4, 
      refit = F # só usa quando as var random são diferentes
      )


# diag --------------------------------------------------------------------
library(RVAideMemoire)

plotresid(lm3, shapiro = T)

shapiro.test(resid(lm3))

plot(lm3,type=c("p","smooth")) 

plot(lm3,sqrt(abs(resid(.)))~fitted(.), type=c("p","smooth")) 



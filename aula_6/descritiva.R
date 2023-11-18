
# Estatística descritiva --------------------------------------------------
# É voltada a organizar, resumir e apresentar os dados
# Não há conslusões (grupos são diferntes, por exemplo).
# Análise exploratória dos dados (fundamental para entender os dados)

# Perguntas que podem ser feitas:
# A quantidade de dados é suficiente? (coletar mais)
# Vale a pena fazer um análise? (qual)


# Identificar o tipo de variáveis que eu possuo 
# qualitativa ou quantitativa

# métodos -----------------------------------------------------------------

# 1 - Tabelas de distribuição de frequência
# 2 - Gráficos
  # histograma
  # densidade
  # boxplot
# 3 - Medidas-resumo
  # posição
  # dispersão
  # forma

# pacotes -----------------------------------------------------------------

library(dplyr)
library(psych)
library(ggplot2)
library(moments)
library(patchwork)
library(summarytools)
library(rstatix)

# dados -------------------------------------------------------------------

dados <- readxl::read_excel("aula_4/dados_exercicio_03.xlsx") 
# |> edit()

head(dados)
# função nativa do R ------------------------------------------------------

str(dados)

summary(dados)
iris |> summary()


# tabela de freq ----------------------------------------------------------
# tabela freq para dados qualitativos
freq(dados)

# para dados quantitativos
dados |> dplyr::mutate(nivel_ph = case_when(ph < 7.0 ~ "acidos",
                                         ph >= 7.0 & ph <=7.1 ~ "neutros", 
                                         ph > 7.9 ~ "alcalinos")) |> 
  freq(nivel_ph)

# com grupo
dados |> dplyr::mutate(nivel_ph = case_when(ph < 7.0 ~ "acidos",
                                            ph >= 7.0 & ph <=7.1 ~ "neutros", 
                                            ph > 7.9 ~ "alcalinos")) |> 
  dplyr::group_by(label) |> 
  freq(nivel_ph)


# medidas de posição, dispersão e forma ---------------------------------------

dados |> 
  summarise(media = mean(K, na.rm = T),
                      mediana = median(K, na.rm = T),
                      desvio_pad = sd(K, na.rm = T),
                      minimo = min(K, na.rm = T),
                      maximo = max(K, na.rm = T),
                      n_amostral = n(),
                      variancia= var(K,na.rm = T),
                      p.25= quantile(K,probs= .25,na.rm= T),
                      p.75= quantile(K, probs= .75, na.rm= T),
                      cv= sd(K,na.rm = T)/mean(K,na.rm=T)*100)

#  com summarytools
dados |> descr()

dados |> dplyr::group_by(label) |> 
  summarytools::descr()

dados |> 
summarytools::freq()
iris 

# com psych
describeBy(dados)
describeBy(dados, group = dados$label)
describeBy(dados~label)
describeBy(K~label, data = dados)


# com rstatix
dados |>dplyr::group_by(label) |> 
  rstatix::get_summary_stats(K)


# gráficos  ---------------------------------------------------------------


# dist normal -------------------------------------------------------------

df <- tibble(x = rnorm(n = 3000, mean = 30, sd = 2),
             nome = rep("trat_A",3000))

# hist
hist(df$x, main = "Histograma", xlab = "Var Inde", ylab = "Freq")

# com ggplot2 -------------------------------------------------------------
# assimetria

# se for 0 é distribuição simétrica
# se for maior que 0 é assimetrica positiva (à direita)
# se for maior que 0 é assimetrica negativa (à esquerda)
assi <- round(skewness(df$x), 2)
# curtose
# se for igual a 3 é normal padrão (mesocúrtica)
# se for maior que 3 é leptocúrtica
# se for menor que 3 é platicúrtica
cur <- round(kurtosis(df$x),2)

p1 <- ggplot(df, aes(x = x)) +
  geom_histogram(aes(y = after_stat(density)), alpha = 0.5, color = "black", fill = "blue") +
  geom_function(fun = dnorm, args = list(mean = 30,
                                         sd = 3),
                size = 1, color = "red", linewidth = 1) +
  annotate(geom = "text", x = 27, y = 0.24, label = paste("Assimetria:",assi)) +
  annotate(geom = "text", x = 27, y = 0.22, label = paste("Curtose:",cur)) +
  ggtitle(label =  bquote("N"~(mu==.(30)~","~sigma^2 == .(2)))) +
  ggthemes::theme_wsj()




# boxplot -----------------------------------------------------------------
# funções nativas
boxplot(df$x)

boxplot(df$x)$out
boxplot(P ~ label, data = dados)


p2 <- ggplot(df) +
  aes(x = nome, y = x) + 
  geom_boxplot(width = .5, fill = ggplot2::alpha("tomato",.9),
               outlier.shape = 21,
               outlier.fill = 'blue',
               outlier.size = 2) +
  stat_boxplot(geom = "errorbar", width = .5) +
  stat_summary(fun = mean, geom="point", shape=18, size=4, color="white") +
  theme_bw()

# dados ex

ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot(width = .5,
               outlier.shape = 21,
               outlier.fill = 'green',
               outlier.size = 3) +
  stat_boxplot(geom = "errorbar", width = .5) +
  scale_fill_brewer(palette="Reds") +
  stat_summary(fun = mean, geom="point", shape=18, size=4, color="blue") +
  theme_bw()


p3 <- ggplot(df, aes(x = nome, y = x)) +
ggrain::geom_rain(alpha = .2)

ggplot(dplyr::filter(dados, label %in% c("rice", "watermelon", "papaya")), aes(x =1, y = K, fill = label)) +
ggrain::geom_rain(alpha = .2)


ggplot(dplyr::filter(dados, label %in% c("rice", "watermelon", "papaya")), aes(x = label, y = K, fill = label)) +
  ggrain::geom_rain(rain.side = "l")



# exemplo2 ----------------------------------------------------------------
rm(list = ls())

dados <- data.frame(num = 1:200, 
                    amostra = sample(x = 1:200,size = 200, replace = T),
                    normal = rnorm(n = 200, mean = 50, sd = 1))

media_normal <- mean(dados$normal, na.rm = T)
desvio_normal <- sd(dados$normal, na.rm = T)

# teste de shapiro ----------------------------------------------

dados |> shapiro_test(normal)

out <- boxplot(dados$normal)$out

# gráfico -------------------------------------------------------

# densidade
p5 <- ggplot(dados) +
  geom_histogram(aes(x = normal, y = ..density..),
                 col = "red", fill = "tomato", bins = 30) +
  geom_function(fun = dnorm, args = list(mean = media_normal,
                                         sd = desvio_normal),
                size = 1) +
  theme_bw() +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(), 
        plot.margin = margin(b = -6, unit = "mm"))

# boxplot
p6 <- ggplot(dados) +
  aes(y = normal) + 
  geom_boxplot(width = .5, fill = "chocolate1",
               outlier.shape = 21,notch = T,
               outlier.fill = 'brown1',
               outlier.size = 2) +
  stat_boxplot(geom = "errorbar", width = .5, coef = 1.5) + # padrão coef 1.5
  scale_x_continuous(limits = c(-.7, .7)) +
  coord_flip() +
  theme_bw() +
  theme(plot.margin = margin(t = -10, unit = "mm"),
        axis.line.x.top = element_blank())

# juntando ------------------------------------------------------

(p5 / p6) + plot_layout(heights = c(.7, .3))

# juntando plots ----------------------------------------------------------

p1 + p2 + p3 

(p1/p2) | p3


p1 / (p2 | p3) + plot_layout(nrow = 2,heights = c(.7,.3))

p1 | plot_spacer() / p2 


p_total <- p1 + inset_element(p = p2, align_to = "panel", 0.7, 0.6, 1, 1)


logo <- png::readPNG('aula_1/figs/R_logo.png', native = TRUE)
p_total + inset_element(logo, left = 0.9, bottom = 0.9, right = 1, top = 1, align_to = 'full') +
  plot_annotation(tag_levels = '1')


plot(function(x) dnorm(x, 100, 8), 60, 140, ylab='f(x)')
plot(function(x) dnorm(x, 90, 8), 60, 140, add=T, col=2)
plot(function(x) dnorm(x, 100, 15), 60, 140, add=T, col=3)



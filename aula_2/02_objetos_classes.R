
# Aula 2 parte 2 ----------------------------------------------------------

getwd() # mostra o diretório de trabalho atual
dir() # mostra a lista de arquivos do diretório
setwd() # muda o diretório de trabalho
ls() # lista os objetos do ambiente

# ajuda -------------------------------------------------------------------

help.start()

help(getwd)

?getwd

example(getwd)

RSiteSearch("getwd")


# Objetos e classes -------------------------------------------------------

print("Tudo no R é um objeto")
print("Todo objeto no R tem uma classe")
print("- John Chamber, criador da linguagem S")

# Algumas considerações ---------------------------------------------------

# R é case sensitive
# Indexação do número 1
# Não use acento ou character especial

# produção; !; @; $; %;

# tipos de objetos --------------------------------------------------------
# mais de 25 tipos e "modos".
# O modo representa a natureza dos elementos objetos
10L;"gustavo";1.5;TRUE;5i

typeof(10L)
typeof("gustavo")
typeof(1.5)
typeof(TRUE)
typeof(5i)

# tipos de classes --------------------------------------------------------

# logical
# character
# list
# matrix
# array
# factor
# data.frame

# Coerção -----------------------------------------------------------------

# Logical vira Numeric
# Numeric vira Character

1 |> class()
TRUE |> class()

c(1,TRUE) |> class()

c(1,TRUE, "Nome") |> class()

# Objetos -----------------------------------------------------------------
# Atribuição de valores a objetos -----------------------------------------

objeto1 <- 1

objeto1

objeto2 <- "g"

objeto2

1 -> objeto1

objeto1

"g" -> objeto2

objeto2

objeto1 = 1

objeto1 # não é indicado usar usar "=" (Usado em funções)

# não permitido
1 = objeto1

# regras para dar nome a objetos ------------------------------------------

# nome curto
# sem character especial
# sem início com número

# Bons nomes

vet <- 1

v1 <- 1

meu_vetor <- 1

meu.vetor <- 1

# Nomes ruins

meu_primeiro_vetor_no_r <- 1

vetor_PRIMEIRO <- 1

# Não permitido

1x <- 1

_vetor <- 1

meu-vetor <- 1

# nomes reservados

?Reserved

if <- 1


# make.names() para sugestão de nome --------------------------------------

.123 <- 1:4
make.names(".123")

# Case sensitive ----------------------------------------------------------

a <- "a"

A <- "a"

Gustavo <- "G"

gustavo <- "gustavo"

# forma menos convencional para atribuir ----------------------------------

assign("obj", c(1,2,3))

# Tipos de objetos --------------------------------------------------------

# 1 - vetores
# 2 - matrizes
# 3 - data.frames
# 4 - listas
# 5 - arrays (não veremos)
# 6 - funções

# remove todos os objetos do ambiente
rm(list = ls())

# Vetores -----------------------------------------------------------------
# Criar vetores
c() # função concatenar

c(1,2,3,4)

vetor <- c(1,2,3,4)

vetor <- 1:100

seq(); rep()

vetor <- rep(4:7, each = 3)
vetor <- rep(4:7, times=3)

vetor <- rep(seq(1,10), 3)

vetor <- rep(c(1,5,10), 3)

vet1 <- 1:5
vet1 <- c(1:5)
vet1 <- c(1,2,3,4,5)
vet1 <- seq(1,5)

# Com string

c("Aula", "R")

vet2 <- c("Aula", "R")

vet_soil <- rep("solos", 10)

vet_soil

# Acessar dados de vetores

area_solo <- c("Química", "Física", "Microbiologia", "Mineralogia")

area_solo[2]

area_solo[c(1,4)]

area_solo[1,3] # Não aceita

area_solo[seq(1,3)]

# menos um
area_solo[-1]
# menos 2
area_solo[-c(1,4)]

# Altera elemento de vetor

vet_1 <- c("Química", "Física", "Microbiologia", "Mineralogia")

vet_1[1] <- "Termodinâmica"

vet_1

vet_1[c(1,3)] <- c("Química", "Pedologia")

vet_1

# fatores -----------------------------------------------------------------

rm(list = ls())

factor()

x <- c(rep("10-20", 3), rep("20-30",3), rep("0-10",3))

factor(x = x)

factor(x = x, levels = c("0-10","10-20","20-30"))

factor(x = x, levels = c("0-10","10-20","20-30"),
       ordered = T, labels = c("0 a 10 cm", "10 a 20 cm", "20 a 30 cm"))

camada <- factor(x = x, levels = c("0-10","10-20","20-30"),
       ordered = T, labels = c("0 a 10 cm", "10 a 20 cm", "20 a 30 cm"))
camada
camada |> class()
# Matrizes ----------------------------------------------------------------
rm(list = ls())
area_solo <- c("Química", "Física", "Microbiologia", "Mineralogia")

matriz1 <- matrix(nrow = 4, ncol = 4, data = area_solo)
matriz1

class(matriz1)

matriz1 <- matrix(nrow = 4, ncol = 4, data = area_solo, byrow = 1)
matriz1

# Acessar elementos de matrizes

matriz1[6]
matriz1[c(1,6)]

# Aletar elemento em matriz

matriz1 <- matrix(nrow = 4, ncol = 4, data = area_solo, byrow = 1)
matriz1 <- matrix(nrow = 4, ncol = 4, data = area_solo, byrow = 2)

matriz1

matriz1[1] <- "Química do solo"

matriz1

# Nome de colunas e de linhas
colnames(matriz1) <- area_solo
rownames(matriz1) <- area_solo
matriz1[1:16] <- "Solo"

matriz1

# Data frame --------------------------------------------------------------
# Objeto mais importante para trabalhar e armazenar dados
# Equivalentes a planilha de Excel

methods(class = data.frame)

data() # lista de banco de dados dentro do R

iris # visualiza o conjunto de dados

data("iris") # carrega o conjunto para o Environment

head(iris)

tail(iris)

# Criando data.frame com função do R --------------------------------------

df <- data.frame(nome_da_coluna = c("primeiro elemento", "segundo elemento",
                                    "n elemento"))
df

df2 <- data.frame(Autor = c("Karl Pearson", "Ronald Fisher", "George Box", "Charles Spearman"),
                  Nacionalidade = c("Islington", "East Finchley", "Gravesend"))

# Acessando elementos de data.frame

iris[1,3] # primeiro número é a linha e o segundo a coluna

iris[[5]] # dois colchetes seleciona todos os elementos da coluna indicada

iris[[5]][1] # seleciona a coluna 5 e o elemento 1

iris[,"Species"] # posso usar o nome da coluna

iris[,c("Sepal.Length","Species")]

# com $

iris$Sepal.Length # realiza a seleção de uma coluna inteira

iris$Sepal.Length[1] # primeiro elemento da coluna Sepal.Length

# alterando elementos

iris$Sepal.Length <- rep("R", 150)

iris$Sepal.Length[1] <- "Sem medida"

# funções para data.frame -------------------------------------------------

head(iris)

tail(iris)

dim(iris)

summary(iris)

edit(iris)

plot(iris)

# listas ------------------------------------------------------------------

rm(list = ls())
# Objeto com pode conter vários tipos de objetos

list()

# criando uma lista
nome <- c("Romero Britto", "Albert Einstein", "Muriel Bristol")

tabela <- data.frame(ocupacao = c("pintor", "físico", "algóloga"))

matriz <- matrix(data = 1:100, nrow = 25)

list(nome, tabela, matriz) # aqui é uma lista com um vetor, um data.frame e uma matriz

lista_1 <- list(nome, tabela, matriz)

# Acessando elementos de listas

lista_1[1]

lista_1$nome # não funciona

lista_1[[1]]

lista_1[[1]][1]

lista_1[[1]]["Romero Britto"] # não funciona

lista_1[[1]][1] # vetor dentro de uma lista

lista_1[[2]][1,1] #tabela dentro de uma lista

lista_1[[3]][1,2] # matriz dentro de uma lista

# modificar elementos

lista_1[[1]]
lista_1[[1]][2]

lista_1[[1]][2] <- "Sheldon Cooper"

lista_1[[1]]

# tible -------------------------------------------------------------------
# tible é um data.frame "turbinado".
# Apresenta atributos que melhoram o objeto

library(tibble)

dados_1 <- tibble(
  a = -5:6,
  b = letters[1:12],
  c = factor(x = c(rep("grupo 1", 6),
                   rep("grupo 2",6)),
             levels = c("grupo 1", "grupo 2"))
)

dados_2 <- data.frame(
  a = -5:6,
  b = letters[1:12],
  c = factor(x = c(rep("grupo 1", 6),
                   rep("grupo 2",6)),
             levels = c("grupo 1", "grupo 2"))
)

dados_1 |> class()
dados_2 |> class()
dados_1
dados_2

dados_1 |> dplyr::group_by(c)

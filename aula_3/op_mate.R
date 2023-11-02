# operações mat -----------------------------------------------------------

# Operações matemáticas com R ---------------------------------------------

2 + 9 # adição
2 - 9 # subtração
2 / 9 # divisão
2 * 9 # multiplicação
2 ^ 9 # exponenciação
2 %% 9 # resto da divisão


10 / 3
10 %/% 3 # parte inteira da divisão

# notação menos utilizada (ou quase nunca)

`*`(4,2)
`+`(4,2)
`/`(4,2)
`-`(4,2)

# como somar dois ou mais elementos e fazer a sqrt() da soma?

20;5
20 + 5

valor <- c(20,5)
sum(valor)
soma <- sum(valor)
sqrt(soma)

# com pipe (exemplo de introdução do operador)
c(5,20) |>
  sum() |>
  sqrt()

# funções matemáticas -----------------------------------------------------

abs(10) # valor absoluto
abs(-10) # valor absoluto

sqrt(49) # raiz quadrada

cos(0) #cosseno

sin(0) # seno

tan(0) # tangente

log(5) # logaritmo. Padrão é o natural
log10(100) # logaritmo base 10

exp(1) # expoente de euler
2.71^1

round(pi, digits = 2)

ceiling(pi) # arredonda para cima

floor(pi) # arredonda para baixo

# funções estatísticas ----------------------------------------------------

mean(c(1,2,3)) # média
mean(c(1,2,NA,5)) # média com NA
mean(c(1,2,NA,5), na.rm = T) # na.rm exclui dados NA

sd(c(1,2,3)) # desvio padrão

median(c(1,2,3)) # mediana

quantile(c(1,2,3)) # quantils
quantile(x = c(1,2,3), probs = .25)
quantile(x = c(1,2,3), probs = .75)

range(c(1,2,3)) # faixa. Amplitude o maior menos o menor

var(c(1,2,3)) # variância

sum(c(1,2,3)) # soma
sum(c(1,2,NA,5))
sum(c(1,2,NA,5), na.rm = TRUE)

diff(c(1,2,3,7)) # diferença entre os elementos

min(c(1,2,3)) # menor valor

max(c(1,2,3)) # maior valor


# reciclagem --------------------------------------------------------------
# O R reaproveita elementos!

x1 <- 1:4
x2 <- c(4,5,3)

x1;x2

x1 == x2 # faz a comparação, mas o último pega o primeiro elemento

x1 + x2 # ele busca o primeiro elemento e o repete


# operações com vetores, data.frame e matrizes  ---------------------------
# vetor
vet_1 <- 1:100

vet_2 <- 10


vet_1 + vet_2
vet_1 - vet_2
vet_1 / vet_2
vet_1 * vet_2
vet_1 ^ vet_2

# matriz

mat_1 <- matrix(1:10, ncol = 2, nrow = 5)
mat_2 <- matrix(10, ncol = 2, nrow = 5)

mat_1 + mat_2
mat_1 - mat_2
mat_1 / mat_2
mat_1 * mat_2
mat_1 ^ mat_2


# data.frame

iris # banco de dados do R

iris$Sepal.Length + 100
iris$Sepal.Length - 100
iris$Sepal.Length / 100
iris$Sepal.Length * 100
iris$Sepal.Length ^ 100

mean(iris$Sepal.Length)
median(iris$Sepal.Length)
quantile(iris$Sepal.Length, probs = .25)
sd(iris$Sepal.Length)
sum(iris$Sepal.Length)

# resolução ---------------------------------------------------------------

# 1

# número
1 == 1
1 >= 1
1 > 1
1 <= 1
1 < 1
1 != 1

# texto
"a" == "b"
"a" >= "b"
"a" > "b"
"a" <= "b"
"a" < "b"
"a" != "b"

# 2

vet_1 <- 1:20
vet_2 <- 21:40
vet_3 <- LETTERS[1:20]
vet_4 <- letters[1:20]

vet_1 == vet_2
vet_1 >= vet_2
vet_1 > vet_2
vet_1 <= vet_2
vet_1 <  vet_2
vet_1 != vet_2

vet_3 == vet_4
vet_3 >= vet_4
vet_3 > vet_4
vet_3 <= vet_4
vet_3 < vet_4
vet_3 != vet_4

# 3

l <- 1:1000

rep_mil <- rep(1000, 1000)

rep_10 <- rep(1:10, length.out = 1000)

rep_con <- rep(1:333.3333, each = 3)

# 4

vet <- seq(1,10)
mat <- matrix(data = vet, ncol = 2)
df <- data.frame(mat)

# 5

vet[5]
mat[5]
df[5,2]

vet[5] <- "texto"
mat[5] <- "texto"
df[5,2] <- "texto"

# 6

x <- c(rep("10-20", 3), rep("20-30",3), rep("0-10",3), rep("30-60", 3))

camada <- factor(x = x, levels = c("0-10","10-20","20-30", "30-60"),
                 ordered = T, labels = c("0 a 10 cm", "10 a 20 cm",
                                         "20 a 30 cm","30 a 60 cm"))

# 7

lista_minha <- list(vet,mat,df)

lista_minha[[1]][5]
lista_minha[[2]][5]
lista_minha[[3]][5,2]

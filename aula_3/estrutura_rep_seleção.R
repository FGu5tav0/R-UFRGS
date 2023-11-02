# Estruturas de repetição e de seleção ------------------------------------
# estrutura básica de sim ou não. O famoso SE do excel

if (condition) {

} else {

}

resultado_idade <- 26 == 27
print(resultado_idade) # função print imprime na tela


if (resultado_idade == TRUE) {
  print("Mesma idade")
}else {
  print("Idade diferente")
}

# exemplo de seleção ------------------------------------------------------
# ph soja 6.0

ph <- 4.5
SMP <- 5.2

if (ph >= 5.5) {
  print("Não precisa de calagem")
} else {
  h_al <- round(exp(10.665 - (1.1483 * SMP)) / 10, 2)
  paste(
    "Deve ser aplicado calcário. O Valor de H+Al é de",
    h_al, "cmolc"
  )
}

# Seleção encadeada -------------------------------------------------------

ph <- 5.5
m <- 10

if (ph >= 5.5 & m <=10) {
  print("Sem necessidade de calagem")
} else {
  if (ph < 5.5 & m <= 10) {
    print("O pH está baixo, mas o Al não está no limite")
  } else {
    print("Deve ser feita a calagem")
  }
}


# várias opções  ----------------------------------------------------------

# teor de K no solo em função da CTC --------------------------------------
# Tabela 6.9 do manual 2016 do RS e SC, pg 96

teor_k <- 100 # mg dm3
ctc <- 15.0 # cmolc ph 7.0

if (ctc <= 7.5) {
  if (teor_k <= 20) {
    "Teor muito baixo"
  } else if (teor_k >= 21 & teor_k <= 40) {
    "Teor baixo"
  } else if (teor_k >= 41 & teor_k <= 60) {
    "Teor médio"
  } else if (teor_k >= 61 & teor_k <= 120) {
    "Teor alto"
  } else {
    "Teor muito alto"
  }
} else if (ctc > 7.6 & ctc <= 15) {
  if (teor_k <= 30) {
    "Teor muito baixo"
  } else if (teor_k >= 31 & teor_k <= 60) {
    "Teor baixo"
  } else if (teor_k >= 61 & teor_k <= 90) {
    "Teor médio"
  } else if (teor_k >= 91 & teor_k <= 180) {
    "Teor alto"
  } else {
    "Teor muito alto"
  }
} else if (ctc > 15.1 & ctc <= 30) {
  if (teor_k <= 40) {
    "Teor muito baixo"
  } else if (teor_k >= 41 & teor_k <= 80) {
    "Teor baixo"
  } else if (teor_k >= 81 & teor_k <= 120) {
    "Teor médio"
  } else if (teor_k >= 121 & teor_k <= 240) {
    "Teor alto"
  } else {
    "Teor muito alt0"
  }
} else {
  if (teor_k <= 45) {
    "Teor muito baixo"
  } else if (teor_k > 46 & teor_k < 90) {
    "Teor baixo"
  } else if (teor_k > 91 & teor_k < 135) {
    "Teor médio"
  } else if (teor_k > 136 & teor_k < 270) {
    "Teor alto"
  } else {
    "Teor muito alto"
  }
}

# com switch --------------------------------------------------------------

mineral <- "caulinita"
mineral <- "hematita"
mineral <- "vermiculita"

switch (mineral,
        "caulinita"={
          print("É um 1:1")
        }, "vermiculita"={
          print("É 2:1")
        }, "hematita"={
          print("É óxido de Fe")
        }
)

# com ifelse --------------------------------------------------------------

ph <- c(5.5,4.5,6.0,5)

ifelse(ph >= 5.5, "pH bom", "pH baixo")

resultado <- ifelse(ph >= 5.5, "pH bom", "pH baixo")



# estrutura de repetição --------------------------------------------------
# loop for
# forma de realizar uma tarefa várias vezes seguidas

for (i in 1:10) {
  print("Ciência do Solo")
}


# com função simples ------------------------------------------------------

df <- data.frame(
  nota1 = c(4,5,6,7),
  nota2 = c(7,8,2,9),
  nota3 = c(4,5,5,9)
)

for (i in 1:length(df)) {
  media <- mean(df[,i])
  print(paste(colnames(df)[i],"média:", media))
}

summary(df)

# -------------------------------------------------------------------------

teor_k <- c(10,20,40,100,200)
ctc <- c(7,15,30,25,10)

for (i in 1:length(teor_k)) {
  if (ctc[i] <= 7.5) {
    if (teor_k[i] <= 20) {
      print("Teor muito baixo")
    } else if (teor_k[i] >= 21 & teor_k[i] <= 40) {
      print("Teor baixo")
    } else if (teor_k[i] >= 41 & teor_k[i] <= 60) {
      print("Teor médio")
    } else if (teor_k[i] >= 61 & teor_k[i] <= 120) {
      print("Teor alto")
    } else {
      print("Teor muito alto")
    }
  } else if (ctc[i] > 7.6 & ctc[i] <= 15) {
    if (teor_k[i] <= 30) {
      print("Teor muito baixo")
    } else if (teor_k[i] >= 31 & teor_k[i] <= 60) {
      print("Teor baixo")
    } else if (teor_k[i] >= 61 & teor_k[i] <= 90) {
      print("Teor médio")
    } else if (teor_k[i] >= 91 & teor_k[i] <= 180) {
      print("Teor alto")
    } else {
      print("Teor muito alto")
    }
  } else if (ctc[i] > 15.1 & ctc[i] <= 30) {
    if (teor_k[i] <= 40) {
      print("Teor muito baixo")
    } else if (teor_k[i] >= 41 & teor_k[i] <= 80) {
      print("Teor baixo")
    } else if (teor_k[i] >= 81 & teor_k[i] <= 120) {
      print("Teor médio")
    } else if (teor_k[i] >= 121 & teor_k[i] <= 240) {
      print("Teor alto")
    } else {
      print("Teor muito alto")
    }
  } else {
    if (teor_k[i] <= 45) {
      print("Teor muito baixo")
    } else if (teor_k[i] > 46 & teor_k[i] < 90) {
      print("Teor baixo")
    } else if (teor_k[i] > 91 & teor_k[i] < 135) {
      print("Teor médio")
    } else if (teor_k[i] > 136 & teor_k[i] < 270) {
      print("Teor alto")
    } else {
      print("Teor muito alto")
    }
  }
}

# com a família apply -----------------------------------------------------

# funções distinadas a operações com loop
# pacote nativo do R

# apply(array, margin, ...)
# lapply(list, function)
# mapply(function, ...)
# sapply(list, function)
# tapply()

# apply -------------------------------------------------------------------

m1 <- matrix(1:10, nrow = 5)

apply(m1, 1, sum) # em linha
apply(m1, 2, sum) # em coluna

# lapply ------------------------------------------------------------------

lista_de_coisas <- list(a = matrix(1:10),
                        b = 1:10,
                        e = 1:10,
                        f = 1:10
                        )

lapply(lista_de_coisas, mean)

unlist(lapply(lista_de_coisas, mean))

# criando função dentro do lapply

lapply(lista_de_coisas, function(x) x^2)

lapply(lista_de_coisas, \(x) x^2)


# sapply ------------------------------------------------------------------

sapply(lista_de_coisas, sum)


# mapply -----------------------------------------------------------------

mapply(rep, 1:4, 10)


# tapply ------------------------------------------------------------------

tapply(iris$Sepal.Length,iris$Species,max)



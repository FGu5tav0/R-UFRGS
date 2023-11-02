

# Funções em R 

# Utilidade: 

# Reutilização de código 
# Organizar e simplificar o código
# Resolução de problemas 
# Agilidade de operação 



# Uma função é dividida em:
# i)   Argumento
# ii)  Corpo 
# iii) Ambiente


# Sintaxe das funções 

#   nome <- function(argumento1 , … , argumento n) {

#   Comandos da função

#   return (saída)

#   }

# Exemplos 

# Criando uma função para calcular a área de um retângulo 
area_ret <- function(b, h){

  area<- b*h
  return(area)
  
}

# usando a função para calcular área do retângulo 
area_ret(32.5, 23.1)
  

# Usando a função para um conjunto de informações 

base<- 1:15 # vetor
altura <- 36:50 # vetor

# cálculo da área para conjunto de informações 
area_ret(base, altura)


# Obtendo mais de um parâmetro de uma função
# parâmetros de uma esfera: circunferência, disco, volume

p_esfera <- function(raio){
  circun <- 2*pi*raio
  disco <- pi*raio^2
  volume <- 3/4*pi*raio^3
  saida <- c(circun, disco, volume)
  return(saida)
}
# Usando a função 
p_esfera(7)

# Entrada com conjunto de informações 
# Melhorando a função...
p_esfera <- function(raio){
  circun <- 2*pi*raio
  disco <- pi*raio^2
  volume <- 3/4*pi*raio^3
  saida <- data.frame(circ=circun, area=disco, vol=volume)
  return(saida)
}

# Dados de entrada 
raios <- 20:50

# cálculo da área para conjunto de informações 
p_esfera(raios)

# Função com operadores de condição 
maior = function (a,b) {
  if (a < b) {
    return (b)
  } else { 
    return (a)
  }
}

# Usando a função 
maior(50,10)





# Agilizando atividades com funções 

# Ler, juntar, transformar e converter formato de arquivo 

# Pacotes
library(dplyr)
library(stringr)

# define a pasta dos arquivos
pasta <- "/Users/gustavopesini/Library/soja"

# lista os arquivos dentro da pasta
docs <- list.files(pasta, full.names = T)

# cria a função que vai ler e criar uma coluna com o nome do arquivo
pega_arquivo <- function(arquivo){
  bd_ <- read.delim(file = arquivo, # vai ler cada arquivo... 
                    header = F,
                    sep = ",",
                    col.names = c("X", "Y")
  )
  
  bd_ <- dplyr::mutate(bd_,        # Pega os dados pelo nome
                       arq = stringr::str_sub(basename(arquivo),
                                              end = -5))
  bd_
}

# repete o processo dentro da lista de arquivo usando a função acima
base <- purrr::map_dfr(docs, pega_arquivo)

# transforma para o formato longo (cada amostra em uma coluna)
dados_quase<- tidyr::pivot_wider(base,
                                 names_from = arq,
                                 values_from = Y)



# Usando funções para gráficos 

# Pacotes 
library(ggplot2)

# Dados
dados<-carData::Soils

# Gráfico Violino em ggplot (Densidade de kernel) 
ggplot(dados, aes(x=Contour, y=pH, fill= Contour))+
  geom_violin(show.legend = F)+
  geom_boxplot(fill = "white", width = 0.1, outlier.alpha = 0)+
  labs(y = "pH", x = "Contour")+
  theme_classic()

#Criando função 
violino <- function(df, vind, vdep, xlab, ylab){
  library(ggplot2)
  ggplot(df, aes(x={{vind}}, y={{vdep}}, fill= {{vind}}))+
    geom_violin(show.legend = F)+
    geom_boxplot(fill = "white", width = 0.1, outlier.alpha = 0)+
    labs(x = xlab, y = ylab)+
    theme_classic()
  
}

# Usando a função
violino(dados, Contour, pH, "Countour", "pH")
violino(dados, Contour, N, "Countour", "N")
violino(dados, Contour, P, "Countour", "P")
violino(dados, Depth, K, "Depth", "K")

# Gráfico Violino em plotly (Densidade de kernel) 
# teste

library(plotly)


# gráfico com Ploty
  plot_ly(df,
    x = ~Depth,
    y = ~P,
    split = ~Depth,
    type = 'violin',
    box = list(
      visible = T
    ),
    meanline = list(
      visible = T
    )
  ) 

violino1<- function(df, vind, vdep, xlab, ylab){
  
}



install.packages("revealjs") # Instala o pacote
library(revealjs) # Abre e executa o pacote.
  
  